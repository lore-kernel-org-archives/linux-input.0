Return-Path: <SRS0=/2A/=Z3=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C05C2D0BE
	for <linux-input@archiver.kernel.org>; Thu,  5 Dec 2019 00:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF2321744
	for <linux-input@archiver.kernel.org>; Thu,  5 Dec 2019 00:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="Y2uLkgrp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbfLEAZN (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 4 Dec 2019 19:25:13 -0500
Received: from onstation.org ([52.200.56.107]:54108 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728590AbfLEAZM (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 4 Dec 2019 19:25:12 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 9659B3EA09;
        Thu,  5 Dec 2019 00:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1575505511;
        bh=wrpNF5GI4EFOJIQeD1HHKoAOQrklQZzjGwI2qeKAV3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y2uLkgrp1ZnUemn32szS0PavSYADzVizEjtCtuPZH3VmtTsL8wvdvTNnoAamlGe+K
         0ovU8u1AsAbq5xJ9v8UtXdJYJKWNEHwmhofrd4OsOYSFyaMYUYDPL5nQkEG4v3slGa
         kUBLKsp9gx9ZXtPybU2vZ6K8genIuPSs8DJovDaI=
From:   Brian Masney <masneyb@onstation.org>
To:     sboyd@kernel.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, mturquette@baylibre.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 7/7] ARM: dts: qcom: msm8974-hammerhead: add support for vibrator
Date:   Wed,  4 Dec 2019 19:25:03 -0500
Message-Id: <20191205002503.13088-8-masneyb@onstation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191205002503.13088-1-masneyb@onstation.org>
References: <20191205002503.13088-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Add support for the vibrator found on the Nexus 5 phone.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index 797a43be844e..e17ea4f602c1 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -234,6 +234,21 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&wlan_regulator_pin>;
 	};
+
+	vibrator {
+		compatible = "clk-vibrator";
+
+		vcc-supply = <&pm8941_l19>;
+
+		clocks = <&mmcc CAMSS_GP1_CLK>;
+		clock-names = "core";
+		clock-frequency = <24000>;
+
+		enable-gpios = <&msmgpio 60 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&vibrator_pin>;
+	};
 };
 
 &soc {
@@ -355,6 +370,21 @@
 				bias-disable;
 			};
 		};
+
+		vibrator_pin: vibrator {
+			core {
+				pins = "gpio27";
+				function = "gp1_clk";
+
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			enable {
+				pins = "gpio60";
+				function = "gpio";
+			};
+		};
 	};
 
 	sdhci@f9824900 {
-- 
2.21.0

