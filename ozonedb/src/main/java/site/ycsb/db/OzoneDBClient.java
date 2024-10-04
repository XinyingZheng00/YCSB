package site.ycsb.db;
import site.ycsb.DB;
import site.ycsb.Status;
import site.ycsb.ByteIterator;
import site.ycsb.StringByteIterator;
import java.util.Set;
import java.util.Map;
import java.util.Vector;
import java.util.HashMap;
import site.ycsb.DBException;
import jni.OzoneDBJNI;
import java.util.Properties;


/**
 * OzoneDB client for YCSB framework.
 */
public class OzoneDBClient extends DB {
  private static final String CONFIG_PROPERTY = "shared_config";
  private static final String CONFIG_DEFAULT = "/home/xinying/Desktop/OZONEDB/"+
      "xinying/ozonedb/src/shared_config_rocksdb.json";
  private static OzoneDBJNI db = null;

  @Override
  public void init() throws DBException {
    if (db == null) {
      db = new OzoneDBJNI();
      final Properties props = getProperties();
      String sharedConfig = props.getProperty(CONFIG_PROPERTY, CONFIG_DEFAULT);
      db.openDB(sharedConfig);
    }
  }

  @Override
  public Status read(String table, String key, Set<String> fields, Map<String, ByteIterator> result){
    String value = db.get(key);
    result.put(key, new StringByteIterator(value));
    return Status.OK;
  }

  @Override
  public Status scan(String table, String startkey, int recordcount, Set<String> fields, 
      Vector<HashMap<String, ByteIterator>> result){
    System.out.println("scan is not supported");
    return Status.OK;
  }

  @Override
  public Status update(String table, String key, Map<String, ByteIterator> values){
    db.put(key, values.toString());
    return Status.OK;
  }

  @Override
  public Status insert(String table, String key, Map<String, ByteIterator> values){
    db.put(key, values.toString());
    return Status.OK;
  }

  @Override
  public Status delete(String table, String key){
    db.remove(key);
    return Status.OK;
  }

}