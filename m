Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA733112C0
	for <linux-input@vger.kernel.org>; Sun,  3 May 2026 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777827182; cv=none; b=B19tj46VETIwIERwiYA5K2pT5PuFfbMKEZ+s+ZUKnMG9AZ6e19Z3WisfBT9FCogAJFUN6SmdJkN8VFWUdlRzBXbE/DChNrDEQmvmNbH+I+Gnj5aHzuB/0dUdPvHS7EIegwuSIoJWDSjIVcmfWmfvMHegfx/XxHGPkOO7GhSG6Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777827182; c=relaxed/simple;
	bh=a8DDUbGKi4KbjMV3e+HbsPy4j0FsEQ2efqEYjbF/y8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IM3/vEUHQmnTNVguJmFPDpYp2wUAVzhm9Bgdag9WNMpbwBEEKIjj3k3WgvYx6KBwFZ9MBAlNzOBcf74X/dChPBjTtPfv4L23WDj0cj9PqRYF2HXkHjPFvt8wfZIQojBAdcsuc35vD5Rr5ICj4xqOXlbBitTMOppwby73b5Wtm6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXzoqrbK; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXzoqrbK"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bbe539fc355so273737266b.2
        for <linux-input@vger.kernel.org>; Sun, 03 May 2026 09:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777827173; x=1778431973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQY9b9kLzwLVCnnN7VEZw07BRk2Ugr4r9Iyui3/2atE=;
        b=nXzoqrbKeazpalkf6bard9fkpZCr2La6Wxtomb0DBOhEDzvpi9jUWM1XDCOVQwU7fx
         CfU9+Lu4t8dkQUnBAUyZ+35fNgKEGcod30gMh1pYhXWqZ9H4nYDQZDNqZopXk1vC3kOa
         0QhBiKUQjUujXXurfW/RosMNu/D6Y1pF8aMJnI4II9UpqBxnXXf7Emgk4YZ5VLO7V1FD
         EOecFeEEn2LVzuDrnTSJx9xf/ihguSVS2Cni+BSkqg86G8wOQJyPhg/+/ksNBfs+t41V
         MtfOSsQEG2bQBUEP+bZIH4UQM7sf9LZ4NedvjQ9xFyXrezYxmQUB536d1UquKMt2KYfs
         Q+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777827173; x=1778431973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tQY9b9kLzwLVCnnN7VEZw07BRk2Ugr4r9Iyui3/2atE=;
        b=UtfJCLqgKHNQRN1tAehZyCDJzjI0iYgC1ZEynEuSSgTzo94h9FMY+n6jb+nARsBead
         sEN0hVPzzGsDIARsdn9hLvoHvfWF2RW07O/TuN+1KlXpGFsARWKyD50mNB98JvQ+uswW
         KhB8x5laW+Vyrp2rSTfzm64uhp6ZVfse33MwHxBOjaE2+tRXhFgDGh3g+rQelS4iF3Nd
         wS5P7C9kCdAo3KK3sbzBjJJK3gdsH2/tZYc+7lF8L0v7bpAyzAq+KLQe4PxYywvjaVt6
         6NnV9boefV8yGLeL5EdBVdjwSpCnoxfgpZ8ZTFZninTisjkb85xdhL80qIXd7aAGIkad
         GxFg==
X-Gm-Message-State: AOJu0YwoEAV38oCZFwaRbzhp/xFyTIW9Y92FOvhpStBaU6MPylayq1QE
	c8kJTTqCvvsWvq+9lU537UuvzOTMwQqGAsxIWjilqA2KG+9dQutcUCLk
X-Gm-Gg: AeBDiet1Bhggza5zyeKAjjA18OqQFlYDnMR4nZtxTd97UqHZ0lV53XYJnA7YE9mdYzS
	7tc4Cvxu/iCdHJ6f1UzhqIiB1MdBfdSDpmkD2/wAO97fltGAh18fLVfA/wmOz4/V1+NmLC00/ge
	Gq2yHt99Xow4fcko4U9eUAfhpXM5WhpsdHV49TBNtrsyUXLAMNwmp5Zo32cWnEfyrLhj+7lq3Ed
	cOr0sMpGiEx8S21p+EuwjwXlrwgsylW7BaD+RZE7cWvebEJomlp/9SAeEbTjoeoHV4woMfCPuk7
	UYO9z2N5WZY4NYUj8A0MVxo/8JT1ixvCgmd1RfvYUPeYAlRbibTLZsv2EGbXhoWy32Wkv91Xx2k
	PYhwd3Fj6n7c3r6JOJLzD+/8N9UjG4Tj0e5rwYrB59FaLdfrCVYMMzpO1XasWR6eSUNOPvDJhAQ
	WHqRGss8kJgICa2SqQM7p0n8OeDj+onfsf6A==
X-Received: by 2002:a17:907:25c6:b0:bbe:7709:5a8c with SMTP id a640c23a62f3a-bbff8ed4865mr297216666b.1.1777827173127;
        Sun, 03 May 2026 09:52:53 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bbe69f6b7f6sm316772566b.3.2026.05.03.09.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 09:52:52 -0700 (PDT)
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
Subject: [PATCH v3 1/2] dt-bindings: input: Document Imagis ISA1200 haptic motor driver
Date: Sun,  3 May 2026 19:52:42 +0300
Message-ID: <20260503165243.215979-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260503165243.215979-1-clamor95@gmail.com>
References: <20260503165243.215979-1-clamor95@gmail.com>
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

Tested-by: Linus Walleij <linusw@kernel.org> # Samsung GT-I9070 Janice
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/input/imagis,isa1200.yaml        | 140 ++++++++++++++++++
 1 file changed, 140 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/imagis,isa1200.yaml

diff --git a/Documentation/devicetree/bindings/input/imagis,isa1200.yaml b/Documentation/devicetree/bindings/input/imagis,isa1200.yaml
new file mode 100644
index 000000000000..bbe6f99d39c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/imagis,isa1200.yaml
@@ -0,0 +1,140 @@
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
+  control-gpios:
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
+    description:
+      Divider for the external input clock/PWM
+    enum: [128, 256, 512, 1024]
+    default: 128
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
+    description: |
+      Defines the motor type isa1200 drives
+      0 - LRA (Linear Resonant Actuator)
+      1 - ERM (Eccentric Rotating Mass)
+    enum: [0, 1]
+    default: 0
+
+  imagis,period-ns:
+    description:
+      Period of the internal PWM channel in nanoseconds.
+    minimum: 10000
+    maximum: 30000
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
+            control-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>,
+                            <&gpio 23 GPIO_ACTIVE_HIGH>;
+
+            vdd-supply = <&vdd_3v3_vbat>;
+            vddp-supply = <&vdd_2v8_vvib>;
+
+            imagis,clk-div = <256>;
+            imagis,pll-div = <2>;
+
+            imagis,mode = <0>; /* LRA_MODE */
+
+            imagis,period-ns = <13400>;
+            imagis,duty-cycle-ns = <100>;
+
+            ldo {
+                regulator-name = "vdd_vib";
+                regulator-min-microvolt = <2300000>;
+                regulator-max-microvolt = <2300000>;
+            };
+        };
+    };
-- 
2.51.0

