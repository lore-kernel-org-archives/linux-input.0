From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 3/4] hid: huion: Switch to generating report descriptor
Date: Wed, 23 Jul 2014 19:31:56 +0300
Message-ID: <1406133117-29243-4-git-send-email-spbnick@gmail.com>
References: <53CFC950.90703@gmail.com>
 <1406133117-29243-1-git-send-email-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:47575 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758143AbaGWQcR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jul 2014 12:32:17 -0400
Received: by mail-wi0-f170.google.com with SMTP id f8so7800316wiw.1
        for <linux-input@vger.kernel.org>; Wed, 23 Jul 2014 09:32:16 -0700 (PDT)
In-Reply-To: <1406133117-29243-1-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>, Nikolai Kondrashov <spbnick@gmail.com>

Switch to generating tablet pen report descriptor from a template and
parameters retrieved from string descriptor 0x64.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
---
 drivers/hid/hid-huion.c | 245 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 167 insertions(+), 78 deletions(-)

diff --git a/drivers/hid/hid-huion.c b/drivers/hid/hid-huion.c
index 46c425b..6c811c1 100644
--- a/drivers/hid/hid-huion.c
+++ b/drivers/hid/hid-huion.c
@@ -16,67 +16,89 @@
 #include <linux/hid.h>
 #include <linux/module.h>
 #include <linux/usb.h>
+#include <asm/unaligned.h>
 #include "usbhid/usbhid.h"
 
 #include "hid-ids.h"
 
