From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] alps: rushmore and v7 resolution support
Date: Tue, 29 Jul 2014 10:07:32 +0200
Message-ID: <1406621252-5569-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47348 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751044AbaG2IHn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jul 2014 04:07:43 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yunkang Tang <yunkang.tang@cn.alps.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Add support for querying the physical size from the touchpad for rushmore
and v7 touchpads, and use that to tell userspace the device resolution.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/input/mouse/alps.h |  2 ++
 2 files changed, 50 insertions(+)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index ac9fdbd..1531387 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1783,6 +1783,45 @@ error:
 	return -1;
 }
 
+static int alps_get_v3_v7_resolution(struct psmouse *psmouse, int reg_pitch)
+{
+	int reg, x_pitch, y_pitch, x_electrode, y_electrode, x_phys, y_phys;
+	struct alps_data *priv = psmouse->private;
+
+	reg = alps_command_mode_read_reg(psmouse, reg_pitch);
+	if (reg < 0)
+		return reg;
+
+	x_pitch = (char)(reg << 4) >> 4; /* sign extend lower 4 bits */
+	x_pitch = 50 + 2 * x_pitch; /* In 0.1 mm units */
+
+	y_pitch = (char)reg >> 4; /* sign extend upper 4 bits */
+	y_pitch = 36 + 2 * y_pitch; /* In 0.1 mm units */
+
+	reg = alps_command_mode_read_reg(psmouse, reg_pitch + 1);
+	if (reg < 0)
+		return reg;
+
+	x_electrode = (char)(reg << 4) >> 4; /* sign extend lower 4 bits */
+	x_electrode = 17 + x_electrode;
+
+	y_electrode = (char)reg >> 4; /* sign extend upper 4 bits */
+	y_electrode = 13 + y_electrode;
+
+	x_phys = x_pitch * (x_electrode - 1); /* In 0.1 mm units */
+	y_phys = y_pitch * (y_electrode - 1); /* In 0.1 mm units */
+
+	priv->x_res = priv->x_max * 10 / x_phys; /* units / mm */
+	priv->y_res = priv->y_max * 10 / y_phys; /* units / mm */
+
+	psmouse_info(psmouse,
+		"alps: pitch %dx%d num-electrodes %dx%d physical size %dx%d mm res %dx%d\n",
+		x_pitch, y_pitch, x_electrode, y_electrode,
+		x_phys / 10, y_phys / 10, priv->x_res, priv->y_res);
+
+	return 0;
+}
+
 static int alps_hw_init_rushmore_v3(struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
@@ -1803,6 +1842,9 @@ static int alps_hw_init_rushmore_v3(struct psmouse *psmouse)
 	    alps_command_mode_write_reg(psmouse, 0xc2cb, 0x00))
 		goto error;
 
+	if (alps_get_v3_v7_resolution(psmouse, 0xc2da))
+		goto error;
+
 	reg_val = alps_command_mode_read_reg(psmouse, 0xc2c6);
 	if (reg_val == -1)
 		goto error;
@@ -1988,6 +2030,9 @@ static int alps_hw_init_v7(struct psmouse *psmouse)
 	    alps_command_mode_read_reg(psmouse, 0xc2d9) == -1)
 		goto error;
 
+	if (alps_get_v3_v7_resolution(psmouse, 0xc397))
+		goto error;
+
 	if (alps_command_mode_write_reg(psmouse, 0xc2c9, 0x64))
 		goto error;
 
@@ -2221,6 +2266,9 @@ static void alps_set_abs_params_mt(struct alps_data *priv,
 	input_set_abs_params(dev1, ABS_MT_POSITION_X, 0, priv->x_max, 0, 0);
 	input_set_abs_params(dev1, ABS_MT_POSITION_Y, 0, priv->y_max, 0, 0);
 
+	input_abs_set_res(dev1, ABS_MT_POSITION_X, priv->x_res);
+	input_abs_set_res(dev1, ABS_MT_POSITION_Y, priv->y_res);
+
 	input_mt_init_slots(dev1, MAX_TOUCHES, INPUT_MT_POINTER |
 		INPUT_MT_DROP_UNUSED | INPUT_MT_TRACK | INPUT_MT_SEMI_MT);
 
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index a98ac9b..66240b4 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -174,6 +174,8 @@ struct alps_data {
 	int y_max;
 	int x_bits;
 	int y_bits;
+	unsigned int x_res;
+	unsigned int y_res;
 
 	int (*hw_init)(struct psmouse *psmouse);
 	void (*process_packet)(struct psmouse *psmouse);
-- 
2.0.1

