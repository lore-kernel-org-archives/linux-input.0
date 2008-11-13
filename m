From: Dan Streetman <ddstreet-EkmVulN54Sk@public.gmane.org>
Subject: Re: [patch] add module parameter to provide hardware-calibrated coordinate
 data for MicroTouch/3M touchscreens
Date: Thu, 13 Nov 2008 18:25:39 -0500
Message-ID: <491CB773.2020205@ieee.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090205010108000802010807"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, daniel.ritz-OI3hZJvNYWs@public.gmane.org, Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This is a multi-part message in MIME format.
--------------090205010108000802010807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


On Thu, Nov 13, 2008 at 3:31 PM, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> wrote:
 > On Thu, Nov 13, 2008 at 03:22:52PM -0500, Dan Streetman wrote:
 >>
 >> --- a/drivers/input/touchscreen/usbtouchscreen.c      2008-11-12
 >> 13:06:23.000000000 -0500
 >> +++ b/drivers/input/touchscreen/usbtouchscreen.c      2008-11-12
 >> 13:07:44.000000000 -0500
 >
 > Your patch is line-wrapped :(

Stupid gmail! :(
I'm trying now with thunderbird but I'm not sure if it has problems also or not.  I'm attaching the patch as well just in case :(

 >
 >> @@ -60,6 +60,10 @@ static int swap_xy;
 >>  module_param(swap_xy, bool, 0644);
 >>  MODULE_PARM_DESC(swap_xy, "If set X and Y axes are swapped.");
 >>
 >> +static int hwcalib_xy = 0;
 >> +module_param(hwcalib_xy, bool, 0444);
 >> +MODULE_PARM_DESC(hwcalib_xy, "If set hw-calibrated X/Y are used if available");
 >
 > Should this variable be allowed to be changed at run time?  That might
 > be useful if the code is built into the system.  If so, please change
 > the permissions on the module_param() call.

I set it as read only because I had to override the min/max coordinate values in the mtouch_init() function
if the hw-calibrated coordinates were being used, so if someone changed the value after a screen
was already connected, it would start reporting hw-calibrated coordinates but the min/max values
would still be the raw min/max...however, for people wanting to change the value and then hotplug
their touchscreens (to reset the min/max values), it would be useful.  Below is the patch with the
permissions adjusted.


--- a/drivers/input/touchscreen/usbtouchscreen.c	2008-11-12 13:06:23.000000000 -0500
+++ b/drivers/input/touchscreen/usbtouchscreen.c	2008-11-12 13:07:44.000000000 -0500
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

--------------090205010108000802010807
Content-Type: text/plain;
 name="patch-usbtouchscreen-hwcalib"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-usbtouchscreen-hwcalib"

--- a/drivers/input/touchscreen/usbtouchscreen.c	2008-11-12 13:06:23.000000000 -0500
+++ b/drivers/input/touchscreen/usbtouchscreen.c	2008-11-12 13:07:44.000000000 -0500
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

--------------090205010108000802010807--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
