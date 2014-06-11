package com.example.reminder;

import java.util.ArrayList;
import java.util.HashMap;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.widget.ImageView;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.SimpleAdapter;
import android.widget.TextView;



public class Main extends Activity {
	ListView list;
	Adapter adapter;
	
	ArrayList<HashMap<String, String>> alist = new ArrayList<HashMap<String, String>>();
  
  private static String url = "https://world-cup-brazil.appspot.com/get_table";
  
  public static final String Data = "data";
  public static final String team2 = "t2";
  public static final String Time = "time";
  public static final String Match = "m";
  public static final String Win = "winner";
  public static final String team1 = "t1";
  
  JSONObject data = null;
  JSONArray arraydata = null;
  
  
  
  
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
    alist = new ArrayList<HashMap<String, String>>();
    
    JSONParser jParser = new JSONParser();
    
    JSONObject json = jParser.getJSONFromUrl(url);
    
    try {
    
   // data = json.getJSONObject(Data);
    arraydata  = json.getJSONArray(Data);
    

    
    for(int i=0;i<arraydata.length();i++){
    	JSONObject jObj = arraydata.getJSONObject(i);
    	String team2 = jObj.getString("t2");
    	String team1 = jObj.getString("t1");
    	String Time = jObj.getString("time");
    	String Match = jObj.getString("m");
    	String Win = jObj.getString("winner");
    	
    	
    	HashMap<String, String> map = new HashMap<String, String>();
    	map.put("t2", team2);
        map.put("t1", team1);
        map.put("time",Time);
        map.put("m", Match);
        map.put("winner", Win);
        alist.add(map);
    	
        Log.i("TEAM: 1",team1);
        Log.i("TEAM: 2",team2);
        Log.i("MATCH : ", Match);
    	
    	
    	
    	
    	
    	list=(ListView)findViewById(R.id.listrow);
    	
    	adapter=new Adapter(this, alist);
        list.setAdapter(adapter);
        
        
        
        
        
    	/*
    	ListAdapter adapter = new SimpleAdapter(Main.this, alist,R.layout.rowlist
    			, new String[] {"username","caption"}, new int[]{
                    R.id.users,R.id.caption});
    	list.setAdapter(adapter);
    	*/
    	
    	
    	
    	
    	
    }
     
      
      
      
  } catch (JSONException e) {
    e.printStackTrace();
  }
    }
}