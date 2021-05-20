using Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAC.Imp
{
    public interface IInventoryRepo
    {
        PageResult<Product> GetPagedResult(int pageIndex, int pageSize);
        ResponseCode AddUpdateInventory(Product product, string proc);
        ResponseCode DeleteInventory(Product product, string proc);
    }
}
