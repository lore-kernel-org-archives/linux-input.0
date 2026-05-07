Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6613FA5C5
	for <linux-input@vger.kernel.org>; Thu,  7 May 2026 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778161203; cv=none; b=jzPEJOTau8kQ7zqCVDJfv91kGAVg/A2sfBzN/vqyQQphd0Km6leORl8R5KGzyNBmRszTCG4RtHHWz/H3A4kUBxSrDGfS+DfXM3a7I7KFG4HHd5Ctw8lSx22A7YeIzm+sfdYJq8WIN5n2Dbvmx/RD/6OHdu6J5WSihVX5KPy0Ba4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778161203; c=relaxed/simple;
	bh=2FvmENfO/vJaQsVl7EbFhKjZmzyDq3pCbM6bhuL7kxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6/8o7j+q4eHm5lndN0vKOdJl03fQcHnFkf9V8tbglop4W2c2AWQF25t/0eUkiFbJICjIGUFlz+1CqmSEPREx08/+kIAg0fRXT0plp/pgGJT9/SA840nBCilcYcMlJb98Qnnx0WRDziDQXBXs+rxDdpEpIHY/rPjNCd7hCeEUQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZZ+eSLp; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZZ+eSLp"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso9826795e9.0
        for <linux-input@vger.kernel.org>; Thu, 07 May 2026 06:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778161199; x=1778765999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9P2MUIoe45JJ2qWDf5DbrVjk/FPu8YOqLPxGiP+tPM0=;
        b=QZZ+eSLpWK0j7Mu3tAeSXZ6XUL+CvlIYPDfhFItRmXN16tPB/js94sCHpR/obWe2H+
         vcnCXv5aokltjUhNcofQ53QkjGdYYi0zp+wiY5lwoRPOgR/0Og1yoxJU4LVEWjOJwtkC
         pM97B92SokCx68F1rdnmYZkZjiHvCrFtxMA/MRlmEzBpgBhQub8ifSSAOYHKLuSu6FLh
         SP1bBaeBflz/ij1y4jLMc/ia9FItitZB/Knurt3cbd++Hf/kMstoVSJRGOFkN/lO4bqz
         d/3AmAGQZeMP3v6YjWj1+bNCCaDrH1UBGh5TSwZgQPJZwbidtfzJ27k0oJBqRkcUse02
         Xbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778161199; x=1778765999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9P2MUIoe45JJ2qWDf5DbrVjk/FPu8YOqLPxGiP+tPM0=;
        b=TfnGH2TcitzY9wWrRtt6/lqGgVPthqp7CocwDvfJGDTkGyeVaCI6cRd2JyA7YP8TGU
         Zlsf8e8iOOvauKegZyUwIPt+n65BXQZDmB+oFBesUixNYw4q5uGrImnvi8/9O8RjcLa5
         RWHmeFZ3hmqOqB0bDePIERd5ABRXlALlOCCC3kuC8rpIJOaNNWENTOKjt1eGbLu3rlVJ
         QTA4iSliIRhP+63bnZzzPsuXu46R3QF5fHqLuQKYDwx6J4z2BiuHdBwUuAlOzJkglLkX
         x2Xc596NuRPESUEbQMVY7pjrZyQESm92vbJtaJwUux8o84h1ym94T3aI3+oDXE0bnzDo
         l9YA==
X-Gm-Message-State: AOJu0YyLAf4gy5COAp1yRnj6wog0gLU7jZ5xFyAcL/PP2jRodiRU+JJp
	oz+KQqiuGyGzG3hZPWyJfyfGWoUY7VEnTxZ4PWH78Wu0RvrM334ioVRY
X-Gm-Gg: AeBDieuNq3fYkzqIFAR3s0ZAOy96WX4ynv6HmQ4JvTU44itRsGO4QWqARixPCsdR1Dp
	eonZbsYL8JbEiXsGEqJtWJf8KMqb6PTJp0Y/aKTDfi0jMpaNrsDGedlgM1ZU9Frcs1aZUsNm0rp
	/d3aMqD6VQlzf0Ue/iynJr2x6VIe19H0hhx9ryRBZC/vBMbqVnZK+ANu+BSZJjk97SuqCCI43W/
	NCo0BQrZNNeSiMDAo6MVJdnjNS0FjbI0En4/y+SYO0IlozAv/A44d4+v28gCi3q2zox4g28P+eF
	Hl2Aj/tS7KsQt9J28zv1YWAa9HZE4HlwbUETJ6w8oEGsX3eB++Jm+S2Htox0meLGkHxvtnc2roV
	UE18yWKIhXQ0oCVupqzQjwGVR0ZoSS18Kx5psVntarQ23V9m3ezUCKHPAmz0WVrcZ9fG2+xisz0
	ZZPd45/pbr/M5VXioLjm2zsvTXZ4QVl+SEVw==
X-Received: by 2002:a05:600c:358b:b0:48a:525b:e157 with SMTP id 5b1f17b1804b1-48e600c4865mr40157305e9.13.1778161199122;
        Thu, 07 May 2026 06:39:59 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e530b05d9sm58003145e9.3.2026.05.07.06.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 06:39:57 -0700 (PDT)
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
Subject: [PATCH v4 1/2] dt-bindings: input: Document Imagis ISA1200 haptic motor driver
Date: Thu,  7 May 2026 16:39:47 +0300
Message-ID: <20260507133948.75704-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260507133948.75704-1-clamor95@gmail.com>
References: <20260507133948.75704-1-clamor95@gmail.com>
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

