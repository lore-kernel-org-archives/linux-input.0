From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/7] Input: psmouse - clean up code
Date: Fri, 19 Jan 2018 15:06:24 -0800
Message-ID: <20180119230629.49428-3-dmitry.torokhov@gmail.com>
References: <20180119230629.49428-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33137 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756071AbeASXGf (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Jan 2018 18:06:35 -0500
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
 drivers/input/mouse/psmouse-base.c | 140 ++++++++++++++++++++-----------------
 1 file changed, 77 insertions(+), 63 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 19f7727555911..cbca668bb931f 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -14,6 +14,7 @@
 #define pr_fmt(fmt)		KBUILD_MODNAME ": " fmt
 #define psmouse_fmt(fmt)	fmt
 
+#include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -23,6 +24,7 @@
 #include <linux/init.h>
 #include <linux/libps2.h>
 #include <linux/mutex.h>
+#include <linux/types.h>
 
 #include "psmouse.h"
 #include "synaptics.h"
@@ -147,7 +149,7 @@ void psmouse_report_standard_packet(struct input_dev *dev, u8 *packet)
 psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse)
 {
 	struct input_dev *dev = psmouse->dev;
-	unsigned char *packet = psmouse->packet;
+	u8 *packet = psmouse->packet;
 
 	if (psmouse->pktcnt < psmouse->pktsize)
 		return PSMOUSE_GOOD_DATA;
@@ -157,39 +159,42 @@ psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse)
 	switch (psmouse->protocol->type) {
 	case PSMOUSE_IMPS:
 		/* IntelliMouse has scroll wheel */
-		input_report_rel(dev, REL_WHEEL, -(signed char) packet[3]);
+		input_report_rel(dev, REL_WHEEL, -(s8) packet[3]);
 		break;
 
 	case PSMOUSE_IMEX:
 		/* Scroll wheel and buttons on IntelliMouse Explorer */
 		switch (packet[3] & 0xC0) {
 		case 0x80: /* vertical scroll on IntelliMouse Explorer 4.0 */
-			input_report_rel(dev, REL_WHEEL, (int) (packet[3] & 32) - (int) (packet[3] & 31));
+			input_report_rel(dev, REL_WHEEL,
+					 -sign_extend32(packet[3], 5));
 			break;
 		case 0x40: /* horizontal scroll on IntelliMouse Explorer 4.0 */
-			input_report_rel(dev, REL_HWHEEL, (int) (packet[3] & 32) - (int) (packet[3] & 31));
+			input_report_rel(dev, REL_HWHEEL,
+					 -sign_extend32(packet[3], 5));
 			break;
 		case 0x00:
 		case 0xC0:
-			input_report_rel(dev, REL_WHEEL, (int) (packet[3] & 8) - (int) (packet[3] & 7));
-			input_report_key(dev, BTN_SIDE, (packet[3] >> 4) & 1);
-			input_report_key(dev, BTN_EXTRA, (packet[3] >> 5) & 1);
+			input_report_rel(dev, REL_WHEEL,
+					 -sign_extend32(packet[3], 3));
+			input_report_key(dev, BTN_SIDE,  BIT(4));
+			input_report_key(dev, BTN_EXTRA, BIT(5));
 			break;
 		}
 		break;
 
 	case PSMOUSE_GENPS:
 		/* Report scroll buttons on NetMice */
-		input_report_rel(dev, REL_WHEEL, -(signed char) packet[3]);
+		input_report_rel(dev, REL_WHEEL, -(s8) packet[3]);
 
 		/* Extra buttons on Genius NewNet 3D */
-		input_report_key(dev, BTN_SIDE, (packet[0] >> 6) & 1);
-		input_report_key(dev, BTN_EXTRA, (packet[0] >> 7) & 1);
+		input_report_key(dev, BTN_SIDE,  BIT(6));
+		input_report_key(dev, BTN_EXTRA, BIT(7));
 		break;
 
 	case PSMOUSE_THINKPS:
 		/* Extra button on ThinkingMouse */
-		input_report_key(dev, BTN_EXTRA, (packet[0] >> 3) & 1);
+		input_report_key(dev, BTN_EXTRA, BIT(3));
 
 		/*
 		 * Without this bit of weirdness moving up gives wildly
@@ -203,8 +208,8 @@ psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse)
 		 * Cortron PS2 Trackball reports SIDE button in the
 		 * 4th bit of the first byte.
 		 */
-		input_report_key(dev, BTN_SIDE, (packet[0] >> 3) & 1);
-		packet[0] |= 0x08;
+		input_report_key(dev, BTN_SIDE, BIT(3));
+		packet[0] |= BIT(3);
 		break;
 
 	default:
@@ -269,7 +274,7 @@ static int psmouse_handle_byte(struct psmouse *psmouse)
 				psmouse_notice(psmouse,
 						"issuing reconnect request\n");
 				serio_reconnect(psmouse->ps2dev.serio);
-				return -1;
+				return -EIO;
 			}
 		}
 		psmouse->pktcnt = 0;
