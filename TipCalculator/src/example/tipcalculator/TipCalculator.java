package example.tipcalculator;

import android.app.Activity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import example.tipcalculator.R;

public class TipCalculator extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_tip_calculator);
		initCalcButton();
		initClearButton();
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.tip_calculator, menu);
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
	
	
	private void initCalcButton() {
		Button calcButton = (Button) findViewById(R.id.calcButton);
		
	calcButton.setOnClickListener(new OnClickListener(){
			
	@Override	
	public void onClick(View arg0) {
		
		EditText amountInput = (EditText) findViewById(R.id.amountInput);
		EditText tipInput = (EditText) findViewById(R.id.tipInput);
		TextView output = (TextView) findViewById(R.id.output);
		TextView grandTotal = (TextView) findViewById(R.id.grandTotal);
		String amount = amountInput.getText().toString();
		String tip = tipInput.getText().toString();
		float amountTotal = Float.parseFloat(amount);
		float tipTotal = Float.parseFloat(tip);
		float tipAmount = (amountTotal * (tipTotal / 100));
		float total = amountTotal + tipAmount;
		output.setText(String.format("Tip: $ %.2f", tipAmount));
		grandTotal.setText(String.format("Grand Total: $ %.2f",total));
	}
	
		});
			
	}
	
	private void initClearButton() {
		Button clearButton = (Button) findViewById(R.id.clearButton);
		clearButton.setOnClickListener(new OnClickListener() {
			
	@Override
	public void onClick(View arg0) {
			TextView output = (TextView) findViewById(R.id.output);
			EditText amountInput = (EditText) findViewById(R.id.amountInput);
			EditText tipInput = (EditText) findViewById(R.id.tipInput);
			TextView grandTotal = (TextView) findViewById(R.id.grandTotal);
			tipInput.setText("");
			amountInput.setText("");
			output.setText("");
			grandTotal.setText("");	
				}
			});
			
			
				
	}
}

	
