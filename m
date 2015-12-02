From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH RFC 4/8] Input: atmel_mxt_ts - handle diagnostic data orientation
Date: Wed,  2 Dec 2015 20:42:27 +0000
Message-ID: <1449088951-7069-5-git-send-email-nick.dyer@itdev.co.uk>
References: <1449088951-7069-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:25175 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753154AbbLBUvR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Dec 2015 15:51:17 -0500
In-Reply-To: <1449088951-7069-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yufeng Shen <miletus@google.com>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Chris Healy <cphealy@gmail.com>, Nick Dyer <nick.dyer@itdev.co.uk>

Invert the diagnostic data to match the orientation of the input device.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 9bc42f4..3b1a938 100644
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
@@ -246,6 +250,8 @@ struct mxt_data {
 	unsigned int irq;
 	unsigned int max_x;
 	unsigned int max_y;
+	bool invertx;
+	bool inverty;
 	bool xy_switch;
 	u8 xsize;
 	u8 ysize;
@@ -1721,6 +1727,8 @@ static int mxt_read_t9_resolution(struct mxt_data *data)
 		return error;
 
 	data->xy_switch = orient & MXT_T9_ORIENT_SWITCH;
+	data->invertx = orient & MXT_T9_ORIENT_INVERTX;
+	data->inverty = orient & MXT_T9_ORIENT_INVERTY;
 
 	return 0;
 }
@@ -1775,6 +1783,8 @@ static int mxt_read_t100_config(struct mxt_data *data)
 		return error;
 
 	data->xy_switch = cfg & MXT_T100_CFG_SWITCHXY;
+	data->invertx = cfg & MXT_T100_CFG_INVERTX;
+	data->inverty = cfg & MXT_T100_CFG_INVERTY;
 
 	/* allocate aux bytes */
 	error =  __mxt_read_reg(client,
@@ -2119,13 +2129,19 @@ static void mxt_convert_debug_pages(struct mxt_data *data)
 	struct mxt_dbg *dbg = &data->dbg;
 	unsigned int x = 0;
 	unsigned int y = 0;
-	unsigned int i;
+	unsigned int i, rx, ry;
 
 	for (i = 0; i < dbg->t37_nodes; i++) {
-		dbg->debug_buf[i] = mxt_get_debug_value(data, x, y);
+		/* Handle orientation */
+		rx = data->xy_switch ? y : x;
+		ry = data->xy_switch ? x : y;
+		rx = data->invertx ? (data->xsize - 1 - rx) : rx;
+		ry = data->inverty ? (data->ysize - 1 - ry) : ry;
+
+		dbg->debug_buf[i] = mxt_get_debug_value(data, rx, ry);
 
 		/* Next value */
-		if (++x >= data->xsize) {
+		if (++x >= (data->xy_switch ? data->ysize : data->xsize)) {
 			x = 0;
 			y++;
 		}
-- 
2.5.0

