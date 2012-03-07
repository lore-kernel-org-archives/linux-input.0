From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] input: altera_ps2: Use of_match_ptr
Date: Wed,  7 Mar 2012 14:48:07 +0100
Message-ID: <1331128087-7947-1-git-send-email-tklauser@distanz.ch>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.zhaw.ch ([160.85.104.50]:50109 "EHLO mx1.zhaw.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754837Ab2CGNsJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 Mar 2012 08:48:09 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Instead of having to define the match table to NULL if CONFIG_OF isn't
set, use the of_match_ptr() macro which will do this for us.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/input/serio/altera_ps2.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/input/serio/altera_ps2.c b/drivers/input/serio/altera_ps2.c
index 35864c6..cc11f4e 100644
--- a/drivers/input/serio/altera_ps2.c
+++ b/drivers/input/serio/altera_ps2.c
@@ -180,8 +180,6 @@ static const struct of_device_id altera_ps2_match[] = {
 	{},
 };
 MODULE_DEVICE_TABLE(of, altera_ps2_match);
-#else /* CONFIG_OF */
-#define altera_ps2_match NULL
 #endif /* CONFIG_OF */
 
 /*
@@ -193,7 +191,7 @@ static struct platform_driver altera_ps2_driver = {
 	.driver	= {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
-		.of_match_table = altera_ps2_match,
+		.of_match_table = of_match_ptr(altera_ps2_match),
 	},
 };
 module_platform_driver(altera_ps2_driver);
-- 
1.7.5.4

