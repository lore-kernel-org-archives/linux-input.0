From: Philippe Coval <rzr@gna.org>
Subject: [PATCH v3] usbtouchscreen: add option for inverting X or Y axis
Date: Tue, 28 Jul 2015 00:16:01 +0200
Message-ID: <1438035361-9157-1-git-send-email-rzr@gna.org>
References: <1436782503-9749-1-git-send-email-rzr@gna.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436782503-9749-1-git-send-email-rzr@gna.org>
In-Reply-To: <1436782503-9749-1-git-send-email-rzr@gna.org>
References: <1436782503-9749-1-git-send-email-rzr@gna.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, bernhard.bender@bytecmed.com
Cc: Philippe Coval <rzr@gna.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Philippe Coval <philippe.coval@open.eurogiciel.org>
List-Id: linux-input@vger.kernel.org

Invert Y is needed (together with swap XY) for some touchscreens,
at least for some of them :

- CarTft 8in4 (type=eGalax, USB=0eef:0001)
- LeadingTouch

Since there is not guarantee that
those above devices will all behave the same,
it's safer to configure them userland using udev rules.

This way is safer than hardcoding options per "recognized" model,
and possible regressions will be avoided in a first place.

Credits-to: Ondrej Zary <linux@rainbow-software.org>
Link:  https://lkml.org/lkml/2015/6/7/191
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
* v3: Use bool static vars (for real), update commit message
  Rebased on v4.2-rc4
  https://github.com/dtor/input/pull/2

 drivers/input/touchscreen/usbtouchscreen.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 2c41107..cfdfb9f 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -64,6 +64,14 @@ static bool swap_xy;
 module_param(swap_xy, bool, 0644);
 MODULE_PARM_DESC(swap_xy, "If set X and Y axes are swapped.");
 
+static bool invert_x;
+module_param(invert_x, bool, 0644);
+MODULE_PARM_DESC(invert_x, "Invert X axis.");
+
+static bool invert_y;
+module_param(invert_y, bool, 0644);
+MODULE_PARM_DESC(invert_y, "Invert Y axis.");
+
 static bool hwcalib_xy;
 module_param(hwcalib_xy, bool, 0644);
 MODULE_PARM_DESC(hwcalib_xy, "If set hw-calibrated X/Y are used if available");
@@ -1306,6 +1314,7 @@ static void usbtouch_process_pkt(struct usbtouch_usb *usbtouch,
                                  unsigned char *pkt, int len)
 {
 	struct usbtouch_device_info *type = usbtouch->type;
+	int x, y;
 
 	if (!type->read_data(usbtouch, pkt))
 			return;
@@ -1313,12 +1322,20 @@ static void usbtouch_process_pkt(struct usbtouch_usb *usbtouch,
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
