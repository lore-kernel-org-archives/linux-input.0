From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 2/4] HID: Add transport-driver functions to the USB HID interface.
Date: Wed, 22 Jan 2014 13:49:42 -0500
Message-ID: <1390416584-3667-3-git-send-email-frank.praznik@oh.rr.com>
References: <1390416584-3667-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:51501 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323AbaAVSuT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jan 2014 13:50:19 -0500
In-Reply-To: <1390416584-3667-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dh.herrmann@gmail.com, jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

Add raw_request, set_raw_report and output_report transport-driver functions to
the USB HID driver.
 
Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

---
 drivers/hid/usbhid/hid-core.c | 78 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 44df131..f8ca312 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -884,6 +884,38 @@ static int usbhid_get_raw_report(struct hid_device *hid,
 	return ret;
 }
 
+static int usbhid_set_raw_report(struct hid_device *hid, unsigned int reportnum,
+				 __u8 *buf, size_t count, unsigned char rtype)
+{
+	struct usbhid_device *usbhid = hid->driver_data;
+	struct usb_device *dev = hid_to_usb_dev(hid);
+	struct usb_interface *intf = usbhid->intf;
+	struct usb_host_interface *interface = intf->cur_altsetting;
+	int ret, skipped_report_id = 0;
+
+	/* Byte 0 is the report number. Report data starts at byte 1.*/
+	buf[0] = reportnum;
+	if (buf[0] == 0x0) {
+		/* Don't send the Report ID */
+		buf++;
+		count--;
+		skipped_report_id = 1;
+	}
+
+	ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
+			HID_REQ_SET_REPORT,
+			USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
+			((rtype + 1) << 8) | reportnum,
+			interface->desc.bInterfaceNumber, buf, count,
+			USB_CTRL_SET_TIMEOUT);
+	/* count also the report id, if this was a numbered report. */
+	if (ret > 0 && skipped_report_id)
+		ret++;
+
+	return ret;
+}
+
+
 static int usbhid_output_raw_report(struct hid_device *hid, __u8 *buf, size_t count,
 		unsigned char report_type)
 {
@@ -936,6 +968,36 @@ static int usbhid_output_raw_report(struct hid_device *hid, __u8 *buf, size_t co
 	return ret;
 }
 
+static int usbhid_output_report(struct hid_device *hid, __u8 *buf, size_t count)
+{
+	struct usbhid_device *usbhid = hid->driver_data;
+	struct usb_device *dev = hid_to_usb_dev(hid);
+	int actual_length, skipped_report_id = 0, ret;
+
+	if (!usbhid->urbout)
+		return -EIO;
+
+	if (buf[0] == 0x0) {
+		/* Don't send the Report ID */
+		buf++;
+		count--;
+		skipped_report_id = 1;
+	}
+
+	ret = usb_interrupt_msg(dev, usbhid->urbout->pipe,
+				buf, count, &actual_length,
+				USB_CTRL_SET_TIMEOUT);
+	/* return the number of bytes transferred */
+	if (ret == 0) {
+		ret = actual_length;
+		/* count also the report id */
+		if (skipped_report_id)
+			ret++;
+	}
+
+	return ret;
+}
+
 static void usbhid_restart_queues(struct usbhid_device *usbhid)
 {
 	if (usbhid->urbout && !test_bit(HID_OUT_RUNNING, &usbhid->iofl))
@@ -1200,6 +1262,20 @@ static void usbhid_request(struct hid_device *hid, struct hid_report *rep, int r
 	}
 }
 
+static int usbhid_raw_request(struct hid_device *hid, unsigned char reportnum,
+			      __u8 *buf, size_t len, unsigned char rtype,
+			      int reqtype)
+{
+	switch (reqtype) {
+	case HID_REQ_GET_REPORT:
+		return usbhid_get_raw_report(hid, reportnum, buf, len, rtype);
+	case HID_REQ_SET_REPORT:
+		return usbhid_set_raw_report(hid, reportnum, buf, len, rtype);
+	default:
+		return -EIO;
+	}
+}
+
 static int usbhid_idle(struct hid_device *hid, int report, int idle,
 		int reqtype)
 {
@@ -1223,6 +1299,8 @@ static struct hid_ll_driver usb_hid_driver = {
 	.power = usbhid_power,
 	.request = usbhid_request,
 	.wait = usbhid_wait_io,
+	.raw_request = usbhid_raw_request,
+	.output_report = usbhid_output_report,
 	.idle = usbhid_idle,
 };
 
-- 
1.8.4.2

