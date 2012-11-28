// Art of Graphics Programming
// based on Patrick Hebron's class examples
//
// Matthew Epler, 2012 

import processing.opengl.*;
import java.util.Set;
import controlP5.*;
import peasy.*;

PeasyCam cam;

ControlP5 controlP5;
ControlWindow controlWindow;

float sceneRadius = 500.0;

ArrayList<TMesh> allSpheres = new ArrayList();
ArrayList<PVector> allPaths = new ArrayList();
ArrayList<PVector> allEndPoints = new ArrayList();
float multiplier = 0;

float sphereSize = 50;
int sphereRes = 20;
int totalSpheres = 8;
PVector centroid;
PVector end1;
PVector location;
PVector path;
boolean away = true;
boolean Freeze;
boolean normals = false;
boolean pointLightOn, 
        directionalLightOn, 
        spotLightOn;
        
float pointLightY;
int xDirection = 1;
float spotAngle = 0;

void setup() 
{

  size( 800, 600, OPENGL );
  cam = new PeasyCam(this, 800);
  initControls();
  
  
  centroid = new PVector( width/2.0, height/2.0, -200.0 );
  cam.lookAt( centroid.x, centroid.y, centroid.z );
  pointLightY = centroid.y;
  
  TMeshFactory meshFactory = new TMeshFactory();
  for( int i = 0; i < totalSpheres; i++ ) 
  {
    TMesh mesh = new TMesh();
    mesh = meshFactory.createSphere( sphereRes, sphereRes, sphereSize );
    allSpheres.add( mesh );
    
    PVector endPoint = new PVector( centroid.x + random(-300, 300), centroid.y + random(-300, 300), centroid.z + random(-300, 300) );
    PVector path = PVector.sub( endPoint, centroid );
    path.normalize();
    allPaths.add( path );
    allEndPoints.add( endPoint );
  }
 
}

void draw() 
{
 
  background( 0 );
  noStroke();
  fill( 0, 0, 255 );
  
  checkLights();
  
 for( int i = 0; i < totalSpheres; i++ )
 {
   TMesh thisSphere = allSpheres.get( i );
   PVector path = allPaths.get( i ); 
   PVector location = new PVector( centroid.x + (path.x * multiplier), centroid.y + (path.y * multiplier), centroid.z + (path.z * multiplier) );
   thisSphere.setPosition ( location );
   thisSphere.draw();
 }
 
 if( !Freeze ) {
   if( multiplier > 300 || multiplier < 0 ) 
     {
      away = !away;  
     } 
     
     if( away ) 
     {
      multiplier += 1; 
     } else {
      multiplier -= 1; 
     }
 }
}


void checkLights()
{
  
 if( pointLightOn ) 
 {
   pointLight( 255, 255, 255, centroid.x, pointLightY, centroid.z );  
   pushMatrix();
     stroke( 255 );
     translate( centroid.x, pointLightY, centroid.z );
     sphere( 5 );
   popMatrix();
   noStroke();
 } 
 
 
 if( directionalLightOn ) 
 {
   directionalLight( 0, 102, 255, // Color
                     xDirection, 0, 0);    // The x-, y-, z-axis direction
 }
 
 
 if( spotLightOn ) 
 {
   spotLight(255, 255, 255, // Color
            centroid.x, centroid.y, centroid.z,     // Position
            0, -1, 0,  // Direction
            spotAngle, 2);     // Angle, concentration  
   pushMatrix();
    translate( centroid.x, centroid.y, centroid.z );
    stroke( 255 );
    sphere( 5 );
    noStroke();
   popMatrix();
 }
}



void keyPressed()
{
  
 if( key == '1' ) 
 {
  pointLightOn = !pointLightOn;
 } 
 
 if( key == '2' )
 {
  directionalLightOn = !directionalLightOn; 
 }
 
 if( key == '3' )
 {
  spotLightOn = !spotLightOn; 
 }
}


void initControls()
{
  controlP5 = new ControlP5(this);
  ControlWindow cw = controlP5.addControlWindow("MAIN CONTROLS",330,430);
  cw.setLocation(10,10);
  //controlP5.addToggle("toggle",300,360,50,50);
  ControlGroup pointLight = controlP5.addGroup("Point Light",30,30);
  pointLight.moveTo(cw);
  controlP5.begin(pointLight,0,10);
  controlP5.addToggle("pointLightOn").linebreak();
  controlP5.addSlider("pointLightY", (height/2) - 400, (height/2) + 400 ).linebreak();
  controlP5.end();
  
  ControlGroup directionalLightG = controlP5.addGroup("Directional Light",30,150);
  directionalLightG.moveTo(cw);
  controlP5.begin(directionalLightG,0,10); 
  controlP5.addToggle("directionalLightOn").linebreak();
  controlP5.addSlider("xDirection", -1, 1 ).setNumberOfTickMarks(3);
  controlP5.end();
  
  ControlGroup spotLightG = controlP5.addGroup("Spot Light",30,270);
  spotLightG.moveTo(cw);
  controlP5.begin(spotLightG,0,10); 
  controlP5.addToggle("spotLightOn").linebreak(); 
  controlP5.addSlider("spotAngle", 0, PI ).linebreak();
  controlP5.end();
  
  ControlGroup freeze = controlP5.addGroup("Freeze Animation",30,370);
  freeze.moveTo(cw);
  controlP5.begin(freeze,0,10); 
  Toggle freezeButton = controlP5.addToggle("Freeze");
  freezeButton.setColorForeground( #F00505 );
  freezeButton.setColorLabel( #FFFFFF ); 
  freezeButton.setColorActive( #F00505 );
  freezeButton.setColorBackground( #9D2626 );  
  controlP5.end();
  
}



