using DAC.Imp;
using Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using System.Data;
using DapperExtensions;

namespace DAC
{
    public class InventoryRepo : IInventoryRepo
    {
        public PageResult<Product> GetPagedResult(int pageIndex, int pageSize)
        {
            IList<ISort> sort = new List<ISort> { Predicates.Sort<Product>(p => p.PkProduct) };
            using (var db = DBProvider.Instance)
            {
                var count = db.Connection.Count<Product>(null);
                IEnumerable<Product> product = db.Connection.GetPage<Product>(null, sort, pageIndex - 1, pageSize);
                return new PageResult<Product>(product, pageIndex, pageSize, count);
            }
        }
        public ResponseCode AddUpdateInventory(Product product, string proc)
        {
            var parameter = new DynamicParameters();
            parameter.Add("@pkProduct", product.PkProduct);
            parameter.Add("@Name", product.Name);
            parameter.Add("@Description", product.Description);
            parameter.Add("@Price", product.Price);

            using (var db = DBProvider.Instance)
            {
                return db.Connection.Query<ResponseCode>(proc, parameter, null, true, null, commandType: CommandType.StoredProcedure).FirstOrDefault();
            }
        }
        public ResponseCode DeleteInventory(Product product, string proc)
        {
            var parameter = new DynamicParameters();
            parameter.Add("@pkProduct", product.PkProduct);
            using (var db = DBProvider.Instance)
            {
                return db.Connection.Query<ResponseCode>(proc, parameter, null, true, null, commandType: CommandType.StoredProcedure).FirstOrDefault();
            }
        }
    }
}
