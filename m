From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] HID: usbhid: get/put around clearing needs_remote_wakeup
Date: Fri, 8 Sep 2017 10:43:37 -0700
Message-ID: <20170908174337.GA13616@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37591 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756210AbdIHRnl (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 8 Sep 2017 13:43:41 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Guenter Roeck <groeck@chromium.org>, Benson Leung <bleung@chromium.org>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

From: Benson Leung <bleung@chromium.org>

usbhid->intf->needs_remote_wakeup is set when a device is opened, and is
cleared when a device is closed.

In usbhid_open, usb_autopm_get_interface is called before setting the
needs_remote_wakeup flag, and usb_autopm_put_interface is called after
hid_start_in. However, when the device is closed in usbhid_close, we
simply reset the flag and the device stays awake even though it could be
suspended.

This patch adds calls to usb_autopm_get_interface and
usb_autopm_put_interface when we reset usbhid->intf->needs_remote_wakeup
flag, giving the system chance to put the device to sleep.

Signed-off-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/usbhid/hid-core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 089bad8a9a21..174d87f0e3e6 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -729,6 +729,7 @@ static int usbhid_open(struct hid_device *hid)
 static void usbhid_close(struct hid_device *hid)
 {
 	struct usbhid_device *usbhid = hid->driver_data;
+	int autopm_error;
 
 	/*
 	 * Make sure we don't restart data acquisition due to
@@ -745,8 +746,14 @@ static void usbhid_close(struct hid_device *hid)
 		return;
 
 	hid_cancel_delayed_stuff(usbhid);
+
+	autopm_error = usb_autopm_get_interface(usbhid->intf);
+
 	usb_kill_urb(usbhid->urbin);
 	usbhid->intf->needs_remote_wakeup = 0;
+
+	if (!autopm_error)
+		usb_autopm_put_interface(usbhid->intf);
 }
 
 /*
@@ -1176,13 +1183,18 @@ static int usbhid_start(struct hid_device *hid)
 static void usbhid_stop(struct hid_device *hid)
 {
 	struct usbhid_device *usbhid = hid->driver_data;
+	int autopm_error;
 
 	if (WARN_ON(!usbhid))
 		return;
 
 	if (hid->quirks & HID_QUIRK_ALWAYS_POLL) {
 		clear_bit(HID_IN_POLLING, &usbhid->iofl);
+
+		autopm_error = usb_autopm_get_interface(usbhid->intf);
 		usbhid->intf->needs_remote_wakeup = 0;
+		if (!autopm_error)
+			usb_autopm_put_interface(usbhid->intf);
 	}
 
 	clear_bit(HID_STARTED, &usbhid->iofl);
-- 
2.14.1.581.gf28d330327-goog


-- 
Dmitry
