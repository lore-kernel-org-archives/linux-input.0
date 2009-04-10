From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Input: Don't use IRQF_SAMPLE_RANDOM in wm97xx driver
Date: Fri, 10 Apr 2009 10:53:12 +0100
Message-ID: <1239357192-27726-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1239357192-27726-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:48351 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934919AbZDJJxW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Apr 2009 05:53:22 -0400
In-Reply-To: <1239357192-27726-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Slaby <jirislaby@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

The input core will add entropy to the pool without this flag being
used.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/wm97xx-core.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index cec480b..69af838 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -370,8 +370,7 @@ static int wm97xx_init_pen_irq(struct wm97xx *wm)
 	 * provided. */
 	BUG_ON(!wm->mach_ops->irq_enable);
 
-	if (request_irq(wm->pen_irq, wm97xx_pen_interrupt,
-			IRQF_SHARED | IRQF_SAMPLE_RANDOM,
+	if (request_irq(wm->pen_irq, wm97xx_pen_interrupt, IRQF_SHARED,
 			"wm97xx-pen", wm)) {
 		dev_err(wm->dev,
 			"Failed to register pen down interrupt, polling");
-- 
1.5.6.3

