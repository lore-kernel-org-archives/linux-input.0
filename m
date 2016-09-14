From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 5/9] HID: uclogic: Switch to reporting abstract button events
Date: Wed, 14 Sep 2016 21:38:16 +0300
Message-ID: <20160914183820.20737-6-spbnick@gmail.com>
References: <20160914101531.GJ25951@mail.corp.redhat.com>
 <20160914183820.20737-1-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36329 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759772AbcINSio (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Sep 2016 14:38:44 -0400
Received: by mail-wm0-f66.google.com with SMTP id b184so3789555wma.3
        for <linux-input@vger.kernel.org>; Wed, 14 Sep 2016 11:38:43 -0700 (PDT)
In-Reply-To: <20160914183820.20737-1-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, Nikolai Kondrashov <spbnick@gmail.com>

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Based on a patch from: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>

Enable abstract keyboard mode for Huion tablets, which makes them report
frame buttons using the pen interface and report ID. Divert these
reports to a virtual report ID describing them.

This makes the tablet compatible with xf86-input-wacom and libinput,
but stops the frame buttons from reporting keyboard events.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-uclogic.c | 102 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 97 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
index 790528e..73c040d 100644
--- a/drivers/hid/hid-uclogic.c
+++ b/drivers/hid/hid-uclogic.c
@@ -586,6 +586,27 @@ static const __u8 uclogic_tablet_rdesc_template[] = {
 	0xC0                    /*  End Collection                          */
 };
 
+/* Fixed virtual pad report descriptor */
+static const __u8 uclogic_buttonpad_rdesc[] = {
+	0x05, 0x01,             /*  Usage Page (Desktop),                   */
+	0x09, 0x07,             /*  Usage (Keypad),                         */
+	0xA1, 0x01,             /*  Collection (Application),               */
+	0x85, 0xF7,             /*      Report ID (247),                    */
+	0x05, 0x0D,             /*      Usage Page (Digitizers),            */
+	0x09, 0x39,             /*      Usage (Tablet Function Keys),       */
+	0xA0,                   /*      Collection (Physical),              */
+	0x05, 0x09,             /*          Usage Page (Button),            */
+	0x75, 0x01,             /*          Report Size (1),                */
+	0x95, 0x18,             /*          Report Count (24),              */
+	0x81, 0x03,             /*          Input (Constant, Variable),     */
+	0x19, 0x01,             /*          Usage Minimum (01h),            */
+	0x29, 0x08,             /*          Usage Maximum (08h),            */
+	0x95, 0x08,             /*          Report Count (8),               */
+	0x81, 0x02,             /*          Input (Variable),               */
+	0xC0,                   /*      End Collection                      */
+	0xC0                    /*  End Collection                          */
+};
+
 /* Parameter indices */
 enum uclogic_prm {
 	UCLOGIC_PRM_X_LM	= 1,
@@ -601,6 +622,7 @@ struct uclogic_drvdata {
 	unsigned int rsize;
 	bool invert_pen_inrange;
 	bool ignore_pen_usage;
+	bool has_virtual_pad_interface;
 };
 
 static __u8 *uclogic_report_fixup(struct hid_device *hdev, __u8 *rdesc,
@@ -847,6 +869,69 @@ cleanup:
 	return rc;
 }
 
+/**
+ * Enable actual button mode.
+ *
+ * @hdev:	HID device
+ */
+static int uclogic_button_enable(struct hid_device *hdev)
+{
+	int rc;
+	struct usb_device *usb_dev = hid_to_usb_dev(hdev);
+	struct uclogic_drvdata *drvdata = hid_get_drvdata(hdev);
+	char *str_buf;
+	size_t str_len = 16;
+	unsigned char *rdesc;
+	size_t rdesc_len;
+
+	str_buf = kzalloc(str_len, GFP_KERNEL);
+	if (str_buf == NULL) {
+		rc = -ENOMEM;
+		goto cleanup;
+	}
+
+	/* Enable abstract keyboard mode */
+	rc = usb_string(usb_dev, 0x7b, str_buf, str_len);
+	if (rc == -EPIPE) {
+		hid_info(hdev, "button mode setting not found\n");
+		rc = 0;
+		goto cleanup;
+	} else if (rc < 0) {
+		hid_err(hdev, "failed to enable abstract keyboard\n");
+		goto cleanup;
+	} else if (strncmp(str_buf, "HK On", rc)) {
+		hid_info(hdev, "invalid answer when requesting buttons: '%s'\n",
+			str_buf);
+		rc = -EINVAL;
+		goto cleanup;
+	}
+
+	/* Re-allocate fixed report descriptor */
+	rdesc_len = drvdata->rsize + sizeof(uclogic_buttonpad_rdesc);
+	rdesc = devm_kzalloc(&hdev->dev, rdesc_len, GFP_KERNEL);
+	if (!rdesc) {
+		rc = -ENOMEM;
+		goto cleanup;
+	}
+
+	memcpy(rdesc, drvdata->rdesc, drvdata->rsize);
+
+	/* Append the buttonpad descriptor */
+	memcpy(rdesc + drvdata->rsize, uclogic_buttonpad_rdesc,
+	       sizeof(uclogic_buttonpad_rdesc));
+
+	/* clean up old rdesc and use the new one */
+	drvdata->rsize = rdesc_len;
+	devm_kfree(&hdev->dev, drvdata->rdesc);
+	drvdata->rdesc = rdesc;
+
+	rc = 0;
+
+cleanup:
+	kfree(str_buf);
+	return rc;
+}
+
 static int uclogic_probe(struct hid_device *hdev,
 		const struct hid_device_id *id)
 {
@@ -878,6 +963,9 @@ static int uclogic_probe(struct hid_device *hdev,
 				return rc;
 			}
 			drvdata->invert_pen_inrange = true;
+
+			rc = uclogic_button_enable(hdev);
+			drvdata->has_virtual_pad_interface = !rc;
 		} else {
 			drvdata->ignore_pen_usage = true;
 		}
@@ -904,12 +992,16 @@ static int uclogic_raw_event(struct hid_device *hdev, struct hid_report *report,
 {
 	struct uclogic_drvdata *drvdata = hid_get_drvdata(hdev);
 
-	if ((drvdata->invert_pen_inrange) &&
-	    (report->type == HID_INPUT_REPORT) &&
+	if ((report->type == HID_INPUT_REPORT) &&
 	    (report->id == UCLOGIC_PEN_REPORT_ID) &&
-	    (size >= 2))
-		/* Invert the in-range bit */
-		data[1] ^= 0x40;
+	    (size >= 2)) {
+		if (drvdata->has_virtual_pad_interface && (data[1] & 0x20))
+			/* Change to virtual frame button report ID */
+			data[0] = 0xf7;
+		else if (drvdata->invert_pen_inrange)
+			/* Invert the in-range bit */
+			data[1] ^= 0x40;
+	}
 
 	return 0;
 }
-- 
2.9.3

