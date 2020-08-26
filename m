Return-Path: <SRS0=eR53=CE=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CDDC433E1
	for <linux-input@archiver.kernel.org>; Wed, 26 Aug 2020 18:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24993214F1
	for <linux-input@archiver.kernel.org>; Wed, 26 Aug 2020 18:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598465992;
	bh=CLfWoFp2UP/nAPTpoINiSe8V0C6mLS0vbNu1/NHgdu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yuafI7W6uoY5kSvQTKoIXnTMOTIzaCLNo97oIe/lE0oRDUn6gOwYGiELBeP5IzlmH
	 NlAeCJyVx4m0shjzgC8QUAzpHChNOM9B/f1+OW4oh/061jqJtBJTvtLQMQvk+SqIZi
	 S9GTHHMd8g2eEYQNSvhe+r800UoQRMB0NFQsW3rE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgHZSTq (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:19:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727895AbgHZSSs (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 26 Aug 2020 14:18:48 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57F63214F1;
        Wed, 26 Aug 2020 18:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598465927;
        bh=CLfWoFp2UP/nAPTpoINiSe8V0C6mLS0vbNu1/NHgdu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0PDQ8A945uJE1QgzcP+uuzJe6cY7+kwGjxOg7+vUjjvwhzCBdGObO7FgNEkoJY1Oy
         CzEsew420WVyGFe4gpVQckl2Byh52HJWr1g/CfgaeeUiwqFPvA8HMv3/di/xK27VLO
         xPkUSUeBd0EEw7LqI3MtZB+rlBYrsFfqe8Obdbr4=
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
Subject: [PATCH 21/24] Input: silead - Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 20:17:03 +0200
Message-Id: <20200826181706.11098-21-krzk@kernel.org>
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
 drivers/input/touchscreen/silead.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
index 8fa2f3b7cfd8..754debb4b2c4 100644
--- a/drivers/input/touchscreen/silead.c
+++ b/drivers/input/touchscreen/silead.c
@@ -512,11 +512,9 @@ static int silead_ts_probe(struct i2c_client *client,
 
 	/* Power GPIO pin */
 	data->gpio_power = devm_gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
-	if (IS_ERR(data->gpio_power)) {
-		if (PTR_ERR(data->gpio_power) != -EPROBE_DEFER)
-			dev_err(dev, "Shutdown GPIO request failed\n");
-		return PTR_ERR(data->gpio_power);
-	}
+	if (IS_ERR(data->gpio_power))
+		return dev_err_probe(dev, PTR_ERR(data->gpio_power),
+				     "Shutdown GPIO request failed\n");
 
 	error = silead_ts_setup(client);
 	if (error)
-- 
2.17.1

