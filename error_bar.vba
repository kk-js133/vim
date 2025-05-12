Sub CreateScatterWithCustomErrorBars()
    Dim ws As Worksheet
    Dim chartObj As ChartObject
    Dim chartSeries As Series
    Dim lastRow As Long
    
    Set ws = ThisWorkbook.Sheets("Sheet1")
    
    ' データの最終行を取得
    lastRow = ws.Cells(ws.Rows.Count, "A").End(xlUp).Row
    MsgBox lastRow
    
    ' 既存のグラフがあれば削除
    For Each chartObj In ws.ChartObjects
        chartObj.Delete
    Next chartObj

    ' 散布図を作成
    Set chartObj = ws.ChartObjects.Add(Left:=100, Top:=50, Width:=400, Height:=300)
    chartObj.Chart.ChartType = xlXYScatterLines ' 直線つき散布図
    
    ' データ系列を追加
    chartObj.Chart.SeriesCollection.NewSeries
    Set chartSeries = chartObj.Chart.SeriesCollection(1)
    
    With chartSeries
        .XValues = ws.Range("A1:A" & lastRow)
        .Values = ws.Range("B1:B" & lastRow)
        .Name = "データ"
        '.Border.ColorIndex = xlAutomatic
        
        ' カスタムエラーバーを追加（Y方向）
        .HasErrorBars = True
        .ErrorBar Direction:=xlY, Include:=xlBoth, Type:=xlCustom, _
                  Amount:=ws.Range("D1:D" & lastRow), _
                  MinusValues:=ws.Range("C1:C" & lastRow)
        .ErrorBar Direction:=xlX, _
                  Include:=xlBoth, _
                  Type:=xlFixedValue, _
                  Amount:=0
    End With
End Sub