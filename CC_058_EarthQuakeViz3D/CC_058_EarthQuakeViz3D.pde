// 3D Earthquake Data Visualization
// The Coding Train / Daniel Shiffman
// https://thecodingtrain.com/CodingChallenges/058-earthquakeviz3d.html
// https://youtu.be/dbs4IYGfAXc
// https://editor.p5js.org/codingtrain/sketches/tttPKxZi


float angle;
PVector oberverPosition = new PVector();

Table table;
float r = 200;

PImage earth;
PShape globe;


void setup() {
  size(600, 600, P3D);
  earth = loadImage("earth.jpg");
  // table = loadTable("https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/significant_day.csv", "header");
  table = loadTable("https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.csv", "header");

  noStroke();
  globe = createShape(SPHERE, r);
  globe.setTexture(earth);
  
  renderSat(25544);
}

void draw() {
  background(51);
  translate(width*0.5, height*0.5);
  rotateY(angle);
  angle += 0.05;

  lights();
  fill(200);
  noStroke();
  //sphere(r);
  shape(globe);

  //for (TableRow row : table.rows()) {
  //  //TODO manage table
  //  float lat = row.getFloat("latitude");
  //  float lon = row.getFloat("longitude");
  // // float mag = row.getFloat("mag");
  // float alt = row.getFloat("alt");
   
  //  float theta = radians(lat);

  //  float phi = radians(lon) + PI;
    
  //  // fix: in OpenGL, y & z axes are flipped from math notation of spherical coordinates
  //  float x = r * cos(theta) * cos(phi);
  //  float y = -r * sin(theta);
  //  float z = -r * cos(theta) * sin(phi);

  //  PVector pos = new PVector(x, y, z);

  //  PVector xaxis = new PVector(1, 0, 0);
  //  float angleb = PVector.angleBetween(xaxis, pos);
  //  PVector raxis = xaxis.cross(pos);
    
  //  pushMatrix();
  //  translate(x, y, z);
  //  rotate(angleb, raxis.x, raxis.y, raxis.z);
  //  fill(255);
  //  box(alt, 5, 5);
  //  popMatrix();
  //}
}

//6455PZ-FHRN5J-HZSC3K-4KH2 API LICENSe KEY

JSONObject fetchSat(int ID, float observer_lat, float observer_lng, float observer_alt, float seconds){
  String filePath = "https://www.n2yo.com/rest/v1/satellite/positions/"+ID+"/"+observer_lat+ "/"+observer_lng+"/"+observer_alt+"/"+seconds+"/&apiKey=6455PZ-FHRN5J-HZSC3K-4KH2";
  //println(filePath);
  return loadJSONObject(filePath);
}

JSONObject fetchSat(int ID, float seconds){
  return fetchSat(ID,55.780276, 12.516251, 0, seconds);
}

void renderSat(int ID){
  JSONObject temp = fetchSat(ID, 1);
  JSONObject info = temp.getJSONObject("info");
  JSONArray pos = temp.getJSONArray("positions");

  // find the posetion of the sat
  
  
  // draw the cube
    pushMatrix();
    // rotate with obs. angel
    // translate out
    // rotate with sat angle
    // translate out
    // make sphere
    
    //translate(x, y, z);
    fill(255);
    sphere(2);
    popMatrix();
}
