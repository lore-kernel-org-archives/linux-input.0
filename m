From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: twl6040 - do not define OF match table without
 CONFIG_OF
Date: Thu, 10 May 2012 21:28:08 -0700
Message-ID: <20120511042807.GA5171@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63402 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758Ab2EKE2L (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 May 2012 00:28:11 -0400
Received: by pbbrp8 with SMTP id rp8so2770915pbb.19
        for <linux-input@vger.kernel.org>; Thu, 10 May 2012 21:28:11 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/misc/twl6040-vibra.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
index c34f6c0..7cf73ce 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -418,11 +418,13 @@ static int __devexit twl6040_vibra_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
 static const struct of_device_id twl6040_vibra_of_match[] = {
 	{.compatible = "ti,twl6040-vibra", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, twl6040_vibra_of_match);
+#endif
 
 static struct platform_driver twl6040_vibra_driver = {
 	.probe		= twl6040_vibra_probe,
@@ -431,7 +433,7 @@ static struct platform_driver twl6040_vibra_driver = {
 		.name	= "twl6040-vibra",
 		.owner	= THIS_MODULE,
 		.pm	= &twl6040_vibra_pm_ops,
-		.of_match_table = twl6040_vibra_of_match,
+		.of_match_table = of_match_ptr(twl6040_vibra_of_match),
 	},
 };
 module_platform_driver(twl6040_vibra_driver);
-- 
1.7.7.6


-- 
Dmitry
