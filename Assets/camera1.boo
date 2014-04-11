import UnityEngine

class camera1 (MonoBehaviour): 
  public _src as RenderTexture
  _material as Material
  def Start ():
    _material = CreateMaterial()
  def Update ():
    pass
  def OnPostRender():
    Graphics.SetRenderTarget(camera.targetTexture.colorBuffer, _src.depthBuffer)
    //GL.Clear(false, true, Color.clear, 1.0f)
    //Graphics.Blit(_rt_0, dst)
    //Graphics.SetRenderTarget(dst)
    _material.mainTexture = _src
    _material.SetPass(0)
    GL.PushMatrix()
    GL.LoadOrtho()
    GL.LoadIdentity()
    for i in range(8):
      //m = Matrix4x4.TRS(Vector3(-0.5f, -0.5f, 0.0f), Quaternion.identity, Vector3.one)
      //GL.MultMatrix(m)
      //m = Matrix4x4.Scale(Vector3(1.0f + i * 0.02f, 1.1f, 1.1f))
      //GL.MultMatrix(m)
      //m = Matrix4x4.TRS(Vector3(0.5f, 0.5f, 0.0f), Quaternion.identity, Vector3.one)
      //GL.MultMatrix(m)
      sz = 0.5f + i * 0.05f
      GL.Begin(GL.TRIANGLE_STRIP);
      GL.Color(Color(1.0f, 1.0f, 1.0f, 1.0f))
      GL.TexCoord2(0, 0)
      GL.Vertex3(0.5f - sz, 0.5f - sz, 0)
      GL.TexCoord2(0, 1)
      GL.Vertex3(0.5f - sz, 0.5f + sz, 0)
      GL.TexCoord2(1, 0)
      GL.Vertex3(0.5f + sz, 0.5f - sz, 0)
      GL.TexCoord2(1, 1);
      GL.Vertex3(0.5f + sz, 0.5f + sz, 0)
      GL.End()
    GL.PopMatrix()
  def CreateMaterial():
    mat = Material(Resources.Load[of Shader]('SpeedBlurShader'))
    return mat
