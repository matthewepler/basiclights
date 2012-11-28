// Art of Graphics Programming
// based on Patrick Hebron's Section Example 004: "Storing Geometries: A Generic Approach" Example Stage: D (Part B)
//
// Matthew Epler, 2012 

import processing.opengl.*;
import java.util.Set;

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

boolean normals = false;

void setup() {

  size( 800, 600, OPENGL );
  
  // set center of universe
  centroid = new PVector( width/2.0, height/2.0, -200.0 );
  
  // Create new mesh factory
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

void draw() {
 
 background( 0 );
 stroke( 255, 0, 0 );
 fill( 0, 255, 0 );
  
 for( int i = 0; i < totalSpheres; i++ )
 {
   TMesh thisSphere = allSpheres.get( i );
   PVector path = allPaths.get( i ); 
   PVector location = new PVector( centroid.x + (path.x * multiplier), centroid.y + (path.y * multiplier), centroid.z + (path.z * multiplier) );
   thisSphere.setPosition ( location );
   thisSphere.draw();
 }
 
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
