Return-Path: <SRS0=9sxG=BJ=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BCEC433E0
	for <linux-input@archiver.kernel.org>; Thu, 30 Jul 2020 13:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2975B20829
	for <linux-input@archiver.kernel.org>; Thu, 30 Jul 2020 13:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="AnoaAalR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgG3NYw (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 30 Jul 2020 09:24:52 -0400
Received: from vps.xff.cz ([195.181.215.36]:55000 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728815AbgG3NYv (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 30 Jul 2020 09:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1596115489; bh=GszcDyWuzeoUstoycZg/BqelDXcPSvv9p22i7U58TFw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=AnoaAalRafFfoeqpuoiljwa/pAKlbdSBSKlvpd9hlsQccnK81K1ERzUqnd02StNxW
         5mPmh4/MRLmumDvFau7dVM2dd8wvBUYP19o6VWg9kj2iL7ZbJQd6e1NLAXMq18f0uj
         hLQ1dSttlE5CzaU6eDjI3S7xlyntpDeUpgegvtqE=
From:   Ondrej Jirman <megous@megous.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>, Luca Weiss <luca@z3ntu.xyz>,
        Tomas Novotny <tomas@novotny.cz>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 3/4] ARM: dts: sun8i-a83t-tbs-a711: Add support for the vibrator motor
Date:   Thu, 30 Jul 2020 15:24:45 +0200
Message-Id: <20200730132446.3139980-4-megous@megous.com>
In-Reply-To: <20200730132446.3139980-1-megous@megous.com>
References: <20200730132446.3139980-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The board has a vibrator motor. Hook it to the input subsystem.

According to the PMIC specification, LDO needs to be enabled (value 0b11)
to achieve the specified max driving current of 150mA. We can't drive
the motor with just GPIO mode.

In GPIO mode the chip is probably just using the regular CMOS logic
output circuitry (typically limited to around 20-35mA, but not specified
in this datasheet).

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index bfc9bb277a49..a278a1e33930 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -99,6 +99,11 @@ panel_input: endpoint {
 		};
 	};
 
+	vibrator {
+		compatible = "gpio-vibrator";
+		vcc-supply = <&reg_ldo_io1>;
+	};
+
 	reg_gps: reg-gps {
 		compatible = "regulator-fixed";
 		regulator-name = "gps";
-- 
2.27.0