@@ -320,7 +325,7 @@ static void psmouse_handle_oob_data(struct psmouse *psmouse, u8 data)
  * for normal processing or gathering them as command response.
  */
 static irqreturn_t psmouse_interrupt(struct serio *serio,
-		unsigned char data, unsigned int flags)
+				     u8 data, unsigned int flags)
 {
 	struct psmouse *psmouse = serio_get_drvdata(serio);
 
@@ -418,17 +423,20 @@ static irqreturn_t psmouse_interrupt(struct serio *serio,
  * 0xE6 0xE8 rr 0xE8 ss 0xE8 tt 0xE8 uu where (rr*64)+(ss*16)+(tt*4)+uu
  * is the command.
  */
-int psmouse_sliced_command(struct psmouse *psmouse, unsigned char command)
+int psmouse_sliced_command(struct psmouse *psmouse, u8 command)
 {
 	int i;
+	int error;
 
-	if (ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11))
-		return -1;
+	error = ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11);
+	if (error)
+		return error;
 
 	for (i = 6; i >= 0; i -= 2) {
-		unsigned char d = (command >> i) & 3;
-		if (ps2_command(&psmouse->ps2dev, &d, PSMOUSE_CMD_SETRES))
-			return -1;
+		u8 d = (command >> i) & 3;
+		error = ps2_command(&psmouse->ps2dev, &d, PSMOUSE_CMD_SETRES);
+		if (error)
+			return error;
 	}
 
 	return 0;
@@ -439,13 +447,15 @@ int psmouse_sliced_command(struct psmouse *psmouse, unsigned char command)
  */
 int psmouse_reset(struct psmouse *psmouse)
 {
-	unsigned char param[2];
+	u8 param[2];
+	int error;
 
-	if (ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_RESET_BAT))
-		return -1;
+	error = ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_RESET_BAT);
+	if (error)
+		return error;
 
 	if (param[0] != PSMOUSE_RET_BAT && param[1] != PSMOUSE_RET_ID)
-		return -1;
+		return -EIO;
 
 	return 0;
 }
