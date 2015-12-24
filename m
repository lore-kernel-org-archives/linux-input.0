From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH RFC v2 4/9] Input: atmel_mxt_ts - handle diagnostic data orientation
Date: Thu, 24 Dec 2015 13:49:23 +0000
Message-ID: <1450964968-9792-5-git-send-email-nick.dyer@itdev.co.uk>
References: <1450964968-9792-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:5973 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752365AbbLXNth (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Dec 2015 08:49:37 -0500
In-Reply-To: <1450964968-9792-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Chris Healy <cphealy@gmail.com>, Nick Dyer <nick.dyer@itdev.co.uk>

Invert the diagnostic data to match the orientation of the input device.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index a177019..48bf9ec 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -122,6 +122,8 @@ struct t9_range {
 
 /* MXT_TOUCH_MULTI_T9 orient */
 #define MXT_T9_ORIENT_SWITCH	(1 << 0)
+#define MXT_T9_ORIENT_INVERTX	(1 << 1)
+#define MXT_T9_ORIENT_INVERTY	(1 << 2)
 
 /* MXT_SPT_COMMSCONFIG_T18 */
 #define MXT_COMMS_CTRL		0
@@ -153,6 +155,8 @@ struct t37_debug {
 #define MXT_T100_YRANGE		24
 
 #define MXT_T100_CFG_SWITCHXY	BIT(5)
+#define MXT_T100_CFG_INVERTY	BIT(6)
+#define MXT_T100_CFG_INVERTX	BIT(7)
 
 #define MXT_T100_TCHAUX_VECT	BIT(0)
 #define MXT_T100_TCHAUX_AMPL	BIT(1)
@@ -244,7 +248,9 @@ struct mxt_data {
 	unsigned int irq;
 	unsigned int max_x;
 	unsigned int max_y;
-	bool xy_switch;
+	bool invertx;
+	bool inverty;
+	bool xyswitch;
 	u8 xsize;
 	u8 ysize;
 	bool in_bootloader;
@@ -1720,7 +1726,9 @@ static int mxt_read_t9_resolution(struct mxt_data *data)
 	if (error)
 		return error;
 
-	data->xy_switch = orient & MXT_T9_ORIENT_SWITCH;
+	data->xyswitch = orient & MXT_T9_ORIENT_SWITCH;
+	data->invertx = orient & MXT_T9_ORIENT_INVERTX;
+	data->inverty = orient & MXT_T9_ORIENT_INVERTY;
 
 	return 0;
 }
@@ -1774,7 +1782,9 @@ static int mxt_read_t100_config(struct mxt_data *data)
 	if (error)
 		return error;
 
-	data->xy_switch = cfg & MXT_T100_CFG_SWITCHXY;
+	data->xyswitch = cfg & MXT_T100_CFG_SWITCHXY;
+	data->invertx = cfg & MXT_T100_CFG_INVERTX;
+	data->inverty = cfg & MXT_T100_CFG_INVERTY;
 
 	/* allocate aux bytes */
 	error =  __mxt_read_reg(client,
@@ -1863,7 +1873,7 @@ static int mxt_initialize_input_device(struct mxt_data *data)
 	if (data->max_y == 0)
 		data->max_y = 1023;
 
-	if (data->xy_switch)
+	if (data->xyswitch)
 		swap(data->max_x, data->max_y);
 
 	dev_info(dev, "Touchscreen size X%uY%u\n", data->max_x, data->max_y);
@@ -2119,15 +2129,21 @@ static void mxt_convert_debug_pages(struct seq_file *s, struct mxt_data *data)
 	struct mxt_dbg *dbg = &data->dbg;
 	unsigned int x = 0;
 	unsigned int y = 0;
-	unsigned int i;
+	unsigned int i, rx, ry;
 	u16 val;
 
 	for (i = 0; i < dbg->t37_nodes; i++) {
-		val = mxt_get_debug_value(data, x, y);
+		/* Handle orientation */
+		rx = data->xyswitch ? y : x;
+		ry = data->xyswitch ? x : y;
+		rx = data->invertx ? (data->xsize - 1 - rx) : rx;
+		ry = data->inverty ? (data->ysize - 1 - ry) : ry;
+
+		val = mxt_get_debug_value(data, rx, ry);
 		seq_write(s, &val, sizeof(u16));
 
 		/* Next value */
-		if (++x >= data->xsize) {
+		if (++x >= (data->xyswitch ? data->ysize : data->xsize)) {
 			x = 0;
 			y++;
 		}
-- 
2.5.0

