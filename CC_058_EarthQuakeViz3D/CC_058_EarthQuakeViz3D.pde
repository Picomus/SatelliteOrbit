// 3D Earthquake Data Visualization
// The Coding Train / Daniel Shiffman
// https://thecodingtrain.com/CodingChallenges/058-earthquakeviz3d.html
// https://youtu.be/dbs4IYGfAXc
// https://editor.p5js.org/codingtrain/sketches/tttPKxZi

float angle;

float r = 200;
PImage earth;
PShape globe;


JSONObject ISS;
JSONObject TSIKADA;
JSONObject CPNineLEO;

JSONObject[] satellites = new JSONObject[5];

void setup() {
  size(800, 800, P3D);
  earth = loadImage("earth.jpg");
  noStroke();
  globe = createShape(SPHERE, r);
  globe.setTexture(earth);
  fetchAll();
}

int globalIndex =0;
int updateFrequency = 300;

void draw() {
  background(51);
  translate(width*0.5, height*0.5);
  rotateY(angle);
  angle += 0.01;

  lights();
  fill(200);
  noStroke();
  //sphere(r);
  shape(globe);
 
  //renderSat(25544,color(#ff0000)); // ISS
  //renderSat(23463,color(#00ff00)); // TSIKADA
  //renderSat(44360,color(#ccff00)); //CP-9 LEO
  //renderSat(44058,color(#ff0099)); // ONEWEB-0010
  //renderSat(39765,color(#ffff00)); // Kosmos 2499

  if (globalIndex == updateFrequency-1) {
    // asks the database for the info when needed
    fetchAll();
    globalIndex = 0;
  }
  
  renderSat(ISS, color(#ffff00), (globalIndex % updateFrequency));
  renderSat(TSIKADA, color(#00ff00), (globalIndex % updateFrequency));
  renderSat(CPNineLEO, color(#0000ff), (globalIndex % updateFrequency));
  
  // index advances if time has passed
  if (millis() % 1000 == 0) {
    globalIndex ++;
  }
}

void fetchAll(){
    ISS = fetchSat(25544, updateFrequency);
    TSIKADA = fetchSat(23463, updateFrequency);
    CPNineLEO = fetchSat(44360, updateFrequency);
}


float timeTester(float amount, float cycels) {
  int t = millis();

  for (int i = 0; i < cycels; i++) {
    fetchSat(25544, amount);
  }
  return ((millis() - t)/cycels) / amount;
}




//6455PZ-FHRN5J-HZSC3K-4KH2 API LICENSe KEY

JSONObject fetchSat(int ID, float observer_lat, float observer_lng, float observer_alt, float seconds) {
  String filePath = "https://www.n2yo.com/rest/v1/satellite/positions/"+ID+"/"+observer_lat+ "/"+observer_lng+"/"+observer_alt+"/"+seconds+"/&apiKey=6455PZ-FHRN5J-HZSC3K-4KH2";
  //println(filePath);
  return loadJSONObject(filePath);
}

JSONObject fetchSat(int ID, float seconds) {
  return fetchSat(ID, 55.780276, 12.516251, 0, seconds);
}

void renderSat(int id, color col) {
  renderSat(id, col, 0);
}

void renderSat(int id, color col, int index) {
  renderSat(fetchSat(id, 300), col, index);
}

void renderSat(JSONObject _tempSat, color col, int index) {
  JSONObject tempSat, info;
  JSONArray pos;

  tempSat = _tempSat;
  info = tempSat.getJSONObject("info");
  pos = tempSat.getJSONArray("positions");

  //JSONObject val = pos.getJSONObject(millis()/1000%300);
  JSONObject val = pos.getJSONObject(index);

  float lat = val.getFloat("satlatitude");
  float lon = val.getFloat("satlongitude");
  float alt = val.getFloat("sataltitude");
  float theta = radians(lat);
  float phi = radians(lon) + PI;

  float x = r * cos(theta) * cos(phi);
  float y = -r * sin(theta);
  float z = -r * cos(theta) * sin(phi);

  PVector posi = new PVector(x, y, z);

  PVector xaxis = new PVector(1, 0, 0);
  float angleb = PVector.angleBetween(xaxis, posi);
  PVector raxis = xaxis.cross(posi);

  pushMatrix();
  translate((x/abs(x))* (200 + alt * 0.03), y, z);  
  println((x/abs(x))* (200 + alt * 0.03));
  rotate(angleb, raxis.x, raxis.y, raxis.z);
  fill(col);
  box(5, 5, 5);
  popMatrix();
}

void renderSatNames(int id, color col) {
  fill(col);
  text(id, 100, 100);
}
