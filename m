From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4/7] Input: lifebook - clean up code
Date: Fri, 19 Jan 2018 15:06:26 -0800
Message-ID: <20180119230629.49428-5-dmitry.torokhov@gmail.com>
References: <20180119230629.49428-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45579 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756201AbeASXGh (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Jan 2018 18:06:37 -0500
In-Reply-To: <20180119230629.49428-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Lyude Paul <lyude@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

- use u8 instead of unsigned char for byte data
- use input_set_capability() instead of manipulating capabilities bits
  directly
- do not abuse -1 as error code, propagate errors from various calls.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/lifebook.c | 50 ++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/input/mouse/lifebook.c b/drivers/input/mouse/lifebook.c
index 65efaade0820d..a5765f747c020 100644
--- a/drivers/input/mouse/lifebook.c
+++ b/drivers/input/mouse/lifebook.c
@@ -17,6 +17,7 @@
 #include <linux/libps2.h>
 #include <linux/dmi.h>
 #include <linux/slab.h>
+#include <linux/types.h>
 
 #include "psmouse.h"
 #include "lifebook.h"
@@ -136,7 +137,7 @@ static psmouse_ret_t lifebook_process_byte(struct psmouse *psmouse)
 	struct lifebook_data *priv = psmouse->private;
 	struct input_dev *dev1 = psmouse->dev;
 	struct input_dev *dev2 = priv ? priv->dev2 : NULL;
-	unsigned char *packet = psmouse->packet;
+	u8 *packet = psmouse->packet;
 	bool relative_packet = packet[0] & 0x08;
 
 	if (relative_packet || !lifebook_use_6byte_proto) {
@@ -201,10 +202,12 @@ static psmouse_ret_t lifebook_process_byte(struct psmouse *psmouse)
 static int lifebook_absolute_mode(struct psmouse *psmouse)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
-	unsigned char param;
+	u8 param;
+	int error;
 
-	if (psmouse_reset(psmouse))
-		return -1;
+	error = psmouse_reset(psmouse);
+	if (error)
+		return error;
 
 	/*
 	 * Enable absolute output -- ps2_command fails always but if
@@ -220,15 +223,15 @@ static int lifebook_absolute_mode(struct psmouse *psmouse)
 static void lifebook_relative_mode(struct psmouse *psmouse)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
-	unsigned char param = 0x06;
+	u8 param = 0x06;
 
 	ps2_command(ps2dev, &param, PSMOUSE_CMD_SETRES);
 }
 
 static void lifebook_set_resolution(struct psmouse *psmouse, unsigned int resolution)
 {
-	static const unsigned char params[] = { 0, 1, 2, 2, 3 };
-	unsigned char p;
+	static const u8 params[] = { 0, 1, 2, 2, 3 };
+	u8 p;
 
 	if (resolution == 0 || resolution > 400)
 		resolution = 400;
@@ -253,11 +256,11 @@ static void lifebook_disconnect(struct psmouse *psmouse)
 int lifebook_detect(struct psmouse *psmouse, bool set_properties)
 {
 	if (!lifebook_present)
-		return -1;
+		return -ENXIO;
 
 	if (desired_serio_phys &&
 	    strcmp(psmouse->ps2dev.serio->phys, desired_serio_phys))
-		return -1;
+		return -ENXIO;
 
 	if (set_properties) {
 		psmouse->vendor = "Fujitsu";
@@ -290,10 +293,10 @@ static int lifebook_create_relative_device(struct psmouse *psmouse)
 	dev2->id.version = 0x0000;
 	dev2->dev.parent = &psmouse->ps2dev.serio->dev;
 
-	dev2->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REL);
-	dev2->relbit[BIT_WORD(REL_X)] = BIT_MASK(REL_X) | BIT_MASK(REL_Y);
-	dev2->keybit[BIT_WORD(BTN_LEFT)] =
-				BIT_MASK(BTN_LEFT) | BIT_MASK(BTN_RIGHT);
+	input_set_capability(dev2, EV_REL, REL_X);
+	input_set_capability(dev2, EV_REL, REL_Y);
+	input_set_capability(dev2, EV_KEY, BTN_LEFT);
+	input_set_capability(dev2, EV_KEY, BTN_RIGHT);
 
 	error = input_register_device(priv->dev2);
 	if (error)
@@ -312,21 +315,26 @@ int lifebook_init(struct psmouse *psmouse)
 {
 	struct input_dev *dev1 = psmouse->dev;
 	int max_coord = lifebook_use_6byte_proto ? 4096 : 1024;
+	int error;
+
+	error = lifebook_absolute_mode(psmouse);
+	if (error)
+		return error;
 
-	if (lifebook_absolute_mode(psmouse))
-		return -1;
+	/* Clear default capabilities */
+	bitmap_zero(dev1->evbit, EV_CNT);
+	bitmap_zero(dev1->relbit, REL_CNT);
+	bitmap_zero(dev1->keybit, KEY_CNT);
 
-	dev1->evbit[0] = BIT_MASK(EV_ABS) | BIT_MASK(EV_KEY);
-	dev1->relbit[0] = 0;
-	dev1->keybit[BIT_WORD(BTN_MOUSE)] = 0;
-	dev1->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+	input_set_capability(dev1, EV_KEY, BTN_TOUCH);
 	input_set_abs_params(dev1, ABS_X, 0, max_coord, 0, 0);
 	input_set_abs_params(dev1, ABS_Y, 0, max_coord, 0, 0);
 
 	if (!desired_serio_phys) {
-		if (lifebook_create_relative_device(psmouse)) {
+		error = lifebook_create_relative_device(psmouse);
+		if (error) {
 			lifebook_relative_mode(psmouse);
-			return -1;
+			return error;
 		}
 	}
 
-- 
2.16.0.rc1.238.g530d649a79-goog

