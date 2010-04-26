From: Marcin Tolysz <tolysz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Actual code fixing Sixaxis
Date: Mon, 26 Apr 2010 22:50:28 +0100
Message-ID: <1272318628.3269.44.camel@zony.bied.prout.be>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-vJhYRyX51YYOSGo4C3JA"
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org, hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org
List-Id: linux-input@vger.kernel.org


--=-vJhYRyX51YYOSGo4C3JA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Add change descriptor bit(works on any usb/bt device)
 Make use of physical minimum and maximum while reporting values to userspace
 Add mini howto comment next to replace hid code
 Assume physical maximum is always signed allowing inverting axes by giving max < min
 Swap a few bits in Sixaxis report as they have wrong(hid-wise) endianess
 Sixaxis specific changes
  and the most important bit modified HID descriptor:
 05 01 09 04 A1 01 09 04 A1 02 85 01 75 08 95 01 80 05 09 75 01 95 04
 14 25 01 09 0C 09 0A 09 09 09 0B 81 02 05 01 09 01 A1 02 75 01 14 25
 01 95 04 09 90 09 92 09 91 09 93 81 02 C0 05 09 95 09 09 08 09 07 09
 06 09 05 09 04 09 02 09 01 09 03 09 0D 81 02 75 01 95 0F 80 14 26 FF
 00 35 80 45 7F 05 01 09 01 75 08 95 02 A0 09 30 09 31 81 02 C0 09 05
 A0 09 32 09 33 81 02 C0 75 08 95 04 80 75 08 95 0C 09 46 34 44 81 02
 75 08 95 0F 80 75 10 95 01 16 80 01 26 7F 02 45 80 35 7F 09 33 81 02
 35 80 45 7F 09 34 81 02 95 02 14 26 00 04 36 01 FE 46 00 02 09 35 09
 36 81 02 14 26 FF 00 34 46 FF 00 75 08 95 30 91 02 75 08 95 30 B1 02
 C0 A1 02 85 02 75 08 95 30 B1 02 C0 A1 02 85 EE 75 08 95 30 B1 02 C0
 A1 02 85 EF 75 08 95 30 B1 02 C0 C0
  convert it into binary using eg. hex2bin.sh and save to
   /lib/firmware/hid/0003:054C:0268:0111.bin

The two attachments are descriptor as .h file and in my own smart(I have a compiler written in Haskel form/to this format and it could possibly be released under GPL). 
The descriptor is functional but it could be made better... the accelerometers work fine. 
PS. as soon as BT(standard) will start working it will be sufficient to provide fixed HID description.

 Signed-off-by: Marcin Tolysz <tolysz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/hid/hid-core.c |   67 +++++++++++++++++++++++++++++++++++++++++++----
 drivers/hid/hid-sony.c |   19 +++++++++++++
 2 files changed, 80 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 2e2aa75..bb40a19 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -27,6 +27,7 @@
 #include <linux/wait.h>
 #include <linux/vmalloc.h>
 #include <linux/sched.h>
+#include <linux/firmware.h>
 
 #include <linux/hid.h>
 #include <linux/hiddev.h>
@@ -333,10 +334,8 @@ static int hid_parser_global(struct hid_parser *parser, struct hid_item *item)
 		return 0;
 
 	case HID_GLOBAL_ITEM_TAG_PHYSICAL_MAXIMUM:
-		if (parser->global.physical_minimum < 0)
-			parser->global.physical_maximum = item_sdata(item);
-		else
-			parser->global.physical_maximum = item_udata(item);
+	/* always signed value, if it is less then minimum we need to invert axis */
+		parser->global.physical_maximum = item_sdata(item);
 		return 0;
 
 	case HID_GLOBAL_ITEM_TAG_UNIT_EXPONENT:
