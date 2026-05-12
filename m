Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF414395AF4
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 10:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778581501; cv=none; b=aTyoSw7J1271Hph2c9nZAud7/8kibu2+Vml8yOocLlTcR005qOVwjHQn68nrxqy8mcW0IZFXFoQN2w1mRIJtz42IwiPU/bvAWOg2JStJZjSRCg/yDlEftxr1zLf6heNu7sFLvB3AUZdqmQUcxCZLkxvykRJEGapHLNWdpVqgPIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778581501; c=relaxed/simple;
	bh=2FvmENfO/vJaQsVl7EbFhKjZmzyDq3pCbM6bhuL7kxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLU0wzWGwbQ6lK7jjycbRqOBQrxGjrLzrnmMm9htqDAQUgukYBY69WDI735VApUMAbldcVAa/pSiXmVHQ39Kr2iiGI/wJbYuD0wJs7qE/d67HWfRlOdJxFYxDmC9N5CQqtixxuEAWhdlDUUtadtQHz7oXuUUxyIO3DHVZTKo6NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iycS1VOY; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iycS1VOY"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67b6a6bd7b8so10977621a12.0
        for <linux-input@vger.kernel.org>; Tue, 12 May 2026 03:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778581497; x=1779186297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9P2MUIoe45JJ2qWDf5DbrVjk/FPu8YOqLPxGiP+tPM0=;
        b=iycS1VOY7A5bWmTQflphlEzjlMbAYvjYYf3faCUBH9IkwptnfF2adcDjhKKe1QIxYL
         eLqyxb5hdfTD1mzUchDtL6PxAxXZH/hczYvAyMsQJCKFvOwZ5QOcuLo49mlgrSA8ZiS9
         DdWyo1mCASn7ovoNld7DzvpkkK22hKt63X5619FUlt8GDvT0L9PHhRVQXJn746ala9dN
         LVRJtvebpuCXvGg/L8kz9y9Nz8iWnBbhI1VhOXYsYOGOARDRuVHyrWO6tgP1tFKsujbj
         PFurkVzi6ggqfvoUMUCnEZHIu6jisRP588DAniMTAOfSNr2Cza3vQBpS//Cb3BMgWuav
         dGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778581497; x=1779186297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9P2MUIoe45JJ2qWDf5DbrVjk/FPu8YOqLPxGiP+tPM0=;
        b=qGqWdQV36sUU2BI1ofXQ8xoTBbEbM7+LXcn2GxbQ48HKEceJT4293VwzgGkVM6f7gV
         UZ0cLasNWTDbUKF26uHziD9xm5Zfcitt/V6ChSSeDxOw5pdSXb4lX5A8MyFNaWota2La
         6nMjPf8JjIBvYCEhxxkhUyCW2XMxQg2KVN9bh48ln6m8K7k5OOmF/yiCcVMIg84l0TUh
         mR+UREi/TsMsaCT+5OZ05WdM6Cwx6ehzYUO3RgM1kWex8Z7JPyKYPo/MLqARhbsIJFgL
         iudK8m5XK0CoEZf5RV/W7eT310vXyM+bE/JHtykbMM5XCrOS1VBtzMRTsiuXe47qdUx1
         cfSw==
X-Gm-Message-State: AOJu0YxPXt7lqi0OZdhmlyVHdfrgdYjZp8iVuihIAX9h+6p2hC8uEvqN
	IwwDxb4mTqhS0hI0ClNkZ0ZLjETa42wSdAiqydQ591WeI4KvJjxLrJ3I
X-Gm-Gg: Acq92OF5o2inWgdfpMgrc0t8CD68cWGlt0KjOq0JlhKFuHoPObJHH6Tk7FniyI4+cb2
	nOYytGN3NrDRtXwgfX5etlnuhoIjyRA9kYvb8n8Ur8viKrpteYnMUL1Dffaid+pIbBrW2SF+6Iu
	owm1NecR71hXcdPCtYk8tytUdNU5ed8ebQqxzlSW7H24SIaHuX9/uhas89kaWtAhqmyy7QZLFNQ
	Ojbxq/l7KFHS3OGvkEjqZMqvjmKs057dt6vjh5f9D91HnPGy+WX0GHngSOAQtqamIwQ0EJTzoGG
	LUSVwh6RHVdVWmSQ7U9FtFaWtApXJW0pkqEVtWBNBe8ewgycA755TMCg+6YQnoKptTvPqCn5JFo
	PtAhyq69VNC0dlvv/AYOh29ykydT4JgJkauN+teg7wTJtw8xNEE7sYmPqDGAmHEDuB7dmhdleTW
	yE3Mc3W3Rwyedp
X-Received: by 2002:aa7:da55:0:b0:67b:e6fd:2ece with SMTP id 4fb4d7f45d1cf-680b360195amr1194037a12.10.1778581497009;
        Tue, 12 May 2026 03:24:57 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67ef0b6a534sm5032792a12.9.2026.05.12.03.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 03:24:56 -0700 (PDT)
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
Subject: [PATCH v5 1/2] dt-bindings: input: Document Imagis ISA1200 haptic motor driver
Date: Tue, 12 May 2026 13:24:44 +0300
Message-ID: <20260512102445.55372-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260512102445.55372-1-clamor95@gmail.com>
References: <20260512102445.55372-1-clamor95@gmail.com>
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

