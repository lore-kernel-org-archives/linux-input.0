Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A57B258EF3
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 13:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787317867; cv=none; b=s9spqbuI97yrK91GGdwkYRH1LQWtDEWCA8r6MR2gqUvxrdUIkpYfCu427rsx19LtwA6+Fs6dD21+Toqhi2+DWnjSfIspmjCk6fYoSzzldeO1/S10o60UrtIaQBmKFwIBMePWH0NRkmqN+KWaOAIrjzbtttC7BRjVDx3vPvhGhDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787317867; c=relaxed/simple;
	bh=ND4t+afKTeWJNKvkfd+bkaxZPQtRVRH6YSMWkHeH59w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ANFR9yWVzqya3TPYjowl4J24mnMe8UY04Hitbdw/oF8VHls4tIVe8tBjwHWK9lIwKd0kc9yKXecSeRTM39CYbgPVBQZkpdPObOra7KaWvTZyNRdZusqQ3GmUsMFkuWbf2d3jbRwt3f1xPh/0emMgU5YdLkmLdIh/9ka5DR3Enoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeROmTH3; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeROmTH3"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c16794450aeso146219266b.2
        for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 06:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787317851; x=1787922651; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HSblcr0CCEdB1oJUM1Wum0cFSHQwfMNAeMnxc8Z942I=;
        b=DeROmTH3mhek7zKY/W4TO8o9ycL+iWZ4KYO/55JbK3NQkef9AEOdm+fUFKl+jqpFgC
         smCnKSwjJO5AXQfWe33EeQVmp1n1uKmScMmpw3uaFYSNM5HTF45ybfq8SqA7EZ4Hz4WD
         EkKDd231PYGjHTSMHsNXM6phiOug97WR5AR0tQX3j6JuV0ocGmmBvZnUnje6ekO9BWk3
         AKROKGYyTR5Kd4AkXXo2PYV/CFfg8rtiKKHLMpwMX0FMDgYKtb2BT6V6FtrgDtobHnGO
         IURDFynWa1zpxqv3DxHnRd/TyFIhGya75v3+4IpJahWnIEhYcpoWQWPiouy9LcF53VSj
         NSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787317851; x=1787922651;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HSblcr0CCEdB1oJUM1Wum0cFSHQwfMNAeMnxc8Z942I=;
        b=Bk8vQDlKk8uvLkRwAnMuD9RujXcacHuOjMkn3TJ91u/P7t8K1ucznfGjDnfRnWKnFN
         bfW5KFWbFphacO7KZqYstYxpl5IfslPHewHVJcmps4Z4pVT9T8BPZuoBg/xucAI3lBVp
         brYTOyezHf1yHJUbDdFnctzV7d4KbEA8Q+i3qbCI9lUtPFFPF6DWl0dQx+E7KerqlXUu
         P29RU3blzw0n2Z1IIS2B+fWzGS1MIJseZ8v88W/lgBapIbLNJVN6+IHXBH5zNQS8RbsI
         D5s5ur1hnJTCOJ2SawXvhd+lxxx6Bpddkq6KwxPDMSinF8jCyTWjKo+a3RvN4kUA/MpC
         kl6Q==
X-Gm-Message-State: AFuF++nrdHuzw3+hgvnzaD6qcRnWv1dhoMr0bktTuMshoRjCCha5bhrV
	ubFPKg2H2hX/S6BFNydwYGAqap9b3KDf3gzUEQiHUjqyPyOydA43nLlk
X-Gm-Gg: AR+sD12mZ+EmiVz38TamI+xryUYjiXYHbUWQL5I3O3Dv4VGyZpVyYkIZ6Vvhtfy+eCf
	zSh1RUml6mxlLLB/brsZ+7gHU2Towz3r4+gM+IvR8cmTGjSXE3kNp25zXv/LrQmEgGlGMzX1vPM
	kHNK/873JanolsLoG3AYFbYgHIOT43BupK6PQUWH/U/2WUHGCqmBnq48+L4Fmir+2kA9SixNfBz
	10olxnYQ4ANADw4sefVQf/i6e52PXYXqshTfU+4bEGsoqT0ZZ2vrQqNkWMOfTMyJFjj/S0ewpHR
	hYCsiTKe8+f/+ejvRK1npRi8jT+uQAvJGIi8UbqxhR9FX2LY6KHu8NilRsI2edf9iMFe8AEi+b4
	pv+1LSUoSMcw2Ug6r6Bij6ZGcx5O4yctksMsv9jLcI1EkOWtIyALkB7lh3C8u70sWa12jlLTFjW
	Rcz5cP6BbVmAgqcAbNqoCrIErRFP2IEXUQnYJNBxPHxtGEOgc0R589nv/b9DuGUcb27IWYzX0EM
	9leHQ0ie/g8Tw88KsGg18QO69Jokdt5grk6JpsbXBFDqEIBClC3eLGpU4pO+yTGABQEe+6l71Ew
	htQqR0u+/5G7FweV84XiD67t8kdwoTPvdTwE0BZAusdRanh8D3yZ0LcnwmbWKZZqcx91QYAP2qt
	TM0x6oA==
