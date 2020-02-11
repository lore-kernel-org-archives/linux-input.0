Return-Path: <SRS0=tMsn=37=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA82C3B188
	for <linux-input@archiver.kernel.org>; Tue, 11 Feb 2020 12:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB3B206DB
	for <linux-input@archiver.kernel.org>; Tue, 11 Feb 2020 12:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="kh8uvMnN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgBKMNh (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:13:37 -0500
Received: from onstation.org ([52.200.56.107]:58256 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728649AbgBKMNa (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 11 Feb 2020 07:13:30 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id A50943EA2C;
        Tue, 11 Feb 2020 12:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1581423209;
        bh=9vYr0veDNGoPaF0yS5MgwbJtvztKvRkU36Niw0Jf0FQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kh8uvMnNUSXxFCihiHSRwOnBVdMbm8XJHSngNXlL/AOB9lOWcvAiyiPBL8ns3OX6D
         0zRubd/bSaJGyCDBaUk16Xae3t9PDSj08gqY1oEK8UWWQB42jFMv3zSTWuWEqdohRj
         P1A3Rylm+FqczfpzlCvaiMcwyAeAsRXv8jdNfZQ0=
From:   Brian Masney <masneyb@onstation.org>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: Input: remove msm-vibrator
Date:   Tue, 11 Feb 2020 07:13:17 -0500
Message-Id: <20200211121318.144067-2-masneyb@onstation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200211121318.144067-1-masneyb@onstation.org>
References: <20200211121318.144067-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The address referenced in this binding is within the Qualcomm Clock
namespace so let's drop the msm-vibrator bindings so that a more
generic solution can be used instead.  No one is currently using these
bindings so this won't affect any users.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/input/msm-vibrator.txt           | 36 -------------------
 1 file changed, 36 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/msm-vibrator.txt

diff --git a/Documentation/devicetree/bindings/input/msm-vibrator.txt b/Documentation/devicetree/bindings/input/msm-vibrator.txt
deleted file mode 100644
index 8dcf014ef2e5..000000000000
--- a/Documentation/devicetree/bindings/input/msm-vibrator.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-* Device tree bindings for the Qualcomm MSM vibrator
-
-Required properties:
-
-  - compatible: Should be one of
-		"qcom,msm8226-vibrator"
-		"qcom,msm8974-vibrator"
-  - reg: the base address and length of the IO memory for the registers.
-  - pinctrl-names: set to default.
-  - pinctrl-0: phandles pointing to pin configuration nodes. See
-               Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
-  - clock-names: set to pwm
-  - clocks: phandle of the clock. See
-            Documentation/devicetree/bindings/clock/clock-bindings.txt
-  - enable-gpios: GPIO that enables the vibrator.
-
-Optional properties:
-
-  - vcc-supply: phandle to the regulator that provides power to the sensor.
-
-Example from a LG Nexus 5 (hammerhead) phone:
-
-vibrator@fd8c3450 {
-	reg = <0xfd8c3450 0x400>;
-	compatible = "qcom,msm8974-vibrator";
-
-	vcc-supply = <&pm8941_l19>;
-
-	clocks = <&mmcc CAMSS_GP1_CLK>;
-	clock-names = "pwm";
-
-	enable-gpios = <&msmgpio 60 GPIO_ACTIVE_HIGH>;
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&vibrator_pin>;
-};
-- 
2.24.1

