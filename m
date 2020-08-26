Return-Path: <SRS0=eR53=CE=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753B4C433DF
	for <linux-input@archiver.kernel.org>; Wed, 26 Aug 2020 18:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41B2B20737
	for <linux-input@archiver.kernel.org>; Wed, 26 Aug 2020 18:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598465920;
	bh=db6cAfvHR7hZaShwMgbp+kK+nTUH1aoOV5Yzheh1ExU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tc6SIaqINHkUX3CR8Nl9qeAEXDgNZV5iSfzk8/P6q03FxKt4hk0l2p+mKKnAJb24U
	 V4HbsQvOwtGOuHe16euYfqoMkKj3bENKCF86nqTZ1rjIpvvZBDMQwlWlB189eNXfzc
	 uUSAwFuMzhR5YyXR5p/6Qu5sbVx5CkFcCDz4ErjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgHZSSg (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:18:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727831AbgHZSSg (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 26 Aug 2020 14:18:36 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30C34207BC;
        Wed, 26 Aug 2020 18:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598465914;
        bh=db6cAfvHR7hZaShwMgbp+kK+nTUH1aoOV5Yzheh1ExU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hPPV10IzLm1EAVanzbPGYA7h1sr/WM621NwqedlyHuX8QIVSrgaatjQ0m4DACkeeo
         lG9pV4TogIuqTuYrE4Lj9xoqOQyTme2lAvm1qJswIOnHvYaTqQEdpPfPdeDjVAf8ri
         8Yabty8B7O7FsQ7w71MWudj+DFc0sVNj3vzV1vXg=
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
Subject: [PATCH 17/24] Input: melfas_mip4 - Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 20:16:59 +0200
Message-Id: <20200826181706.11098-17-krzk@kernel.org>
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

