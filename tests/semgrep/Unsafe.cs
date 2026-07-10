using System.IO;
using System.Runtime.Serialization.Formatters.Binary;

static class UnsafeExample
{
    static object Read(Stream stream) => new BinaryFormatter().Deserialize(stream);
}
