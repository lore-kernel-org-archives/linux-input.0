From: Dan Streetman <ddstreet-EkmVulN54Sk@public.gmane.org>
Subject: Re: [patch] add module parameter to provide hardware-calibrated
 coordinate data for MicroTouch/3M touchscreens
Date: Mon, 24 Nov 2008 09:57:46 -0500 (EST)
Message-ID: <alpine.LNX.1.10.0811240944520.4090@floyd.root.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, daniel.ritz-OI3hZJvNYWs@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


Ping, in case my last email didn't go through.

Vojtech and Greg, is this patch ok?

------



This patch adds a module parameter to report either the raw coordinate data or 
the hardware-calibrated coordinate data.  The default is set to the raw 
coordinates for backwards compatibilty.

Signed-off-by: Dan Streetman <ddstreet-EkmVulN54Sk@public.gmane.org>



--- a/drivers/input/touchscreen/usbtouchscreen.c	2008-11-17 10:51:30.000000000 -0500
+++ b/drivers/input/touchscreen/usbtouchscreen.c	2008-11-17 10:51:45.000000000 -0500
@@ -60,6 +60,10 @@ static int swap_xy;
 module_param(swap_xy, bool, 0644);
 MODULE_PARM_DESC(swap_xy, "If set X and Y axes are swapped.");
 
+static int hwcalib_xy = 0;
+module_param(hwcalib_xy, bool, 0644);
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
+		dev->y = 0xffff - ((pkt[6] << 8) | pkt[5]); // Invert Y
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
+		input_set_abs_params(usbtouch->input, ABS_Y, 0, 0xffff, 0, 0);
+	}
+
 	return 0;
 }
 #endif
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
