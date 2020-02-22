Return-Path: <SRS0=ep/6=4K=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559DAC35671
	for <linux-input@archiver.kernel.org>; Sat, 22 Feb 2020 23:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1721C20702
	for <linux-input@archiver.kernel.org>; Sat, 22 Feb 2020 23:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="lcuPU+Gf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgBVXVz (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 22 Feb 2020 18:21:55 -0500
Received: from vps.xff.cz ([195.181.215.36]:34176 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726865AbgBVXVz (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 22 Feb 2020 18:21:55 -0500
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Feb 2020 18:21:54 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582413271; bh=EbeAOpviq24JHTSqKTtGGCUdeye+O8up0OquvyuB0Sg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=lcuPU+GfEZsPTBkMZdO9IBD8LxhgGqJSAaMWttZ1ZocTjfnyf9sAKW6N1ahFP7fGz
         StwBRq5EfBO2lhChY6aEQpwUqZtJP4NxdO3ivnACiadBHws37Y1Rm+NLEz3Y9tlabt
         8eeuHQxdfTXPykC9tD30SXbLhOVdfIwsdm119nOw=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Luca Weiss <luca@z3ntu.xyz>, Tomas Novotny <tomas@novotny.cz>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] input: gpio-vibra: Allow to use vcc-supply alone to control the vibrator
Date:   Sun, 23 Feb 2020 00:14:26 +0100
Message-Id: <20200222231428.233621-3-megous@megous.com>
In-Reply-To: <20200222231428.233621-1-megous@megous.com>
References: <20200222231428.233621-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Make enable-gpio optional to allow using this driver with
boards that have vibrator connected to a power supply without
intermediate gpio based enable circuitry.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 drivers/input/misc/gpio-vibra.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/gpio-vibra.c b/drivers/input/misc/gpio-vibra.c
index f79f75595dd73..f11877f04b43c 100644
--- a/drivers/input/misc/gpio-vibra.c
+++ b/drivers/input/misc/gpio-vibra.c
@@ -121,7 +121,8 @@ static int gpio_vibrator_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	vibrator->gpio = devm_gpiod_get(&pdev->dev, "enable", GPIOD_OUT_LOW);
+	vibrator->gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
+						 GPIOD_OUT_LOW);
 	err = PTR_ERR_OR_ZERO(vibrator->gpio);
 	if (err) {
 		if (err != -EPROBE_DEFER)
-- 
2.25.1

