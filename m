Return-Path: <SRS0=z9W1=CF=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2EFC433E1
	for <linux-input@archiver.kernel.org>; Thu, 27 Aug 2020 06:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4FCA2177B
	for <linux-input@archiver.kernel.org>; Thu, 27 Aug 2020 06:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598509706;
	bh=uTlyu4Ggbom6cpomUXJKQ1GKWCdyLuFd3Pick+7iBao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xFA6oaJqnVgnYza3v9u6AdcfLDAjgeIuhP1/NpyC1BbWfDbA+x21S8/fJq4bLYqbM
	 SFE6OaUV9HUXRxGPca1SYIHMnjoKAecq2B7VW/hETAZp/SvW0LxvTb6U1f84povNWh
	 SGFy9riZXFVhOYewdJRrbopiQ0Tec9PciytzceNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgH0G2T (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 27 Aug 2020 02:28:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgH0G2Q (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Aug 2020 02:28:16 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DDEF22B49;
        Thu, 27 Aug 2020 06:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598509695;
        bh=uTlyu4Ggbom6cpomUXJKQ1GKWCdyLuFd3Pick+7iBao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nO8NuCnVpOQBELP+v/O22dxuv09RFbjRFq/uuriGLAgYqTIEZrsSmItlVXgtxwd7v
         t1/0qQ87dP254Xh9i2+lbDYE5U0jXlgQi1fC7bWJznJbyPfh1rVCxOf+GAITgh+pxM
         kjhL+WjNZJro0xiZqk1xVGhmCcNfZ5xUO6W4RLRs=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 2/2] Input: gpio_keys - Simplify with dev_err_probe()
Date:   Thu, 27 Aug 2020 08:28:04 +0200
Message-Id: <20200827062804.16730-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827062804.16730-1-krzk@kernel.org>
References: <20200827062804.16730-1-krzk@kernel.org>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe() and devm_fwnode_gpiod_get_optional().   Less code and
the error value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>

---

Changes since v2:
1. Preserve comment,
2. Include <device.h> to fix warning on clang (reported by kbuild),
3. Fix use of uninitialized "error" variable.

Changes since v1:
1. Use devm_fwnode_gpiod_get_optional
---
 drivers/input/keyboard/gpio_keys.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index f2d4e4daa818..160d94b1c2c0 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -18,6 +18,7 @@
 #include <linux/sysctl.h>
 #include <linux/proc_fs.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
@@ -494,23 +495,13 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	spin_lock_init(&bdata->lock);
 
 	if (child) {
-		bdata->gpiod = devm_fwnode_gpiod_get(dev, child,
-						     NULL, GPIOD_IN, desc);
-		if (IS_ERR(bdata->gpiod)) {
-			error = PTR_ERR(bdata->gpiod);
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
-		}
+		/*
+		 * GPIO is optional, we may be dealing with purely
+		 * interrupt-driven setup.
+		 */
+		bdata->gpiod = devm_fwnode_gpiod_get_optional(dev, child, NULL, GPIOD_IN, desc);
+		if (IS_ERR(bdata->gpiod))
+			return dev_err_probe(dev, PTR_ERR(bdata->gpiod), "failed to get gpio\n");
 	} else if (gpio_is_valid(button->gpio)) {
 		/*
 		 * Legacy GPIO number, so request the GPIO here and
-- 
2.17.1

