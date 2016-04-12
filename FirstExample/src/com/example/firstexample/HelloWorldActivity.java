package com.example.firstexample;

import android.app.Activity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

public class HelloWorldActivity extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_hello_world);
initDisplayButton();
clearButton();
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.hello_world, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		// Handle action bar item clicks here. The action bar will
		// automatically handle clicks on the Home/Up button, so long
		// as you specify a parent activity in AndroidManifest.xml.
		int id = item.getItemId();
		if (id == R.id.action_settings) {
			return true;
		}
		return super.onOptionsItemSelected(item);
		
	}
	private void initDisplayButton() { 
		Button displayButton = (Button) findViewById( R.id.button1);
		
	displayButton.setOnClickListener( new OnClickListener () { 
		@Override 
		public void onClick( View arg0) { 
			EditText firstName = (EditText) findViewById( R.id.nameeditText); 
			EditText lastName = (EditText) findViewById( R.id.editText1);  
			TextView textDisplay = (TextView) findViewById( R.id.textView2);
			String firstNameToDisplay = firstName.getText(). toString(); 
			String lastNameToDisplay = lastName.getText(). toString(); 
			textDisplay.setText(" Hello " + firstNameToDisplay + " " + lastNameToDisplay + "!");  }

		}); }
	
	private void clearButton() {
		Button clearButton = (Button) findViewById( R.id.button2);
		clearButton.setOnClickListener( new OnClickListener () { 
			@Override 
			public void onClick( View arg0) { 
				EditText firstName = (EditText) findViewById( R.id.nameeditText); 
				firstName.setText("");
				EditText lastName = (EditText) findViewById( R.id.editText1);  
				lastName.setText("");
				TextView textDisplay = (TextView) findViewById( R.id.textView2);
				textDisplay.setText(" Hello World!");
			}
			}); 
		
	}
	}

	


