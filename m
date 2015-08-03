From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH 9/9] Input: atmel_mxt_ts - remove warning on zero T44 count
Date: Mon,  3 Aug 2015 16:23:17 +0100
Message-ID: <1438615397-17112-10-git-send-email-nick.dyer@itdev.co.uk>
References: <1438615397-17112-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:34554 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754240AbbHCPcs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Aug 2015 11:32:48 -0400
In-Reply-To: <1438615397-17112-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>, Nick Dyer <nick.dyer@itdev.co.uk>

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 2aa44dc..c874008 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -938,16 +938,15 @@ static irqreturn_t mxt_process_messages_t44(struct mxt_data *data)
 
 	count = data->msg_buf[0];
 
-	if (count == 0) {
-		/*
-		 * This condition is caused by the CHG line being configured
-		 * in Mode 0. It results in unnecessary I2C operations but it
-		 * is benign.
-		 */
-		dev_dbg(dev, "Interrupt triggered but zero messages\n");
+	/*
+	 * This condition may be caused by the CHG line being configured in
+	 * Mode 0. It results in unnecessary I2C operations but it is benign.
+	 */
+	if (count == 0)
 		return IRQ_NONE;
-	} else if (count > data->max_reportid) {
-		dev_err(dev, "T44 count %d exceeded max report id\n", count);
+
+	if (count > data->max_reportid) {
+		dev_warn(dev, "T44 count %d exceeded max report id\n", count);
 		count = data->max_reportid;
 	}
 
-- 
2.4.6

