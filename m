Return-Path: <SRS0=PsuB=ID=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D641C4332E
	for <linux-input@archiver.kernel.org>; Fri,  5 Mar 2021 16:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2087B6509F
	for <linux-input@archiver.kernel.org>; Fri,  5 Mar 2021 16:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhCEQqM (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 5 Mar 2021 11:46:12 -0500
Received: from smtpweb146.aruba.it ([62.149.158.146]:43056 "EHLO
        smtpweb146.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbhCEQpr (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 5 Mar 2021 11:45:47 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Mar 2021 11:45:47 EST
Received: from ubuntu.localdomain ([146.241.168.111])
        by Aruba Outgoing Smtp  with ESMTPSA
        id IDTPlgHCw1jmzIDTRlCrB3; Fri, 05 Mar 2021 17:38:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1614962326; bh=XFPljTLEpx+iDJEZVKAEvkdEGU2G+Au15VT749VzRcI=;
        h=From:To:Subject:Date:MIME-Version;
        b=KI54Uu7vZQbo0vKor1OOaOQ4cptRs7rYunM9mlIGJyZsY1ytHlAGnkrAQy/G+U5Mn
         O+Sgk8NxUGsZ5mYCQ7sX0GAY6rwiTcv77XTd+V1Cu+4sEriYdUTSvoJvLqjT3jxcbv
         9+T/tyoDvBkoqNvt5uNGFj0vunfW8Pqilmhx0e61mRUzsAvNTqzjEfGiHwqcUjhWF3
         LMMstKXrSkVJcAl0kl0RffRhZoUiFIHPYqTEPsnhX4mken1jRRi2fNsYQkmvpQConl
         Flk1UHgygOB/O55UX0WJnJnNEiAODTcwaAO9phU0S7INdw+xRY51fhayNgMGkGcKCp
         y7/FySFIypXTQ==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: touchscreen: Add HY46XX bindings
Date:   Fri,  5 Mar 2021 17:38:33 +0100
Message-Id: <20210305163834.70924-3-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305163834.70924-1-giulio.benetti@benettiengineering.com>
References: <20210305163834.70924-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOjOXavtwRgjjMB8Lcj823f0m6pi8u/nB6O1dPedYSb4BkzaAht/8t+7QmiR8+K7dDfr3baH+CwS5Cap4tW7nMNtxPCnPSA2J3hNQpQCVdUbvroCOjBY
 a2uLfDHcVT4ZGg/oRC9r6cIbspABP/2O9ebJYjTc56VsMQCyvolkG7hWYv+sD5KNo6cNUfbPc3P8kQmWzkiQQIRw4Ecdb9u7UG0tq/7KQnU5eepacDsfD5yl
 dEN1pDu+tRLVmv77LgQqaMn0X2nT93BHIQ3r8qrMixpPJ+Vj1rmUO1tffxn0FLRYB7BtEhYJ41QomyYWtq8NqEK0iuMJ8e3ahRFHQbvWtJVDuN7DESWdZNq4
 dHWH6irjW4MItTTIMhgWU3Zo9mXB40A4dssgxGWd3Oak81SjHzp5mUHhQ9lYlL5b7L8aU/A4
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Giulio Benetti <giulio.benetti@micronovasrl.com>

This adds device tree bindings for the Hycon HY46XX touchscreen series.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 .../input/touchscreen/hycon,hy46xx.yaml       | 130 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 136 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/hycon,hy46xx.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/hycon,hy46xx.yaml b/Documentation/devicetree/bindings/input/touchscreen/hycon,hy46xx.yaml
new file mode 100644
index 000000000000..cddd5e5bae92
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/hycon,hy46xx.yaml
@@ -0,0 +1,130 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/hycon-hy46xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: hyconon HY46XX series touchscreen controller Bindings
+
+description: |
+             There are 6 variants of the chip for various touch panel sizes and coverl len material
+              Glass: 0.3mm--4.0mm
+              PET/PMMA: 0.2mm--2.0mm
+               HY4613(B)-N048  < 6"
+               HY4614(B)-N068  7" .. 10.1"
+               HY4621-NS32  < 5"
+               HY4623-NS48  5.1" .. 7"
+              Glass: 0.3mm--8.0mm
+              PET/PMMA: 0.2mm--4.0mm
+               HY4633(B)-N048  < 6"
+               HY4635(B)-N048  < 7" .. 10.1"
+
+maintainers:
+  - Giulio Benetti <giulio.benetti@micronovasrl.com>
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    enum:
+      - hycon,hycon-hy4613
+      - hycon,hycon-hy4614
+      - hycon,hycon-hy4621
+      - hycon,hycon-hy4623
+      - hycon,hycon-hy4633
+      - hycon,hycon-hy4635
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  vcc-supply: true
+
+  threshold:
+    description: Allows setting the sensitivity in the range from 0 to 255.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 255
+
+  proximity-sensor-switch:
+    description: Allows enabling or disabling the Proximity Sensor.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 1
+
+  glove-enable:
+    description: Allows enabling or disabling glove setting.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 1
+
+  report-speed:
+    description: Allows setting the report speed(i.e 0x64 => 100Hz).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 255
+
+  power-noise-enable:
+    description: Allows enabling or disabling power noise filter.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 1
+
+  filter-data:
+    description: Allows setting the filtering data before reporting touch
+                 in the range from 0 to 5.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 5
+
+  gain:
+    description: Allows setting the sensitivity distance in the range from 0 to 5.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 5
+
+  edge-offset:
+    description: Allows setting the edge compensation in the range from 0 to 16.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 16
+
+  touchscreen-size-x: true
+  touchscreen-size-y: true
+  touchscreen-fuzz-x: true
+  touchscreen-fuzz-y: true
+  touchscreen-inverted-x: true
+  touchscreen-inverted-y: true
+  touchscreen-swapped-x-y: true
+  interrupt-controller: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      hycon-hy4633@1c {
+        compatible = "hycon,hy4633";
+        reg = <0x1c>;
+        interrupt-parent = <&gpio2>;
+        interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+        reset-gpios = <&gpio2 6 GPIO_ACTIVE_LOW>;
+      };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index d92f85ca831d..3f83daf6b2bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8245,6 +8245,12 @@ S:	Maintained
 F:	mm/hwpoison-inject.c
 F:	mm/memory-failure.c
 
+HYCON HY46XX TOUCHSCREEN SUPPORT
+M:	Giulio Benetti <giulio.benetti@micronovasrl.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/touchscreen/hycon,hy46xx.yaml
+
 HYGON PROCESSOR SUPPORT
 M:	Pu Wen <puwen@hygon.cn>
 L:	linux-kernel@vger.kernel.org
-- 
2.25.1

