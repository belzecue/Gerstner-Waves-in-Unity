using System;
using UnityEditor;
using UnityEngine;

public class WaveCreator : MonoBehaviour {
	public Material gerstnerExample;

	[Range(0f, 1f)]
	public float offsetStrength = 1;

	[Range(0f, 1f)]
	public float normalStrength = 1;
	
	[Range(0f, 1f)]
	public float steepness = 0;

	public int combined = 1;

	public int combined2 = 1;

	public GersterWaveProperties[] waves;
	public bool updateOnStartup;

	public void Start() {
		if (updateOnStartup) {
			SoftUpdate();
			HardUpdate();
		}
	}

	public void SoftUpdate() {
		gerstnerExample.SetFloat("_offsetStrength", offsetStrength);
		gerstnerExample.SetFloat("_normalStrength", normalStrength);
		gerstnerExample.SetFloat("_steepness", steepness);
		gerstnerExample.SetInt("_combined", combined);
		gerstnerExample.SetInt("_combined2", combined2);
	}

	public void HardUpdate() {
		float[] amplitude = new float[waves.Length];
		float[] wavelength = new float[waves.Length];
		float[] speed = new float[waves.Length];
		Vector4[] direction = new Vector4[waves.Length];

		for (int i = 0; i < waves.Length; i++) {
			amplitude[i] = waves[i].amplitude;
			wavelength[i] = waves[i].wavelength;
			speed[i] = waves[i].speed;
			direction[i] = waves[i].GetDirection();
		}

		gerstnerExample.SetFloatArray("_amplitude", amplitude);
		gerstnerExample.SetFloatArray("_wavelength", wavelength);
		gerstnerExample.SetFloatArray("_speed", speed);
		gerstnerExample.SetVectorArray("_direction", direction);
		gerstnerExample.SetFloat("_numWaves", (float)waves.Length);
	}
}

[Serializable]
public class GersterWaveProperties {
	public float amplitude = 1.0f;
	public float wavelength = 1.0f;
	public float speed = 1.0f;

	[Range(0, Mathf.PI * 2)]
	public float yawAngle = 0.0f;

	public Vector3 GetDirection() {
		return new Vector3(Mathf.Cos(yawAngle), 0f, Mathf.Sin(yawAngle));
	}
}

[CustomEditor(typeof(WaveCreator))]
public class WaveCreatorEditor : Editor {
	public override void OnInspectorGUI() {
		WaveCreator wc = (WaveCreator)target;

		DrawDefaultInspector();

		if (GUI.changed && wc.gerstnerExample != null) {
			wc.SoftUpdate();
		}

		if (wc.gerstnerExample == null) {
			EditorGUILayout.HelpBox("material not set", MessageType.Warning);
		}
		else if (wc.gerstnerExample.shader != Shader.Find("Gerstner/Example")) {
			EditorGUILayout.HelpBox("wrong shader", MessageType.Error);
		}
		else if (wc.waves.Length < 1) {
			EditorGUILayout.HelpBox("array length < 1", MessageType.Error);
		}
		else if (wc.waves.Length > 10) {
			EditorGUILayout.HelpBox("array length > 10", MessageType.Error);
		}
		else {	
			if (GUILayout.Button("Update")) {
				wc.HardUpdate();
			}
		}
	}
}