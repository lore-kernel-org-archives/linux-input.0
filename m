From: Robert Schedel <r.schedel@yahoo.de>
Subject: [PATCH] hid: Support new variants of Samsung USB IR receiver (0419:0001)
Date: Tue, 23 Jun 2009 00:57:05 +0200
Message-ID: <4A400C41.9080103@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp102.mail.ukl.yahoo.com ([77.238.184.34]:20645 "HELO
	smtp102.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751010AbZFVXFs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Jun 2009 19:05:48 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

From: Robert Schedel <r.schedel@yahoo.de>

This patch extends the existing Samsung IrDA (0419:0001) quirk file with newly reported variants:
* New device variants with 203 byte and 135 byte report descriptors were reported to be recognized incorrectly. This patch adds an autodetection for those two, using report descriptor size to enable new quirks.
* Any other unknown 0419:0001 variants will now be treated without any quirk flags (i.e. IGNORE_HIDINPUT/HIDDEV_FORCE will not be set by default anymore).

Signed-off-by: Robert Schedel <r.schedel@yahoo.de>

---

 drivers/hid/hid-samsung.c |   39 +++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

Hello all,

in December 2007 I had originally submitted a HID patch for a Samsung USB IR receiver (0419:0001), which is now located in "hid-samsung.c". So I still feel somewhat responsible for this.

Recently, I got hold of several bug reports to other variants of the same vendor/class combination. The best way to differentiate those new variants seems to be the report descriptor:

1. Descriptor size 184 bytes ("Satelco bundled remote")
Already supported since kernel 2.6.25 (my old patch).

2. Descriptor size 203 bytes ("Optronix remote")

This receiver mostly works with the regular HID input driver. Only when some keys are released, another spurious key press event is interpreted due to incorrect array ranges. According to HID 1.11, section 6.2.2.5, arrays should return a 0 value when no control is asserted, and ranges should go from 1 to the number of elements. The patch clips the value with a logical range from 1..15 (instead of originally 0..18).

Ticket with more information available at
https://bugs.launchpad.net/bugs/326986

3. Descriptor size 135 bytes ("Gotview remote")

This receiver has a similar issue than the previous one, i.e. it mostly works with regular HID input, except some key press events get stuck on key release. The patch clips the array value from 1..14 (instead of originally 0..17). 

Ticket with more information available at
http://bugs.archlinux.org/task/15216

4. Other unknown variants (found one report with 218 bytes, but no further information about issues)

For such unknown variants we should refrain from changing any device flags. Currently, HIDINPUT is suppressed and HIDDEV is enforced (because in 2.6.25 the quirk table did not yet allow differentiating variants and we did not expect variants either). Now we should be as strict as possible and enable it only for the first variant above.

As you see, the patch differentiates the variants via descriptor size, due to a lack of any other differing fields. Using a descriptor hash for autodetection would probably be even safer, but not (yet) worth the effort.

Patch applies to kernel 2.6.30.

Checked with checkpatch.pl.

Regards,
Robert Schedel

diff -rupN linux-2.6.30-orig/drivers/hid/hid-samsung.c linux-2.6.30/drivers/hid/hid-samsung.c
--- linux-2.6.30-orig/drivers/hid/hid-samsung.c	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6.30/drivers/hid/hid-samsung.c	2009-06-21 01:42:00.199080601 +0200
@@ -25,25 +25,48 @@
 /*
  * Samsung IrDA remote controller (reports as Cypress USB Mouse).
  *
+ * There are several variants for 0419:0001:
+ *
+ * 1. 184 byte report descriptor
  * Vendor specific report #4 has a size of 48 bit,
  * and therefore is not accepted when inspecting the descriptors.
  * As a workaround we reinterpret the report as:
  *   Variable type, count 6, size 8 bit, log. maximum 255
  * The burden to reconstruct the data is moved into user space.
+ *
+ * 2. 203 byte report descriptor
+ * Report #4 has an array field with logical range 0..18 instead of 1..15.
+ *
+ * 3. 135 byte report descriptor
+ * Report #4 has an array field with logical range 0..17 instead of 1..14.
  */
 static void samsung_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int rsize)
 {
-	if (rsize >= 182 && rdesc[175] == 0x25 && rdesc[176] == 0x40 &&
+	if (rsize == 184 && rdesc[175] == 0x25 && rdesc[176] == 0x40 &&
 			rdesc[177] == 0x75 && rdesc[178] == 0x30 &&
 			rdesc[179] == 0x95 && rdesc[180] == 0x01 &&
 			rdesc[182] == 0x40) {
-		dev_info(&hdev->dev, "fixing up Samsung IrDA report "
-				"descriptor\n");
+		dev_info(&hdev->dev, "fixing up Samsung IrDA %d byte report "
+				"descriptor\n", 184);
 		rdesc[176] = 0xff;
 		rdesc[178] = 0x08;
 		rdesc[180] = 0x06;
 		rdesc[182] = 0x42;
+	} else
+	if (rsize == 203 && rdesc[192] == 0x15 && rdesc[193] == 0x0 &&
+			rdesc[194] == 0x25 && rdesc[195] == 0x12) {
+		dev_info(&hdev->dev, "fixing up Samsung IrDA %d byte report "
+				"descriptor\n", 203);
+		rdesc[193] = 0x1;
+		rdesc[195] = 0xf;
+	} else
+	if (rsize == 135 && rdesc[124] == 0x15 && rdesc[125] == 0x0 &&
+			rdesc[126] == 0x25 && rdesc[127] == 0x11) {
+		dev_info(&hdev->dev, "fixing up Samsung IrDA %d byte report "
+				"descriptor\n", 135);
+		rdesc[125] = 0x1;
+		rdesc[127] = 0xe;
 	}
 }
 
@@ -51,6 +74,7 @@ static int samsung_probe(struct hid_devi
 		const struct hid_device_id *id)
 {
 	int ret;
+	unsigned int cmask = HID_CONNECT_DEFAULT;
 
 	ret = hid_parse(hdev);
 	if (ret) {
@@ -58,8 +82,13 @@ static int samsung_probe(struct hid_devi
 		goto err_free;
 	}
 
-	ret = hid_hw_start(hdev, (HID_CONNECT_DEFAULT & ~HID_CONNECT_HIDINPUT) |
-			HID_CONNECT_HIDDEV_FORCE);
+	if (hdev->rsize == 184) {
+		/* disable hidinput, force hiddev */
+		cmask = (cmask & ~HID_CONNECT_HIDINPUT) |
+			HID_CONNECT_HIDDEV_FORCE;
+	}
+
+	ret = hid_hw_start(hdev, cmask);
 	if (ret) {
 		dev_err(&hdev->dev, "hw start failed\n");
 		goto err_free;
