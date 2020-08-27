Return-Path: <SRS0=z9W1=CF=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C58C433E4
	for <linux-input@archiver.kernel.org>; Thu, 27 Aug 2020 19:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8F2620786
	for <linux-input@archiver.kernel.org>; Thu, 27 Aug 2020 19:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598554834;
	bh=Dqxv1PukEgIMN3bm5Lm6sGdSDukCKcjdzgy7iM6VbfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BZhKWrjh6Shfrdbcce0pjWOGdZLEWppi3LYu9atulBw8qnN0cFjVmBcfCASgev47Y
	 QsCo0Aj8gISJ5a4YHHqHngxeKIxYoPK7ITC7uP8mSppz3YKAwO7r9Xw3lo5Y9WtcSq
	 FXjSNLjaurgxj6k0wgamryCkf1FQOKgbLITV2zsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgH0S7f (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 27 Aug 2020 14:59:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:49860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728122AbgH0S7c (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Aug 2020 14:59:32 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 610BC2087E;
        Thu, 27 Aug 2020 18:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598554772;
        bh=Dqxv1PukEgIMN3bm5Lm6sGdSDukCKcjdzgy7iM6VbfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Liu8obZvNyBblM0iUyAt5drhqfZgaCB4+6wJWN+DwRYCnf7Mgmr8uAX19RUbFmArt
         ZOlo+IE3uAMOWUg8j4FVbgGc46w4mW/NEQS6O6UywtK/OzlsQpdOKaQGSJOfX40rfA
         /lDwnnd0Aw22mLJ8EzJDPcdL8QmRChehhgqrVK/o=
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
Subject: [PATCH v3 15/27] Input: melfas_mip4 - Simplify with dev_err_probe()
Date:   Thu, 27 Aug 2020 20:58:17 +0200
Message-Id: <20200827185829.30096-16-krzk@kernel.org>
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
 drivers/input/touchscreen/melfas_mip4.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/melfas_mip4.c b/drivers/input/touchscreen/melfas_mip4.c
index f67efdd040b2..d43a8643adcd 100644
--- a/drivers/input/touchscreen/melfas_mip4.c
+++ b/drivers/input/touchscreen/melfas_mip4.c
@@ -1451,13 +1451,8 @@ static int mip4_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	ts->gpio_ce = devm_gpiod_get_optional(&client->dev,
 					      "ce", GPIOD_OUT_LOW);
-	if (IS_ERR(ts->gpio_ce)) {
-		error = PTR_ERR(ts->gpio_ce);
-		if (error != EPROBE_DEFER)
-			dev_err(&client->dev,
-				"Failed to get gpio: %d\n", error);
-		return error;
-	}
+	if (IS_ERR(ts->gpio_ce))
+		return dev_err_probe(&client->dev, PTR_ERR(ts->gpio_ce), "Failed to get gpio\n");
 
 	error = mip4_power_on(ts);
 	if (error)
-- 
2.17.1

