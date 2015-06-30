From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: wdt87xx_i2c - remove stray newline in diagnostic
 message
Date: Tue, 30 Jun 2015 11:29:42 -0700
Message-ID: <20150630182942.GA22859@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:34148 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbbF3S3r (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Jun 2015 14:29:47 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: HungNien Chen <hn.chen@weidahitech.com>, linux-kernel@vger.kernel.org

There is no reason to have a newline between plat_id and xml_id1.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/wdt87xx_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/wdt87xx_i2c.c b/drivers/input/touchscreen/wdt87xx_i2c.c
index 43c3bee..9eb8e8c 100644
--- a/drivers/input/touchscreen/wdt87xx_i2c.c
+++ b/drivers/input/touchscreen/wdt87xx_i2c.c
@@ -442,7 +442,7 @@ static int wdt87xx_get_sysparam(struct i2c_client *client,
 	param->fw_id = get_unaligned_le16(&buf[1]);
 
 	dev_info(&client->dev,
-		 "fw_id: 0x%x, plat_id: 0x%x\nxml_id1: %04x, xml_id2: %04x\n",
+		 "fw_id: 0x%x, plat_id: 0x%x, xml_id1: %04x, xml_id2: %04x\n",
 		 param->fw_id, param->plat_id,
 		 param->xmls_id1, param->xmls_id2);
 
-- 
2.4.3.573.g4eafbef


-- 
Dmitry
