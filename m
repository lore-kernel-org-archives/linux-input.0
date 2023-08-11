Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2543CC0015E
	for <linux-input@archiver.kernel.org>; Fri, 11 Aug 2023 11:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbjHKLEj (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 11 Aug 2023 07:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbjHKLEj (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 11 Aug 2023 07:04:39 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF35DE54;
        Fri, 11 Aug 2023 04:04:38 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 4EBC980F1;
        Fri, 11 Aug 2023 11:04:37 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: input: gpio-keys: Allow optional dedicated wakeirq
Date:   Fri, 11 Aug 2023 14:04:31 +0300
Message-ID: <20230811110432.3968-1-tony@atomide.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Allow configuring optional dedicated wakeirq that some SoCs have.
Let's use the interrupt naming "irq" and "wakeup" that we already have
in use for some drivers and subsystems like i2c.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 .../devicetree/bindings/input/gpio-keys.yaml      | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
--- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
+++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
@@ -31,7 +31,17 @@ patternProperties:
         maxItems: 1
 
       interrupts:
-        maxItems: 1
+        description:
+          Optional interrupts if different from the gpio interrupt
+        maxItems: 2
+
+      interrupt-names:
+        description:
+	  Optional interrupt names, can be used to specify a separate
+	  dedicated wake-up interrupt
+        items:
+          -const: irq
+          -const: wakeup
 
       label:
         description: Descriptive name of the key.
@@ -130,6 +140,9 @@ examples:
             label = "GPIO Key UP";
             linux,code = <103>;
             gpios = <&gpio1 0 1>;
+            interrupts-extended = <&intc_wakeup 0 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "wakeup";
+            wakeup-source;
         };
 
         key-down {
-- 
2.41.0
