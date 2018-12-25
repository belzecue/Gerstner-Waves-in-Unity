using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SetVertexColorAsDepth : MonoBehaviour {
	void Start () {
		Mesh mesh = GetComponent<MeshFilter>().mesh;
        Vector3[] vertices = mesh.vertices;

        // create new colors array where the colors will be created.
        Color[] colors = new Color[vertices.Length];

        for (int i = 0; i < vertices.Length; i++) {
            colors[i] = Color.black;

            RaycastHit hit;
	       
	        // Does the ray intersect any objects excluding the player layer
	        if (Physics.Raycast(vertices[i], Vector3.down, out hit, Mathf.Infinity)) {
	        	colors[i].r = hit.distance;
	        }
	        else {
	        	colors[i].r = 0f;
	        }

            // set r to depth
        }

        // assign the array of colors to the Mesh.
        mesh.colors = colors;
	}
}
