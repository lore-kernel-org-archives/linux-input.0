Return-Path: <SRS0=/2A/=Z3=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32D7C2D0B1
	for <linux-input@archiver.kernel.org>; Thu,  5 Dec 2019 00:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB81621835
	for <linux-input@archiver.kernel.org>; Thu,  5 Dec 2019 00:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="rGMse0ea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbfLEAZM (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 4 Dec 2019 19:25:12 -0500
Received: from onstation.org ([52.200.56.107]:54108 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728557AbfLEAZL (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 4 Dec 2019 19:25:11 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 65DCD538A5;
        Thu,  5 Dec 2019 00:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1575505510;
        bh=2OX8S2TwxbSrcYZ5mPRrewqOvJrOWqLNCom5xuy7YCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rGMse0ea89HvvjHNUxTuQd6nyWDAByRfnP7z+y1yHCcxXq3kYDKvyl4gE3uU24jiN
         YfIRb/Dw/hbiuRjSr0dtJPj6G+IzUWqleAqtnFMcORWQXyMVB/fL4lstuPrfh0HZTV
         h11Bl2jx5CvcrcZmtABsqMix7F7hAsfrsG3lUvFE=
From:   Brian Masney <masneyb@onstation.org>
To:     sboyd@kernel.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, mturquette@baylibre.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 4/7] dt-bindings: Input: introduce new clock vibrator bindings
Date:   Wed,  4 Dec 2019 19:25:00 -0500
Message-Id: <20191205002503.13088-5-masneyb@onstation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191205002503.13088-1-masneyb@onstation.org>
References: <20191205002503.13088-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Add support for clock-based vibrator devices where the speed can be
controlled by changing the duty cycle.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 .../bindings/input/clk-vibrator.yaml          | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/clk-vibrator.yaml

diff --git a/Documentation/devicetree/bindings/input/clk-vibrator.yaml b/Documentation/devicetree/bindings/input/clk-vibrator.yaml
new file mode 100644
index 000000000000..2103a5694fad
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/clk-vibrator.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/input/clk-vibrator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Clock vibrator
+
+maintainers:
+  - Brian Masney <masneyb@onstation.org>
+
+description: |
+  Support for clock-based vibrator devices where the speed can be controlled
+  by changing the duty cycle.
+
+properties:
+  compatible:
+    const: clk-vibrator
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    description: output clock that controls the speed
+    items:
+      - const: core
+
+  clock-frequency: true
+
+  enable-gpios:
+    maxItems: 1
+
+  vcc-supply:
+    description: Regulator that provides power
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - clock-frequency
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,mmcc-msm8974.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    vibrator {
+        compatible = "clk-vibrator";
+
+        vcc-supply = <&pm8941_l19>;
+
+        clocks = <&mmcc CAMSS_GP1_CLK>;
+        clock-names = "core";
+        clock-frequency = <24000>;
+
+        enable-gpios = <&msmgpio 60 GPIO_ACTIVE_HIGH>;
+
+        pinctrl-names = "default";
+        pinctrl-0 = <&vibrator_pin>;
+    };
-- 
2.21.0