@@ -455,8 +465,8 @@ int psmouse_reset(struct psmouse *psmouse)
  */
 void psmouse_set_resolution(struct psmouse *psmouse, unsigned int resolution)
 {
-	static const unsigned char params[] = { 0, 1, 2, 2, 3 };
-	unsigned char p;
+	static const u8 params[] = { 0, 1, 2, 2, 3 };
+	u8 p;
 
 	if (resolution == 0 || resolution > 200)
 		resolution = 200;
@@ -471,11 +481,12 @@ void psmouse_set_resolution(struct psmouse *psmouse, unsigned int resolution)
  */
 static void psmouse_set_rate(struct psmouse *psmouse, unsigned int rate)
 {
-	static const unsigned char rates[] = { 200, 100, 80, 60, 40, 20, 10, 0 };
-	unsigned char r;
+	static const u8 rates[] = { 200, 100, 80, 60, 40, 20, 10, 0 };
+	u8 r;
 	int i = 0;
 
-	while (rates[i] > rate) i++;
+	while (rates[i] > rate)
+		i++;
 	r = rates[i];
 	ps2_command(&psmouse->ps2dev, &r, PSMOUSE_CMD_SETRATE);
 	psmouse->rate = r;
@@ -547,7 +558,7 @@ bool psmouse_matches_pnp_id(struct psmouse *psmouse, const char * const ids[])
 static int genius_detect(struct psmouse *psmouse, bool set_properties)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
-	unsigned char param[4];
+	u8 param[4];
 
 	param[0] = 3;
 	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
@@ -557,7 +568,7 @@ static int genius_detect(struct psmouse *psmouse, bool set_properties)
 	ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO);
 
 	if (param[0] != 0x00 || param[1] != 0x33 || param[2] != 0x55)
-		return -1;
+		return -ENODEV;
 
 	if (set_properties) {
 		__set_bit(BTN_MIDDLE, psmouse->dev->keybit);
@@ -579,7 +590,7 @@ static int genius_detect(struct psmouse *psmouse, bool set_properties)
 static int intellimouse_detect(struct psmouse *psmouse, bool set_properties)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
-	unsigned char param[2];
+	u8 param[2];
 
 	param[0] = 200;
 	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
@@ -590,7 +601,7 @@ static int intellimouse_detect(struct psmouse *psmouse, bool set_properties)
 	ps2_command(ps2dev, param, PSMOUSE_CMD_GETID);
 
 	if (param[0] != 3)
-		return -1;
+		return -ENODEV;
 
 	if (set_properties) {
 		__set_bit(BTN_MIDDLE, psmouse->dev->keybit);
@@ -612,7 +623,7 @@ static int intellimouse_detect(struct psmouse *psmouse, bool set_properties)
 static int im_explorer_detect(struct psmouse *psmouse, bool set_properties)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
-	unsigned char param[2];
+	u8 param[2];
 
 	intellimouse_detect(psmouse, 0);
 
@@ -625,7 +636,7 @@ static int im_explorer_detect(struct psmouse *psmouse, bool set_properties)
 	ps2_command(ps2dev, param, PSMOUSE_CMD_GETID);
 
 	if (param[0] != 4)
-		return -1;
+		return -ENODEV;
 
 	/* Magic to enable horizontal scrolling on IntelliMouse 4.0 */
 	param[0] = 200;
@@ -658,8 +669,8 @@ static int im_explorer_detect(struct psmouse *psmouse, bool set_properties)
 static int thinking_detect(struct psmouse *psmouse, bool set_properties)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
-	unsigned char param[2];
-	static const unsigned char seq[] = { 20, 60, 40, 20, 20, 60, 40, 20, 20 };
+	u8 param[2];
+	static const u8 seq[] = { 20, 60, 40, 20, 20, 60, 40, 20, 20 };
 	int i;
 
 	param[0] = 10;
@@ -673,7 +684,7 @@ static int thinking_detect(struct psmouse *psmouse, bool set_properties)
 	ps2_command(ps2dev, param, PSMOUSE_CMD_GETID);
 
 	if (param[0] != 2)
-		return -1;
+		return -ENODEV;
 
 	if (set_properties) {
 		__set_bit(BTN_MIDDLE, psmouse->dev->keybit);
@@ -701,7 +712,7 @@ static int ps2bare_detect(struct psmouse *psmouse, bool set_properties)
 		 * We have no way of figuring true number of buttons so let's
 		 * assume that the device has 3.
 		 */
-		__set_bit(BTN_MIDDLE, psmouse->dev->keybit);
+		input_set_capability(psmouse->dev, EV_KEY, BTN_MIDDLE);
 	}
 
 	return 0;
@@ -956,20 +967,17 @@ static void psmouse_apply_defaults(struct psmouse *psmouse)
 {
 	struct input_dev *input_dev = psmouse->dev;
 
-	memset(input_dev->evbit, 0, sizeof(input_dev->evbit));
-	memset(input_dev->keybit, 0, sizeof(input_dev->keybit));
-	memset(input_dev->relbit, 0, sizeof(input_dev->relbit));
-	memset(input_dev->absbit, 0, sizeof(input_dev->absbit));
-	memset(input_dev->mscbit, 0, sizeof(input_dev->mscbit));
-
-	__set_bit(EV_KEY, input_dev->evbit);
-	__set_bit(EV_REL, input_dev->evbit);
+	bitmap_zero(input_dev->evbit, EV_CNT);
+	bitmap_zero(input_dev->keybit, KEY_CNT);
+	bitmap_zero(input_dev->relbit, REL_CNT);
+	bitmap_zero(input_dev->absbit, ABS_CNT);
+	bitmap_zero(input_dev->mscbit, MSC_CNT);
 
-	__set_bit(BTN_LEFT, input_dev->keybit);
-	__set_bit(BTN_RIGHT, input_dev->keybit);
+	input_set_capability(input_dev, EV_KEY, BTN_LEFT);
+	input_set_capability(input_dev, EV_KEY, BTN_RIGHT);
 
-	__set_bit(REL_X, input_dev->relbit);
-	__set_bit(REL_Y, input_dev->relbit);
+	input_set_capability(input_dev, EV_REL, REL_X);
+	input_set_capability(input_dev, EV_REL, REL_Y);
 
 	__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
 
@@ -1239,7 +1247,8 @@ static int psmouse_extensions(struct psmouse *psmouse,
 static int psmouse_probe(struct psmouse *psmouse)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
-	unsigned char param[2];
+	u8 param[2];
+	int error;
 
 	/*
 	 * First, we check if it's a mouse. It should send 0x00 or 0x03 in
@@ -1248,20 +1257,22 @@ static int psmouse_probe(struct psmouse *psmouse)
 	 * subsequent ID queries, probably due to a firmware bug.
 	 */
 	param[0] = 0xa5;
-	if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETID))
-		return -1;
+	error = ps2_command(ps2dev, param, PSMOUSE_CMD_GETID);
+	if (error)
+		return error;
 
 	if (param[0] != 0x00 && param[0] != 0x03 &&
 	    param[0] != 0x04 && param[0] != 0xff)
-		return -1;
+		return -ENODEV;
 
 	/*
 	 * Then we reset and disable the mouse so that it doesn't generate
 	 * events.
 	 */
-	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_RESET_DIS))
-		psmouse_warn(psmouse, "Failed to reset mouse on %s\n",
-			     ps2dev->serio->phys);
+	error = ps2_command(ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
+	if (error)
+		psmouse_warn(psmouse, "Failed to reset mouse on %s: %d\n",
+			     ps2dev->serio->phys, error);
 
 	return 0;
 }
@@ -1302,10 +1313,13 @@ int psmouse_activate(struct psmouse *psmouse)
  */
 int psmouse_deactivate(struct psmouse *psmouse)
 {
-	if (ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_DISABLE)) {
-		psmouse_warn(psmouse, "Failed to deactivate mouse on %s\n",
-			     psmouse->ps2dev.serio->phys);
-		return -1;
+	int error;
+
+	error = ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_DISABLE);
+	if (error) {
+		psmouse_warn(psmouse, "Failed to deactivate mouse on %s: %d\n",
+			     psmouse->ps2dev.serio->phys, error);
+		return error;
 	}
 
 	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
-- 
2.16.0.rc1.238.g530d649a79-goog

