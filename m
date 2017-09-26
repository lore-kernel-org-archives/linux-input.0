From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH] Input: sa1111ps2 - extend test delay
Date: Tue, 26 Sep 2017 17:25:53 +0100
Message-ID: <E1dwsgD-0006Hy-5u@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:53728 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966562AbdIZQ0C (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 26 Sep 2017 12:26:02 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

A 2us delay is too small for the bus to settle after writing to the
register.  Extend to 10us which gives more reliable results.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/input/serio/sa1111ps2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/serio/sa1111ps2.c b/drivers/input/serio/sa1111ps2.c
index f1c036260d25..f9e5c793f4f0 100644
--- a/drivers/input/serio/sa1111ps2.c
+++ b/drivers/input/serio/sa1111ps2.c
@@ -212,7 +212,7 @@ static unsigned int ps2_test_one(struct ps2if *ps2if,
 
 	writel_relaxed(PS2CR_ENA | mask, ps2if->base + PS2CR);
 
-	udelay(2);
+	udelay(10);
 
 	val = readl_relaxed(ps2if->base + PS2STAT);
 	return val & (PS2STAT_KBC | PS2STAT_KBD);
-- 
2.7.4

