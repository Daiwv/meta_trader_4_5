//+------------------------------------------------------------------+
//|                                                      feeling.mq4 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      ""
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
      //test();
      double ema15 = iMA(NULL, 0, 15, 0, MODE_EMA, PRICE_CLOSE, 1);
      double ema60 = iMA(NULL, 0, 60, 0, MODE_EMA, PRICE_CLOSE, 1);
      int total=OrdersTotal();
      double minstoplevel=MarketInfo(Symbol(),MODE_STOPLEVEL); 
      string _name = Symbol();
      int length = Digits;
      Print("digits=", length);
      double _min = minstoplevel/10000;
      Print("Minimum Stop Level=",_min," points"); 
      Print("Now=", Bid);
      Print("Now=", Bid-2*_min*Point);

      double stoploss = 0;
      double takeprofit = 0;
      if(total <= 0)
         {

         if(ema15 > ema60) // short
           {
            if( Close[2] > Open[2] && Close[1] < Open[1] && Close[1] < Open[2] )
              {
               if(minstoplevel==0)
                 {
                  stoploss=High[2];
                  takeprofit=ema15;
                 }
               else
                 {
                  stoploss=NormalizeDouble(Bid+_min,Digits); 
                  takeprofit=NormalizeDouble(Bid-2*_min,Digits); 
                 }
                  OrderSend(Symbol(), OP_SELL, 0.1, NormalizeDouble(Bid, Digits), 0, stoploss, takeprofit, NULL, 0, 0, clrGreen);
           
              }
            }
         if(ema15 < ema60)
           {
            if( Close[2] < Open[2] && Close[1] > Open[1] && Close[1] > Open[2] )
              {
              if(minstoplevel==0)
                 {
                  stoploss=Low[2];
                  takeprofit=ema15;
                 }
               else
                 {
                  stoploss=NormalizeDouble(Ask-_min,Digits); 
                  takeprofit=NormalizeDouble(Ask+2*_min,Digits); 
                 }

               OrderSend(Symbol(), OP_BUY, 0.1, NormalizeDouble(Ask, Digits), 0, stoploss, takeprofit, NULL, 0, 0, clrRed);
           
              }
           }
       }
  }
  

  
void test()
   {
Print(MarketInfo(Symbol(),MODE_TICKSIZE)); 
   //Print(MarketInfo(Symbol(),MODE_TICKSIZE));  

   }
//+------------------------------------------------------------------+
