From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] wm97xx-core: Use IRQF_SAMPLE_RANDOM
Date: Tue, 15 Apr 2008 15:47:07 +0100
Message-ID: <1208270828-10413-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20080415144535.GA20619@rakim.wolfsonmicro.main>
 <1208270828-10413-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:43470 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759656AbYDOOrL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Apr 2008 10:47:11 -0400
In-Reply-To: <1208270828-10413-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, David Brownell <david-b@pacbell.net>, Dmitry Torokhov <dtor@mail.ru>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

The touchscreen interrupt is driven by human input which can reasonably
be used to provide entropy.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/wm97xx-core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index e27b1e0..fec07c2 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -355,7 +355,8 @@ static int wm97xx_init_pen_irq(struct wm97xx *wm)
 	 * provided. */
 	BUG_ON(!wm->mach_ops->irq_enable);
 
-	if (request_irq(wm->pen_irq, wm97xx_pen_interrupt, IRQF_SHARED,
+	if (request_irq(wm->pen_irq, wm97xx_pen_interrupt,
+			IRQF_SHARED | IRQF_SAMPLE_RANDOM,
 			"wm97xx-pen", wm)) {
 		dev_err(wm->dev,
 			"Failed to register pen down interrupt, polling");
-- 
1.5.5

