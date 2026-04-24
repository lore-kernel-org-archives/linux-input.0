Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4F636E46C
	for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 07:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777014822; cv=none; b=Nb3oy3kH6BpmkYEEplP28cbuP2xh0w3k96YhdTIWYE5RXC1tH6aNd8b6l/wlgDvT0ODWsQL0pXQCc50SYwdul1ZPT4HrmuX5lRNZDOud9iunapSMXQs1k3LKvvNcri+oBHLMZ+sBrpYbIuVgVjtEvhqg5qEbfVGKJvlhlgu0gGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777014822; c=relaxed/simple;
	bh=tnLPRL9A9azacxq4NLt+IId8izuY1ScptZDT7gzu40c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LoE2ExuOqZvamCMekeXsPBb2WVMSKBxmZzE5EoPuydP5ggFbBYVVRuLVJkvPqb4ib9zyAWls9AFnodg9JI8o+dcZ1hgTimc3l57QIlUFOxke/M9z8o0/Iswm+7ZrL6BYRtCRv/EQIoRlUGfzCgY6lgm0SCj0i86rYTf3EMXUnbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JY4AFANb; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JY4AFANb"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38c620f1699so69167491fa.0
        for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 00:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777014814; x=1777619614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBE1o78vN0SIWnrb8j+CXJa2K5r2M8CfhkLvD2G7oEc=;
        b=JY4AFANbEnAu7Sm0MHnDuPYu5DcBcphUo8zr8wbxxIxCIMX1QWhV37CB2N3tJcHl31
         MGJ7Oqaq/fvZCBtCFoJX0WK4vwNaCXoy5AY39WxlAyft8e9I8sDSAHUl9jB4+lMbBAgx
         hh4+eZoBk6eZVJ//ykx+gKR51D5rx5mNTo4cXUrBHZvfZe7otyL7obuzYUXqztsmKH0I
         9qpm8OJHq+KyKz9WBYvDUbF2yMG431YAM6MCWl8njp7LD2we2A/CdTw8ZkXNx5Ji3txM
         nhZCGagNS/UoxBCFjNB9mIWNL16X9XOtCA8xXiNRH4HDSaO738FF4+SiMkkoGGa/I4JB
         iTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777014814; x=1777619614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RBE1o78vN0SIWnrb8j+CXJa2K5r2M8CfhkLvD2G7oEc=;
        b=gdoXFIbyqFop1DLTVgHpeJl9kGjzH6DOTvEXrGtiFeYe+pNe3jUe7suKbZKpqanOdS
         35kPdRtqMJyGbg8q+qp9rvoFyMWonHZSfYU1+ob1wBF3fs+SbNCfyWN862cWApMZTGse
         3pKidAEAnHoufDsCG7kdogKjFidOOEL8lijshl3Ot4VDLxDXn2RNhCYvOIpHVxmkx0KZ
         6L4y9bDc23NrWWYzbCofguLgv18JGyFEYL+DNVEgf3EASdcRrsKb6mVLNHfTXEIuH8Zg
         eG+BJ0FzwiopFlk3nIcYZ8e3rEq9I7TyhsSOchytyYyYjnLiU7RPN2bGZ8JbLAODJO+3
         PofQ==
X-Gm-Message-State: AOJu0Yz3uM3i2X2sPTol7r6MK+rH95Bh3r0zvxAKusOc9FoGr7E7kcbw
	1NpxVM2qS0PQjAC26/VPaPjeefAZ9G1UH3IIzcqm/0VWAiOKgPAP7j3d
X-Gm-Gg: AeBDieuXFt0Q90nyrZvwW5Xa4Tul7Ldj4Ut4ipnYIX77n2fzYXIf2aUO4RmFFLArNBP
	fGJEbtPW+pztRcDur222Ou5NGlEVuhH22vpL0oqsSYABcZVB0ek341/GYvxkL3weRELcdtMt0rh
	t2mbVAqs1/kKZ8dGmRNY2CyTPwEdbXql/CPfgT1JYceezI0uk+CbZRzkczG8hXuEwNJudvZQY0N
	Pqxz8rd0UjETvp3e6J3FBtOBSl0CGMNrhjtoBBKe7pzVUfmqFyykhVPDi2tgG0eqkrAZuzqIghA
	jQc4jLeImK/VhAea2NYKsISNBKX17QAbE4zIlaJxBw/JMx9OBAinn+G2ksvpLfZJRRf209Nd/4i
	B+b0/xCvsbxiKWOb3VTxFsvBJBgYt3b1ixcX01FOOYM2KWkwGFWe4nw9E+9UQO+ysIFWUbJ3gkD
	ALImy8REljea+MN5wGIbhsRK4=
X-Received: by 2002:a05:6512:3b14:b0:5a3:d381:2a7c with SMTP id 2adb3069b0e04-5a4172e2d60mr12562766e87.31.1777014814198;
        Fri, 24 Apr 2026 00:13:34 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb290095sm43760131fa.0.2026.04.24.00.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 00:13:33 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: input: Document Imagis ISA1200 haptic motor driver
