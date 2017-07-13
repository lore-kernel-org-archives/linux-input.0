From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] HID: usbhid: fix "always poll" quirk
Date: Wed, 12 Jul 2017 17:14:24 -0700
Message-ID: <20170713001424.GA7990@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Even though the IO for devices with "always poll" quirk is already running,
we still need to set HID_OPENED bit in usbhid->iofl so the interrupt
handler does not ignore the data coming from the device.

Reported-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Tested-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Fixes: e399396a6b0 ("HID: usbhid: remove custom locking from usbhid_open...")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/hid/usbhid/hid-core.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 76013eb5cb7f..c008847e0b20 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -680,18 +680,21 @@ static int usbhid_open(struct hid_device *hid)
 	struct usbhid_device *usbhid = hid->driver_data;
 	int res;
 
+	set_bit(HID_OPENED, &usbhid->iofl);
+
 	if (hid->quirks & HID_QUIRK_ALWAYS_POLL)
 		return 0;
 
 	res = usb_autopm_get_interface(usbhid->intf);
 	/* the device must be awake to reliably request remote wakeup */
-	if (res < 0)
+	if (res < 0) {
+		clear_bit(HID_OPENED, &usbhid->iofl);
 		return -EIO;
+	}
 
 	usbhid->intf->needs_remote_wakeup = 1;
 
 	set_bit(HID_RESUME_RUNNING, &usbhid->iofl);
-	set_bit(HID_OPENED, &usbhid->iofl);
 	set_bit(HID_IN_POLLING, &usbhid->iofl);
 
 	res = hid_start_in(hid);
@@ -727,19 +730,20 @@ static void usbhid_close(struct hid_device *hid)
 {
 	struct usbhid_device *usbhid = hid->driver_data;
 
-	if (hid->quirks & HID_QUIRK_ALWAYS_POLL)
-		return;
