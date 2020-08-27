Return-Path: <SRS0=z9W1=CF=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C324C433E1
	for <linux-input@archiver.kernel.org>; Thu, 27 Aug 2020 18:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1214822CB3
	for <linux-input@archiver.kernel.org>; Thu, 27 Aug 2020 18:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598554765;
	bh=D3W11RS5LQuK0NiOtRpaiYpfrAhdnBPWAZ5FOYkiWdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=db/76rGQETsf5tLX+wcy5oJq6LE4s4cwXyMSK7+kEVX+TLrq19LqaD0ic7r4tblR9
	 1VQELmdCh82AQUOsblAhDwBv0+pXcDZ0FwSlwCQF4bxJlFl9PDXZFMQO/ALSF1jznp
	 zAytrtiYgxN4Uu5kEc4Z8P3ScQDiYS4+EPHWD/AY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgH0S7Y (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 27 Aug 2020 14:59:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728074AbgH0S7W (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Aug 2020 14:59:22 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7487D2087E;
        Thu, 27 Aug 2020 18:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598554762;
        bh=D3W11RS5LQuK0NiOtRpaiYpfrAhdnBPWAZ5FOYkiWdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kxo8B7z/KfXCzKq6i9xdm5ZGZ30wxjrUHTxPxbWshx3XUfUIB4KPbrRyBxVzX7GGS
         AC6Be2aH8B/1ewVSYLxARvkdKZS8lDRb+CBweofoYewIqDTK9PYyhNZsPoH5xZWJzg
         6aysKruXbFti6mJolKvpAN6Kl5u3Zr/Z9K/S7AcQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        Sangwon Jee <jeesw@melfas.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        clang-built-linux@googlegroups.com
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 12/27] Input: ektf2127 - Simplify with dev_err_probe()
Date:   Thu, 27 Aug 2020 20:58:14 +0200
Message-Id: <20200827185829.30096-13-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827185829.30096-1-krzk@kernel.org>
References: <20200827185829.30096-1-krzk@kernel.org>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/input/touchscreen/ektf2127.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/ektf2127.c b/drivers/input/touchscreen/ektf2127.c
index eadd389cf81f..cd41483cfae5 100644
--- a/drivers/input/touchscreen/ektf2127.c
+++ b/drivers/input/touchscreen/ektf2127.c
@@ -237,12 +237,8 @@ static int ektf2127_probe(struct i2c_client *client,
 
 	/* This requests the gpio *and* turns on the touchscreen controller */
 	ts->power_gpios = devm_gpiod_get(dev, "power", GPIOD_OUT_HIGH);
-	if (IS_ERR(ts->power_gpios)) {
-		error = PTR_ERR(ts->power_gpios);
-		if (error != -EPROBE_DEFER)
-			dev_err(dev, "Error getting power gpio: %d\n", error);
-		return error;
-	}
+	if (IS_ERR(ts->power_gpios))
+		return dev_err_probe(dev, PTR_ERR(ts->power_gpios), "Error getting power gpio\n");
 
 	input = devm_input_allocate_device(dev);
 	if (!input)
-- 
2.17.1

