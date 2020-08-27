Return-Path: <SRS0=z9W1=CF=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F304C433E3
	for <linux-input@archiver.kernel.org>; Thu, 27 Aug 2020 18:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69D6822CB3
	for <linux-input@archiver.kernel.org>; Thu, 27 Aug 2020 18:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598554799;
	bh=uuRqkmEQUfrTFVyLKREdckixX1+af1YgVze1b7IwB/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nv0YAFRI7qbbbhiTkRKB3YkzzB40lVsptv0lY0P9r4lmAknkwIp3jmb0Vncu/mgxw
	 /Ve13k5DdeGiPUL1amoaIh0zGT1nVPEfX8o4sIclHRd+ZQKTJ9pt1xXckLyggX6VQe
	 Mm0b/NL8JyAjcipj0CnH0ZHrGjROP1b9ySftQkqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgH0S75 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 27 Aug 2020 14:59:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728227AbgH0S74 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Aug 2020 14:59:56 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12FA422BEA;
        Thu, 27 Aug 2020 18:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598554795;
        bh=uuRqkmEQUfrTFVyLKREdckixX1+af1YgVze1b7IwB/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KKPFcFkSX0ci8UuDDGQh/QU7DazBDmgvPMk2uABsqU1ddu0Ncm1yFZm3PesMQZ8WL
         BDiv8KVM41hh7UNoGs7CIfc2BXK/aa9d6zGR71rd07NBeLrFtRpU19sFLcS8Jq9urg
         cN8hXbkjf6yFnwKx84VaaOxGeuAi2FsMU9m7DbFM=
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
Subject: [PATCH v3 22/27] Input: sx8643 - Simplify with dev_err_probe()
Date:   Thu, 27 Aug 2020 20:58:24 +0200
Message-Id: <20200827185829.30096-23-krzk@kernel.org>
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
 drivers/input/touchscreen/sx8654.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
index de85e57b2486..d2ed9be64c3a 100644
--- a/drivers/input/touchscreen/sx8654.c
+++ b/drivers/input/touchscreen/sx8654.c
@@ -323,13 +323,9 @@ static int sx8654_probe(struct i2c_client *client,
 
 	sx8654->gpio_reset = devm_gpiod_get_optional(&client->dev, "reset",
 						     GPIOD_OUT_HIGH);
-	if (IS_ERR(sx8654->gpio_reset)) {
-		error = PTR_ERR(sx8654->gpio_reset);
-		if (error != -EPROBE_DEFER)
-			dev_err(&client->dev, "unable to get reset-gpio: %d\n",
-				error);
-		return error;
-	}
+	if (IS_ERR(sx8654->gpio_reset))
+		return dev_err_probe(&client->dev, PTR_ERR(sx8654->gpio_reset),
+				     "unable to get reset-gpio\n");
 	dev_dbg(&client->dev, "got GPIO reset pin\n");
 
 	sx8654->data = device_get_match_data(&client->dev);
-- 
2.17.1

