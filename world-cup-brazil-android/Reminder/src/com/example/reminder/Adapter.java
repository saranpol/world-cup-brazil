package com.example.reminder;

import java.util.ArrayList;
import java.util.HashMap;
 

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;
 
public class Adapter extends BaseAdapter {
	

	private Context context;
	private ArrayList<HashMap<String, String>> data;
	private static LayoutInflater inflater=null;
	public ImageLoader imageLoader;
	

	
	
	public Adapter(Context a, ArrayList<HashMap<String, String>> d) {
	context = a;
	data=d;
	inflater = (LayoutInflater)context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
	imageLoader=new ImageLoader(context.getApplicationContext());
	}
	
	public int getCount() {
	return data.size();
	}
	
	public Object getItem(int position) {
	return position;
	}
	
	public long getItemId(int position) {
	return position;
	}
	
	public View getView(int position, View convertView, ViewGroup parent) {
	View vi=convertView;
	if(convertView==null)
	vi = inflater.inflate(R.layout.rowlist, null);
	
	TextView team1 = (TextView)vi.findViewById(R.id.VT1); 
	TextView team2 = (TextView)vi.findViewById(R.id.VT2);
	//ImageView thumb_image=(ImageView)vi.findViewById(R.id.img);
	
	HashMap<String, String> mapu = new HashMap<String, String>();
	
	mapu = data.get(position);
	/*
	vi.setOnClickListener(new View.OnClickListener() {
		
		@Override
		public void onClick(View v) {
			///Intent intent = new Intent(context,Showpic.class);
			for(int i = 0;i<mapu.length;i++){
				Toast.makeText(context.getApplicationContext(),mapu.get(MainActivity.USER), Toast.LENGTH_SHORT).show();
			}
			
			//context.getApplicationContext().startActivity(intent);
			
			
		}
	});
	*/
	
	mapu = data.get(position);
	team1.setText(mapu.get(Main.team1));
	team2.setText(mapu.get(Main.team2));
	//imageLoader.DisplayImage(mapu.get(Main.team2), position, thumb_image);
	return vi; 
	}
}