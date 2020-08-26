Return-Path: <SRS0=eR53=CE=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94112C433E1
	for <linux-input@archiver.kernel.org>; Wed, 26 Aug 2020 18:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60C4E207BC
	for <linux-input@archiver.kernel.org>; Wed, 26 Aug 2020 18:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598465879;
	bh=bFWXrahWZE4RHtfb+fZwx6Jtt7jkIi/qT02KwyGXOCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BIavQkNY7EuOwzZlSEsbWgv2TIjLAPPBJMa49vIySaKrwZfTtDUNr5yNnV8s+ybnb
	 SPTdpk2mr4ikZ40d/CSx5qL3//9uPVOtj2OZbxhBfBKOUOR1sw4JBA6nJ5Ow00gUTW
	 7Vnv/TfdKvhibZbrf9GvevveJiCDlgrF8Ouvbm4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgHZSRt (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:17:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbgHZSRr (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 26 Aug 2020 14:17:47 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1D672083B;
        Wed, 26 Aug 2020 18:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598465867;
        bh=bFWXrahWZE4RHtfb+fZwx6Jtt7jkIi/qT02KwyGXOCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ddqnq4zB7lPpM7hzVw1IloUX1PupoBZcOzkPV3jMtjXridhGL/WBng3zm33pTk6v/
         dgkG5XGalcVMSSbYyjt9mElmrSSi60XlrBZuAwkMkzwiGxWGT/VVygfdN1TUZQ/pT9
         ZnlQ86TvdUWo0Xzii6iUDBEOIkSqSezzlrjUTfUY=
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
Subject: [PATCH 06/24] Input: pwm-vibra - Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 20:16:48 +0200
Message-Id: <20200826181706.11098-6-krzk@kernel.org>
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
 drivers/input/misc/pwm-vibra.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/input/misc/pwm-vibra.c b/drivers/input/misc/pwm-vibra.c
index 81e777a04b88..e45cd6801208 100644
--- a/drivers/input/misc/pwm-vibra.c
+++ b/drivers/input/misc/pwm-vibra.c
@@ -135,21 +135,13 @@ static int pwm_vibrator_probe(struct platform_device *pdev)
 
 	vibrator->vcc = devm_regulator_get(&pdev->dev, "vcc");
 	err = PTR_ERR_OR_ZERO(vibrator->vcc);
-	if (err) {
-		if (err != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Failed to request regulator: %d",
-				err);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(&pdev->dev, err, "Failed to request regulator\n");
 
 	vibrator->pwm = devm_pwm_get(&pdev->dev, "enable");
 	err = PTR_ERR_OR_ZERO(vibrator->pwm);
-	if (err) {
-		if (err != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Failed to request main pwm: %d",
-				err);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(&pdev->dev, err, "Failed to request main pwm\n");
 
 	INIT_WORK(&vibrator->play_work, pwm_vibrator_play_work);
 
-- 
2.17.1

