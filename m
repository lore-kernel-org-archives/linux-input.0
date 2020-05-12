Return-Path: <SRS0=3AEP=62=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C89DC2D0FA
	for <linux-input@archiver.kernel.org>; Tue, 12 May 2020 22:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E3AA24927
	for <linux-input@archiver.kernel.org>; Tue, 12 May 2020 22:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="MvLZ0+OT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgELW1U (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 12 May 2020 18:27:20 -0400
Received: from vps.xff.cz ([195.181.215.36]:41818 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731313AbgELW1U (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 12 May 2020 18:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1589322130; bh=JFe/nwMSA6vjCYShOxGSMoLkzCpZNbpdrhZDImIOA/U=;
        h=From:To:Cc:Subject:Date:References:From;
        b=MvLZ0+OT0w6t9T1roThSn1RHOcYbUluUau/zL6wlyhmuWJ6PG89U+sUmG3yKJQOdw
         emI/0T8uIhd7tgBbmCeAy7rat0LL3eMNNEjbKoWT79KVAp6LFmbg0YsSeGSjkCaIGh
         5g7hgQ+zZqIuvmDKPOiFVORdEo2RmSmIE5pDAu2c=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>, Luca Weiss <luca@z3ntu.xyz>,
        Tomas Novotny <tomas@novotny.cz>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/4] ARM: dts: sun8i-a83t-tbs-a711: Increase voltage on the vibrator
Date:   Wed, 13 May 2020 00:22:05 +0200
Message-Id: <20200512222205.1456300-5-megous@megous.com>
In-Reply-To: <20200512222205.1456300-1-megous@megous.com>
References: <20200512222205.1456300-1-megous@megous.com>
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
index a278a1e33930..1e086e979348 100644
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
2.26.2

