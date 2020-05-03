Return-Path: <SRS0=LbEz=6R=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F4EC28CBC
	for <linux-input@archiver.kernel.org>; Sun,  3 May 2020 20:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66521206F1
	for <linux-input@archiver.kernel.org>; Sun,  3 May 2020 20:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgECURr (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 3 May 2020 16:17:47 -0400
Received: from v6.sk ([167.172.42.174]:36010 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729026AbgECURr (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 3 May 2020 16:17:47 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id F3D83610C9;
        Sun,  3 May 2020 20:17:15 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 1/2] dt-bindings: input: Add Dell Wyse 3020 Power Button binding
Date:   Sun,  3 May 2020 22:12:36 +0200
Message-Id: <20200503201237.413864-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200503201237.413864-1-lkundrak@v3.sk>
References: <20200503201237.413864-1-lkundrak@v3.sk>
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
index 000000000000..e022d36c48d2
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
2.26.0

