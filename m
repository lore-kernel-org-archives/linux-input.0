From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: ps2-gpio - actually abort probe when connected to
 sleeping GPIOs
Date: Mon, 23 Oct 2017 16:44:47 -0700
Message-ID: <20171023234447.qaohcuyfvnwn5m2n@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:50006 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbdJWXo6 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 23 Oct 2017 19:44:58 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Danilo Krummrich <danilokrummrich@dk-develop.de>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org

We've been missing a goto to the unwind path...

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/ps2-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/serio/ps2-gpio.c b/drivers/input/serio/ps2-gpio.c
index b50e3817f3c4..c62cceb97bb1 100644
--- a/drivers/input/serio/ps2-gpio.c
+++ b/drivers/input/serio/ps2-gpio.c
@@ -366,6 +366,7 @@ static int ps2_gpio_probe(struct platform_device *pdev)
 	    gpiod_cansleep(drvdata->gpio_clk)) {
 		dev_err(dev, "GPIO data or clk are connected via slow bus\n");
 		error = -EINVAL;
+		goto err_free_serio;
 	}
 
 	drvdata->irq = platform_get_irq(pdev, 0);
-- 
2.15.0.rc0.271.g36b669edcc-goog


-- 
Dmitry
