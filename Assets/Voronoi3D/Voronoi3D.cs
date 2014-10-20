using UnityEngine;
using System.Collections;

public class Voronoi3D : MonoBehaviour {

	public Texture2D pointData;
	public int pointNum = 100;
	public GameObject quad;
	public Vector3 offset = Vector3.zero;
	public float scale = 1f;

	void Start () {

		var num = pointNum;

		pointData = new Texture2D(num, 2);
		pointData.filterMode = FilterMode.Point;
		pointData.wrapMode = TextureWrapMode.Clamp;

		var pixels = new Color[num*2];

		for(var i=0; i<num; ++i)
		{
			var pos = new Vector3(Random.value, Random.value, Random.value);
			pos = pos * scale + offset;

			pixels[i] = new Color(pos.x, pos.y, pos.z, 1f);
			pixels[i+num] = new Color(Random.value, Random.value, Random.value, 0.2f);
		}

		pointData.SetPixels(pixels);
		pointData.Apply();

		var quadNum = 20;
		for(var i=0; i<quadNum; ++i)
		{
			var pos = transform.position;
			pos.z = (((float)i / quadNum) - 0.5f) * 0.5f;
			var obj = Instantiate(quad, pos, Quaternion.identity) as GameObject;
			obj.transform.parent = transform;
		}
	}
	
	void Update () {
	
	}
}
