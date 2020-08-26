Return-Path: <SRS0=eR53=CE=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50847C433DF
	for <linux-input@archiver.kernel.org>; Wed, 26 Aug 2020 18:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DBBF20737
	for <linux-input@archiver.kernel.org>; Wed, 26 Aug 2020 18:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598465930;
	bh=DAJ4IK0T3bYzcNbVBNiI+Vu9Q4UxL1+YwJDRQtT/cUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CNIMMjobEgttgxmLJapex2krlX2hcmX8aZNLxlNDBy1rIGEtyS94aDSy/VRjqW3hr
	 qhYJXD0UvYkPk/wtCa1TfQkrP8JZSq0Wmtk9ortA7EcmeiZ2/+uDOU0c87Gawv8P1B
	 tKIef5r/DLGnCnm0WlujN3NRf9Ukkrb/ykM+3/Wg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgHZSSt (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:18:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727881AbgHZSSp (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 26 Aug 2020 14:18:45 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2237320737;
        Wed, 26 Aug 2020 18:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598465924;
        bh=DAJ4IK0T3bYzcNbVBNiI+Vu9Q4UxL1+YwJDRQtT/cUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xi7x5aqOUP5FpsDQ38MnGbVt+nIQx7FmM4kLD0OEKTs+oY0REYpQ1krT3q5OgonML
         4YTzELWJpn5wldO2Q93XCvCJjGFWkqPymXeVXuyeSpK/TmATtoGHfpLuScbizBmGyh
         a84AEQBcmfVgZ6LkVKAXN8WNRLhUYIC6X6TzrdTo=
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
Subject: [PATCH 20/24] Input: resistive-adc-touch - Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 20:17:02 +0200
Message-Id: <20200826181706.11098-20-krzk@kernel.org>
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
 drivers/input/touchscreen/resistive-adc-touch.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/resistive-adc-touch.c b/drivers/input/touchscreen/resistive-adc-touch.c
index cfc8bb4553f7..46b5a6caef84 100644
--- a/drivers/input/touchscreen/resistive-adc-touch.c
+++ b/drivers/input/touchscreen/resistive-adc-touch.c
@@ -108,12 +108,8 @@ static int grts_probe(struct platform_device *pdev)
 
 	/* get the channels from IIO device */
 	st->iio_chans = devm_iio_channel_get_all(dev);
-	if (IS_ERR(st->iio_chans)) {
-		error = PTR_ERR(st->iio_chans);
-		if (error != -EPROBE_DEFER)
-			dev_err(dev, "can't get iio channels.\n");
-		return error;
-	}
+	if (IS_ERR(st->iio_chans))
+		return dev_err_probe(dev, PTR_ERR(st->iio_chans), "can't get iio channels\n");
 
 	chan = &st->iio_chans[0];
 	st->pressure = false;
-- 
2.17.1

