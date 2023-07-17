Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A21EB64DC
	for <linux-input@archiver.kernel.org>; Mon, 17 Jul 2023 13:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjGQN2z (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 17 Jul 2023 09:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjGQN15 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 17 Jul 2023 09:27:57 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEC9199C
        for <linux-input@vger.kernel.org>; Mon, 17 Jul 2023 06:27:10 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5803:2d6d:5bbc:e252])
        by laurent.telenet-ops.be with bizsmtp
        id NDT62A00Z0ucMBo01DT6Sd; Mon, 17 Jul 2023 15:27:06 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qLOFd-001fw3-Ou;
        Mon, 17 Jul 2023 15:27:06 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qLOFm-007R1G-Lz;
        Mon, 17 Jul 2023 15:27:06 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH resend 2] Input: gpio-keys - convert to dev_err_probe()
Date:   Mon, 17 Jul 2023 15:27:05 +0200
Message-Id: <d225a837c50e2b19a41555a8f7ce0f94b1689aa4.1689600353.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Use the dev_err_probe() helper, instead of open-coding the same
operation.

While at it, invert the error checking logic to simplify code flow.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/input/keyboard/gpio_keys.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 20250b072a7a01c5..7e8342ef7a79b17f 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -523,18 +523,15 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 						     NULL, GPIOD_IN, desc);
 		if (IS_ERR(bdata->gpiod)) {
 			error = PTR_ERR(bdata->gpiod);
-			if (error == -ENOENT) {
-				/*
-				 * GPIO is optional, we may be dealing with
-				 * purely interrupt-driven setup.
-				 */
-				bdata->gpiod = NULL;
-			} else {
-				if (error != -EPROBE_DEFER)
-					dev_err(dev, "failed to get gpio: %d\n",
-						error);
-				return error;
-			}
+			if (error != -ENOENT)
+				return dev_err_probe(dev, error,
+						     "failed to get gpio\n");
+
+			/*
+			 * GPIO is optional, we may be dealing with
+			 * purely interrupt-driven setup.
+			 */
+			bdata->gpiod = NULL;
 		}
 	} else if (gpio_is_valid(button->gpio)) {
 		/*
-- 
2.34.1

