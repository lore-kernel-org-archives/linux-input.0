From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] Input: twl4030-vibra: Correct the power down sequence
Date: Fri, 21 May 2010 08:06:38 +0300
Message-ID: <1274418398-10885-1-git-send-email-peter.ujfalusi@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:29462 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752987Ab0EUFHd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 May 2010 01:07:33 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dtor@mail.ru, jari.vanhala@ixonos.com

It is better to turn off the first APLL, than the codec.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 drivers/input/misc/twl4030-vibra.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/misc/twl4030-vibra.c b/drivers/input/misc/twl4030-vibra.c
index 2fb79e0..1b9dc32 100644
--- a/drivers/input/misc/twl4030-vibra.c
+++ b/drivers/input/misc/twl4030-vibra.c
@@ -89,8 +89,8 @@ static void vibra_disable(struct vibra_info *info)
 	twl_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
 			 (reg & ~TWL4030_VIBRA_EN), TWL4030_REG_VIBRA_CTL);
 
-	twl4030_codec_disable_resource(TWL4030_CODEC_RES_POWER);
 	twl4030_codec_disable_resource(TWL4030_CODEC_RES_APLL);
+	twl4030_codec_disable_resource(TWL4030_CODEC_RES_POWER);
 
 	info->enabled = false;
 }
-- 
1.7.1

