/*
using System;
using UnityEditor;
using UnityEngine;

public class GerstnerDrawer : MaterialPropertyDrawer {
    public override void OnGUI(Rect position, MaterialProperty prop, String label, MaterialEditor editor) {
    	Vector4 wave = prop.vectorValue;

       	EditorGUI.BeginChangeCheck();
       	EditorGUI.showMixedValue = prop.hasMixedValue;

       	EditorGUILayout.FloatField("Amplitude", wave.x);
       	EditorGUILayout.FloatField("Wavelength", wave.y);
       	EditorGUILayout.FloatField("Speed", wave.z);
       	EditorGUILayout.Slider("Steepness", wave.w, 0f, 1f);
        
        if (EditorGUI.EndChangeCheck()) {
        	prop.vectorValue = wave;
        }

        EditorGUI.showMixedValue = false;

        Apply(prop);
    }
}
*/