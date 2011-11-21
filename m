From: JJ Ding <jj_ding@emc.com.tw>
Subject: [PATCH v2 2/2] Input: elantech - add resolution query support for v4 hardware
Date: Mon, 21 Nov 2011 13:53:06 +0800
Message-ID: <1321854786-6666-3-git-send-email-jj_ding@emc.com.tw>
References: <1321854786-6666-1-git-send-email-jj_ding@emc.com.tw>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:6308 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250Ab1KUFzj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Nov 2011 00:55:39 -0500
In-Reply-To: <1321854786-6666-1-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, =?UTF-8?q?=C3=89ric=20Piel?= <E.A.B.Piel@tudelft.nl>
Cc: linux-input@vger.kernel.org, JJ Ding <jj_ding@emc.com.tw>

It turns out that v4's firmware provides a command so we can query
the resolution. Let's use it.

Signed-off-by: JJ Ding <jj_ding@emc.com.tw>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
---

Hi Daniel,

I still add your Reviewed-by. I checked synaptics.c and it leaves resolution
zero if touchpad doesn't support it. So I just allow the query to fail and don't
check x_res != 0 && y_res != 0. If the query fails, x_res and y_res should be 0
as they've been initialized. Please let me know if you think this behavior might
cause problems. Thank you very much.

jj

 drivers/input/mouse/elantech.c |   37 +++++++++++++++++++++++++++++++++++++
 drivers/input/mouse/elantech.h |    1 +
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index dae020c..1122924 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -931,6 +931,30 @@ static int elantech_set_range(struct psmouse *psmouse,
 }
 
 /*
+ * (value from firmware) * 10 + 790 = dpi
+ * we also have to convert dpi to dots/mm (*10/254 to avoid floating point)
+ */
+static inline unsigned int convert_res(unsigned int val)
+{
+	return (val * 10 + 790) * 10 / 254;
+}
+
+static int set_resolution_v4(struct psmouse *psmouse,
+			     unsigned int *x_res,
+			     unsigned int *y_res)
+{
+	unsigned char param[3];
+
+	if (elantech_send_cmd(psmouse, ETP_RESOLUTION_QUERY, param))
+		return -1;
+
+	*x_res = convert_res(param[1] & 0x0f);
+	*y_res = convert_res((param[1] & 0xf0) >> 4);
+
+	return 0;
+}
+
+/*
  * Set the appropriate event bits for the input subsystem
  */
 static int elantech_set_input_params(struct psmouse *psmouse)
@@ -938,6 +962,7 @@ static int elantech_set_input_params(struct psmouse *psmouse)
 	struct input_dev *dev = psmouse->dev;
 	struct elantech_data *etd = psmouse->private;
 	unsigned int x_min = 0, y_min = 0, x_max = 0, y_max = 0, width = 0;
+	unsigned int x_res = 0, y_res = 0;
 
 	if (elantech_set_range(psmouse, &x_min, &y_min, &x_max, &y_max, &width))
 		return -1;
@@ -985,10 +1010,20 @@ static int elantech_set_input_params(struct psmouse *psmouse)
 		break;
 
 	case 4:
+		if (set_resolution_v4(psmouse, &x_res, &y_res)) {
+			/*
+			 * if query failed, print a warning and leave the values
+			 * zero to resemble synaptics.c behavior.
+			 */
+			psmouse_warn(psmouse, "couldn't query resolution data.\n");
+		}
+
 		__set_bit(BTN_TOOL_QUADTAP, dev->keybit);
 		/* For X to recognize me as touchpad. */
 		input_set_abs_params(dev, ABS_X, x_min, x_max, 0, 0);
 		input_set_abs_params(dev, ABS_Y, y_min, y_max, 0, 0);
+		input_abs_set_res(dev, ABS_X, x_res);
+		input_abs_set_res(dev, ABS_Y, y_res);
 		/*
 		 * range of pressure and width is the same as v2,
 		 * report ABS_PRESSURE, ABS_TOOL_WIDTH for compatibility.
@@ -1001,6 +1036,8 @@ static int elantech_set_input_params(struct psmouse *psmouse)
 		input_mt_init_slots(dev, ETP_MAX_FINGERS);
 		input_set_abs_params(dev, ABS_MT_POSITION_X, x_min, x_max, 0, 0);
 		input_set_abs_params(dev, ABS_MT_POSITION_Y, y_min, y_max, 0, 0);
+		input_abs_set_res(dev, ABS_MT_POSITION_X, x_res);
+		input_abs_set_res(dev, ABS_MT_POSITION_Y, y_res);
 		input_set_abs_params(dev, ABS_MT_PRESSURE, ETP_PMIN_V2,
 				     ETP_PMAX_V2, 0, 0);
 		/*
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h
index 08d00bd..46db3be 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -20,6 +20,7 @@
 #define ETP_FW_VERSION_QUERY		0x01
 #define ETP_CAPABILITIES_QUERY		0x02
 #define ETP_SAMPLE_QUERY		0x03
+#define ETP_RESOLUTION_QUERY		0x04
 
 /*
  * Command values for register reading or writing
-- 
1.7.8-rc2

