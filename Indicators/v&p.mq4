//+------------------------------------------------------------------+
//|                                                          v&p.mq4 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#include <MovingAverages.mqh>

#property strict
#property indicator_separate_window
#property indicator_buffers 2
#property indicator_plots   2
//--- plot long
#property indicator_label1  "long"
#property indicator_type1   DRAW_LINE
#property indicator_color1  clrRed
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1
//--- plot short
#property indicator_label2  "short"
#property indicator_type2   DRAW_LINE
#property indicator_color2  clrGreen
#property indicator_style2  STYLE_SOLID
#property indicator_width2  1
//--- input parameters
//input int      ema=15;
//--- indicator buffers
double         longBuffer[];
double         shortBuffer[];
double         longVolBuffer[];
double         shortVolBuffer[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   IndicatorBuffers(4);
   SetIndexBuffer(0,longBuffer);
   SetIndexBuffer(1,shortBuffer);
   SetIndexBuffer(2,longVolBuffer);
   SetIndexBuffer(3,shortVolBuffer);
   
//--- indicator line
   SetIndexStyle(0,DRAW_LINE);
   SetIndexBuffer(0,longBuffer);
   SetIndexStyle(1, DRAW_LINE);
   SetIndexBuffer(1, shortBuffer);
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+

//int calc()
//   {
//      int    i,pos;
//      
//      ArraySetAsSeries(shortBuffer,false);
//      ArraySetAsSeries(longBuffer,false);
//      ArraySetAsSeries(longVolBuffer,false);
//      ArraySetAsSeries(shortVolBuffer,false);
//      
//      if(prev_calculated<1)
//        {
//         longBuffer[0]=0.0;
//         shortBuffer[0]=0.0;
//         longVolBuffer[0]=0.0;
//         shortVolBuffer[0]=0.0;
//        }
//   //--- calculate position
//      pos=prev_calculated-1;
//      if(pos<15)
//        {
//         pos=15;
//        }
//   //--- typical price and its moving average
//      for(i=pos; i<rates_total; i++)
//        {
//         if(open[i] > close[i])
//           {
//            shortVolBuffer[i]=1.0 * tick_volume[i];
//            longVolBuffer[i]=longVolBuffer[i-1];
//           }
//         if(open[i] <= close[i])
//           {
//            longVolBuffer[i]=1.0 * tick_volume[i];
//            shortVolBuffer[i]=shortVolBuffer[i-1];
//           }
//          longBuffer[i]=ExponentialMA(i, 15, tick_volume[0], longVolBuffer);
//          shortBuffer[i]=ExponentialMA(i, 15, tick_volume[0], shortVolBuffer);
//        }   
//   }

int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
      int    i,pos;
      
      ArraySetAsSeries(shortBuffer,false);
      ArraySetAsSeries(longBuffer,false);
      ArraySetAsSeries(longVolBuffer,false);
      ArraySetAsSeries(shortVolBuffer,false);
      
      if(prev_calculated<1)
        {
         longBuffer[0]=0.0;
         shortBuffer[0]=0.0;
         longVolBuffer[0]=0.0;
         shortVolBuffer[0]=0.0;
        }
   //--- calculate position
      pos=prev_calculated-1;
      if(pos<15)
        {
         pos=15;
        }
   //--- typical price and its moving average
      for(i=pos; i<rates_total; i++)
        {
         if(open[i] > close[i])
           {
            shortVolBuffer[i]=1.0 * tick_volume[i];
            longVolBuffer[i]=longVolBuffer[i-1];
           }
         if(open[i] <= close[i])
           {
            longVolBuffer[i]=1.0 * tick_volume[i];
            shortVolBuffer[i]=shortVolBuffer[i-1];
           }
          longBuffer[i]=SimpleMA(i, 15, longVolBuffer);
          shortBuffer[i]=SimpleMA(i, 15, shortVolBuffer);
        }   
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
