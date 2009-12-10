From: Robert Schedel <r.schedel@yahoo.de>
Subject: [PATCH] hid: Support 171 byte variant of Samsung USB IR receiver
 (0419:0001)
Date: Fri, 11 Dec 2009 00:37:11 +0100
Message-ID: <4B218627.7050006@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp127.mail.ukl.yahoo.com ([77.238.184.58]:42147 "HELO
	smtp127.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755092AbZLJXou (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Dec 2009 18:44:50 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

From: Robert Schedel <r.schedel@yahoo.de>

Extends the existing Samsung USB IrDA (0419:0001) quirk with newly reported 171 byte variant. Refactors duplicate trace call into local helper function.

Signed-off-by: Robert Schedel <r.schedel@yahoo.de>

---
 drivers/hid/hid-samsung.c |   25 +++++++++++++++++++------
  1 file changed, 19 insertions(+), 6 deletions(-)

Hello all,

the attached patch adds support for a new variant of a Samsung USB IR receiver with a 171 byte report descriptor. This variant seems to have a similar array min/max quirk as other variants added to hid-samsung before.

The original bug report for the new variant is available at the second half of this ticket page:

  https://bugs.launchpad.net/bugs/326986

Patch applies to kernel 2.6.32.

Regards,
Robert Schedel

diff -rupN linux-2.6.32-orig/drivers/hid/hid-samsung.c linux-2.6.32/drivers/hid/hid-samsung.c
--- linux-2.6.32-orig/drivers/hid/hid-samsung.c	2009-12-03 04:51:21.000000000 +0100
+++ linux-2.6.32/drivers/hid/hid-samsung.c	2009-12-10 23:20:07.633321274 +0100
@@ -39,7 +39,17 @@
  *
  * 3. 135 byte report descriptor
  * Report #4 has an array field with logical range 0..17 instead of 1..14.
+ *
+ * 4. 171 byte report descriptor
+ * Report #3 has an array field with logical range 0..1 instead of 1..3.
  */
+static inline void samsung_dev_trace(struct hid_device *hdev,
+		unsigned int rsize)
+{
+	dev_info(&hdev->dev, "fixing up Samsung IrDA %d byte report "
+			"descriptor\n", rsize);
+}
+
 static void samsung_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int rsize)
 {
@@ -47,8 +57,7 @@ static void samsung_report_fixup(struct 
 			rdesc[177] == 0x75 && rdesc[178] == 0x30 &&
 			rdesc[179] == 0x95 && rdesc[180] == 0x01 &&
 			rdesc[182] == 0x40) {
-		dev_info(&hdev->dev, "fixing up Samsung IrDA %d byte report "
-				"descriptor\n", 184);
+		samsung_dev_trace(hdev, 184);
 		rdesc[176] = 0xff;
 		rdesc[178] = 0x08;
 		rdesc[180] = 0x06;
@@ -56,17 +65,21 @@ static void samsung_report_fixup(struct 
 	} else
 	if (rsize == 203 && rdesc[192] == 0x15 && rdesc[193] == 0x0 &&
 			rdesc[194] == 0x25 && rdesc[195] == 0x12) {
-		dev_info(&hdev->dev, "fixing up Samsung IrDA %d byte report "
-				"descriptor\n", 203);
+		samsung_dev_trace(hdev, 203);
 		rdesc[193] = 0x1;
 		rdesc[195] = 0xf;
 	} else
 	if (rsize == 135 && rdesc[124] == 0x15 && rdesc[125] == 0x0 &&
 			rdesc[126] == 0x25 && rdesc[127] == 0x11) {
-		dev_info(&hdev->dev, "fixing up Samsung IrDA %d byte report "
-				"descriptor\n", 135);
+		samsung_dev_trace(hdev, 135);
 		rdesc[125] = 0x1;
 		rdesc[127] = 0xe;
+	} else
+	if (rsize == 171 && rdesc[160] == 0x15 && rdesc[161] == 0x0 &&
+			rdesc[162] == 0x25 && rdesc[163] == 0x01) {
+		samsung_dev_trace(hdev, 171);
+		rdesc[161] = 0x1;
+		rdesc[163] = 0x3;
 	}
 }
 
