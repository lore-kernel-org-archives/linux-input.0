From: Dan Streetman <ddstreet@ieee.org>
Subject: Re: [patch] add module parameter to provide hardware-calibrated
 coordinate data for MicroTouch/3M touchscreens
Date: Mon, 17 Nov 2008 11:26:25 -0500 (EST)
Message-ID: <alpine.LNX.1.10.0811171040200.17925@floyd.root.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:54100 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997AbYKQR7M (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Nov 2008 12:59:12 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Greg KH <greg@kroah.com>, daniel.ritz@gmx.ch


On Sat, Nov 15, 2008 at 4:08 PM, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Fri, Nov 14, 2008 at 04:46:08PM -0500, Dan Streetman wrote:
>> Ok - I'll update the patch to invert Y before reporting.
>>
>> On the issue of whether to use a module param to send raw coordinates
>> or hw-calibrated coordinates, or to just change the code to report the
>> hw-calibrated coordinates instead of the raw coordinates, what do you
>> think?
>
> I'm in favor for the option, because of:
>
>        * backwards compatibility
>        * the Linux input standard is unprocessed coordinate data
>          (but after compensating for all hardware quirks)
>        * most touchscreens can't do HW calibration anyway, and we
>          benefit from common SW calibration code, eg in tslib
>
> Actually, I don't see much value in the hw-calibrated data, but I see it
> could be useful in some cases, so I'm still fine with adding the
> possibility to use that mode.

Just to point it out again because I think it's important...userspace can treat 
the hardware-calibrated coordinates *exactly the same* as the raw coordinates if 
using software calibration such as tslib.  So like I said there is not really a 
benefit there of using the raw coordinates, except for one-time backwards 
compatibility.  This is why I don't see the point in reporting the raw 
coordinates by default instead of the hw-calibrated coordinates - I think the 
module parameter is fine to let the user pick which one they want, but it should 
default to the hw-calibrated coordinates.

But, that's just my opinion :)  So here is the updated patch with the Y 
inversion and normal non-inverted Y min/max, the module parameter permissions 
set to 0644, and default to raw.


This patch adds a module parameter to report either the raw coordinate data or 
the hardware-calibrated coordinate data.  The default is set to the raw 
coordinates for backwards compatibilty.

Signed-off-by: Dan Streetman <ddstreet@ieee.org>



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
