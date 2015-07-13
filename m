From: Philippe Coval <rzr@gna.org>
Subject: [PATCH v2] usbtouchscreen: adds support for inverting X or Y axis (or both)
Date: Mon, 13 Jul 2015 12:15:03 +0200
Message-ID: <1436782503-9749-1-git-send-email-rzr@gna.org>
References: <1433720284-23342-1-git-send-email-rzr@gna.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:51815 "EHLO
	smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbbGMKQq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2015 06:16:46 -0400
In-Reply-To: <1433720284-23342-1-git-send-email-rzr@gna.org>
In-Reply-To: <1433720284-23342-1-git-send-email-rzr@gna.org>
References: <1433720284-23342-1-git-send-email-rzr@gna.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: poeschel@lemonage.de, dmitry.torokhov@gmail.com
Cc: Philippe Coval <rzr@gna.org>, Ondrej Zary <linux@rainbow-software.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Philippe Coval <philippe.coval@open.eurogiciel.org>

Invert Y is needed (together with swap XY) for some touchscreens :
- LeadingTouch screens (at least for some of them)
- CarTft 8in4 (USB ID=0eef:0001)

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
Bug-Link: https://bugs.tizen.org/jira/browse/TC-2522
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philippe Coval <philippe.coval@open.eurogiciel.org>
---

ChangeLog:

* v1: Initial version from me :
  Rebased on v4.1.0-rc6
  https://lkml.org/lkml/2015/6/7/191
  Note it is based on Ondrej Zary's patch (2007):
  https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg136266.html
  Test demo on tizen cartft 8inch4 :
  https://www.youtube.com/watch?v=4L9Bjfy8oDM
* v2: Use bool not int for options variables
  Rebased on v4.2-rc2
  Latest unmerged version can be picked from :
  https://github.com/rzr/linux/tree/for-upstream

 drivers/input/touchscreen/usbtouchscreen.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index f2c6c35..af7e6f3 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -63,6 +63,12 @@
 static bool swap_xy;
 module_param(swap_xy, bool, 0644);
 MODULE_PARM_DESC(swap_xy, "If set X and Y axes are swapped.");
+static int invert_x;
+module_param(invert_x, bool, 0644);
+MODULE_PARM_DESC(invert_x, "Invert X axis.");
+static int invert_y;
+module_param(invert_y, bool, 0644);
+MODULE_PARM_DESC(invert_y, "Invert Y axis.");
 
 static bool hwcalib_xy;
 module_param(hwcalib_xy, bool, 0644);
@@ -1303,6 +1309,7 @@ static void usbtouch_process_pkt(struct usbtouch_usb *usbtouch,
                                  unsigned char *pkt, int len)
 {
 	struct usbtouch_device_info *type = usbtouch->type;
+	int x, y;
 
 	if (!type->read_data(usbtouch, pkt))
 			return;
@@ -1310,12 +1317,20 @@ static void usbtouch_process_pkt(struct usbtouch_usb *usbtouch,
 	input_report_key(usbtouch->input, BTN_TOUCH, usbtouch->touch);
 
 	if (swap_xy) {
-		input_report_abs(usbtouch->input, ABS_X, usbtouch->y);
-		input_report_abs(usbtouch->input, ABS_Y, usbtouch->x);
+		x = usbtouch->y;
+		y = usbtouch->x;
 	} else {
-		input_report_abs(usbtouch->input, ABS_X, usbtouch->x);
-		input_report_abs(usbtouch->input, ABS_Y, usbtouch->y);
+		x = usbtouch->x;
+		y = usbtouch->y;
 	}
+	if (invert_x)
+		x = type->max_xc - x + type->min_xc;
+	if (invert_y)
+		y = type->max_yc - y + type->min_yc;
+
+	input_report_abs(usbtouch->input, ABS_X, x);
+	input_report_abs(usbtouch->input, ABS_Y, y);
+
 	if (type->max_press)
 		input_report_abs(usbtouch->input, ABS_PRESSURE, usbtouch->press);
 	input_sync(usbtouch->input);
-- 
2.1.4

