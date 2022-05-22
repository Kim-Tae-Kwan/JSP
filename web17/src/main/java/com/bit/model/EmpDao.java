package com.bit.model;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.bson.BsonDocument;
import org.bson.Document;
import org.bson.conversions.Bson;
import org.bson.types.ObjectId;

import com.mongodb.MongoClient;
import com.mongodb.ServerAddress;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;

public class EmpDao {
	private String addr = "localhost:27017";
	private MongoClient client = null;
	
	
	/*
	 * public List<Map<String, Object>> getList() { List<Map<String, Object>> list =
	 * new ArrayList<>(); try { client = new MongoClient(addr); MongoDatabase db =
	 * client.getDatabase("testDB"); MongoCollection<Document> collection =
	 * db.getCollection("emp"); MongoCursor<Document> cur =
	 * collection.find().iterator(); while(cur.hasNext()) { Map<String, Object> bean
	 * = new HashMap<>(); Document document = cur.next(); for(String key :
	 * document.keySet()) { bean.put(key, document.get(key)); } list.add(bean); }
	 * 
	 * }finally { if(client != null) client.close(); } return list; }
	 */
	
	public List<EmpDto> getList() {
		List<EmpDto> list = new ArrayList<>();
		try {
			client = new MongoClient(addr);
			MongoDatabase db = client.getDatabase("testDB");
			MongoCollection<Document> collection = db.getCollection("emp");
			
			MongoCursor<Document> cur = collection.find().iterator();
			while(cur.hasNext()) {
				Document document = cur.next();
				
				EmpDto bean = new EmpDto();
				bean.setId(document.getObjectId("_id"));
				//bean.setEmpno(document.getInteger("empno"));
				bean.setEmpno(Integer.parseInt(document.get("empno").toString()));
				bean.setEname(document.getString("ename"));
				bean.setItem(document.getList("item", String.class));
				list.add(bean);
			}
			
		}finally {
			if(client != null) client.close();
		}
		return list;
	}
	
	public EmpDto selectOne(String idx) {
		try {
			client = new MongoClient(addr);
			MongoDatabase db = client.getDatabase("testDB");
			MongoCollection<Document> collection = db.getCollection("emp");
			
			Bson filter = Filters.eq("_id", new ObjectId(idx));
			Document document = collection.find(filter).first();
			
			EmpDto bean = new EmpDto();
			bean.setId(document.getObjectId("_id"));
			//bean.setEmpno(document.getInteger("empno"));
			bean.setEmpno(Integer.parseInt(document.get("empno").toString()));
			bean.setEname(document.getString("ename"));
			bean.setItem(document.getList("item", String.class));
			
			return bean;
		} finally {
			if(client != null) client.close();
		}
	}

	public void insertOne(Map<String, String[]> items) {
		try {
			client = new MongoClient(addr);
			MongoDatabase db = client.getDatabase("testDB");
			MongoCollection<Document> collection = db.getCollection("emp");
			
			Document document = new Document();
			
			for(String key : items.keySet()) { 
				if(key.equals("item"))
					document.append(key, Arrays.asList(items.get(key)));
				else
					document.append(key, items.get(key)[0]);
			}
			
			collection.insertOne(document);
		} finally {
			if(client != null) client.close();
		}
	}

	public void updateOne(Map<String, String[]> params) {
		try(MongoClient client = new MongoClient(new ServerAddress("localhost", 27017))) {
			MongoDatabase db = client.getDatabase("testDB");
			MongoCollection<Document> collection = db.getCollection("emp");
			
			Bson filter = Filters.eq("_id",  new ObjectId(params.get("_id")[0]));
			
			Document update = new Document();
			
			for(String key : params.keySet()) { 
				if(key.equals("item"))
					update.append(key, Arrays.asList(params.get(key)));
				else if(key.equals("_id") || key.equals("idx")) {}
				else
					update.append(key, params.get(key)[0]);
			}
			
			collection.updateOne(filter, new Document("$set", update));
		} 
	}

	public void deleteOne(String json) {
		try(MongoClient client = new MongoClient(new ServerAddress("localhost", 27017))) {
			MongoDatabase db = client.getDatabase("testDB");
			MongoCollection<Document> collection = db.getCollection("emp");
			
			Bson filter = BsonDocument.parse(json);
			collection.deleteOne(filter);
		}
	}
}