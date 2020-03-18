Return-Path: <SRS0=NBds=5D=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561C8C5ACDA
	for <linux-input@archiver.kernel.org>; Wed, 18 Mar 2020 11:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4D020770
	for <linux-input@archiver.kernel.org>; Wed, 18 Mar 2020 11:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgCRLqJ (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:46:09 -0400
Received: from v6.sk ([167.172.42.174]:51372 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgCRLqI (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 18 Mar 2020 07:46:08 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 34F3560EED;
        Wed, 18 Mar 2020 11:46:07 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 1/2] dt-bindings: input: Add Dell Wyse 3020 Power Button binding
Date:   Wed, 18 Mar 2020 12:45:55 +0100
Message-Id: <20200318114556.2064-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200318114556.2064-1-lkundrak@v3.sk>
References: <20200318114556.2064-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Add binding document for the Dell Wyse 3020 a.k.a. "Ariel" Power Button.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 .../bindings/input/ariel-pwrbutton.yaml       | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/ariel-pwrbutton.yaml

diff --git a/Documentation/devicetree/bindings/input/ariel-pwrbutton.yaml b/Documentation/devicetree/bindings/input/ariel-pwrbutton.yaml
new file mode 100644
index 0000000000000..e022d36c48d23
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/ariel-pwrbutton.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/ariel-pwrbutton.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dell Wyse 3020 a.k.a. "Ariel" Power Button
+
+maintainers:
+  - Lubomir Rintel <lkundrak@v3.sk>
+
+description: |
+  The ENE Embedded Controller on the Ariel board has an interface to the
+  SPI bus that is capable of sending keyboard and mouse data. A single
+  power button is attached to it. This binding describes this
+  configuration.
+
+allOf:
+  - $ref: input.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: dell,wyse-ariel-ec-input
+      - const: ene,kb3930-input
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        power-button@0 {
+            compatible = "dell,wyse-ariel-ec-input", "ene,kb3930-input";
+            reg = <0>;
+            interrupt-parent = <&gpio>;
+            interrupts = <60 IRQ_TYPE_EDGE_RISING>;
+            spi-max-frequency = <33000000>;
+        };
+    };
-- 
2.25.1

