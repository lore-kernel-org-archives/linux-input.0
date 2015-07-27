From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] usbtouchscreen: add option for inverting X or Y axis
Date: Mon, 27 Jul 2015 15:28:23 -0700
Message-ID: <20150727222823.GF3613@dtor-ws>
References: <1436782503-9749-1-git-send-email-rzr@gna.org>
 <1438035361-9157-1-git-send-email-rzr@gna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438035361-9157-1-git-send-email-rzr@gna.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Philippe Coval <rzr@gna.org>
Cc: bernhard.bender@bytecmed.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Philippe Coval <philippe.coval@open.eurogiciel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Jul 28, 2015 at 12:16:01AM +0200, Philippe Coval wrote:
> Invert Y is needed (together with swap XY) for some touchscreens,
> at least for some of them :
> 
> - CarTft 8in4 (type=eGalax, USB=0eef:0001)
> - LeadingTouch
> 
> Since there is not guarantee that
> those above devices will all behave the same,
> it's safer to configure them userland using udev rules.
> 
> This way is safer than hardcoding options per "recognized" model,
> and possible regressions will be avoided in a first place.

Does the following still work?

Thanks.

-- 
Dmitry

Input: usbtouchscreen - add option for inverting X or Y axis

From: Philippe Coval <rzr@gna.org>

Invert Y is needed (together with swap XY) for some touchscreens,
at least for some of them:

- CarTft 8in4 (type=eGalax, USB=0eef:0001)
- LeadingTouch

Since there is not guarantee that those above devices will all behave the
same, it's safer to configure them from userland using udev rules.

This way is safer than hard-coding options per "recognized" model,
and possible regressions will be avoided in a first place.

Credits-to: Ondrej Zary <linux@rainbow-software.org>
Link:  https://lkml.org/lkml/2015/6/7/191
Bug-Link: https://bugs.tizen.org/jira/browse/TC-2522
Signed-off-by: Philippe Coval <philippe.coval@open.eurogiciel.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/usbtouchscreen.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 2c41107..d283077 100644
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
@@ -1312,13 +1320,16 @@ static void usbtouch_process_pkt(struct usbtouch_usb *usbtouch,
 
 	input_report_key(usbtouch->input, BTN_TOUCH, usbtouch->touch);
 
-	if (swap_xy) {
-		input_report_abs(usbtouch->input, ABS_X, usbtouch->y);
-		input_report_abs(usbtouch->input, ABS_Y, usbtouch->x);
-	} else {
-		input_report_abs(usbtouch->input, ABS_X, usbtouch->x);
-		input_report_abs(usbtouch->input, ABS_Y, usbtouch->y);
-	}
+	if (swap_xy)
+		swap(usbtouch->y, usbtouch->x);
+	if (invert_x)
+		usbtouch->x = type->max_xc - usbtouch->x + type->min_xc;
+	if (invert_y)
+		usbtouch->y = type->max_yc - usbtouch->y + type->min_yc;
+
+	input_report_abs(usbtouch->input, ABS_X, usbtouch->x);
+	input_report_abs(usbtouch->input, ABS_Y, usbtouch->y);
+
 	if (type->max_press)
 		input_report_abs(usbtouch->input, ABS_PRESSURE, usbtouch->press);
 	input_sync(usbtouch->input);