Date: Fri, 24 Apr 2026 10:13:04 +0300
Message-ID: <20260424071305.89503-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260424071305.89503-1-clamor95@gmail.com>
References: <20260424071305.89503-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the Imagis ISA1200 haptic motor driver, used primarily in mobile
handheld devices and capable of supporting up to two motors.

The exact datasheet for the ISA1200 is not available; all data was modeled
based on available downstream kernel sources for various devices and
fragments of information scattered across the internet.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/input/imagis,isa1200.yaml        | 145 ++++++++++++++++++
 include/dt-bindings/input/isa1200.h           |  16 ++
 2 files changed, 161 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/imagis,isa1200.yaml
 create mode 100644 include/dt-bindings/input/isa1200.h

diff --git a/Documentation/devicetree/bindings/input/imagis,isa1200.yaml b/Documentation/devicetree/bindings/input/imagis,isa1200.yaml
new file mode 100644
index 000000000000..51767fd8189d
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/imagis,isa1200.yaml
@@ -0,0 +1,145 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/imagis,isa1200.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Imagis ISA1200 haptic motor driver
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+  - Linus Walleij <linusw@kernel.org>
+
+description:
+  The ISA1200 is a high-performance enhanced haptic motor driver designed
+  for mobile hand-held devices. It supports various voltages for both ERM
+  (Eccentric Rotating Mass) and LRA (Linear Resonant Actuator) type
+  actuators. Thanks to an embedded LDO, battery power can be used directly
+  in handheld applications.
+
+properties:
+  compatible:
+    const: imagis,isa1200
+
+  reg:
+    maxItems: 1
+
+  enable-gpios:
+    description:
+      One or two GPIOs flagged as active high linked to HEN and LEN pins
+    maxItems: 2
+
+  clocks:
+    maxItems: 1
+
+  pwms:
+    maxItems: 1
+
+  vdd-supply:
+    description:
+      Regulator for 2.4V - 5.5V power supply
+
+  vddp-supply:
+    description:
+      Regulator for 2.4V - 3.6V IO power supply
+
+  imagis,clk-div:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Divider for the external input clock/PWM
+      0 - 128
+      1 - 256
+      2 - 512
+      3 - 1024
+    enum: [0, 1, 2, 3]
+    default: 0
+
+  imagis,pll-div:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Divider for the internal PLL clock
+    minimum: 1
+    maximum: 15
+    default: 1
+
+  imagis,mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Defines the motor type isa1200 drives
+      0 - LRA (Linear Resonant Actuator)
+      1 - ERM (Eccentric Rotating Mass)
+    enum: [0, 1]
+    default: 0
+
+  imagis,period-ns:
+    description:
+      Period of the internal PWM channel in nanoseconds.
+    minimum: 128
+    maximum: 254
+
+  imagis,duty-cycle-ns:
+    description:
+      Duty cycle of the external/internal PWM channel in nanoseconds,
+      defaults to 50% of the channel's period
+
+  ldo:
+    $ref: /schemas/regulator/regulator.yaml#
+    type: object
+    description:
+      Embedded LDO regulator with voltage range 2.3V - 3.8V
+    unevaluatedProperties: false
+
+    required:
+      - regulator-min-microvolt
+      - regulator-max-microvolt
+
+required:
+  - compatible
+  - reg
+  - ldo
+
+anyOf:
+  - required:
+      - clocks
+      - imagis,period-ns
+  - required:
+      - pwms
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/input/isa1200.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        haptic-engine@49 {
+            compatible = "imagis,isa1200";
+            reg = <0x49>;
+
+            clocks = <&isa1200_refclk>;
+
+            enable-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>,
+                           <&gpio 23 GPIO_ACTIVE_HIGH>;
+
+            vdd-supply = <&vdd_3v3_vbat>;
+            vddp-supply = <&vdd_2v8_vvib>;
+
+            imagis,clk-div = <ISA1200_CKLDIV_256>;
+            imagis,pll-div = <2>;
+
+            imagis,mode = <ISA1200_LRA_MODE>;
+
+            imagis,period-ns = <134>;
+            imagis,duty-cycle-ns = <100>;
+
+            ldo {
+                regulator-name = "vdd_vib";
+                regulator-min-microvolt = <2300000>;
+                regulator-max-microvolt = <2300000>;
+            };
+        };
+    };
diff --git a/include/dt-bindings/input/isa1200.h b/include/dt-bindings/input/isa1200.h
new file mode 100644
index 000000000000..cbae47ccf99b
--- /dev/null
+++ b/include/dt-bindings/input/isa1200.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+
+#ifndef _DT_BINDINGS_ISA1200_H
+#define _DT_BINDINGS_ISA1200_H
+
+/* Linked actuator type */
+#define ISA1200_LRA_MODE		0
+#define ISA1200_ERM_MODE		1
+
+/* External clock divider */
+#define ISA1200_CKLDIV_128		0
+#define ISA1200_CKLDIV_256		1
+#define ISA1200_CKLDIV_512		2
+#define ISA1200_CKLDIV_1024		3
+
+#endif
-- 
2.51.0