X-Received: by 2002:a17:907:9603:b0:c07:43ed:1b3e with SMTP id a640c23a62f3a-c2469f9a365mr727120166b.0.1787317850935;
        Fri, 21 Aug 2026 06:10:50 -0700 (PDT)
Received: from workstation ([85.186.165.159])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2459197cc9sm468761466b.31.2026.08.21.06.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 06:10:50 -0700 (PDT)
From: =?UTF-8?q?=C8=98tefan=20Ghe=C8=9Bu?= <stefanghetu9@gmail.com>
To: =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C8=98tefan=20Ghe=C8=9Bu?= <stefanghetu9@gmail.com>
Subject: [PATCH] dt-bindings: input: touchscreen: convert sis_i2c to DT schema
Date: Fri, 21 Aug 2026 16:10:39 +0300
Message-ID: <20260821131039.37525-1-stefanghetu9@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert the SiS 9200 family I2C touchscreen binding from free-form
text to DT schema format.

While at it, fix the example which referenced a non-existent
"irq-gpios" property; the driver looks up "attn" via
devm_gpiod_get_optional(), so the correct property is "attn-gpios".

Signed-off-by: Ștefan Ghețu <stefanghetu9@gmail.com>
---
 .../input/touchscreen/sis,9200-ts.yaml        | 61 +++++++++++++++++++
 .../bindings/input/touchscreen/sis_i2c.txt    | 31 ----------
 MAINTAINERS                                   |  2 +-
 3 files changed, 62 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/sis,9200-ts.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/sis_i2c.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sis,9200-ts.yaml b/Documentation/devicetree/bindings/input/touchscreen/sis,9200-ts.yaml
new file mode 100644
index 000000000..5c4806348
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/sis,9200-ts.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/sis,9200-ts.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiS 9200 Family I2C Touchscreen Controller
+
+maintainers:
+  - Mika Penttilä <mpenttil@redhat.com>
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    const: sis,9200-ts
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  attn-gpios:
+    maxItems: 1
+    description: GPIO pin used as the attention line
+
+  reset-gpios:
+    maxItems: 1
+    description: GPIO pin used to reset the controller
+
+  wakeup-source: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        touchscreen@5c {
+            compatible = "sis,9200-ts";
+            reg = <0x5c>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&pinctrl_sis>;
+            interrupt-parent = <&gpio3>;
+            interrupts = <19 IRQ_TYPE_EDGE_FALLING>;
+            attn-gpios = <&gpio3 19 GPIO_ACTIVE_LOW>;
+            reset-gpios = <&gpio2 30 GPIO_ACTIVE_LOW>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/input/touchscreen/sis_i2c.txt b/Documentation/devicetree/bindings/input/touchscreen/sis_i2c.txt
deleted file mode 100644
index 8f5322e01..000000000
--- a/Documentation/devicetree/bindings/input/touchscreen/sis_i2c.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-* SiS I2C Multiple Touch Controller
-
-Required properties:
-- compatible: must be "sis,9200-ts"
-- reg: i2c slave address
-- interrupts: touch controller interrupt (see interrupt
-  binding [0])
-
-Optional properties:
-- pinctrl-names: should be "default" (see pinctrl binding [1]).
-- pinctrl-0: a phandle pointing to the pin settings for the
-  device (see pinctrl binding [1]).
-- attn-gpios: the gpio pin used as attention line
-- reset-gpios: the gpio pin used to reset the controller
-- wakeup-source: touchscreen can be used as a wakeup source
-
-[0]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
-[1]: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
-
-Example:
-
-	sis9255@5c  {
-		compatible = "sis,9200-ts";
-		reg = <0x5c>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_sis>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <19 IRQ_TYPE_EDGE_FALLING>;
-		irq-gpios = <&gpio3 19 GPIO_ACTIVE_LOW>;
-		reset-gpios = <&gpio2 30 GPIO_ACTIVE_LOW>;
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 8014b9f82..88d0cb1d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24866,7 +24866,7 @@ SIS I2C TOUCHSCREEN DRIVER
 M:	Mika Penttilä <mpenttil@redhat.com>
 L:	linux-input@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/input/touchscreen/sis_i2c.txt
+F:	Documentation/devicetree/bindings/input/touchscreen/sis,9200-ts.yaml
 F:	drivers/input/touchscreen/sis_i2c.c
 
 SIS USB2VGA DRIVER
-- 
2.53.0

