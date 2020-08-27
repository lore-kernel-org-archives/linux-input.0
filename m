Return-Path: <SRS0=z9W1=CF=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1892CC433DF
	for <linux-input@archiver.kernel.org>; Thu, 27 Aug 2020 19:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E035C22B4D
	for <linux-input@archiver.kernel.org>; Thu, 27 Aug 2020 19:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598554833;
	bh=JMGBhCbFmH+9hMDpsQ5Azdm1zxEQ9lgD8y90ydoMsQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VsXu2TOIcG2/jOg/kFurFpvGdOBEU62Yl8xjC+1c5WeU8Q2ddvw16DfyPsqVPacrO
	 ynwHj5SRbJ94NBhV6DmhAByLDqZbQqK5lCoJ2mA1xUGGWdhGm119bpdNSM5TlV2TdN
	 AdpY9riPZHADIkdsY8dKoB83ueTR4N2+BuEfcstA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgH0S76 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 27 Aug 2020 14:59:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728211AbgH0S7x (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Aug 2020 14:59:53 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E4B42087E;
        Thu, 27 Aug 2020 18:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598554792;
        bh=JMGBhCbFmH+9hMDpsQ5Azdm1zxEQ9lgD8y90ydoMsQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kOk7ctcGE2MBFeLLMWqu0pat1Qj7C19IKf9gJ4EkY61L5goHm2FHin3TtCBdZPaev
         BMQ3PvDTossgOGYqKdY/cbW/rZqHd+63DcaF5ZwxpB3Jlhiro2ol3ga/DUfgEoCJk8
         RW3MROPytreat/iGj6aJAbBzdaeu4CPnwN6HPXNs=
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
Subject: [PATCH v3 21/27] Input: surface3_spi - Simplify with dev_err_probe()
Date:   Thu, 27 Aug 2020 20:58:23 +0200
Message-Id: <20200827185829.30096-22-krzk@kernel.org>
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
 drivers/input/touchscreen/surface3_spi.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/surface3_spi.c b/drivers/input/touchscreen/surface3_spi.c
index ce4828b1415a..25bb77ddf2ef 100644
--- a/drivers/input/touchscreen/surface3_spi.c
+++ b/drivers/input/touchscreen/surface3_spi.c
@@ -223,7 +223,6 @@ static void surface3_spi_power(struct surface3_ts_data *data, bool on)
  */
 static int surface3_spi_get_gpio_config(struct surface3_ts_data *data)
 {
-	int error;
 	struct device *dev;
 	struct gpio_desc *gpiod;
 	int i;
@@ -233,15 +232,9 @@ static int surface3_spi_get_gpio_config(struct surface3_ts_data *data)
 	/* Get the reset lines GPIO pin number */
 	for (i = 0; i < 2; i++) {
 		gpiod = devm_gpiod_get_index(dev, NULL, i, GPIOD_OUT_LOW);
-		if (IS_ERR(gpiod)) {
-			error = PTR_ERR(gpiod);
-			if (error != -EPROBE_DEFER)
-				dev_err(dev,
-					"Failed to get power GPIO %d: %d\n",
-					i,
-					error);
-			return error;
-		}
+		if (IS_ERR(gpiod))
+			return dev_err_probe(dev, PTR_ERR(gpiod),
+					     "Failed to get power GPIO %d\n", i);
 
 		data->gpiod_rst[i] = gpiod;
 	}
-- 
2.17.1

