package site.ycsb.db;

import site.ycsb.DB;
import site.ycsb.Status;
import site.ycsb.ByteIterator;
import site.ycsb.StringByteIterator;
import java.util.Set;
import java.util.Map;
import java.util.Vector;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import site.ycsb.DBException;
import jni.OzoneDBJNI;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * OzoneDB client for YCSB framework.
 */
public class OzoneDBClient extends DB {
  private static final String CONFIG_PROPERTY = "shared_config";
  private static final String CONFIG_DEFAULT = "/users/Xinying/ozonedb/src/shared_config_rocksdb.json";

  private static final Logger LOGGER = LoggerFactory.getLogger(OzoneDBClient.class);
  private OzoneDBJNI db = null;
  private long lastTime = 0;

  @Override
  public void init() throws DBException {
    if (db == null) {
      LOGGER.info("Initializing OzoneDB client with shared config: " + CONFIG_DEFAULT);
      db = new OzoneDBJNI();
      final Properties props = getProperties();
      String sharedConfig = props.getProperty(CONFIG_PROPERTY, CONFIG_DEFAULT);
      db.openDB(sharedConfig);
      lastTime = System.nanoTime();
    }
  }

  @Override
  public Status read(String table, String key, Set<String> fields, Map<String, ByteIterator> result) {
    String value = db.get(key);
    result.put(key, new StringByteIterator(value));
    int totalBytes = key.getBytes(StandardCharsets.UTF_8).length + value.getBytes(StandardCharsets.UTF_8).length;
    LOGGER.info("Read size: " + totalBytes);
    if (totalBytes <= 1000){
      LOGGER.info("Read value: " + value);
    }
    reportThroughput(totalBytes); // Report throughput after each read
    return Status.OK;
  }

  @Override
  public Status scan(String table, String startkey, int recordcount, Set<String> fields,
      Vector<HashMap<String, ByteIterator>> result) {
    System.out.println("scan is not supported");
    return Status.OK;
  }

  @Override
  public Status update(String table, String key, Map<String, ByteIterator> values) {
    db.put(key, values.toString());
    int totalBytes = key.getBytes(StandardCharsets.UTF_8).length + values.toString()
        .getBytes(StandardCharsets.UTF_8).length;
    LOGGER.info("update size: " + totalBytes);
    reportThroughput(totalBytes); // Report throughput after each update
    return Status.OK;
  }

  @Override
  public Status insert(String table, String key, Map<String, ByteIterator> values) {
    db.put(key, values.toString());
    int totalBytes = key.getBytes(StandardCharsets.UTF_8).length
        + values.toString().getBytes(StandardCharsets.UTF_8).length;
    LOGGER.info("Insert size: " + totalBytes);
    reportThroughput(totalBytes); // Report throughput after each insert
    return Status.OK;
  }

  @Override
  public Status delete(String table, String key) {
    db.remove(key);
    return Status.OK;
  }

  // Method to report throughput
  private void reportThroughput(long size) {
    long currentTime = System.nanoTime();
    long elapsedTime = currentTime - lastTime; // Elapsed time in nanoTime
    lastTime = currentTime;
    if (elapsedTime > 0) {
      LOGGER.info("Current size: " + size);
      LOGGER.info("Current elapsed time: " + elapsedTime);
      double throughput = size / 1024.0 / 1024.0 / (elapsedTime / 1000.0 / 1000.0 / 1000.0); // MB per second
      LOGGER.info("Current Throughput: " + throughput + " MB/sec");
    }
  }
}
