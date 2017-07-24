From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v4 1/2] HID: introduce hid_is_using_ll_driver
Date: Mon, 24 Jul 2017 09:46:18 -0700
Message-ID: <20170724164619.29228-1-killertofu@gmail.com>
References: <alpine.LSU.2.20.1707201540560.4705@cbobk.fhfr.pm>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:37173 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753856AbdGXQqc (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 24 Jul 2017 12:46:32 -0400
Received: by mail-qk0-f193.google.com with SMTP id q130so10409365qka.4
        for <linux-input@vger.kernel.org>; Mon, 24 Jul 2017 09:46:32 -0700 (PDT)
In-Reply-To: <alpine.LSU.2.20.1707201540560.4705@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

Although HID itself is transport-agnostic, occasionally a driver may
want to interact with the low-level transport that a device is connected
through. To do this, we need to know what kind of bus is in use. The
first guess may be to look at the 'bus' field of the 'struct hid_device',
but this field may be emulated in some cases (e.g. uhid).

More ideally, we can check which ll_driver a device is using. This
function introduces a 'hid_is_using_ll_driver' function and makes the
'struct hid_ll_driver' of the four most common transports accessible
through hid.h.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/i2c-hid/i2c-hid.c |  3 ++-
 drivers/hid/uhid.c            |  3 ++-
 drivers/hid/usbhid/hid-core.c |  3 ++-
 include/linux/hid.h           | 11 +++++++++++
 net/bluetooth/hidp/core.c     |  3 ++-
 5 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index fb55fb4c39fc..fef2cfafcedd 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -794,7 +794,7 @@ static int i2c_hid_power(struct hid_device *hid, int lvl)
 	return 0;
 }
 
-static struct hid_ll_driver i2c_hid_ll_driver = {
+struct hid_ll_driver i2c_hid_ll_driver = {
 	.parse = i2c_hid_parse,
 	.start = i2c_hid_start,
 	.stop = i2c_hid_stop,
@@ -804,6 +804,7 @@ static struct hid_ll_driver i2c_hid_ll_driver = {
 	.output_report = i2c_hid_output_report,
 	.raw_request = i2c_hid_raw_request,
 };
+EXPORT_SYMBOL_GPL(i2c_hid_ll_driver);
 
 static int i2c_hid_init_irq(struct i2c_client *client)
 {
diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 7f8ff39ed44b..6f819f144cb4 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -369,7 +369,7 @@ static int uhid_hid_output_report(struct hid_device *hid, __u8 *buf,
 	return uhid_hid_output_raw(hid, buf, count, HID_OUTPUT_REPORT);
 }
 
-static struct hid_ll_driver uhid_hid_driver = {
+struct hid_ll_driver uhid_hid_driver = {
 	.start = uhid_hid_start,
 	.stop = uhid_hid_stop,
 	.open = uhid_hid_open,
@@ -378,6 +378,7 @@ static struct hid_ll_driver uhid_hid_driver = {
 	.raw_request = uhid_hid_raw_request,
 	.output_report = uhid_hid_output_report,
 };
+EXPORT_SYMBOL_GPL(uhid_hid_driver);
 
 #ifdef CONFIG_COMPAT
 
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 83772fa7d92a..9bef8ece135f 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1256,7 +1256,7 @@ static int usbhid_idle(struct hid_device *hid, int report, int idle,
 	return hid_set_idle(dev, ifnum, report, idle);
 }
 
-static struct hid_ll_driver usb_hid_driver = {
+struct hid_ll_driver usb_hid_driver = {
 	.parse = usbhid_parse,
 	.start = usbhid_start,
 	.stop = usbhid_stop,
@@ -1269,6 +1269,7 @@ static struct hid_ll_driver usb_hid_driver = {
 	.output_report = usbhid_output_report,
 	.idle = usbhid_idle,
 };
+EXPORT_SYMBOL_GPL(usb_hid_driver);
 
 static int usbhid_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 5be325d890d9..a09c5f37dda9 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -765,6 +765,17 @@ struct hid_ll_driver {
 	int (*idle)(struct hid_device *hdev, int report, int idle, int reqtype);
 };
 
+extern struct hid_ll_driver i2c_hid_ll_driver;
+extern struct hid_ll_driver hidp_hid_driver;
+extern struct hid_ll_driver uhid_hid_driver;
+extern struct hid_ll_driver usb_hid_driver;
+
+static inline bool hid_is_using_ll_driver(struct hid_device *hdev,
+		struct hid_ll_driver *driver)
+{
+	return hdev->ll_driver == driver;
+}
+
 #define	PM_HINT_FULLON	1<<5
 #define PM_HINT_NORMAL	1<<1
 
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 0bec4588c3c8..1c3615636bd0 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -733,7 +733,7 @@ static void hidp_stop(struct hid_device *hid)
 	hid->claimed = 0;
 }
 
-static struct hid_ll_driver hidp_hid_driver = {
+struct hid_ll_driver hidp_hid_driver = {
 	.parse = hidp_parse,
 	.start = hidp_start,
 	.stop = hidp_stop,
@@ -742,6 +742,7 @@ static struct hid_ll_driver hidp_hid_driver = {
 	.raw_request = hidp_raw_request,
 	.output_report = hidp_output_report,
 };
+EXPORT_SYMBOL_GPL(hidp_hid_driver);
 
 /* This function sets up the hid device. It does not add it
    to the HID system. That is done in hidp_add_connection(). */
-- 
2.13.3

