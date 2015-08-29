From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH v2 1/6] input: ab8500-ponkey: Fix module autoload for OF
 platform driver
Date: Sat, 29 Aug 2015 12:43:51 +0200
Message-ID: <20150829104351.GA20626@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35343 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbbH2Knx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 29 Aug 2015 06:43:53 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
---

Moving the MODULE_DEVICE_TABLE into the CONFIG_OF #ifdef block.
As suggested by Dmitry Torokhov.

Thanks,
Luis

 drivers/input/misc/ab8500-ponkey.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/misc/ab8500-ponkey.c b/drivers/input/misc/ab8500-ponkey.c
index 1f7e15c..4f5ef5b 100644
--- a/drivers/input/misc/ab8500-ponkey.c
+++ b/drivers/input/misc/ab8500-ponkey.c
@@ -118,6 +118,7 @@ static const struct of_device_id ab8500_ponkey_match[] = {
 	{ .compatible = "stericsson,ab8500-ponkey", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, ab8500_ponkey_match);
 #endif
 
 static struct platform_driver ab8500_ponkey_driver = {
-- 
2.4.6

