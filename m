From: shawn <shawnlandden@gmail.com>
Subject: usb touch screen of Mimo 720 has x,y rotated 180 degrees
Date: Wed, 22 Feb 2012 13:18:54 -0800
Message-ID: <1329945534.2237.13.camel@ssd-ubuntu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-CUaC+5Ah9xa6yw3bz1sV"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59169 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608Ab2BVVS5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Feb 2012 16:18:57 -0500
Received: by daed14 with SMTP id d14so451382dae.19
        for <linux-input@vger.kernel.org>; Wed, 22 Feb 2012 13:18:57 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org


--=-CUaC+5Ah9xa6yw3bz1sV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

I just got a Mimo 720 usb-only touchscreen. using module
"usbtouchscreen"
The x and y are rotated 180 deg.

While I initially thought the touch device used by usbtouchscreen.c was 
17e9:401a, it turns out it is is 1ac7:0001, which matches it's controller, but
is a problem as this may be the only model where x any y are 180 deg off.

The module has an option to rotate 90 deg, and with a 180 deg rotation parameter
we could support all possible rotations from mis-installations (if that is what this is).

Would it make sense to add a parameter to flip a usbtouchscreen 180 deg, and if so,
should that setting apply to every (or most) displays in the module, or just
this one where there is a backwards implamentations?
I see that some touchscreens already invert one or both of their axis' from the input.

Inc. patch that inverts _all_ e2i touchscreens. I came across this on 3.2.2

computer information: https://bugzilla.kernel.org/show_bug.cgi?id=42743

--=-CUaC+5Ah9xa6yw3bz1sV
Content-Description: 
Content-Disposition: attachment; filename="invert_e2i_touchscreen_fix_mimo720.patch"
Content-Type: text/plain; name="invert_e2i_touchscreen_fix_mimo720.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 73fd664..a9f2303 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -265,8 +265,8 @@ static int e2i_init(struct usbtouch_usb *usbtouch)
 static int e2i_read_data(struct usbtouch_usb *dev, unsigned char *pkt)
 {
 	int tmp = (pkt[0] << 8) | pkt[1];
-	dev->x  = (pkt[2] << 8) | pkt[3];
-	dev->y  = (pkt[4] << 8) | pkt[5];
+	dev->x  = 0x7fff - ((pkt[2] << 8) | pkt[3]);
+	dev->y  = 0x7fff - ((pkt[4] << 8) | pkt[5]);
 
 	tmp = tmp - 0xA000;
 	dev->touch = (tmp > 0);

--=-CUaC+5Ah9xa6yw3bz1sV--

