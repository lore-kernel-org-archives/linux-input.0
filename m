Return-Path: <SRS0=eR53=CE=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6DEC433DF
	for <linux-input@archiver.kernel.org>; Wed, 26 Aug 2020 18:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E30C20737
	for <linux-input@archiver.kernel.org>; Wed, 26 Aug 2020 18:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598465914;
	bh=QRZ2bQQtheOypVoyAK/PzaZmjf1dQjEQJxQMbx49de0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bbQS75jDSPCGkXZcIIIApH20GYgvCLmljnzN5Aj8XnIC+CrW2C+t0SbonSS/mpV4D
	 5nq7RbJ7QuxQY9tj57h8QOor1BR43k5Wv0TCd54r0AKUIRg3t9SZeMgLrNoCMkSPW5
	 ZNILzFlZ/8f/XJ/w2f3cnvN7f+A87Y8iadyvX95Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgHZSS1 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:18:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbgHZSSZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 26 Aug 2020 14:18:25 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C2BC20737;
        Wed, 26 Aug 2020 18:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598465904;
        bh=QRZ2bQQtheOypVoyAK/PzaZmjf1dQjEQJxQMbx49de0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iSQPH1+qnOXJ0r+evYR/XNlyyX6uhSA9ICStJXZYAQXDQdweY/fk9JiHJtdf32PKk
         dl6TmIZkqdXjlP1a0leJusa0M8zSHwRJm3ZVEpP9Q9cN6NswKF+ESkhUBAfaOJr0e9
         VF+95zhHhI3Z83hPqJoxaukZUuzuO7pCvcuCSmoE=
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
Subject: [PATCH 14/24] Input: ektf2127 - Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 20:16:56 +0200
Message-Id: <20200826181706.11098-14-krzk@kernel.org>
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

