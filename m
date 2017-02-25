From: Tobias Jakobi <tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org>
Subject: [PATCH] HID: usbhid: extend polling interval configuration to joysticks
Date: Sat, 25 Feb 2017 20:27:27 +0100
Message-ID: <1488050847-6250-1-git-send-email-tjakobi@math.uni-bielefeld.de>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tobias Jakobi <tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org>
List-Id: linux-input@vger.kernel.org

For mouse devices we can currently change the polling interval
via usbhid.mousepoll. Implement the same thing for joysticks, so
users can reduce input latency this way.

This has been tested with a Logitech RumblePad 2 with jspoll=2,
resulting in a polling rate of 500Hz (verified with evhz).

Signed-off-by: Tobias Jakobi <tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org>
---
 Documentation/kernel-parameters.txt |  3 +++
 drivers/hid/usbhid/hid-core.c       | 18 +++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 922dec8..928ce2c 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -4260,6 +4260,9 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 	usbhid.mousepoll=
 			[USBHID] The interval which mice are to be polled at.
 
+	usbhid.jspoll=
+			[USBHID] The interval which joysticks are to be polled at.
+
 	usb-storage.delay_use=
 			[UMS] The delay in seconds before a new device is
 			scanned for Logical Units (default 1).
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index ae83af6..f7a692f 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -53,6 +53,10 @@ static unsigned int hid_mousepoll_interval;
 module_param_named(mousepoll, hid_mousepoll_interval, uint, 0644);
 MODULE_PARM_DESC(mousepoll, "Polling interval of mice");
 
+static unsigned int hid_jspoll_interval;
+module_param_named(jspoll, hid_jspoll_interval, uint, 0644);
+MODULE_PARM_DESC(jspoll, "Polling interval of joysticks");
+
 static unsigned int ignoreled;
 module_param_named(ignoreled, ignoreled, uint, 0644);
 MODULE_PARM_DESC(ignoreled, "Autosuspend with active leds");
@@ -1082,9 +1086,17 @@ static int usbhid_start(struct hid_device *hid)
 			       hid->name, endpoint->bInterval, interval);
 		}
 
-		/* Change the polling interval of mice. */
-		if (hid->collection->usage == HID_GD_MOUSE && hid_mousepoll_interval > 0)
-			interval = hid_mousepoll_interval;
+		/* Change the polling interval of mice and joysticks. */
+		switch (hid->collection->usage) {
+		case HID_GD_MOUSE:
+			if (hid_mousepoll_interval > 0)
+				interval = hid_mousepoll_interval;
+			break;
+		case HID_GD_JOYSTICK:
+			if (hid_jspoll_interval > 0)
+				interval = hid_jspoll_interval;
+			break;
+		}
 
 		ret = -ENOMEM;
 		if (usb_endpoint_dir_in(endpoint)) {
-- 
2.7.3

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
