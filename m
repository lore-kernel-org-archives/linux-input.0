From: David Herrmann <dh.herrmann@gmail.com>
Subject: [RFC 8/8] HID: implement new transport-driver callbacks
Date: Mon, 15 Jul 2013 19:10:17 +0200
Message-ID: <1373908217-16748-9-git-send-email-dh.herrmann@gmail.com>
References: <1373908217-16748-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f173.google.com ([209.85.215.173]:64367 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab3GORKx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Jul 2013 13:10:53 -0400
Received: by mail-ea0-f173.google.com with SMTP id g15so7933852eak.18
        for <linux-input@vger.kernel.org>; Mon, 15 Jul 2013 10:10:52 -0700 (PDT)
In-Reply-To: <1373908217-16748-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Oliver Neukum <oliver@neukum.org>, David Herrmann <dh.herrmann@gmail.com>

->raw_request() and ->output_report() implement the SET/GET_REPORT and raw
intr OUTPUT requests for all transport drivers. Once these are
implemented, we can remove the old get_raw_report() and
output_raw_report() per-device callbacks.

Note that the different device drivers expect different semantics for each
call. The new helpers are properly documented and the semantics are known.
We now need to carefully convert each driver to use the correct callback
and then remove the old helpers.

UHID isn't converted, yet. I need to invest how user-space currently
handles UHID_OUTPUT to see whether it's a SET_REPORT or intr-OUTPUT
report.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/uhid.c            | 27 +++++++++++++
 drivers/hid/usbhid/hid-core.c | 77 ++++++++++++++++++++++++++++++++++++
 include/linux/hid.h           |  8 +++-
 net/bluetooth/hidp/core.c     | 90 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 201 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index f53f2d5..a344172 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -244,12 +244,39 @@ static int uhid_hid_output_raw(struct hid_device *hid, __u8 *buf, size_t count,
 	return count;
 }
 
+static int uhid_hid_output_report(struct hid_device *hid, __u8 *buf,
+				  size_t count)
+{
+	struct uhid_device *uhid = hid->driver_data;
+	unsigned long flags;
+	struct uhid_event *ev;
+
+	if (count < 1 || count > UHID_DATA_MAX)
+		return -EINVAL;
+
+	ev = kzalloc(sizeof(*ev), GFP_KERNEL);
+	if (!ev)
+		return -ENOMEM;
+
+	ev->type = UHID_OUTPUT;
+	ev->u.output.size = count;
+	ev->u.output.rtype = UHID_OUTPUT_REPORT;
+	memcpy(ev->u.output.data, buf, count);
+
+	spin_lock_irqsave(&uhid->qlock, flags);
+	uhid_queue(uhid, ev);
+	spin_unlock_irqrestore(&uhid->qlock, flags);
+
+	return count;
+}
+
 static struct hid_ll_driver uhid_hid_driver = {
 	.start = uhid_hid_start,
 	.stop = uhid_hid_stop,
 	.open = uhid_hid_open,
 	.close = uhid_hid_close,
 	.parse = uhid_hid_parse,
+	.output_report = uhid_hid_output_report,
 };
 
 #ifdef CONFIG_COMPAT
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 8c32357..6666345 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -880,6 +880,37 @@ static int usbhid_get_raw_report(struct hid_device *hid,
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
 static int usbhid_output_raw_report(struct hid_device *hid, __u8 *buf, size_t count,
 		unsigned char report_type)
 {
@@ -932,6 +963,36 @@ static int usbhid_output_raw_report(struct hid_device *hid, __u8 *buf, size_t co
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
@@ -1196,6 +1257,20 @@ static void usbhid_request(struct hid_device *hid, struct hid_report *rep, int r
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
@@ -1219,6 +1294,8 @@ static struct hid_ll_driver usb_hid_driver = {
 	.power = usbhid_power,
 	.request = usbhid_request,
 	.wait = usbhid_wait_io,
+	.raw_request = usbhid_raw_request,
+	.output_report = usbhid_output_report,
 	.idle = usbhid_idle,
 };
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index ea4b828..c0bf05f 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -693,8 +693,14 @@ struct hid_ll_driver {
 			struct hid_report *report, int reqtype);
 
 	int (*wait)(struct hid_device *hdev);
-	int (*idle)(struct hid_device *hdev, int report, int idle, int reqtype);
 
+	int (*raw_request) (struct hid_device *hdev, unsigned char reportnum,
+			    __u8 *buf, size_t len, unsigned char rtype,
+			    int reqtype);
+
+	int (*output_report) (struct hid_device *hdev, __u8 *buf, size_t len);
+
+	int (*idle)(struct hid_device *hdev, int report, int idle, int reqtype);
 };
 
 #define	PM_HINT_FULLON	1<<5
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 46c6a14..754d797 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -329,6 +329,71 @@ err:
 	return ret;
 }
 
+static int hidp_set_raw_report(struct hid_device *hid, unsigned char reportnum,
+			       unsigned char *data, size_t count,
+			       unsigned char report_type)
+{
+	struct hidp_session *session = hid->driver_data;
+	int ret;
+
+	switch (report_type) {
+	case HID_FEATURE_REPORT:
+		report_type = HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_FEATURE;
+		break;
+	case HID_INPUT_REPORT:
+		report_type = HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_INPUT;
+		break;
+	case HID_OUTPUT_REPORT:
+		report_type = HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_OUPUT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (mutex_lock_interruptible(&session->report_mutex))
+		return -ERESTARTSYS;
+
+	/* Set up our wait, and send the report request to the device. */
+	data[0] = reportnum;
+	set_bit(HIDP_WAITING_FOR_SEND_ACK, &session->flags);
+	ret = hidp_send_ctrl_message(session, report_type, data, count);
+	if (ret)
+		goto err;
+
+	/* Wait for the ACK from the device. */
+	while (test_bit(HIDP_WAITING_FOR_SEND_ACK, &session->flags) &&
+	       !atomic_read(&session->terminate)) {
+		int res;
+
+		res = wait_event_interruptible_timeout(session->report_queue,
+			!test_bit(HIDP_WAITING_FOR_SEND_ACK, &session->flags)
+				|| atomic_read(&session->terminate),
+			10*HZ);
+		if (res == 0) {
+			/* timeout */
+			ret = -EIO;
+			goto err;
+		}
+		if (res < 0) {
+			/* signal */
+			ret = -ERESTARTSYS;
+			goto err;
+		}
+	}
+
+	if (!session->output_report_success) {
+		ret = -EIO;
+		goto err;
+	}
+
+	ret = count;
+
+err:
+	clear_bit(HIDP_WAITING_FOR_SEND_ACK, &session->flags);
+	mutex_unlock(&session->report_mutex);
+	return ret;
+}
+
 static int hidp_output_raw_report(struct hid_device *hid, unsigned char *data, size_t count,
 		unsigned char report_type)
 {
@@ -387,6 +452,29 @@ err:
 	return ret;
 }
 
+static int hidp_raw_request(struct hid_device *hid, unsigned char reportnum,
+			    __u8 *buf, size_t len, unsigned char rtype,
+			    int reqtype)
+{
+	switch (reqtype) {
+	case HID_REQ_GET_REPORT:
+		return hidp_get_raw_report(hid, reportnum, buf, len, rtype);
+	case HID_REQ_SET_REPORT:
+		return hidp_set_raw_report(hid, reportnum, buf, len, rtype);
+	default:
+		return -EIO;
+	}
+}
+
+static int hidp_output_report(struct hid_device *hid, __u8 *data, size_t count)
+{
+	struct hidp_session *session = hid->driver_data;
+
+	return hidp_send_intr_message(session,
+				      HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUPUT,
+				      data, count);
+}
+
 static void hidp_idle_timeout(unsigned long arg)
 {
 	struct hidp_session *session = (struct hidp_session *) arg;
@@ -717,6 +805,8 @@ static struct hid_ll_driver hidp_hid_driver = {
 	.stop = hidp_stop,
 	.open  = hidp_open,
 	.close = hidp_close,
+	.raw_request = hidp_raw_request,
+	.output_report = hidp_output_report,
 };
 
 /* This function sets up the hid device. It does not add it
-- 
1.8.3.2

