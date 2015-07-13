From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH] Input: zforce - don't overwrite the stack
Date: Mon, 13 Jul 2015 14:45:12 +0200
Message-ID: <1436791512-21027-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from imta22.fe.bosch.de ([139.15.243.26]:19541 "EHLO
	imta22.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbbGMMpS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2015 08:45:18 -0400
Received: from smtp6-v.fe.bosch.de (imta24.fe.bosch.de [139.15.243.27])
	by imta22.fe.bosch.de (Postfix) with ESMTP id BC3748406C5
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2015 14:45:16 +0200 (CEST)
Received: from vsmta12.fe.internet.bosch.com (unknown [10.4.98.52])
	by imta24.fe.bosch.de (Postfix) with ESMTP id 494A6D801D7
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2015 14:45:15 +0200 (CEST)
Received: from FE-HUB1001.de.bosch.com (vsgw24.fe.internet.bosch.com [10.4.98.24])
	by vsmta12.fe.internet.bosch.com (Postfix) with ESMTP id ED1D81B80492
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2015 14:45:14 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>, Dirk Behme <dirk.behme@de.bosch.com>

From: Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>

If we get a corrupted packet with PAYLOAD_LENGTH > FRAME_MAXSIZE, we
will silently overwrite the stack.

Signed-off-by: Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 drivers/input/touchscreen/zforce_ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index c4cffcf..32749db 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -441,7 +441,7 @@ static int zforce_read_packet(struct zforce_ts *ts, u8 *buf)
 		goto unlock;
 	}
 
-	if (buf[PAYLOAD_LENGTH] == 0) {
+	if (buf[PAYLOAD_LENGTH] == 0 || buf[PAYLOAD_LENGTH] > FRAME_MAXSIZE) {
 		dev_err(&client->dev, "invalid payload length: %d\n",
 			buf[PAYLOAD_LENGTH]);
 		ret = -EIO;
-- 
2.3.4

