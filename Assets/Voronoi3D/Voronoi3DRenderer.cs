using UnityEngine;
using System.Collections;

public class Voronoi3DRenderer : MonoBehaviour {

	Voronoi3D voronoi;

	void Start () {

		voronoi = GetComponentInParent<Voronoi3D>();
	
	}
	
	void OnWillRenderObject(){

		var mat = renderer.material;
		mat.SetTexture("_pointData", voronoi.pointData);
		mat.SetInt("_pointNum", voronoi.pointNum);
	
	}
}
