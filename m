Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25EBC4332F
	for <linux-input@archiver.kernel.org>; Tue, 15 Feb 2022 16:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241186AbiBOQCe (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 15 Feb 2022 11:02:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241147AbiBOQCe (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 15 Feb 2022 11:02:34 -0500
Received: from hs01.dk-develop.de (hs01.dk-develop.de [173.249.23.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508C930B;
        Tue, 15 Feb 2022 08:02:24 -0800 (PST)
From:   Danilo Krummrich <danilokrummrich@dk-develop.de>
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org,
        Danilo Krummrich <danilokrummrich@dk-develop.de>
Subject: [PATCH 3/4] input: ps2-gpio: remove tx timeout from ps2_gpio_irq_tx()
Date:   Tue, 15 Feb 2022 17:02:07 +0100
Message-Id: <20220215160208.34826-4-danilokrummrich@dk-develop.de>
In-Reply-To: <20220215160208.34826-1-danilokrummrich@dk-develop.de>
References: <20220215160208.34826-1-danilokrummrich@dk-develop.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Actually, there's no extra clock pulse to wait for.

The assumption of an extra clock pulse was mistakenly derived from the
fact that by the time this driver was introduced the GPIO controller of
the test machine (bcm2835) generated spurious interrupts.

Since now spurious interrupts are handled properly this can and must be
removed in order to make TX xfers work properly.

While at it, remove duplicate gpiod_direction_input(). The data gpio
must already be configured to act as input when receiving the ACK bit.

This patch is tested with the original hardware (peripherals and board)
the driver was developed on.

Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
---
 drivers/input/serio/ps2-gpio.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/input/serio/ps2-gpio.c b/drivers/input/serio/ps2-gpio.c
index 246a583986e9..f47a967f7521 100644
--- a/drivers/input/serio/ps2-gpio.c
+++ b/drivers/input/serio/ps2-gpio.c
@@ -37,8 +37,7 @@
 #define PS2_DATA_BIT7		8
 #define PS2_PARITY_BIT		9
 #define PS2_STOP_BIT		10
-#define PS2_TX_TIMEOUT		11
-#define PS2_ACK_BIT		12
+#define PS2_ACK_BIT		11
 
 #define PS2_DEV_RET_ACK		0xfa
 #define PS2_DEV_RET_NACK	0xfe
@@ -335,13 +334,7 @@ static irqreturn_t ps2_gpio_irq_tx(struct ps2_gpio_data *drvdata)
 		/* release data line to generate stop bit */
 		gpiod_direction_input(drvdata->gpio_data);
 		break;
-	case PS2_TX_TIMEOUT:
-		/* Devices generate one extra clock pulse before sending the
-		 * acknowledgment.
-		 */
-		break;
 	case PS2_ACK_BIT:
-		gpiod_direction_input(drvdata->gpio_data);
 		data = gpiod_get_value(drvdata->gpio_data);
 		if (data) {
 			dev_warn(drvdata->dev, "TX: received NACK, retry\n");
-- 
2.35.1

