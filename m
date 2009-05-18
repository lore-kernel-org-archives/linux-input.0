From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: [PATCH 1/3 ] hid: Multitouch support for the N-Trig touchscreen
Date: Tue, 19 May 2009 00:10:08 +0200
Message-ID: <2DCAF4CF-1408-4C2E-9713-5BD901899953@enac.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:51460 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754039AbZERWj5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 May 2009 18:39:57 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, jkosina@suze.cz, Henrik Rydberg <rydberg@euromail.se>
Cc: Mohamed Ikbel Boulabiar <medikbel@lii-enac.fr>, Sebastien Hamdani <sebastien.hamdani@gmail.com>


Added constants to hid.h for all digitizer usages (including the new  
multitouch ones), and updated hid-debug.c  to support the new MT  
input constants such as ABS_MT_POSITION_X.


Signed-off-by: Stephane Chatty <chatty@enac.fr>

diff -uprN a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
--- a/drivers/hid/hid-debug.c	2009-05-09 02:14:14.000000000 +0200
+++ b/drivers/hid/hid-debug.c	2009-05-16 16:06:56.000000000 +0200
@@ -137,6 +137,14 @@ static const struct hid_usage_entry hid_
      {0, 0x44, "BarrelSwitch"},
      {0, 0x45, "Eraser"},
      {0, 0x46, "TabletPick"},
+    {0, 0x47, "Confidence"},
+    {0, 0x48, "Width"},
+    {0, 0x49, "Height"},
+    {0, 0x51, "ContactID"},
+    {0, 0x52, "InputMode"},
+    {0, 0x53, "DeviceIndex"},
+    {0, 0x54, "ContactCount"},
+    {0, 0x55, "ContactMaximumNumber"},
    { 15, 0, "PhysicalInterfaceDevice" },
      {0, 0x00, "Undefined"},
      {0, 0x01, "Physical_Interface_Device"},
@@ -514,9 +522,11 @@ static const char *events[EV_MAX + 1] =
  	[EV_FF_STATUS] = "ForceFeedbackStatus",
  };

-static const char *syncs[2] = {
+static const char *syncs[3] = {
  	[SYN_REPORT] = "Report",		[SYN_CONFIG] = "Config",
+	[SYN_MT_REPORT] = "MT Report"
  };
+
  static const char *keys[KEY_MAX + 1] = {
  	[KEY_RESERVED] = "Reserved",		[KEY_ESC] = "Esc",
  	[KEY_1] = "1",				[KEY_2] = "2",
@@ -734,8 +744,17 @@ static const char *absolutes[ABS_MAX + 1
  	[ABS_HAT2Y] = "Hat2Y",		[ABS_HAT3X] = "Hat3X",
  	[ABS_HAT3Y] = "Hat 3Y",		[ABS_PRESSURE] = "Pressure",
  	[ABS_DISTANCE] = "Distance",	[ABS_TILT_X] = "XTilt",
-	[ABS_TILT_Y] = "YTilt",		[ABS_TOOL_WIDTH] = "Tool Width",
+	[ABS_TILT_Y] = "YTilt",		[ABS_TOOL_WIDTH] = "ToolWidth",
  	[ABS_VOLUME] = "Volume",	[ABS_MISC] = "Misc",
+	[ABS_MT_TOUCH_MAJOR] = "MTMajor",
+	[ABS_MT_TOUCH_MINOR] = "MTMinor",
+	[ABS_MT_WIDTH_MAJOR] = "MTMajorW",
+	[ABS_MT_WIDTH_MINOR] = "MTMinorW",
+	[ABS_MT_ORIENTATION] = "MTOrientation",
+	[ABS_MT_POSITION_X] = "MTPositionX",
+	[ABS_MT_POSITION_Y] = "MTPositionY",
+	[ABS_MT_TOOL_TYPE] = "MTToolType",
+	[ABS_MT_BLOB_ID] = "MTBlobID",
  };

  static const char *misc[MSC_MAX + 1] = {
diff -uprN a/include/linux/hid.h b/include/linux/hid.h
--- a/include/linux/hid.h	2009-05-09 02:14:14.000000000 +0200
+++ b/include/linux/hid.h	2009-05-16 16:44:24.000000000 +0200
@@ -238,6 +238,37 @@ struct hid_item {
  #define HID_GD_RIGHT		0x00010092
  #define HID_GD_LEFT		0x00010093

+#define HID_DG_DIGITIZER	0x000d0001
+#define HID_DG_PEN		0x000d0002
+#define HID_DG_LIGHTPEN		0x000d0003
+#define HID_DG_TOUCHSCREEN	0x000d0004
+#define HID_DG_TOUCHPAD		0x000d0005
+#define HID_DG_STYLUS		0x000d0020
+#define HID_DG_PUCK		0x000d0021
+#define HID_DG_FINGER		0x000d0022
+#define HID_DG_TIPPRESSURE	0x000d0030
+#define HID_DG_BARRELPRESSURE	0x000d0031
+#define HID_DG_INRANGE		0x000d0032
+#define HID_DG_TOUCH		0x000d0033
+#define HID_DG_UNTOUCH		0x000d0034
+#define HID_DG_TAP		0x000d0035
+#define HID_DG_TABLETFUNCTIONKEY	0x000d0039
+#define HID_DG_PROGRAMCHANGEKEY	0x000d003a
+#define HID_DG_INVERT		0x000d003c
+#define HID_DG_TIPSWITCH	0x000d0042
+#define HID_DG_TIPSWITCH2	0x000d0043
+#define HID_DG_BARRELSWITCH	0x000d0044
+#define HID_DG_ERASER		0x000d0045
+#define HID_DG_TABLETPICK	0x000d0046
+#define HID_DG_CONFIDENCE	0x000d0047
+#define HID_DG_WIDTH		0x000d0048
+#define HID_DG_HEIGHT		0x000d0049
+#define HID_DG_CONTACTID	0x000d0051
+#define HID_DG_INPUTMODE	0x000d0052
+#define HID_DG_DEVICEINDEX	0x000d0053
+#define HID_DG_CONTACTCOUNT	0x000d0054
+#define HID_DG_CONTACTMAX	0x000d0055
+
  /*
   * HID report types --- Ouch! HID spec says 1 2 3!
   */

