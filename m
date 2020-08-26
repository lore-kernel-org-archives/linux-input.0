Return-Path: <SRS0=eR53=CE=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81D3C433E3
	for <linux-input@archiver.kernel.org>; Wed, 26 Aug 2020 18:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2F0E20737
	for <linux-input@archiver.kernel.org>; Wed, 26 Aug 2020 18:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598466006;
	bh=MhmkwJ2yyDo7W16oC/eUQhQtQQPiKt2NFHFuo0anrwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mHozBONAJdpzOOdhszty8pqYTLI2kcWPmXjGJcQoaAoxBlthpXWZFwkMr3x7nH0A7
	 cZUYBL/EOzLe4FUMLmP4V1Oe5qKPU0G2UUQ8fBFoJTuUP9uOOnRGDa9OLYIECcGcW9
	 lpkQwSkevl1hp4MBAU59/RNS+3GxSxkEBrU+DDcU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgHZSUG (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:20:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbgHZSRx (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 26 Aug 2020 14:17:53 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D8A320786;
        Wed, 26 Aug 2020 18:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598465872;
        bh=MhmkwJ2yyDo7W16oC/eUQhQtQQPiKt2NFHFuo0anrwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fBU6CEuAA0amVc+6o5CPkB5Rh3XmQO1TEJXL+cFkD0c5P+wobSWcKG4cGtSSrqiZj
         68w16vrtYopb/o6hDHNTwOaolZi3w6lxHP1apv/XOs1PYC+eh5xT5eejdertKgYtQt
         PD6sAFEl2vaV85bkDGWgwMlt7HPTV36kavA/5rgc=
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
Subject: [PATCH 07/24] Input: rotary_encoder - Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 20:16:49 +0200
Message-Id: <20200826181706.11098-7-krzk@kernel.org>
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
 drivers/input/misc/rotary_encoder.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index 6d613f2a017c..ea56c9f4975a 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -236,12 +236,8 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 		device_property_read_bool(dev, "rotary-encoder,relative-axis");
 
 	encoder->gpios = devm_gpiod_get_array(dev, NULL, GPIOD_IN);
-	if (IS_ERR(encoder->gpios)) {
-		err = PTR_ERR(encoder->gpios);
-		if (err != -EPROBE_DEFER)
-			dev_err(dev, "unable to get gpios: %d\n", err);
-		return err;
-	}
+	if (IS_ERR(encoder->gpios))
+		return dev_err_probe(dev, PTR_ERR(encoder->gpios), "unable to get gpios\n");
 	if (encoder->gpios->ndescs < 2) {
 		dev_err(dev, "not enough gpios found\n");
 		return -EINVAL;
-- 
2.17.1

