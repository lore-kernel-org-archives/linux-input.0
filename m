Return-Path: <SRS0=eR53=CE=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AEDC433E1
	for <linux-input@archiver.kernel.org>; Wed, 26 Aug 2020 18:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8679F207BC
	for <linux-input@archiver.kernel.org>; Wed, 26 Aug 2020 18:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598465899;
	bh=BJVFQy3/ZY4QN0q1KpODN4O1wsNuQRFbfec6DZhQ+d0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vshHlza0juJM5D1Iu2U0obTHZ7Zqxb2ZzdG6h8lO6m2whmVlVYSD09pZ6NgiCSxlM
	 O5nL/LNTs4Q9xLsg7+ZsCLXzTVUTUqlcZdB6FSHsicMjrlV9jMUC5iIjfYTUthaZJI
	 GTElViiQWh4kfhTTy47qE5QfuyJGVLXX5w5nhM4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgHZSSR (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:18:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbgHZSSM (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 26 Aug 2020 14:18:12 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AA1222B40;
        Wed, 26 Aug 2020 18:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598465891;
        bh=BJVFQy3/ZY4QN0q1KpODN4O1wsNuQRFbfec6DZhQ+d0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F3VqhC8R0Eqi0HEnUJg6V5+uRGmJEB4ioxGk3UB+VWXhEFUtBD+aT3/gCycWyCQ16
         RmifWmG4gBMPpOpmF9AXHvvhJvV6eA3wKwLYBD0Av5WCFZMWTjhz8IQSh3xgJKWkKY
         FzVqWIveihljNC4og5ce315GsEQUiOB+t364LNEQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bastien Nocera <hadess@hadess.net>,
        Sangwon Jee <jeesw@melfas.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 11/24] Input: chipone_icn8318 - Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 20:16:53 +0200
Message-Id: <20200826181706.11098-11-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826181706.11098-1-krzk@kernel.org>
References: <20200826181706.11098-1-krzk@kernel.org>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/input/touchscreen/chipone_icn8318.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/chipone_icn8318.c b/drivers/input/touchscreen/chipone_icn8318.c
index d91d2fd78649..5bee007184c4 100644
--- a/drivers/input/touchscreen/chipone_icn8318.c
+++ b/drivers/input/touchscreen/chipone_icn8318.c
@@ -194,12 +194,8 @@ static int icn8318_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	data->wake_gpio = devm_gpiod_get(dev, "wake", GPIOD_OUT_LOW);
-	if (IS_ERR(data->wake_gpio)) {
-		error = PTR_ERR(data->wake_gpio);
-		if (error != -EPROBE_DEFER)
-			dev_err(dev, "Error getting wake gpio: %d\n", error);
-		return error;
-	}
+	if (IS_ERR(data->wake_gpio))
+		return dev_err_probe(dev, PTR_ERR(data->wake_gpio), "Error getting wake gpio\n");
 
 	input = devm_input_allocate_device(dev);
 	if (!input)
-- 
2.17.1

