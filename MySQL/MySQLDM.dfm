object DMmySQL: TDMmySQL
  OldCreateOrder = False
  Left = 1013
  Top = 167
  Height = 278
  Width = 117
  object sconnMySQL: TSQLConnection
    ConnectionName = 'MySQLConnection'
    DriverName = 'MySQL'
    GetDriverFunc = 'getSQLDriverMYSQL'
    LibraryName = 'dbexpmysql.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=MySQL'
      'HostName=localhost'
      'Database=aluga'
      'User_Name=root'
      'Password='
      'BlobSize=-1'
      'ErrorResourceFile='
      'LocaleCode=0000')
    TableScope = [tsSynonym, tsTable, tsView]
    VendorLib = 'libmysql.dll'
    Connected = True
    Left = 40
    Top = 8
  end
  object sdsMySQL: TSQLDataSet
    CommandText = 'select * from produtos'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = sconnMySQL
    Left = 40
    Top = 56
  end
  object dspMySQL: TDataSetProvider
    DataSet = sdsMySQL
    Left = 40
    Top = 104
  end
  object cdsMySQL: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'dspMySQL'
    ReadOnly = True
    Left = 40
    Top = 152
  end
  object dsMySQL: TDataSource
    DataSet = cdsMySQL
    Left = 40
    Top = 200
  end
end
