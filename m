From: Simon Wood <simon@mungewell.org>
Subject: [PATCH 2/4] USB: HID: SRW-S1 Add support for dials
Date: Thu, 24 Jan 2013 23:34:45 -0700
Message-ID: <1359095687-13398-2-git-send-email-simon@mungewell.org>
References: <1359095687-13398-1-git-send-email-simon@mungewell.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359095687-13398-1-git-send-email-simon@mungewell.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, simon@mungewell.org, rosegardener@freeode.co.uk
List-Id: linux-input@vger.kernel.org

From: simon <simon@simon-virtual-machine.(none)>

This patch to the SRW-S1 driver re-writes the HID descriptor
to insert a section for the 3 dials on the device, previously
these were contained within a 'Manufacturer Specific' usage
page.

Signed-off-by: Simon Wood <simon@mungewell.org>
tested-by: John Murphy <rosegardener@freeode.co.uk>

---
 drivers/hid/hid-srws1.c |   86 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 82 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-srws1.c b/drivers/hid/hid-srws1.c
index 7776d74..4d8a86b 100644
--- a/drivers/hid/hid-srws1.c
+++ b/drivers/hid/hid-srws1.c
@@ -17,16 +17,94 @@
 
 #include "hid-ids.h"
 
+/* Fixed report descriptor for Steelseries SRW-S1 wheel controller
+ *
+ * The original descriptor hides the sensitivity and assists dials
+ * a custom vendor usage page. This inserts a patch to make them
+ * appear in the 'Generic Desktop' usage.
+ */
+
+static __u8 srws1_rdesc_fixed[] = {
+0x05, 0x01,         /*  Usage Page (Desktop)                */
+0x09, 0x08,         /*  Usage (MultiAxis), Changed          */
+0xA1, 0x01,         /*  Collection (Application),           */
+0xA1, 0x02,         /*      Collection (Logical),           */
+0x95, 0x01,         /*          Report Count (1),           */
+0x05, 0x01,         /* Changed  Usage Page (Desktop),       */
+0x09, 0x30,         /* Changed  Usage (X),                  */
+0x16, 0xF8, 0xF8,   /*          Logical Minimum (-1800),    */
+0x26, 0x08, 0x07,   /*          Logical Maximum (1800),     */
+0x65, 0x14,         /*          Unit (Degrees),             */
+0x55, 0x0F,         /*          Unit Exponent (15),         */
+0x75, 0x10,         /*          Report Size (16),           */
+0x81, 0x02,         /*          Input (Variable),           */
+0x09, 0x31,         /* Changed  Usage (Y),                  */
+0x15, 0x00,         /*          Logical Minimum (0),        */
+0x26, 0xFF, 0x03,   /*          Logical Maximum (1023),     */
+0x75, 0x0C,         /*          Report Size (12),           */
+0x81, 0x02,         /*          Input (Variable),           */
+0x09, 0x32,         /* Changed  Usage (Z),                  */
+0x15, 0x00,         /*          Logical Minimum (0),        */
+0x26, 0xFF, 0x03,   /*          Logical Maximum (1023),     */
+0x75, 0x0C,         /*          Report Size (12),           */
+0x81, 0x02,         /*          Input (Variable),           */
+0x05, 0x01,         /*          Usage Page (Desktop),       */
+0x09, 0x39,         /*          Usage (Hat Switch),         */
+0x25, 0x07,         /*          Logical Maximum (7),        */
+0x35, 0x00,         /*          Physical Minimum (0),       */
+0x46, 0x3B, 0x01,   /*          Physical Maximum (315),     */
+0x65, 0x14,         /*          Unit (Degrees),             */
+0x75, 0x04,         /*          Report Size (4),            */
+0x95, 0x01,         /*          Report Count (1),           */
+0x81, 0x02,         /*          Input (Variable),           */
+0x25, 0x01,         /*          Logical Maximum (1),        */
+0x45, 0x01,         /*          Physical Maximum (1),       */
+0x65, 0x00,         /*          Unit,                       */
+0x75, 0x01,         /*          Report Size (1),            */
+0x95, 0x03,         /*          Report Count (3),           */
+0x81, 0x01,         /*          Input (Constant),           */
+0x05, 0x09,         /*          Usage Page (Button),        */
+0x19, 0x01,         /*          Usage Minimum (01h),        */
+0x29, 0x11,         /*          Usage Maximum (11h),        */
+0x95, 0x11,         /*          Report Count (17),          */
+0x81, 0x02,         /*          Input (Variable),           */
+                    /*   ---- Dial patch starts here ----   */
+0x05, 0x01,         /*          Usage Page (Desktop),       */
+0x09, 0x33,         /*          Usage (RX),                 */
+0x75, 0x04,         /*          Report Size (4),            */
+0x95, 0x02,         /*          Report Count (2),           */
+0x15, 0x00,         /*          Logical Minimum (0),        */
+0x25, 0x0b,         /*          Logical Maximum (b),        */
+0x81, 0x02,         /*          Input (Variable),           */
+0x09, 0x35,         /*          Usage (RZ),                 */
+0x75, 0x04,         /*          Report Size (4),            */
+0x95, 0x01,         /*          Report Count (1),           */
+0x25, 0x03,         /*          Logical Maximum (3),        */
+0x81, 0x02,         /*          Input (Variable),           */
+                    /*    ---- Dial patch ends here ----    */
+0x06, 0x00, 0xFF,   /*          Usage Page (FF00h),         */
+0x09, 0x01,         /*          Usage (01h),                */
+0x75, 0x04,         /* Changed  Report Size (4),            */
+0x95, 0x0D,         /* Changed  Report Count (13),          */
+0x81, 0x02,         /*          Input (Variable),           */
+0xC0,               /*      End Collection,                 */
+0xA1, 0x02,         /*      Collection (Logical),           */
+0x09, 0x02,         /*          Usage (02h),                */
+0x75, 0x08,         /*          Report Size (8),            */
+0x95, 0x10,         /*          Report Count (16),          */
+0x91, 0x02,         /*          Output (Variable),          */
+0xC0,               /*      End Collection,                 */
+0xC0                /*  End Collection                      */
+};
+
 static __u8 *srws1_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
 	if (*rsize >= 115 && rdesc[11] == 0x02 && rdesc[13] == 0xc8
 			&& rdesc[29] == 0xbb && rdesc[40] == 0xc5) {
 		hid_info(hdev, "Fixing up Steelseries SRW-S1 report descriptor\n");
-		rdesc[11] = 0x01;
-		rdesc[13] = 0x30;
-		rdesc[29] = 0x31;
-		rdesc[40] = 0x32;
+		rdesc = srws1_rdesc_fixed;
+		*rsize = sizeof(srws1_rdesc_fixed);
 	}
 	return rdesc;
 }
-- 
1.7.10.4
