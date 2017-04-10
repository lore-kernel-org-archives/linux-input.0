From: Peter Fink <pfink@christ-es.de>
Subject: [PATCH] input: touchscreen: stmpe: check fifo_empty flag before reading x/y values
Date: Mon, 10 Apr 2017 11:52:26 +0200
Message-ID: <1491817946-13926-1-git-send-email-pfink@christ-es.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nm28-vm2.bullet.mail.ir2.yahoo.com ([212.82.97.62]:50776 "EHLO
        nm28-vm2.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752659AbdDJJ7S (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Apr 2017 05:59:18 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, stefan.agner@toradex.com, Peter Fink <pfink@christ-es.de>

STMPE driver with STMPE811 reported x=0/y=0 when clicking in succession at
higher speeds. In some configurations the consuming X11 input stack is able
to ignore this input, but e.g. with inverted axes this is prone to fail.

In these cases it might happen that even applications are closed when the
close-X is located in the same corner as touch 0/0 is mapped to. This
happens when touch coordinates are read from an empty fifo although the
threshold interrupt indicates that new data is available.

To avoid wrong touch data read and evaluate the fifo_empty bit before
accessing the fifo.

Signed-off-by: Peter Fink <pfink@christ-es.de>
---
 drivers/input/touchscreen/stmpe-ts.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
index 2a78e27..dcc9d48 100644
--- a/drivers/input/touchscreen/stmpe-ts.c
+++ b/drivers/input/touchscreen/stmpe-ts.c
@@ -44,6 +44,7 @@
 #define OP_MOD_XYZ			0
 
 #define STMPE_TSC_CTRL_TSC_EN		(1<<0)
+#define STMPE_FIFO_EMPTY		(1<<5)
 
 #define STMPE_FIFO_STA_RESET		(1<<0)
 
@@ -175,17 +176,22 @@ static irqreturn_t stmpe_ts_handler(int irq, void *data)
 	stmpe_set_bits(ts->stmpe, STMPE_REG_TSC_CTRL,
 				STMPE_TSC_CTRL_TSC_EN, 0);
 
-	stmpe_block_read(ts->stmpe, STMPE_REG_TSC_DATA_XYZ, 4, data_set);
+	if (!(stmpe_reg_read(ts->stmpe, STMPE_REG_FIFO_STA)
+					& STMPE_FIFO_EMPTY)) {
 
-	x = (data_set[0] << 4) | (data_set[1] >> 4);
-	y = ((data_set[1] & 0xf) << 8) | data_set[2];
-	z = data_set[3];
+		stmpe_block_read(ts->stmpe, STMPE_REG_TSC_DATA_XYZ,
+							4, data_set);
 
-	input_report_abs(ts->idev, ABS_X, x);
-	input_report_abs(ts->idev, ABS_Y, y);
-	input_report_abs(ts->idev, ABS_PRESSURE, z);
-	input_report_key(ts->idev, BTN_TOUCH, 1);
-	input_sync(ts->idev);
+		x = (data_set[0] << 4) | (data_set[1] >> 4);
+		y = ((data_set[1] & 0xf) << 8) | data_set[2];
+		z = data_set[3];
+
+		input_report_abs(ts->idev, ABS_X, x);
+		input_report_abs(ts->idev, ABS_Y, y);
+		input_report_abs(ts->idev, ABS_PRESSURE, z);
+		input_report_key(ts->idev, BTN_TOUCH, 1);
+		input_sync(ts->idev);
+	}
 
        /* flush the FIFO after we have read out our values. */
 	__stmpe_reset_fifo(ts->stmpe);
-- 
1.9.1

