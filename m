Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D503B19BB
	for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 11:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777376606; cv=none; b=Fv4/ln8Jnln0IY5Hfcynon4SekGosV7Txhi0aUZGLYDVuzg23xxg1hEDL6MmWM434EZLKxMAXt8Eu/kGHxl9INhOlE7B1RBzQ1dQUYKnnHBaFYiH2JmVzfYGpQCIvRlp/+JhSpJkkwBg4A+j7OHDntMr+SnLBwg6mELXUMR2H1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777376606; c=relaxed/simple;
	bh=rQQeryjlDPg4urwf9wsAKv6+1E3kGh1WMOFNdp3Rw3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTCmcBm1seDqTeVsQkXwJhnzhi1bUQBBtRO0UTyZemFLlf0DZT/0eRje/ySu5yK2ifbQacj8td0HkrWLus60qrU2EIXUxYm8Fp7Gxd/EQWsE9xYIl8t/oo/ubgiLosbHdTF6rMsE2pHtUw5ZmRdkK2f71zCHGaZiJEhiegNWbac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5/Lco54; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5/Lco54"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d7645adbdso6194077f8f.1
        for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 04:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777376603; x=1777981403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTrqK5wcsWCvddHoN+UD4X9AWwNewOZ8K7DocYXvyXI=;
        b=B5/Lco54OgwwVxVaHSxVce0iE16++Bc4kUeVZImsgfmDJRej9tdgL20NBTj+vfJKcT
         x/n+piliGrx7emQbLhhC3Nuy5gCo4lY9QAtTtGV4cIV5HwZh41ZMrJVHJ8tYj3Byf5QS
         pL8uvBSK2R6Q5cPqlwihPYzHLZtZPm4FbWQdATk3k3m4NJ0B9EzJaE1cpBxSFKLsJOhO
         6U6E1g/SydjFt+zRejG2ZnMJPQwtG8Z0XOiuEwyHuHcdK7N5fCxpb7kuIND++CvB3Vo6
         GeZ4/4UjZUFisx8NR/ti5TpYg0RDRQZzG3svwzMudxdAvs0iShAI/vU/f9W824urMkHh
         RX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777376603; x=1777981403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iTrqK5wcsWCvddHoN+UD4X9AWwNewOZ8K7DocYXvyXI=;
        b=ZW6YztKeI2bKC3pnMVJv5Ujca8kC5cNFGhSqk1a8yGYD1GayMOWJx/jsVb6/yvMTQ+
         raB41n8EZXT7ov0kGctY/WwO3zq82CkDl3wr2QyHBKeMx8WgaQANZBQq8nuZROWfjtW3
         B4CM6egClN3biR108kwPRKZgUtxN8IDTZG1VhPt+fsJ+vBKgC9DbuYe9Sv0cqafWW0i0
         VriooWspZ/X/6r0BCziMpDrfCFGS7xkwYwm+5dKjyZBD8t3ULk53Um/r6De12AZF5hjL
         tsM37hfZFVXdth8vLOUGf8K2uR6wIxl5hckUQwv6/aRKqs5JNKy8cppsBEpg3QY+XfUg
         AAzg==
X-Gm-Message-State: AOJu0YylYKRKGQuxBP0IZqGoA7EYC8UIx+PHlN8AO5+F1Mnxu5NT1+ds
	X0+8V3pTqHiQ1jiTh5WcqIYCSOq+9zVOI78lD6S7ZUBDD62VBD9vGr+/
X-Gm-Gg: AeBDievBCO4kr/pFISb+0qt+5ygT5Ft3+GtjPF4VqxSZ5/M1j0GlYKV80uja9C6hKAA
	7XAknuO73cAxieBvx3Y9Kr0jlNb5hQmH0xlnC/RBGaHuj+4U4UXnUYNh+x21rrK5UaeffdQse4J
	Q0x6cjEhrwqFj6iqUwG0wYy4IWBFNQK4uc3F1gHOgC3p1FqKmOyffYJ/XFxQVlAbvVg7Z0P07w3
	YUFDt5Z4SKyproMFnhmqXiHj5/kgJVY1ucmZ20bZmULzytmv+doxpmyI9F//EbmOP0BEPoxGEpq
	N+1TkdSP3dZb0cFCVNzAcujarkZMWsMYn1aZSfCFmtONJaxEFoIdSebjOSRUQ5k7SfCk9T373b/
	6rQ8eojETldPLKUVIe+hjX0CWkplY4ybiJIRoK92gTYdz/Gq6HNStElMNuy6YhyiqsSgC2KKMLj
	ARSyyO9S5YW+avfsXedH9CJuQ=
X-Received: by 2002:a05:6000:310b:b0:43f:ea91:63ff with SMTP id ffacd0b85a97d-4464761c07fmr5171770f8f.10.1777376603089;
        Tue, 28 Apr 2026 04:43:23 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463ff5a1acsm5589842f8f.33.2026.04.28.04.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 04:43:22 -0700 (PDT)
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
Subject: [PATCH v2 1/2] dt-bindings: input: Document Imagis ISA1200 haptic motor driver
Date: Tue, 28 Apr 2026 14:43:07 +0300
Message-ID: <20260428114308.113253-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428114308.113253-1-clamor95@gmail.com>
References: <20260428114308.113253-1-clamor95@gmail.com>
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
index 000000000000..40a4c7fd78bc
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
+    minimum: 12800
+    maximum: 25400
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

