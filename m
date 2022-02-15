Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561CFC433F5
	for <linux-input@archiver.kernel.org>; Tue, 15 Feb 2022 18:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242868AbiBOSIr (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 15 Feb 2022 13:08:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242870AbiBOSIq (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 15 Feb 2022 13:08:46 -0500
Received: from hs01.dk-develop.de (hs01.dk-develop.de [173.249.23.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9628F1199;
        Tue, 15 Feb 2022 10:08:36 -0800 (PST)
From:   Danilo Krummrich <danilokrummrich@dk-develop.de>
To:     krzysztof.kozlowski@canonical.com, dmitry.torokhov@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org,
        Danilo Krummrich <danilokrummrich@dk-develop.de>
Subject: [PATCH v3 2/3] dt-bindings: ps2-gpio: document bus signals open drain
Date:   Tue, 15 Feb 2022 19:08:28 +0100
Message-Id: <20220215180829.63543-3-danilokrummrich@dk-develop.de>
In-Reply-To: <20220215180829.63543-1-danilokrummrich@dk-develop.de>
References: <20220215180829.63543-1-danilokrummrich@dk-develop.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The PS/2 bus defines data and clock line to be open drain, this should
be reflected in the gpio flags set in the binding.

Especially, this is important since the clock line sometimes is driven
by the host while being used as interrupt source.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
---
 .../devicetree/bindings/serio/ps2-gpio.yaml        | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/serio/ps2-gpio.yaml b/Documentation/devicetree/bindings/serio/ps2-gpio.yaml
index 304132fd30c5..a63d9172346f 100644
--- a/Documentation/devicetree/bindings/serio/ps2-gpio.yaml
+++ b/Documentation/devicetree/bindings/serio/ps2-gpio.yaml
@@ -15,12 +15,18 @@ properties:
 
   data-gpios:
     description:
-      the gpio used for the data signal
+      the gpio used for the data signal - this should be flagged as
+      active high using open drain with (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)
+      from <dt-bindings/gpio/gpio.h> since the signal is open drain by
+      definition
     maxItems: 1
 
   clk-gpios:
     description:
-      the gpio used for the clock signal
+      the gpio used for the clock signal - this should be flagged as
+      active high using open drain with (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)
+      from <dt-bindings/gpio/gpio.h> since the signal is open drain by
+      definition
     maxItems: 1
 
   interrupts:
@@ -52,7 +58,7 @@ examples:
         compatible = "ps2-gpio";
         interrupt-parent = <&gpio>;
         interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
-        data-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
-        clk-gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
+        data-gpios = <&gpio 24 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+        clk-gpios = <&gpio 23 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
         write-enable;
     };
-- 
2.35.1

