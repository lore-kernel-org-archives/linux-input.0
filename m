From: "Matteo Croce" <technoboy85@gmail.com>
Subject: [PATCH] usbtouchscreen: option to swap X and Y axes
Date: Thu, 18 Sep 2008 19:16:40 +0200
Message-ID: <40101cc30809181016l632de30en6ff56b1fe9fe36ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:65180 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754128AbYIRRQm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Sep 2008 13:16:42 -0400
Received: by gxk9 with SMTP id 9so31534630gxk.13
        for <linux-input@vger.kernel.org>; Thu, 18 Sep 2008 10:16:40 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Here there is a patch to invert the X and Y axes, as my controller swaps it:

Signed-off-by: Matteo Croce <matteo@openwrt.org>

--- a/drivers/input/touchscreen/usbtouchscreen.c	2008-09-18
18:50:44.294868149 +0200
+++ b/drivers/input/touchscreen/usbtouchscreen.c	2008-09-18
18:50:44.226867816 +0200
@@ -56,8 +56,16 @@
 #define DRIVER_DESC		"USB Touchscreen Driver"

 static int swap_xy;
+static int invert_x;
+static int invert_y;
+
 module_param(swap_xy, bool, 0644);
+module_param(invert_x, bool, 0644);
+module_param(invert_y, bool, 0644);
+
 MODULE_PARM_DESC(swap_xy, "If set X and Y axes are swapped.");
+MODULE_PARM_DESC(invert_x, "If set X axe is inverted.");
+MODULE_PARM_DESC(invert_y, "If set Y axe is inverted.");

 /* device specifc data/functions */
 struct usbtouch_usb;
@@ -683,6 +691,7 @@
                                  unsigned char *pkt, int len)
 {
 	struct usbtouch_device_info *type = usbtouch->type;
+	int x, y;

 	if (!type->read_data(usbtouch, pkt))
 			return;
@@ -690,12 +699,22 @@
 	input_report_key(usbtouch->input, BTN_TOUCH, usbtouch->touch);

 	if (swap_xy) {
-		input_report_abs(usbtouch->input, ABS_X, usbtouch->y);
-		input_report_abs(usbtouch->input, ABS_Y, usbtouch->x);
+		x = usbtouch->y;
+		y = usbtouch->x;
+		if(invert_x)
+			x = type->max_yc - (x - type->min_yc);
+		if(invert_y)
+			y = type->max_xc - (y - type->min_xc);
 	} else {
-		input_report_abs(usbtouch->input, ABS_X, usbtouch->x);
-		input_report_abs(usbtouch->input, ABS_Y, usbtouch->y);
+		x = usbtouch->x;
+		y = usbtouch->y;
+		if(invert_x)
+			x = type->max_xc - (x - type->min_xc);
+		if(invert_y)
+			y = type->max_yc - (y - type->min_yc);
 	}
+	input_report_abs(usbtouch->input, ABS_X, x);
+	input_report_abs(usbtouch->input, ABS_Y, y);
 	if (type->max_press)
 		input_report_abs(usbtouch->input, ABS_PRESSURE, usbtouch->press);
 	input_sync(usbtouch->input);