@@ -642,6 +641,10 @@ int hid_parse_report(struct hid_device *device, __u8 *start,
 	struct hid_item item;
 	__u8 *end;
 	int ret;
+	const struct firmware *fw;
+	int fw_fail;
+	const char *file;
+
 	static int (*dispatch_type[])(struct hid_parser *parser,
 				      struct hid_item *item) = {
 		hid_parser_main,
@@ -652,10 +655,39 @@ int hid_parse_report(struct hid_device *device, __u8 *start,
 
 	if (device->driver->report_fixup)
 		device->driver->report_fixup(device, start, size);
+	/* Now try to load a hid descriptor from a file firmware
+	if succesful ignoring this fixup thing */
+   /*
+  Mini howto: fixing the descriptor:
+  1) dump it from /debug/hid/!!device!!/rdesc
+  2) copy 1st line &edit it
+  3) convert to bin eg. cat descriptor.txt | hex2bin.sh > descriptor.bin
+
+----hex2bin.sh
+#!/bin/bash
+echo -n -e $(tr -d '[:space:]' | sed 's/../\\x&/g')
+4) place in /lib/firmware/hid/... where the location is provided by kern.log
+*/
+	file = kasprintf(GFP_KERNEL, "hid/%04X:%04X:%04X:%04X.bin",
+			device->bus, device->vendor, device->product, device->version);
+
+	fw_fail = request_firmware(&fw, file, &device->dev);
+
+	if (fw_fail)
+		pr_info("To relace HID descriptor place it in /lib/firmaware/%s\n", file);
+	else{
+		start = fw->data;
+		size = fw->size;
+		pr_info("HID descriptor relaced with /lib/firmaware/%s\n", file);
+	}
+	kfree(file);
 
 	device->rdesc = kmalloc(size, GFP_KERNEL);
-	if (device->rdesc == NULL)
+	if (device->rdesc == NULL) {
+		if (!fw_fail)
+			release_firmware(fw);
 		return -ENOMEM;
+	}
 	memcpy(device->rdesc, start, size);
 	device->rsize = size;
 
@@ -692,6 +724,8 @@ int hid_parse_report(struct hid_device *device, __u8 *start,
 				dbg_hid("unbalanced delimiter at end of report description\n");
 				goto err;
 			}
+			if (!fw_fail)
+				release_firmware(fw);
 			vfree(parser);
 			return 0;
 		}
@@ -699,6 +733,8 @@ int hid_parse_report(struct hid_device *device, __u8 *start,
 
 	dbg_hid("item fetching failed at offset %d\n", (int)(end - start));
 err:
+	if (!fw_fail)
+		release_firmware(fw);
 	vfree(parser);
 	return ret;
 }
@@ -878,6 +914,25 @@ static void hid_process_event(struct hid_device *hid, struct hid_field *field,
 }
 
 /*
+ * Translate values from logical to physical, exponent is still missing.
+ */
+static __s32 convert_to_physical(__s32 x, struct hid_field *field)
+{
+	__s32 min = field->logical_minimum;
+	__s32 max = field->logical_maximum;
+	__s32 pmin = field->physical_minimum;
+	__s32 pmax = field->physical_maximum;
+/*	__s32 uexp = field->unit_exponent; need to find a way how to use it */
+
+	if ((pmin == pmax) /* would give pmin and covers the case ==0 */
+	 || (pmin == min && pmax == max) /* would do nothing */
+	 || (min == max)) /* would be div by 0 */
+		return x;
+	else
+		return (pmax - pmin)*(x - min) / (max - min) + pmin;
+}
+
+/*
  * Analyse a received field, and fetch the data from it. The field
  * content is stored for next report processing (we do differential
  * reporting to the layer).
@@ -911,7 +966,7 @@ static void hid_input_field(struct hid_device *hid, struct hid_field *field,
 	for (n = 0; n < count; n++) {
 
 		if (HID_MAIN_ITEM_VARIABLE & field->flags) {
-			hid_process_event(hid, field, &field->usage[n], value[n], interrupt);
+			hid_process_event(hid, field, &field->usage[n], convert_to_physical(value[n], field), interrupt);
 			continue;
 		}
 
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 7502a4b..3e094e4 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -45,6 +45,24 @@ static void sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 }
 
 /*
+ * There is a few bits that has to be shifted around to make this report more compatibile with
+ * HID standard descriptions, and we want it to be parsable by standard driver
+ */
+static int sony_raw_event(struct hid_device *hdev, struct hid_report *report, __u8 *rd, int size)
+{
+ /* for sixaxis connected via usb. */
+	if (rd[0] == 0x01 && size == 49) {
+		swap(rd[41], rd[42]);
+		swap(rd[43], rd[44]);
+		swap(rd[45], rd[46]);
+		swap(rd[47], rd[48]);
+	}
+
+return 0;
+}
+
+
+/*
  * Sending HID_REQ_GET_REPORT changes the operation mode of the ps3 controller
  * to "operational".  Without this, the ps3 controller will not report any
  * events.
@@ -151,6 +169,7 @@ static struct hid_driver sony_driver = {
 	.probe = sony_probe,
 	.remove = sony_remove,
 	.report_fixup = sony_report_fixup,
+	.raw_event = sony_raw_event,
 };
 
 static int __init sony_init(void)
-- 
1.7.0.5



--=-vJhYRyX51YYOSGo4C3JA
Content-Disposition: attachment; filename="sixaxis.h"
Content-Type: text/x-chdr; name="sixaxis.h"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

rdesc = {
 0x05, 0x01,        //  GUsagePage Generic Desktop
 0x09, 0x04,        //  LUsage 0x04 [Joystick]
 0xA1, 0x01,        //  MCollection Application (mouse, keyboard)
  0x09, 0x04,       //  LUsage 0x04 [Joystick]
  0xA1, 0x02,       //  MCollection Logical (interrelated data)
   0x85, 0x01,      //  GReportID 0x01 [1]
   0x75, 0x08,      //  GReportSize 0x08 [8]
   0x95, 0x01,      //  GReportCount 0x01 [1]
   0x80,            //  MInput 
                    //  

   0x05, 0x09,      //  GUsagePage Button
   0x75, 0x01,      //  GReportSize 0x01 [1]
   0x95, 0x04,      //  GReportCount 0x04 [4]
   0x14,            //  GLogicalMinimum  [0]
   0x25, 0x01,      //  GLogicalMaximum 0x01 [1]
   0x09, 0x0C,      //  LUsage 0x0C [Button 0C]
   0x09, 0x0A,      //  LUsage 0x0A [Button 0A]
   0x09, 0x09,      //  LUsage 0x09 [Button 09]
   0x09, 0x0B,      //  LUsage 0x0B [Button 0B]
   0x81, 0x02,      //  MInput 0x02
                    //  Data[0] Var[1] Abs[2] 

   0x05, 0x01,      //  GUsagePage Generic Desktop
   0x09, 0x01,      //  LUsage 0x01 [Pointer]
   0xA1, 0x02,      //  MCollection Logical (interrelated data)
    0x75, 0x01,     //  GReportSize 0x01 [1]
    0x14,           //  GLogicalMinimum  [0]
    0x25, 0x01,     //  GLogicalMaximum 0x01 [1]
    0x95, 0x04,     //  GReportCount 0x04 [4]
    0x09, 0x90,     //  LUsage 0x90 [D-pad Up]
    0x09, 0x92,     //  LUsage 0x92 [D-pad Right]
    0x09, 0x91,     //  LUsage 0x91 [D-pad Down]
    0x09, 0x93,     //  LUsage 0x93 [D-pad Left]
    0x81, 0x02,     //  MInput 0x02
                    //  Data[0] Var[1] Abs[2] 

    0xC0,           //  MEndCollection  [Pointer]

   0x05, 0x09,      //  GUsagePage Button
   0x95, 0x09,      //  GReportCount 0x09 [9]
   0x09, 0x08,      //  LUsage 0x08 [Button 08]
   0x09, 0x07,      //  LUsage 0x07 [Button 07]
   0x09, 0x06,      //  LUsage 0x06 [Button 06]
   0x09, 0x05,      //  LUsage 0x05 [Button 05]
   0x09, 0x04,      //  LUsage 0x04 [Button 04]
   0x09, 0x02,      //  LUsage 0x02 [Button 2 (secondary)]
   0x09, 0x01,      //  LUsage 0x01 [Button 1 (primary/trigger)]
   0x09, 0x03,      //  LUsage 0x03 [Button 3 (tertiary)]
   0x09, 0x0D,      //  LUsage 0x0D [Button 0D]
   0x81, 0x02,      //  MInput 0x02
                    //  Data[0] Var[1] Abs[2] 

   0x75, 0x01,      //  GReportSize 0x01 [1]
   0x95, 0x0F,      //  GReportCount 0x0F [15]
   0x80,            //  MInput 
                    //  

   0x14,            //  GLogicalMinimum  [0]
   0x26, 0xFF, 0x00,  //  GLogicalMaximum 0x00FF [255]
   0x35, 0x80,      //  GPhysicalMinimum 0x80 [-128]
   0x45, 0x7F,      //  GPhysicalMaximum 0x7F [127]
   0x05, 0x01,      //  GUsagePage Generic Desktop
   0x09, 0x01,      //  LUsage 0x01 [Pointer]
   0x75, 0x08,      //  GReportSize 0x08 [8]
   0x95, 0x02,      //  GReportCount 0x02 [2]
   0xA0,            //  MCollection Physical (group of axes)
    0x09, 0x30,     //  LUsage 0x30 [X]
    0x09, 0x31,     //  LUsage 0x31 [Y]
    0x81, 0x02,     //  MInput 0x02
                    //  Data[0] Var[1] Abs[2] 

    0xC0,           //  MEndCollection  [Pointer]

   0x09, 0x05,      //  LUsage 0x05 [Game Pad]
   0xA0,            //  MCollection Physical (group of axes)
    0x09, 0x32,     //  LUsage 0x32 [Z]
    0x09, 0x33,     //  LUsage 0x33 [Rx]
    0x81, 0x02,     //  MInput 0x02
                    //  Data[0] Var[1] Abs[2] 

    0xC0,           //  MEndCollection  [Game Pad]

   0x75, 0x08,      //  GReportSize 0x08 [8]
   0x95, 0x04,      //  GReportCount 0x04 [4]
   0x80,            //  MInput 
                    //  

   0x75, 0x08,      //  GReportSize 0x08 [8]
   0x95, 0x0C,      //  GReportCount 0x0C [12]
   0x09, 0x46,      //  LUsage 0x46 [Vno]
   0x34,            //  GPhysicalMinimum  [0]
   0x44,            //  GPhysicalMaximum  [0]
   0x81, 0x02,      //  MInput 0x02
                    //  Data[0] Var[1] Abs[2] 

   0x75, 0x08,      //  GReportSize 0x08 [8]
   0x95, 0x0F,      //  GReportCount 0x0F [15]
   0x80,            //  MInput 
                    //  

   0x75, 0x10,      //  GReportSize 0x10 [16]
   0x95, 0x01,      //  GReportCount 0x01 [1]
   0x16, 0x80, 0x01,  //  GLogicalMinimum 0x0180 [384]
   0x26, 0x7F, 0x02,  //  GLogicalMaximum 0x027F [639]
   0x45, 0x80,      //  GPhysicalMaximum 0x80 [-128]
   0x35, 0x7F,      //  GPhysicalMinimum 0x7F [127]
   0x09, 0x33,      //  LUsage 0x33 [Rx]
   0x81, 0x02,      //  MInput 0x02
                    //  Data[0] Var[1] Abs[2] 

   0x35, 0x80,      //  GPhysicalMinimum 0x80 [-128]
   0x45, 0x7F,      //  GPhysicalMaximum 0x7F [127]
   0x09, 0x34,      //  LUsage 0x34 [Ry]
   0x81, 0x02,      //  MInput 0x02
                    //  Data[0] Var[1] Abs[2] 

   0x95, 0x02,      //  GReportCount 0x02 [2]
   0x14,            //  GLogicalMinimum  [0]
   0x26, 0x00, 0x04,  //  GLogicalMaximum 0x0400 [1024]
   0x36, 0x01, 0xFE,  //  GPhysicalMinimum 0xFE01 [-511]
   0x46, 0x00, 0x02,  //  GPhysicalMaximum 0x0200 [512]
   0x09, 0x35,      //  LUsage 0x35 [Rz]
   0x09, 0x36,      //  LUsage 0x36 [Slider]
   0x81, 0x02,      //  MInput 0x02
                    //  Data[0] Var[1] Abs[2] 

   0x14,            //  GLogicalMinimum  [0]
   0x26, 0xFF, 0x00,  //  GLogicalMaximum 0x00FF [255]
   0x34,            //  GPhysicalMinimum  [0]
   0x46, 0xFF, 0x00,  //  GPhysicalMaximum 0x00FF [255]
   0x75, 0x08,      //  GReportSize 0x08 [8]
   0x95, 0x30,      //  GReportCount 0x30 [48]
   0x91, 0x02,      //  MOutput 0x02
                    //  Data[0] Var[1] Abs[2] 

   0x75, 0x08,      //  GReportSize 0x08 [8]
   0x95, 0x30,      //  GReportCount 0x30 [48]
   0xB1, 0x02,      //  MFeature 0x02
                    //  Data[0] Var[1] Abs[2] 

   0xC0,            //  MEndCollection  [Joystick]

  0xA1, 0x02,       //  MCollection Logical (interrelated data)
   0x85, 0x02,      //  GReportID 0x02 [2]
   0x75, 0x08,      //  GReportSize 0x08 [8]
   0x95, 0x30,      //  GReportCount 0x30 [48]
   0xB1, 0x02,      //  MFeature 0x02
                    //  Data[0] Var[1] Abs[2] 

   0xC0,            //  MEndCollection  [Joystick]

  0xA1, 0x02,       //  MCollection Logical (interrelated data)
   0x85, 0xEE,      //  GReportID 0xEE [238]
   0x75, 0x08,      //  GReportSize 0x08 [8]
   0x95, 0x30,      //  GReportCount 0x30 [48]
   0xB1, 0x02,      //  MFeature 0x02
                    //  Data[0] Var[1] Abs[2] 

   0xC0,            //  MEndCollection  [Joystick]

  0xA1, 0x02,       //  MCollection Logical (interrelated data)
   0x85, 0xEF,      //  GReportID 0xEF [239]
   0x75, 0x08,      //  GReportSize 0x08 [8]
   0x95, 0x30,      //  GReportCount 0x30 [48]
   0xB1, 0x02,      //  MFeature 0x02
                    //  Data[0] Var[1] Abs[2] 

   0xC0,            //  MEndCollection  [Joystick]

  0xC0              //  MEndCollection  [Joystick]

}

--=-vJhYRyX51YYOSGo4C3JA
Content-Disposition: attachment; filename="ps3.smart"
Content-Type: text/plain; name="ps3.smart"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

UP    0x01            //  Generic Desktop
U     0x04            //  0x04 [Joystick]
A {                   //  Application (mouse, keyboard)
   U     0x04         //  0x04 [Joystick]
   L {                //  Logical (interrelated data)
      ID    0x01      //  0x01 [1]
      RS    0x08      //  0x08 [8]
      RC    0x01      //  0x01 [1]
      I               //   

      UP    0x09      //  Button
      RS    0x01      //  0x01 [1]
      RC    0x04      //  0x04 [4]
      Lmin     0      //   [0]
      Lmax     1      //  0x01 [1]
      U     0x0C      //  0x0C [Button 0C]
      U     0x0A      //  0x0A [Button 0A]
      U     0x09      //  0x09 [Button 09]
      U     0x0B      //  0x0B [Button 0B]
      I     0x02      //  0x02 Data[0] Var[1] Abs[2] 

      UP    0x01      //  Generic Desktop
      U     0x01      //  0x01 [Pointer]
      L {             //  Physical (group of axes)
         RS    0x01   //  0x01 [1]
         Lmin     0   //   [0]
         Lmax     1   //  0x01 [1]
         RC    0x04   //  0x04 [4]
         U     0x90   //  0x90 [D-pad Up]
         U     0x92   //  0x92 [D-pad Right]
         U     0x91   //  0x91 [D-pad Down]
         U     0x93   //  0x93 [D-pad Left]
         I     0x02   //  0x02 Data[0] Var[1] Abs[2] 

         }            //   [Pointer]

      UP    0x09      //  Button
      RC    0x09      //  0x09 [9]
      U     0x08      //  0x08 [Button 08]
      U     0x07      //  0x07 [Button 07]
      U     0x06      //  0x06 [Button 06]
      U     0x05      //  0x05 [Button 05]
      U     0x04      //  0x04 [Button 04]
      U     0x02      //  0x02 [Button 2 (secondary)]
      U     0x01      //  0x01 [Button 1 (primary/trigger)]
      U     0x03      //  0x03 [Button 3 (tertiary)]
      U     0x0D      //  0x0D [Button 0D]
      I     0x02      //  0x02 Data[0] Var[1] Abs[2] 

      RS    0x01      //  0x01 [1]
      RC    0x0F      //  0x0F [15]
      I               //   

      Lmin     0      //   [0]
      Lmax   255      //  0x00FF [255]
      Pmin  -128      //  0x80 [-128]
      Pmax   127      //  0x7F [127]
      UP    0x01      //  Generic Desktop
      U     0x01      //  0x01 [Pointer]
      RS    0x08      //  0x08 [8]
      RC    0x02      //  0x02 [2]
      P {             //  Physical (group of axes)
         U     0x30   //  0x30 [X]
         U     0x31   //  0x31 [Y]
         I     0x02   //  0x02 Data[0] Var[1] Abs[2] 

         }            //   [Pointer]

      U     0x05      //  0x05 [Game Pad]
      P {             //  Physical (group of axes)
         U     0x32   //  0x32 [Z]
         U     0x33   //  0x33 [Rx]
         I     0x02   //  0x02 Data[0] Var[1] Abs[2] 

         }            //   [Game Pad]

      RS    0x08      //  0x08 [8]
      RC    0x04      //  0x04 [4]
      I               //   

      RS    0x08      //  0x08 [8]
      RC    0x0C      //  0x0C [12]
      U     0x46      //  0x46 [Vno]
      Pmin     0      //   [0]
      Pmax     0      //   [0]
      I     0x02      //  0x02 Data[0] Var[1] Abs[2] 

      RS    0x08      //  0x08 [8]
      RC    0x0F      //  0x0F [15]
      I               //   

      RS    0x10      //  0x10 [16]
      RC    0x01      //  0x01 [1]
      Lmin   384      //  0x0180 [384]
      Lmax   639      //  0x027F [639]
      Pmax  -128      //  0x80 [-128]
      Pmin   127      //  0x7F [127]
      U     0x33      //  0x33 [Rx]
      I     0x02      //  0x02 Data[0] Var[1] Abs[2] 

      Pmin  -128      //  0x80 [-128]
      Pmax   127      //  0x7F [127]
      U     0x34      //  0x34 [Ry]
      I     0x02      //  0x02 Data[0] Var[1] Abs[2] 

      RC    0x02      //  0x02 [2]
      Lmin     0      //   [0]
      Lmax  1024      //  0x0400 [1024]
      Pmin  -511      //  0xFE01 [-511]
      Pmax   512      //  0x0200 [512]
      U     0x35      //  0x35 [Rz]
      U     0x36      //  0x36 [Slider]
      I     0x02      //  0x02 Data[0] Var[1] Abs[2] 

      Lmin     0      //   [0]
      Lmax   255      //  0x00FF [255]
      Pmin     0      //   [0]
      Pmax   255      //  0x00FF [255]
      RS    0x08      //  0x08 [8]
      RC    0x30      //  0x30 [48]
      O     0x02      //  0x02 Data[0] Var[1] Abs[2] 

      RS    0x08      //  0x08 [8]
      RC    0x30      //  0x30 [48]
      F     0x02      //  0x02 Data[0] Var[1] Abs[2] 

      }               //   [Joystick]

   L {                //  Logical (interrelated data)
      ID    0x02      //  0x02 [2]
      RS    0x08      //  0x08 [8]
      RC    0x30      //  0x30 [48]
      F     0x02      //  0x02 Data[0] Var[1] Abs[2] 

      }               //   [Joystick]

   L {                //  Logical (interrelated data)
      ID    0xEE      //  0xEE [238]
      RS    0x08      //  0x08 [8]
      RC    0x30      //  0x30 [48]
      F     0x02      //  0x02 Data[0] Var[1] Abs[2] 

      }               //   [Joystick]

   L {                //  Logical (interrelated data)
      ID    0xEF      //  0xEF [239]
      RS    0x08      //  0x08 [8]
      RC    0x30      //  0x30 [48]
      F     0x02      //  0x02 Data[0] Var[1] Abs[2] 

      }               //   [Joystick]

   }                  //   [Joystick]


--=-vJhYRyX51YYOSGo4C3JA
Content-Type: application/octet-stream; name="0003:054C:0268:0111.bin"
Content-Disposition: attachment; filename="0003:054C:0268:0111.bin"
Content-Transfer-Encoding: base64

BQEJBKEBCQShAoUBdQiVAYAFCXUBlQQUJQEJDAkKCQkJC4ECBQEJAaB1ARQlAZUECZAJkgmRCZOB
AsAFCZUJCQgJBwkGCQUJBAkCCQEJAwkNgQJ1AZUPgBQm/wA1gEV/BQEJAXUIlQKgCTAJMYECwAkF
oAkyCTOBAsB1CJUEgHUIlQwJRjREgQJ1CJUPgHUQlQEWgAEmfwJFgDV/CTOBAjWARX8JNIEClQIU
JgAENgH+RgACCTUJNoECFCb/ADRG/wB1CJUwkQJ1CJUwsQLAoQKFAnUIlTCxAsChAoXudQiVMLEC
wKEChe91CJUwsQLAwA==


--=-vJhYRyX51YYOSGo4C3JA--
