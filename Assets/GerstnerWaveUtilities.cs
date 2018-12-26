using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GersterWaveProperties {
	[Range(0, 1)]
	float contribution = 1.0f;
	float amplitude = 1.0f;
	float wavelength = 1.0f;
	float speed = 1.0f;

	[Range(0, 1)]
	float steepness = 0.0f;

	[Range(0, Mathf.PI * 2)]
	float yawAngle = 0.0f;

	public Vector2 GetDirection() {
		return new Vector2(Mathf.Cos(yawAngle), Mathf.Sin(yawAngle));
	}
}