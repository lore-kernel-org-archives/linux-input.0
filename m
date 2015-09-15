From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] Input: cyapa: remove variable overwriting
Date: Tue, 15 Sep 2015 15:36:27 +0530
Message-ID: <1442311587-24458-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34406 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbbIOKGg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Sep 2015 06:06:36 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Even if rotat_align is true or false the final value of
cyapa->electrodes_rx is always cyapa->electrodes_y. remove the variable
overwriting and in the process remove the variable rotat_align which is
not required any more.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/input/mouse/cyapa_gen6.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/input/mouse/cyapa_gen6.c b/drivers/input/mouse/cyapa_gen6.c
index 5f19107..f0c614b 100644
--- a/drivers/input/mouse/cyapa_gen6.c
+++ b/drivers/input/mouse/cyapa_gen6.c
@@ -196,7 +196,6 @@ static int cyapa_gen6_read_sys_info(struct cyapa *cyapa)
 	u8 resp_data[PIP_READ_SYS_INFO_RESP_LENGTH];
 	int resp_len;
 	u16 product_family;
-	u8 rotat_align;
 	int error;
 
 	/* Get App System Information to determine Gen5 or Gen6. */
@@ -241,14 +240,7 @@ static int cyapa_gen6_read_sys_info(struct cyapa *cyapa)
 	memcpy(&cyapa->product_id[13], &resp_data[62], 2);
 	cyapa->product_id[15] = '\0';
 
-	rotat_align = resp_data[68];
-	if (rotat_align) {
-		cyapa->electrodes_rx = cyapa->electrodes_y;
-		cyapa->electrodes_rx = cyapa->electrodes_y;
-	} else {
-		cyapa->electrodes_rx = cyapa->electrodes_x;
-		cyapa->electrodes_rx = cyapa->electrodes_y;
-	}
+	cyapa->electrodes_rx = cyapa->electrodes_y;
 	cyapa->aligned_electrodes_rx = (cyapa->electrodes_rx + 3) & ~3u;
 
 	if (!cyapa->electrodes_x || !cyapa->electrodes_y ||
-- 
1.9.1

