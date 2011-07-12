From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] Input: cy8ctmg110_ts - fix checking return value of
 i2c_master_send
Date: Tue, 12 Jul 2011 14:14:21 +0800
Message-ID: <1310451261.13592.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52019 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502Ab1GLGO1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jul 2011 02:14:27 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuli Konttila <samuli.konttila@aavamobile.com>, linux-input@vger.kernel.org

i2c_master_send() returns negative errno, or else the number of bytes written.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/input/touchscreen/cy8ctmg110_ts.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/cy8ctmg110_ts.c b/drivers/input/touchscreen/cy8ctmg110_ts.c
index 4481cc5..c458da0 100644
--- a/drivers/input/touchscreen/cy8ctmg110_ts.c
+++ b/drivers/input/touchscreen/cy8ctmg110_ts.c
@@ -84,9 +84,9 @@ static int cy8ctmg110_write_regs(struct cy8ctmg110 *tsc, unsigned char reg,
 	memcpy(i2c_data + 1, value, len);
 
 	ret = i2c_master_send(client, i2c_data, len + 1);
-	if (ret != 1) {
+	if (ret != (len + 1)) {
 		dev_err(&client->dev, "i2c write data cmd failed\n");
-		return ret ? ret : -EIO;
+		return -EIO;
 	}
 
 	return 0;
-- 
1.7.4.1



