#property version   "1.00"

input int chart_limit=20;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
   EventSetTimer(60);
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   EventKillTimer();

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//void OnTick()
//    {
//     Print(Bid, Close[0], Close[1]);
//    }

void algo_tickvol()
   {
      long short_vol[];
      long long_vol[];
      long _tmp_value[1];
      for(int i=0;i<chart_limit;i++)
        {
         _tmp_value[0] = MarketInfo(Symbol(), MODE_TICKSIZE);
         if(Open[1] > Close[1])
           {
              ArrayCopy(short_vol, _tmp_value);
           }
         else
           {
              ArrayCopy(long_vol, _tmp_value);
           }
        }
      if(ArraySize(long_vol)>0)
        {
            for(int k=0;k<ArraySize(long_vol);k++)
              {
                  Print(long_vol[k]);
              }
        }
      if(ArraySize(short_vol)>0)
        {
            for(int j=0;j<ArraySize(short_vol);j++)
              {
                  Print(short_vol[j]);
              }
        }
   }

void algo()
   {
   
   double ema15 = iMA(NULL, 0, 15, 0, MODE_EMA, PRICE_CLOSE, 0);
   double ema60 = iMA(NULL, 0, 60, 0, MODE_EMA, PRICE_CLOSE, 0);
   double _tmp_value[1];
   double short_key = 0;
   double long_key = 0;
   for(int x=6;x>1;x--)
     {
      if(iOpen(Symbol(), 0, x) < iClose(Symbol(), 0 , x))
        {
         short_key = iOpen(Symbol(), 0, x);
        }
      if(iOpen(Symbol(), 0, x) > iClose(Symbol(), 0 , x))
        {
         long_key = iOpen(Symbol(), 0,x );
        }
      if(iOpen(Symbol(), 0, x) == iClose(Symbol(), 0 , x))
        {
         long_key = iOpen(Symbol(), 0, x);
         short_key = iOpen(Symbol(), 0, x);
        }
     }
   int total=OrdersTotal();
   if(total>0)
     {
      for(int pos=0;pos<total;pos++) 
       { 
        if(OrderSelect(pos,SELECT_BY_POS)==false) continue; 
        int order_id = OrderTicket();
        if(OrderType()==0)  // long
          {
           if(Close[0]<short_key)
             {
               OrderClose(order_id,1,Bid,0.1,Red);
             }
          }
        if(OrderType()==1)  // short
          {
           if(Close[0]>long_key)
             {
               OrderClose(order_id,1,Ask,0.1,Red);
             }
          }
       } 
    }
    else
      {
       if(ema15>ema60 && Close[0]>ema15)
           {
         
            OrderSend(Symbol(),OP_BUY,1,Ask,0.1,Low[0],2*Ask,NULL,0,0,clrGreen);
           }
      }
   }
   
 void test()
   {
      a = MarketInfo(Symbol(), MODE_TICKSIZE);
      b = MarketInfo(Symbol(), MODE_TICKVALUE);
      Print(a, b);
   }

void OnTick()
  {
   //algo();
   test();
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---

  }
