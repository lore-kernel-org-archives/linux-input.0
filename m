Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B59C3BB127
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 07:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781679978; cv=none; b=JXIuIIjISHHF07qTvZOMxo/hHHLNZfBTftqIk6hdDLUSxuo0HkcsRrGCIrlMxTZKr4EL2K4/EuZPhFn7WSSr5ReGfRTQ0wrFFniV2iGU5w0Ms6H3v17WjM1F3GeqakrM9RiW0Mvno8Txm6btm5UY1b5lHqkV1hR16TksVhQDsVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781679978; c=relaxed/simple;
	bh=1ZpgbLFhc7uTynHM6QmCi54UKtHyRhZrUYid+cJ3Fmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYFAoB9Z4Y4sOdvis4TTkI+oGv5FObIzQvHkL3rsMe42wtEwJppkuVWfkdoP87B4TvPROuzldpCwU5d7r+vIP6g76W5UeH9DQSvBlpRw3wVe4zYeZD7/kSvUiFxuu6K/xYv6sXaIPDfQ/ap3IpCluH6UNFNj6TYz1jJAcOnTbmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o5t+C5V1; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5t+C5V1"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-becfa735b9aso677735466b.1
        for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 00:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781679976; x=1782284776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VN85jO6g8etsAnhUc2JoU6sdjjboKtQLkjRbxbRf3MM=;
        b=o5t+C5V1OIX5WobFQEOuiasNOaVy0ZuFKRMARF2RPp86S+O7B7QJ0kLFJ24yh1/BBT
         Ea+8nSF6NSo3tcl+PrjywqevE+j5keuWUo7AzDjQjHd/FxGO5D0w5LTOIPM/kO7T+QQd
         KIO2Jl4D1N7glZUVloMN1r4s5zwZWOCLo0O9TxMyL+s09ne95rJg47S/MdkpYRa2fAWy
         KjenSNr2VAFs/3pMiByfNWJTHH1M1dqJmWhamZHKj+aHG0tYNL4q5rqbEbKsYB+OpiOF
         yDyRtmxqWtGBQ+6MsZZECI4dMNtVjNk3pt63jwIZ/MeokSn8sXpD0AjJq33rzF5e4oI5
         K89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781679976; x=1782284776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VN85jO6g8etsAnhUc2JoU6sdjjboKtQLkjRbxbRf3MM=;
        b=fBfkEJhtMYaxD5T5lk39DmE6c1Zre3/g/sdF6Xhs0DFz7Sh7gwnMJKZXir9KYAa5De
         xbFKIgfL1QiTBORTuT0HIpTnOinsP5cnrUlfrlNoLDl5++meKwtMDIWOZdKipWsGiBeb
         YBI5vhf/rAAWqiRD6nWv97uMhI39L/r4kvIuPKughA8V20WWbD6iGtyrcHlnlkidyDqQ
         Iecno19M8ZwZB2ViugBnikW7UlCD/QfAfHvxh4+VWE2a85lhOPIURl25iuIyWf4FFKZS
         522RzzSwGHxiRbdbG4uOJE2a89Ho0CIAAjA9gs2elQh40HZjUY7ZfSM2bRmVLchmtXaZ
         B4Zg==
X-Gm-Message-State: AOJu0YztKvz74Mp8qOJJ3L0Tlcx4+81JWJ7z5ZCtk9qqYKEd4bGKut9K
	G3nCjmHuLoNQF0I/5FqtHbRjv/51xKGTtG9fJ4tCJnzkz92CoO+ZIlTg
X-Gm-Gg: Acq92OHKd1Vcp9O5hn7nA0huFU6nM1w+Z35vcSwDDPlPjwB3ENuqINq+4rOJOGYXk0Q
	gkcTiFnJoRPTol8x5RsjAO/NhRxVn/2MI9hej6QZvQvtn87k0ubwhot4NEeieekwwr6dl5vTuOa
	gCZpYLVARR8GHHm9USh5JGcWZBw2U7O+k/MfidxMBhOlTx0I80jnv9WQ4wSzhTv7s6vr3E2AlHY
	EPuQTFgHaG8gElI3ccdxpNbO5HQeWzSZGPSbH//k5EqPIvjdnUNgSqPNER6+JCdQRnUsDYDLNLe
	xwCjz/kiw7iNjfdx0+IM0IBZnH1B8W7DlqfJezu1C3kK04qQ6TOP70qQ6sXWNtOlY+E9nY9yoPm
	insS9CKqikDDgUvJEaKjkRWRB1goume9CAFgYBymvGyi62Lnb2Ke5/Q6oh8/4iosg+5Q8pWRF4h
	liww==
X-Received: by 2002:a17:907:3f0a:b0:bec:6c5c:cced with SMTP id a640c23a62f3a-c05a69ec26dmr196055766b.28.1781679975407;
        Wed, 17 Jun 2026 00:06:15 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb7b6e6c9sm752857266b.39.2026.06.17.00.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 00:06:14 -0700 (PDT)
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
Subject: [PATCH v6 1/2] dt-bindings: input: Document Imagis ISA1200 haptic motor driver
Date: Wed, 17 Jun 2026 10:05:26 +0300
Message-ID: <20260617070528.35006-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617070528.35006-1-clamor95@gmail.com>
References: <20260617070528.35006-1-clamor95@gmail.com>
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
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/input/imagis,isa1200.yaml        | 141 ++++++++++++++++++
 1 file changed, 141 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/imagis,isa1200.yaml

diff --git a/Documentation/devicetree/bindings/input/imagis,isa1200.yaml b/Documentation/devicetree/bindings/input/imagis,isa1200.yaml
new file mode 100644
index 000000000000..4bc8630edcdd
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/imagis,isa1200.yaml
@@ -0,0 +1,141 @@
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
+    minItems: 1
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
+oneOf:
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
2.53.0

