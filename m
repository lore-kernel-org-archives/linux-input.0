Return-Path: <SRS0=eR53=CE=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BA4C433DF
	for <linux-input@archiver.kernel.org>; Wed, 26 Aug 2020 20:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F37BD2078D
	for <linux-input@archiver.kernel.org>; Wed, 26 Aug 2020 20:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598472525;
	bh=p0i0gDJ2jS4t7JJ4ocLozJvGErG8heeVM4U3k61ApPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o+f7hXyGEIRIjirsG2COpkBI8G946Zuds5XmmrKX/Maj9cRLlj/+cRMRJ6l1bAU5K
	 ehJD5ooGXytlFMdu13rMhjmpoGJFqmIrqbrX5yJcQU3x0FKAVdpDDUH0gcB327eLPB
	 VZRa5OZKZCbNwDBOW3ZD6jogFGcJKcdVvAOwF/OQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgHZUIm (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 26 Aug 2020 16:08:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbgHZUIg (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 26 Aug 2020 16:08:36 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C20802080C;
        Wed, 26 Aug 2020 20:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598472515;
        bh=p0i0gDJ2jS4t7JJ4ocLozJvGErG8heeVM4U3k61ApPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PKGrrwPE5hIfuaNKgGIpKkhl0nZqny54lvbaklqusmvYoVIQySnCHWsyZ4d1GJ5tz
         IOnx9dgeJXpxP4577acpOrimdDYTH7Zf4G4en6bnC46fQSHWY9HgpNM4LbXalcXkc+
         mUtcNFmR/5XeZktf4hhwYi9TzjN3XjyGOL3uu9ww=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 2/2] Input: gpio_keys - Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 22:08:27 +0200
Message-Id: <20200826200827.30931-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826200827.30931-1-krzk@kernel.org>
References: <20200826200827.30931-1-krzk@kernel.org>
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

Changes since v1:
1. Use devm_fwnode_gpiod_get_optional
---
 drivers/input/keyboard/gpio_keys.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index f2d4e4daa818..a07ac6fa25ed 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -494,23 +494,10 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
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
+		bdata->gpiod = devm_fwnode_gpiod_get_optional(dev, child, NULL,
+							      GPIOD_IN, desc);
+		if (IS_ERR(bdata->gpiod))
+			return dev_err_probe(dev, error, "failed to get gpio\n");
 	} else if (gpio_is_valid(button->gpio)) {
 		/*
 		 * Legacy GPIO number, so request the GPIO here and
-- 
2.17.1

