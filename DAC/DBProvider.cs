using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAC
{
    public class DBProvider
    {
        private static IDbContext _db;
        public static IDbContext Instance
        {
            get
            {
                if (_db == null)
                {
                    _db = new DbContext(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
                }
                return _db;
            }
        }
    }
}
