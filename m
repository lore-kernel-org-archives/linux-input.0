From: "Dan Streetman" <ddstreet-EkmVulN54Sk@public.gmane.org>
Subject: [patch] add module parameter to provide hardware-calibrated coordinate data for MicroTouch/3M touchscreens
Date: Thu, 13 Nov 2008 15:22:52 -0500
Message-ID: <3fad22b40811131222k3a168a06tfe01b09ca106e0a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, daniel.ritz-OI3hZJvNYWs@public.gmane.org, Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Back in mtouchusb, I added the "raw_coordinates" module parameter to
make it possible to get the hw-calib data:
http://marc.info/?l=linux-usb-devel&m=110968309531306&w=2

When mtouchusb was integrated into the usbtouchscreen driver, that
ability wasn't carried over - it reports only the raw coordinates
again.

This patch restores the ability to get hardware-calibrated coordinate
data, and defaults to the raw data so existing systems with a
microtouch touchscreen won't see any changes.

Note that the Y axis is inverted as reported by the touchscreen, so
this reverses the Y min and max (0xffff for the min, 0 for the max).
This works fine on my system using the X evdev driver.

(I'm sending this from gmail which hopefully won't mangle the
patch...I tested it and it seems ok)

Signed-off-by: Dan Streetman <ddstreet-EkmVulN54Sk@public.gmane.org>


--- a/drivers/input/touchscreen/usbtouchscreen.c	2008-11-12
13:06:23.000000000 -0500
+++ b/drivers/input/touchscreen/usbtouchscreen.c	2008-11-12
13:07:44.000000000 -0500
@@ -60,6 +60,10 @@ static int swap_xy;
 module_param(swap_xy, bool, 0644);
 MODULE_PARM_DESC(swap_xy, "If set X and Y axes are swapped.");

+static int hwcalib_xy = 0;
+module_param(hwcalib_xy, bool, 0444);
+MODULE_PARM_DESC(hwcalib_xy, "If set hw-calibrated X/Y are used if available");
+
 /* device specifc data/functions */
 struct usbtouch_usb;
 struct usbtouch_device_info {
@@ -260,8 +264,13 @@ static int panjit_read_data(struct usbto

 static int mtouch_read_data(struct usbtouch_usb *dev, unsigned char *pkt)
 {
-	dev->x = (pkt[8] << 8) | pkt[7];
-	dev->y = (pkt[10] << 8) | pkt[9];
+	if (hwcalib_xy) {
+		dev->x = (pkt[4] << 8) | pkt[3];
+		dev->y = (pkt[6] << 8) | pkt[5];
+	} else {
+		dev->x = (pkt[8] << 8) | pkt[7];
+		dev->y = (pkt[10] << 8) | pkt[9];
+	}
 	dev->touch = (pkt[2] & 0x40) ? 1 : 0;

 	return 1;
@@ -294,6 +303,12 @@ static int mtouch_init(struct usbtouch_u
 			return ret;
 	}

+	// Default min/max xy are the raw values, override if using hw-calib
+	if (hwcalib_xy) {
+		input_set_abs_params(usbtouch->input, ABS_X, 0, 0xffff, 0, 0);
+		input_set_abs_params(usbtouch->input, ABS_Y, 0xffff, 0, 0, 0);
+	}
+
 	return 0;
 }
 #endif
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
