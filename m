From: Michael Poole <mdpoole@troilus.org>
Subject: [RFC PATCH 2/3] Add a hid_ll_driver.hid_set_report() function.
Date: Mon, 25 Jan 2010 00:04:36 -0500
Message-ID: <ad7d2406ee127c0686463dadae9792ba7d8692a8.1264395708.git.mdpoole@troilus.org>
References: <1264395877-2582-1-git-send-email-mdpoole@troilus.org>
 <411caeb60f5b808d0524636a03fc99e6216e67c6.1264395708.git.mdpoole@troilus.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:58664 "HELO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751000Ab0AYFEw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jan 2010 00:04:52 -0500
Received: by qyk11 with SMTP id 11so2277295qyk.16
        for <linux-input@vger.kernel.org>; Sun, 24 Jan 2010 21:04:51 -0800 (PST)
In-Reply-To: <411caeb60f5b808d0524636a03fc99e6216e67c6.1264395708.git.mdpoole@troilus.org>
In-Reply-To: <411caeb60f5b808d0524636a03fc99e6216e67c6.1264395708.git.mdpoole@troilus.org>
References: <411caeb60f5b808d0524636a03fc99e6216e67c6.1264395708.git.mdpoole@troilus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Michael Poole <mdpoole@troilus.org>

This allows a HID device driver to send a Set_Report(Output) or
Set_Report(Feature) message to its device.

Signed-off-by: Michael Poole <mdpoole@troilus.org>
---
 drivers/hid/usbhid/hid-core.c |   23 +++++++++++++++++++++++
 include/linux/hid.h           |    4 ++++
 net/bluetooth/hidp/core.c     |   25 +++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index e2997a8..d3d2a6e 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1067,6 +1067,28 @@ static int usbhid_power(struct hid_device *hid, int lvl)
 	return r;
 }
 
+static int usbhid_set_report(struct hid_device *hid, int type,
+	__u8 *buf, int count)
+{
+	struct usb_device *dev = hid_to_usb_dev(hid);
+	struct usbhid_device *usbhid = hid->driver_data;
+	struct usb_interface *intf = usbhid->intf;
+	struct usb_host_interface *interface = intf->cur_altsetting;
+	int ret;
+
+	ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
+		HID_REQ_SET_REPORT,
+		USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
+		((type + 1) << 8) | *buf,
+		interface->desc.bInterfaceNumber, buf + 1, count - 1,
+		USB_CTRL_SET_TIMEOUT);
+
+	if (ret > 0)
+		ret++;
+
+	return ret;
+}
+
 static struct hid_ll_driver usb_hid_driver = {
 	.parse = usbhid_parse,
 	.start = usbhid_start,
@@ -1075,6 +1097,7 @@ static struct hid_ll_driver usb_hid_driver = {
 	.close = usbhid_close,
 	.power = usbhid_power,
 	.hidinput_input_event = usb_hidinput_input_event,
+	.hid_set_report = usbhid_set_report,
 };
 
 static int usbhid_probe(struct usb_interface *intf, const struct usb_device_id *id)
diff --git a/include/linux/hid.h b/include/linux/hid.h
index c411983..07154bb 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -642,6 +642,7 @@ struct hid_driver {
  * @hidinput_input_event: event input event (e.g. ff or leds)
  * @parse: this method is called only once to parse the device data,
  *	   shouldn't allocate anything to not leak memory
+ * @hid_set_report: sends a SET_REPORT request to the device
  */
 struct hid_ll_driver {
 	int (*start)(struct hid_device *hdev);
@@ -656,6 +657,9 @@ struct hid_ll_driver {
 			unsigned int code, int value);
 
 	int (*parse)(struct hid_device *hdev);
+
+	int (*hid_set_report) (struct hid_device *hdev, int type,
+			__u8 *buf, int count);
 };
 
 #define	PM_HINT_FULLON	1<<5
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 18e7f5a..91b0ca4 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -752,6 +752,30 @@ static void hidp_stop(struct hid_device *hid)
 	hid->claimed = 0;
 }
 
+static int hidp_set_report(struct hid_device *hid, int type,
+	__u8 *data, int size)
+{
+	struct hidp_session *session = hid->driver_data;
+	struct sk_buff *skb;
+
+	BT_DBG("session %p hid %p data %p size %d", session, hid, data, size);
+
+	if (!(skb = alloc_skb(size + 1, GFP_ATOMIC))) {
+		BT_ERR("Can't allocate memory for new frame");
+		return -ENOMEM;
+	}
+
+	*skb_put(skb, 1) = 0xa0 | (type + 1);
+	if (size > 0)
+		memcpy(skb_put(skb, size), data, size);
+
+	skb_queue_tail(&session->intr_transmit, skb);
+
+	hidp_schedule(session);
+
+	return 0;
+}
+
 static struct hid_ll_driver hidp_hid_driver = {
 	.parse = hidp_parse,
 	.start = hidp_start,
@@ -759,6 +783,7 @@ static struct hid_ll_driver hidp_hid_driver = {
 	.open  = hidp_open,
 	.close = hidp_close,
 	.hidinput_input_event = hidp_hidinput_event,
+	.hid_set_report = hidp_set_report,
 };
 
 static int hidp_setup_hid(struct hidp_session *session,
-- 
1.6.5.6

