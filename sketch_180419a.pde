import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port
Table dataTable = new Table();
int numReadings = 200; //Amount of readings before writing to file
int readingCounter = 0;

void setup()
{
  // I know that the first port in the serial list on my mac
  // is Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);

  
//Ive put a column for each sensor
dataTable.addColumn("Red");
 
  dataTable.addColumn("Blue");
}


void serialEvent(Serial myPort){
  val = myPort.readStringUntil('\n'); //The newline separator separates each Arduino loop. We will parse the data by each newline separator. 
  if (val!= null) { //We have a reading! Record it.
    val = trim(val); //gets rid of any whitespace or Unicode nonbreakable space
    println(val); //Optional, useful for debugging. If you see this, you know data is being sent. Delete if  you like. 
    int sensorVals[] = int(split(val, ',')); //parses the packet from Arduino and places the values into the sensorVals array. I am assuming floats. Change the data type to match the datatype coming from Arduino. 
   
    TableRow newRow = dataTable.addRow(); //add a row for this new reading
    
    //record sensor information. Customize the names so they match your sensor column names. 
    newRow.setInt("Red", sensorVals[0]);
    newRow.setInt("Blue", sensorVals[1]);
    readingCounter++; //optional, use if you'd like to write your file every numReadings reading cycles
    println(readingCounter);
    //saves the table as a csv in the same folder as the sketch every numReadings. 
    if (readingCounter % numReadings ==0)//The % is a modulus, a math operator that signifies remainder after division. The if statement checks if readingCounter is a multiple of numReadings (the remainder of readingCounter/numReadings is 0)
    {
      saveTable(dataTable, "data/table.csv"); //Woo! save it to your computer. It is ready for all your spreadsheet dreams. 
    }
   }
}




void draw()
{
  if ( myPort.available() > 0) 
  {  // If data is available,
  serialEvent(myPort);
  } 
}