-/* Original tablet report descriptor size */
-#define HUION_TABLET_RDESC_ORIG_SIZE	177
-
-/* Fixed tablet report descriptor */
-static __u8 huion_tablet_rdesc_fixed[] = {
-	0x05, 0x0D,         /*  Usage Page (Digitizer),             */
-	0x09, 0x02,         /*  Usage (Pen),                        */
-	0xA1, 0x01,         /*  Collection (Application),           */
-	0x85, 0x07,         /*      Report ID (7),                  */
-	0x09, 0x20,         /*      Usage (Stylus),                 */
-	0xA0,               /*      Collection (Physical),          */
-	0x14,               /*          Logical Minimum (0),        */
-	0x25, 0x01,         /*          Logical Maximum (1),        */
-	0x75, 0x01,         /*          Report Size (1),            */
-	0x09, 0x42,         /*          Usage (Tip Switch),         */
-	0x09, 0x44,         /*          Usage (Barrel Switch),      */
-	0x09, 0x46,         /*          Usage (Tablet Pick),        */
-	0x95, 0x03,         /*          Report Count (3),           */
-	0x81, 0x02,         /*          Input (Variable),           */
-	0x95, 0x03,         /*          Report Count (3),           */
-	0x81, 0x03,         /*          Input (Constant, Variable), */
-	0x09, 0x32,         /*          Usage (In Range),           */
-	0x95, 0x01,         /*          Report Count (1),           */
-	0x81, 0x02,         /*          Input (Variable),           */
-	0x95, 0x01,         /*          Report Count (1),           */
-	0x81, 0x03,         /*          Input (Constant, Variable), */
-	0x75, 0x10,         /*          Report Size (16),           */
-	0x95, 0x01,         /*          Report Count (1),           */
-	0xA4,               /*          Push,                       */
-	0x05, 0x01,         /*          Usage Page (Desktop),       */
-	0x65, 0x13,         /*          Unit (Inch),                */
-	0x55, 0xFD,         /*          Unit Exponent (-3),         */
-	0x34,               /*          Physical Minimum (0),       */
-	0x09, 0x30,         /*          Usage (X),                  */
-	0x46, 0x40, 0x1F,   /*          Physical Maximum (8000),    */
-	0x26, 0x00, 0x7D,   /*          Logical Maximum (32000),    */
-	0x81, 0x02,         /*          Input (Variable),           */
-	0x09, 0x31,         /*          Usage (Y),                  */
-	0x46, 0x88, 0x13,   /*          Physical Maximum (5000),    */
-	0x26, 0x20, 0x4E,   /*          Logical Maximum (20000),    */
-	0x81, 0x02,         /*          Input (Variable),           */
-	0xB4,               /*          Pop,                        */
-	0x09, 0x30,         /*          Usage (Tip Pressure),       */
-	0x26, 0xFF, 0x07,   /*          Logical Maximum (2047),     */
-	0x81, 0x02,         /*          Input (Variable),           */
-	0xC0,               /*      End Collection,                 */
-	0xC0                /*  End Collection                      */
+/* Report descriptor template placeholder head */
+#define HUION_PH_HEAD	0xFE, 0xED, 0x1D
+
+/* Report descriptor template placeholder IDs */
+enum huion_ph_id {
+	HUION_PH_ID_X_LM,
+	HUION_PH_ID_X_PM,
+	HUION_PH_ID_Y_LM,
+	HUION_PH_ID_Y_PM,
+	HUION_PH_ID_PRESSURE_LM,
+	HUION_PH_ID_NUM
+};
+
+/* Report descriptor template placeholder */
+#define HUION_PH(_ID) HUION_PH_HEAD, HUION_PH_ID_##_ID
+
+/* Fixed report descriptor template */
+static const __u8 huion_tablet_rdesc_template[] = {
+	0x05, 0x0D,             /*  Usage Page (Digitizer),                 */
+	0x09, 0x02,             /*  Usage (Pen),                            */
+	0xA1, 0x01,             /*  Collection (Application),               */
+	0x85, 0x07,             /*      Report ID (7),                      */
+	0x09, 0x20,             /*      Usage (Stylus),                     */
+	0xA0,                   /*      Collection (Physical),              */
+	0x14,                   /*          Logical Minimum (0),            */
+	0x25, 0x01,             /*          Logical Maximum (1),            */
+	0x75, 0x01,             /*          Report Size (1),                */
+	0x09, 0x42,             /*          Usage (Tip Switch),             */
+	0x09, 0x44,             /*          Usage (Barrel Switch),          */
+	0x09, 0x46,             /*          Usage (Tablet Pick),            */
+	0x95, 0x03,             /*          Report Count (3),               */
+	0x81, 0x02,             /*          Input (Variable),               */
+	0x95, 0x03,             /*          Report Count (3),               */
+	0x81, 0x03,             /*          Input (Constant, Variable),     */
+	0x09, 0x32,             /*          Usage (In Range),               */
+	0x95, 0x01,             /*          Report Count (1),               */
+	0x81, 0x02,             /*          Input (Variable),               */
+	0x95, 0x01,             /*          Report Count (1),               */
+	0x81, 0x03,             /*          Input (Constant, Variable),     */
+	0x75, 0x10,             /*          Report Size (16),               */
+	0x95, 0x01,             /*          Report Count (1),               */
+	0xA4,                   /*          Push,                           */
+	0x05, 0x01,             /*          Usage Page (Desktop),           */
+	0x65, 0x13,             /*          Unit (Inch),                    */
+	0x55, 0xFD,             /*          Unit Exponent (-3),             */
+	0x34,                   /*          Physical Minimum (0),           */
+	0x09, 0x30,             /*          Usage (X),                      */
+	0x27, HUION_PH(X_LM),   /*          Logical Maximum (PLACEHOLDER),  */
+	0x47, HUION_PH(X_PM),   /*          Physical Maximum (PLACEHOLDER), */
+	0x81, 0x02,             /*          Input (Variable),               */
+	0x09, 0x31,             /*          Usage (Y),                      */
+	0x27, HUION_PH(Y_LM),   /*          Logical Maximum (PLACEHOLDER),  */
+	0x47, HUION_PH(Y_PM),   /*          Physical Maximum (PLACEHOLDER), */
+	0x81, 0x02,             /*          Input (Variable),               */
+	0xB4,                   /*          Pop,                            */
+	0x09, 0x30,             /*          Usage (Tip Pressure),           */
+	0x27,
+	HUION_PH(PRESSURE_LM),  /*          Logical Maximum (PLACEHOLDER),  */
+	0x81, 0x02,             /*          Input (Variable),               */
+	0xC0,                   /*      End Collection,                     */
+	0xC0                    /*  End Collection                          */
+};
+
+/* Driver data */
+struct huion_drvdata {
+	__u8 *rdesc;
+	unsigned int rsize;
 };
 
 static __u8 *huion_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
+	struct huion_drvdata *drvdata = hid_get_drvdata(hdev);
 	switch (hdev->product) {
 	case USB_DEVICE_ID_HUION_TABLET:
-		if (*rsize == HUION_TABLET_RDESC_ORIG_SIZE) {
-			rdesc = huion_tablet_rdesc_fixed;
-			*rsize = sizeof(huion_tablet_rdesc_fixed);
+		if (drvdata->rdesc != NULL) {
+			rdesc = drvdata->rdesc;
+			*rsize = drvdata->rsize;
 		}
 		break;
 	}
@@ -84,57 +106,124 @@ static __u8 *huion_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 }
 
 /**
- * Enable fully-functional tablet mode by reading special string
- * descriptor.
+ * Enable fully-functional tablet mode and determine device parameters.
  *
  * @hdev:	HID device
- *
- * The specific string descriptor and data were discovered by sniffing
- * the Windows driver traffic.
  */
 static int huion_tablet_enable(struct hid_device *hdev)
 {
 	int rc;
-	char buf[22];
+	struct usb_device *usb_dev = hid_to_usb_dev(hdev);
+	struct huion_drvdata *drvdata = hid_get_drvdata(hdev);
+	u16 buf[6];
 
-	rc = usb_string(hid_to_usb_dev(hdev), 0x64, buf, sizeof(buf));
-	if (rc < 0)
-		return rc;
+	/*
+	 * Read string descriptor containing tablet parameters. The specific
+	 * string descriptor and data were discovered by sniffing the Windows
+	 * driver traffic.
+	 * NOTE: This enables fully-functional tablet mode.
+	 */
+	rc = usb_control_msg(usb_dev, usb_rcvctrlpipe(usb_dev, 0),
+				USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
+				(USB_DT_STRING << 8) + 0x64,
+				0x0409, buf, sizeof(buf),
+				USB_CTRL_GET_TIMEOUT);
+	if (rc == -EPIPE)
+		hid_warn(hdev, "device parameters not found\n");
+	else if (rc < 0)
+		hid_warn(hdev, "failed to get device parameters: %d\n", rc);
+	else if (rc != sizeof(buf))
+		hid_warn(hdev, "invalid device parameters\n");
+	else {
+		s32 params[HUION_PH_ID_NUM];
+		s32 resolution;
+		__u8 *p;
+		s32 v;
+
+		/* Extract device parameters */
+		params[HUION_PH_ID_X_LM] = le16_to_cpu(buf[1]);
+		params[HUION_PH_ID_Y_LM] = le16_to_cpu(buf[2]);
+		params[HUION_PH_ID_PRESSURE_LM] = le16_to_cpu(buf[4]);
+		resolution = le16_to_cpu(buf[5]);
+		if (resolution == 0) {
+			params[HUION_PH_ID_X_PM] = 0;
+			params[HUION_PH_ID_Y_PM] = 0;
+		} else {
+			params[HUION_PH_ID_X_PM] = params[HUION_PH_ID_X_LM] *
+							1000 / resolution;
+			params[HUION_PH_ID_Y_PM] = params[HUION_PH_ID_Y_LM] *
+							1000 / resolution;
+		}
+
+		/* Allocate fixed report descriptor */
+		drvdata->rdesc = devm_kmalloc(&hdev->dev,
+					sizeof(huion_tablet_rdesc_template),
+					GFP_KERNEL);
+		if (drvdata->rdesc == NULL) {
+			hid_err(hdev, "failed to allocate fixed rdesc\n");
+			return -ENOMEM;
+		}
+		drvdata->rsize = sizeof(huion_tablet_rdesc_template);
+
+		/* Format fixed report descriptor */
+		memcpy(drvdata->rdesc, huion_tablet_rdesc_template,
+			drvdata->rsize);
+		for (p = drvdata->rdesc;
+		     p <= drvdata->rdesc + drvdata->rsize - 4;) {
+			if (p[0] == 0xFE && p[1] == 0xED && p[2] == 0x1D &&
+			    p[3] < sizeof(params)) {
+				v = params[p[3]];
+				put_unaligned(cpu_to_le32(v), (s32 *)p);
+				p += 4;
+			} else {
+				p++;
+			}
+		}
+	}
 
 	return 0;
 }
 
 static int huion_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
-	int ret;
-
-	ret = hid_parse(hdev);
-	if (ret) {
-		hid_err(hdev, "parse failed\n");
-		goto err;
-	}
+	int rc;
+	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
+	struct huion_drvdata *drvdata;
 
-	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
-	if (ret) {
-		hid_err(hdev, "hw start failed\n");
-		goto err;
+	/* Allocate and assign driver data */
+	drvdata = devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (drvdata == NULL) {
+		hid_err(hdev, "failed to allocate driver data\n");
+		return -ENOMEM;
 	}
+	hid_set_drvdata(hdev, drvdata);
 
 	switch (id->product) {
 	case USB_DEVICE_ID_HUION_TABLET:
-		ret = huion_tablet_enable(hdev);
-		if (ret) {
-			hid_err(hdev, "tablet enabling failed\n");
-			goto enabling_err;
+		/* If this is the pen interface */
+		if (intf->cur_altsetting->desc.bInterfaceNumber == 0) {
+			rc = huion_tablet_enable(hdev);
+			if (rc) {
+				hid_err(hdev, "tablet enabling failed\n");
+				return rc;
+			}
 		}
 		break;
 	}
 
+	rc = hid_parse(hdev);
+	if (rc) {
+		hid_err(hdev, "parse failed\n");
+		return rc;
+	}
+
+	rc = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (rc) {
+		hid_err(hdev, "hw start failed\n");
+		return rc;
+	}
+
 	return 0;
-enabling_err:
-	hid_hw_stop(hdev);
-err:
-	return ret;
 }
 
 static int huion_raw_event(struct hid_device *hdev, struct hid_report *report,
-- 
2.0.1

