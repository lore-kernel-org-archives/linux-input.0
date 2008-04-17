From: Mark Brown <dmitry.torokhov@gmail.com>
Subject: [PATCH 31/37] Input: wm97xx-core - use IRQF_SAMPLE_RANDOM
Date: Thu, 17 Apr 2008 09:24:48 -0400
Message-ID: <db7c10e708b9bdd1618c034591d27c33cb341222.1208783694.git.dmitry.torokhov@gmail.com>
References: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:8449 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760032AbYDUNTK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2008 09:19:10 -0400
Received: by wa-out-1112.google.com with SMTP id m16so3106305waf.23
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2008 06:19:10 -0700 (PDT)
In-Reply-To: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jkosina@suse.cz, akpm@linux-foundation.org

The touchscreen interrupt is driven by human input which can reasonably
be used to provide entropy.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
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
1.5.5.rc2.6.gf58d


