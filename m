From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] Input: twl4030-pwrbutton - fix a leak of the IRQ during
 init failure
Date: Thu, 28 Apr 2011 11:57:21 +0800
Message-ID: <1303963041.2588.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49665 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754154Ab1D1D5a (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Apr 2011 23:57:30 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter De Schrijver <peter.de-schrijver@nokia.com>, Felipe Balbi <felipe.balbi@nokia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

In twl4030_pwrbutton_probe error path, free_irq() was using NULL rather than
the driver data as the data pointer so free_irq() wouldn't have matched.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/input/misc/twl4030-pwrbutton.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
index f16972b..38e4b50 100644
--- a/drivers/input/misc/twl4030-pwrbutton.c
+++ b/drivers/input/misc/twl4030-pwrbutton.c
@@ -89,7 +89,7 @@ static int __init twl4030_pwrbutton_probe(struct platform_device *pdev)
 	return 0;
 
 free_irq:
-	free_irq(irq, NULL);
+	free_irq(irq, pwr);
 free_input_dev:
 	input_free_device(pwr);
 	return err;
-- 
1.7.1



