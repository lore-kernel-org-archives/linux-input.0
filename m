From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/7] Input: logips2pp - clean up code
Date: Fri, 19 Jan 2018 15:06:25 -0800
Message-ID: <20180119230629.49428-4-dmitry.torokhov@gmail.com>
References: <20180119230629.49428-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44740 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756185AbeASXGh (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Jan 2018 18:06:37 -0500
In-Reply-To: <20180119230629.49428-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Lyude Paul <lyude@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

- switch to using BIT() macros
- use u8 instead of unsigned char for byte data
- use input_set_capability() instead of manipulating capabilities bits
  directly
- use sign_extend32() when extracting wheel data.
- do not abuse -1 as error code, propagate errors from various calls.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/logips2pp.c | 142 +++++++++++++++++++++++-----------------
 1 file changed, 83 insertions(+), 59 deletions(-)

diff --git a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2pp.c
index b7d17db632fc0..3c8d7051ef5e0 100644
--- a/drivers/input/mouse/logips2pp.c
+++ b/drivers/input/mouse/logips2pp.c
@@ -9,9 +9,11 @@
  * the Free Software Foundation.
  */
 
+#include <linux/bitops.h>
 #include <linux/input.h>
 #include <linux/serio.h>
 #include <linux/libps2.h>
+#include <linux/types.h>
 #include "psmouse.h"
 #include "logips2pp.h"
 
@@ -22,12 +24,12 @@
 #define PS2PP_KIND_TRACKMAN	4
 
 /* Logitech mouse features */
-#define PS2PP_WHEEL		0x01
-#define PS2PP_HWHEEL		0x02
-#define PS2PP_SIDE_BTN		0x04
-#define PS2PP_EXTRA_BTN		0x08
-#define PS2PP_TASK_BTN		0x10
-#define PS2PP_NAV_BTN		0x20
+#define PS2PP_WHEEL		BIT(0)
+#define PS2PP_HWHEEL		BIT(1)
+#define PS2PP_SIDE_BTN		BIT(2)
+#define PS2PP_EXTRA_BTN		BIT(3)
+#define PS2PP_TASK_BTN		BIT(4)
+#define PS2PP_NAV_BTN		BIT(5)
 
 struct ps2pp_info {
 	u8 model;
@@ -42,7 +44,7 @@ struct ps2pp_info {
 static psmouse_ret_t ps2pp_process_byte(struct psmouse *psmouse)
 {
 	struct input_dev *dev = psmouse->dev;
-	unsigned char *packet = psmouse->packet;
+	u8 *packet = psmouse->packet;
 
 	if (psmouse->pktcnt < 3)
 		return PSMOUSE_GOOD_DATA;
@@ -58,28 +60,30 @@ static psmouse_ret_t ps2pp_process_byte(struct psmouse *psmouse)
 
 		case 0x0d: /* Mouse extra info */
 
-			input_report_rel(dev, packet[2] & 0x80 ? REL_HWHEEL : REL_WHEEL,
-				(int) (packet[2] & 8) - (int) (packet[2] & 7));
-			input_report_key(dev, BTN_SIDE, (packet[2] >> 4) & 1);
-			input_report_key(dev, BTN_EXTRA, (packet[2] >> 5) & 1);
+			input_report_rel(dev,
+				packet[2] & 0x80 ? REL_HWHEEL : REL_WHEEL,
+				-sign_extend32(packet[2], 3));
+			input_report_key(dev, BTN_SIDE,  packet[2] & BIT(4));
+			input_report_key(dev, BTN_EXTRA, packet[2] & BIT(5));
 
 			break;
 
 		case 0x0e: /* buttons 4, 5, 6, 7, 8, 9, 10 info */
 
-			input_report_key(dev, BTN_SIDE, (packet[2]) & 1);
-			input_report_key(dev, BTN_EXTRA, (packet[2] >> 1) & 1);
-			input_report_key(dev, BTN_BACK, (packet[2] >> 3) & 1);
-			input_report_key(dev, BTN_FORWARD, (packet[2] >> 4) & 1);
-			input_report_key(dev, BTN_TASK, (packet[2] >> 2) & 1);
+			input_report_key(dev, BTN_SIDE,    packet[2] & BIT(0));
+			input_report_key(dev, BTN_EXTRA,   packet[2] & BIT(1));
+			input_report_key(dev, BTN_TASK,    packet[2] & BIT(2));
+			input_report_key(dev, BTN_BACK,    packet[2] & BIT(3));
+			input_report_key(dev, BTN_FORWARD, packet[2] & BIT(4));
 
 			break;
 
 		case 0x0f: /* TouchPad extra info */
 
-			input_report_rel(dev, packet[2] & 0x08 ? REL_HWHEEL : REL_WHEEL,
-				(int) ((packet[2] >> 4) & 8) - (int) ((packet[2] >> 4) & 7));
-			packet[0] = packet[2] | 0x08;
+			input_report_rel(dev,
+				packet[2] & 0x08 ? REL_HWHEEL : REL_WHEEL,
+				-sign_extend32(packet[2] >> 4, 3));
+			packet[0] = packet[2] | BIT(3);
 			break;
 
 		default:
@@ -109,13 +113,17 @@ static psmouse_ret_t ps2pp_process_byte(struct psmouse *psmouse)
  * Ugly.
  */
 
-static int ps2pp_cmd(struct psmouse *psmouse, unsigned char *param, unsigned char command)
+static int ps2pp_cmd(struct psmouse *psmouse, u8 *param, u8 command)
 {
-	if (psmouse_sliced_command(psmouse, command))
-		return -1;
+	int error;
+
+	error = psmouse_sliced_command(psmouse, command);
+	if (error)
+		return error;
 
-	if (ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_POLL | 0x0300))
-		return -1;
+	error = ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_POLL | 0x0300);
+	if (error)
+		return error;
 
 	return 0;
 }
@@ -131,7 +139,7 @@ static int ps2pp_cmd(struct psmouse *psmouse, unsigned char *param, unsigned cha
 static void ps2pp_set_smartscroll(struct psmouse *psmouse, bool smartscroll)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
-	unsigned char param[4];
+	u8 param[4];
 
 	ps2pp_cmd(psmouse, param, 0x32);
 
@@ -169,7 +177,7 @@ static ssize_t ps2pp_attr_set_smartscroll(struct psmouse *psmouse, void *data,
 }
 
 PSMOUSE_DEFINE_ATTR(smartscroll, S_IWUSR | S_IRUGO, NULL,
-			ps2pp_attr_show_smartscroll, ps2pp_attr_set_smartscroll);
+		    ps2pp_attr_show_smartscroll, ps2pp_attr_set_smartscroll);
 
 /*
  * Support 800 dpi resolution _only_ if the user wants it (there are good
@@ -177,11 +185,12 @@ PSMOUSE_DEFINE_ATTR(smartscroll, S_IWUSR | S_IRUGO, NULL,
  * also good reasons to use it, let the user decide).
  */
 
-static void ps2pp_set_resolution(struct psmouse *psmouse, unsigned int resolution)
+static void ps2pp_set_resolution(struct psmouse *psmouse,
+				 unsigned int resolution)
 {
 	if (resolution > 400) {
 		struct ps2dev *ps2dev = &psmouse->ps2dev;
-		unsigned char param = 3;
+		u8 param = 3;
 
 		ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE11);
 		ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE11);
@@ -194,7 +203,8 @@ static void ps2pp_set_resolution(struct psmouse *psmouse, unsigned int resolutio
 
 static void ps2pp_disconnect(struct psmouse *psmouse)
 {
-	device_remove_file(&psmouse->ps2dev.serio->dev, &psmouse_attr_smartscroll.dattr);
+	device_remove_file(&psmouse->ps2dev.serio->dev,
+			   &psmouse_attr_smartscroll.dattr);
 }
 
 static const struct ps2pp_info *get_model_info(unsigned char model)
@@ -267,24 +277,24 @@ static void ps2pp_set_model_properties(struct psmouse *psmouse,
 	struct input_dev *input_dev = psmouse->dev;
 
 	if (model_info->features & PS2PP_SIDE_BTN)
-		__set_bit(BTN_SIDE, input_dev->keybit);
+		input_set_capability(input_dev, EV_KEY, BTN_SIDE);
 
 	if (model_info->features & PS2PP_EXTRA_BTN)
-		__set_bit(BTN_EXTRA, input_dev->keybit);
+		input_set_capability(input_dev, EV_KEY, BTN_EXTRA);
 
 	if (model_info->features & PS2PP_TASK_BTN)
-		__set_bit(BTN_TASK, input_dev->keybit);
+		input_set_capability(input_dev, EV_KEY, BTN_TASK);
 
 	if (model_info->features & PS2PP_NAV_BTN) {
-		__set_bit(BTN_FORWARD, input_dev->keybit);
-		__set_bit(BTN_BACK, input_dev->keybit);
+		input_set_capability(input_dev, EV_KEY, BTN_FORWARD);
+		input_set_capability(input_dev, EV_KEY, BTN_BACK);
 	}
 
 	if (model_info->features & PS2PP_WHEEL)
-		__set_bit(REL_WHEEL, input_dev->relbit);
+		input_set_capability(input_dev, EV_REL, REL_WHEEL);
 
 	if (model_info->features & PS2PP_HWHEEL)
-		__set_bit(REL_HWHEEL, input_dev->relbit);
+		input_set_capability(input_dev, EV_REL, REL_HWHEEL);
 
 	switch (model_info->kind) {
 
@@ -316,6 +326,30 @@ static void ps2pp_set_model_properties(struct psmouse *psmouse,
 	}
 }
 
+static int ps2pp_setup_protocol(struct psmouse *psmouse,
+				const struct ps2pp_info *model_info)
+{
+	int error;
+
+	psmouse->protocol_handler = ps2pp_process_byte;
+	psmouse->pktsize = 3;
+
+	if (model_info->kind != PS2PP_KIND_TP3) {
+		psmouse->set_resolution = ps2pp_set_resolution;
+		psmouse->disconnect = ps2pp_disconnect;
+
+		error = device_create_file(&psmouse->ps2dev.serio->dev,
+					   &psmouse_attr_smartscroll.dattr);
+		if (error) {
+			psmouse_err(psmouse,
+				    "failed to create smartscroll sysfs attribute, error: %d\n",
+				    error);
+			return error;
+		}
+	}
+
+	return 0;
+}
 
 /*
  * Logitech magic init. Detect whether the mouse is a Logitech one
@@ -326,9 +360,9 @@ static void ps2pp_set_model_properties(struct psmouse *psmouse,
 int ps2pp_detect(struct psmouse *psmouse, bool set_properties)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
-	unsigned char param[4];
-	unsigned char model, buttons;
 	const struct ps2pp_info *model_info;
+	u8 param[4];
+	u8 model, buttons;
 	bool use_ps2pp = false;
 	int error;
 
@@ -344,7 +378,7 @@ int ps2pp_detect(struct psmouse *psmouse, bool set_properties)
 	buttons = param[1];
 
 	if (!model || !buttons)
-		return -1;
+		return -ENXIO;
 
 	model_info = get_model_info(model);
 	if (model_info) {
@@ -366,7 +400,8 @@ int ps2pp_detect(struct psmouse *psmouse, bool set_properties)
 
 			param[0] = 0;
 			if (!ps2_command(ps2dev, param, 0x13d1) &&
-			    param[0] == 0x06 && param[1] == 0x00 && param[2] == 0x14) {
+			    param[0] == 0x06 && param[1] == 0x00 &&
+			    param[2] == 0x14) {
 				use_ps2pp = true;
 			}
 
@@ -385,7 +420,9 @@ int ps2pp_detect(struct psmouse *psmouse, bool set_properties)
 		}
 
 	} else {
-		psmouse_warn(psmouse, "Detected unknown Logitech mouse model %d\n", model);
+		psmouse_warn(psmouse,
+			     "Detected unknown Logitech mouse model %d\n",
+			     model);
 	}
 
 	if (set_properties) {
@@ -393,31 +430,18 @@ int ps2pp_detect(struct psmouse *psmouse, bool set_properties)
 		psmouse->model = model;
 
 		if (use_ps2pp) {
-			psmouse->protocol_handler = ps2pp_process_byte;
-			psmouse->pktsize = 3;
-
-			if (model_info->kind != PS2PP_KIND_TP3) {
-				psmouse->set_resolution = ps2pp_set_resolution;
-				psmouse->disconnect = ps2pp_disconnect;
-
-				error = device_create_file(&ps2dev->serio->dev,
-							   &psmouse_attr_smartscroll.dattr);
-				if (error) {
-					psmouse_err(psmouse,
-						    "failed to create smartscroll sysfs attribute, error: %d\n",
-						    error);
-					return -1;
-				}
-			}
+			error = ps2pp_setup_protocol(psmouse, model_info);
+			if (error)
+				return error;
 		}
 
 		if (buttons >= 3)
-			__set_bit(BTN_MIDDLE, psmouse->dev->keybit);
+			input_set_capability(psmouse->dev, EV_KEY, BTN_MIDDLE);
 
 		if (model_info)
 			ps2pp_set_model_properties(psmouse, model_info, use_ps2pp);
 	}
 
-	return use_ps2pp ? 0 : -1;
+	return use_ps2pp ? 0 : -ENXIO;
 }
 
-- 
2.16.0.rc1.238.g530d649a79-goog

