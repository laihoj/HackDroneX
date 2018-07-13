//Declaring variables for Bluetooth
ArrayList<String> devicesDiscovered = new ArrayList();
KetaiBluetooth bt;
String info = "";
KetaiList klist;

////********************************************************************
//// The following code is required to enable bluetooth at startup.
////********************************************************************
//void onCreate(Bundle savedInstanceState) {
//  super.onCreate(savedInstanceState);
//  bt = new KetaiBluetooth(this);
//}

//void onActivityResult(int requestCode, int resultCode, Intent data) {
//  bt.onActivityResult(requestCode, resultCode, data);
//}

////********************************************************************

//void onKetaiListSelection(KetaiList klist)
//{
//  String selection = klist.getSelection();
//  bt.connectToDeviceByName(selection);

//  //dispose of list for now
//  klist = null;
//}
