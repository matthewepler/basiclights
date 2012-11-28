// Art of Graphics Programming
// based on Patrick Hebron's Section Example 004: "Storing Geometries: A Generic Approach" Example Stage: D (Part B)
//
// Matthew Epler, 2012 

import processing.opengl.*;
import java.util.Set;

TMesh mesh;
TMesh mesh2;
float multiplier;

PVector centroid;
PVector end1;
PVector location;
PVector path;
boolean away = true;

void setup() {

  size( 800, 600, OPENGL );
  
  // set center of universe
  centroid = new PVector( width/2.0, height/2.0, -200.0 );
  
  // Create new mesh factory
  TMeshFactory meshFactory = new TMeshFactory();
  
  // Create a new mesh object
  mesh = new TMesh();
  
  // Create sphere: createSphere(int iDimU, int iDimV, float iRadius) {
  mesh = meshFactory.createSphere(20, 20, 100) ;
  
  // Sphere Position set at centroid
  mesh.setPosition( centroid );
  
  // pick a random end position within a certain radius from the centroid
  end1 = new PVector( centroid.x + 300, centroid.y + 300, centroid.z + 300 );
  
  // subtract the vectors to get a direction
  path = PVector.sub( end1, centroid );
  path.normalize();
   
  mesh2 = new TMesh();
  mesh2 = meshFactory.createSphere( 20, 20, 100 );
  
  multiplier = 0;
  location = new PVector( centroid.x + (path.x * multiplier), centroid.y + (path.y * multiplier), centroid.z + (path.z * multiplier) );
  
  mesh2.setPosition ( location );
  mesh2.draw();

}

void draw() {
 
 background( 0 );
 stroke( 255, 0, 0 );
 fill( 0, 255, 0 );
  
 mesh.draw();
 
 PVector location = new PVector( centroid.x + (path.x * multiplier), centroid.y + (path.y * multiplier), centroid.z + (path.z * multiplier) );

 mesh2.setPosition ( location );
 mesh2.draw();
 
 if( multiplier > 300 || multiplier < 0 ) {
  away = !away;  
 } 
 
 if( away ) {
  multiplier += 1; 
 } else {
  multiplier -= 1; 
 }
   
}
