Return-Path: <SRS0=ep/6=4K=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C9EC35673
	for <linux-input@archiver.kernel.org>; Sat, 22 Feb 2020 23:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7785F2071E
	for <linux-input@archiver.kernel.org>; Sat, 22 Feb 2020 23:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="aGVQrg/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgBVXVz (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 22 Feb 2020 18:21:55 -0500
Received: from vps.xff.cz ([195.181.215.36]:34180 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbgBVXVz (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 22 Feb 2020 18:21:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582413272; bh=WwPRw8c1ksPjhP3qFyeLOPanGzgHH/wo0hf0oKx3fqE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=aGVQrg/CmOuf7Mgexl9iQ0PdpxoBG17io2yR/F56s4kLZXF80RUVr6dZAzNA3x409
         Elfcnmzo1wJDBcswdpSWlWyzSovwzAeHQ7oEmzVslMvsezYaN8kOHNui0ssas3y2K7
         jHkup+yjw/2ou0xcGS6uCikver+f8S3eCTU/Xi4Y=
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
Subject: [PATCH 4/4] ARM: dts: sun8i-a83t-tbs-a711: Increase voltage on the vibrator
Date:   Sun, 23 Feb 2020 00:14:28 +0100
Message-Id: <20200222231428.233621-5-megous@megous.com>
In-Reply-To: <20200222231428.233621-1-megous@megous.com>
References: <20200222231428.233621-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Vibrator motor is weak at the current voltage. Increase the voltage.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index a22920275e99b..314491cdafca2 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -434,8 +434,8 @@ &reg_ldo_io0 {
 };
 
 &reg_ldo_io1 {
-	regulator-min-microvolt = <3100000>;
-	regulator-max-microvolt = <3100000>;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
 	regulator-name = "vcc-vb";
 	status = "okay";
 };
-- 
2.25.1

