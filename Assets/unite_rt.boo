import UnityEngine

class unite_rt (MonoBehaviour): 
  public _rt_0 as RenderTexture
  public _rt_1 as RenderTexture
  public _rt_2 as RenderTexture
  _material as Material
  _mesh as Mesh
  _count = 0.0f
  _select = 0
  _effect = true
  _cam0 as GameObject
  _cam1 as GameObject
  def Start ():
    _cam0 = GameObject.Find('Camera0')
    cam = _cam0.GetComponent[of Camera]()
    cam.depthTextureMode = DepthTextureMode.Depth
    _cam1 = GameObject.Find('Camera1')
    cam = _cam1.GetComponent[of Camera]()
    cam.depthTextureMode = DepthTextureMode.Depth
    _material = CreateMaterial()
    _mesh = CreateMesh()
  def Update ():
    _count += Time.deltaTime
    transform.position = Vector3(Mathf.Sin(_count) * 2.0f, 0.0f, -5.0f)
  def OnRenderImage(src as RenderTexture, dst as RenderTexture):
    if _select == 0:
      Graphics.Blit(_rt_0, dst)
      Graphics.SetRenderTarget(dst)
      RenderTexture(_rt_1)
      RenderTexture(_rt_2)
    elif _select == 1:
      Graphics.Blit(_rt_0, dst)
    elif _select == 2:
      Graphics.Blit(_rt_1, dst)
    elif _select == 3:
      Graphics.Blit(_rt_2, dst)
    else:
      pass
  def RenderTexture(rt as RenderTexture):
      _material.mainTexture = rt
      _material.SetPass(0);
      GL.PushMatrix()
      GL.LoadOrtho()
      GL.Begin(GL.TRIANGLE_STRIP);
      GL.Color(Color(1.0f, 1.0f, 1.0f, 1.0f))
      GL.TexCoord2(0, 0)
      GL.Vertex3(0, 0, 0)
      GL.TexCoord2(0, 1)
      GL.Vertex3(0, 1, 0)
      GL.TexCoord2(1, 0)
      GL.Vertex3(1, 0, 0)
      GL.TexCoord2(1, 1);
      GL.Vertex3(1, 1, 0);
      GL.End()
      GL.PopMatrix()
  def OnGUI():
    _select = GUILayout.SelectionGrid(_select, ('cam0+cam1+cam2', 'cam0', 'cam1', 'cam2'), 1)
    _effect = GUILayout.Toggle(_effect, 'post effect')
    //_cam0.GetComponent[of NoiseEffect]().enabled = _effect
  private def CreateMesh() as Mesh:
    mesh = Mesh()
    pos = (
        Vector3(-1,  1, 0),
        Vector3(-1, -1, 0),
        Vector3( 1,  1, 0),
        Vector3( 1, -1, 0))
    nml = (
        Vector3(0, 0, -1),
        Vector3(0, 0, -1),
        Vector3(0, 0, -1),
        Vector3(0, 0, -1))
    uv = (
        Vector2(0, 1),
        Vector2(0, 0),
        Vector2(1, 1),
        Vector2(1, 0))
    tri = (0, 2, 1, 1, 2, 3)
    mesh.vertices = pos
    mesh.normals = nml
    mesh.uv = uv
    mesh.triangles = tri
    mesh.Optimize()
    return mesh
  private def CreateMaterial() as Material:
    mat = Material(Resources.Load[of Shader]('SpeedBlurShader'))
    return mat
