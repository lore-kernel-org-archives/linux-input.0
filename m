Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213BA396B9D
	for <linux-input@vger.kernel.org>; Sun, 19 Jul 2026 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784470630; cv=none; b=LxFo/T/JDoS0PUIvwkJHREMiTnQbfMBQmeNFakgXdL13lSY4yXekBP4MW2+IK4BqdsSDeaI/fwVT05fSZ8/0uCdOE2k3nvoulMlnSy45NPpE9sULQFB9g7CVn96V1taZDZ8BWLPfWRA4cKVWswM8AJNvCPJcQOlPqyCyerar1co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784470630; c=relaxed/simple;
	bh=SpeAbWuMzIs16vYBg+PKkHGC0eKCjEEqBJcc41Jr0Go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gXEA5SoyfQqRNko0Uf/yjSpWbyt4PUw38A9eteoHbmwCF5f8TFB3HaLgZBd1rLK+wFMzv1afKcYeRNMS0gf46BeSJuOrvZr3vj5YePXQirA3dUd5sXqtYeenLLIN/Gl9U4Gi53gQaolFG+EvlWPo30K4Pi5mHIM9uEkyC4mhA6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NY93HeRZ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NY93HeRZ"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f71156e1aso248644f8f.3
        for <linux-input@vger.kernel.org>; Sun, 19 Jul 2026 07:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784470627; x=1785075427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=flMnLVuuStL9Ibbrxu4EV+KrfuDkbDXYXGCnZSZTM1I=;
        b=NY93HeRZ8opmVeD5+KP0f3GTsTqjKHUonlk74abib+qMzi/Fq8okTI2uvaVF01TiH4
         cczgv0itZqjLTYi6CXAw4MuG3OSdivZocCS/v/XtCNqHk0bdnmEKAkjYUYxk0HM0/YfI
         /6fAVR/OoJj2rhsD24FzdwCNNCBJsD0d25hdwW9cGLEn9Y39VlydkhEt6xcI+KboYqby
         hE6Mggf4l9VGP/fXBueqc45IYGjN0QNNXSLs/AxuK7W5vAaelduW1M/Rxie1p7Uzbcpv
         EXv2jlMYv8dqI6SfrPCq7H6qTqXrnzEfL0MfFqfoyF9ZE9tHPj4U6dGWkyHPMK6rVsYw
         00wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784470627; x=1785075427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=flMnLVuuStL9Ibbrxu4EV+KrfuDkbDXYXGCnZSZTM1I=;
        b=CgAJo2hOzMoLYzbS7F1U82d/X3R9fgb1MulDK6/QLFVGalwWsQSHpfkR5V17sNB2fr
         bI9xWBrclmkMIIMP87o38gNhXOoWmsJdhg/OS7pbtRUkTmPP0JuTMiz1c1a0KMKsyVF9
         TYNvom9ye/kosxV8MXXsJjQAxEKgbg83O7kHyBvbtyEUYRhR5evZEWgaTMGlw6OpOvSF
         XBx6hTwg7kmCjhSydjYVipDKLD40fAUQzTIfG7Qb9pMTKyscE3dXJVfXyOzdgyG6OriQ
         1uo7I7308uDHiFFT54m48W/1mjatLd3BQGypPhhXNxMoXPEaqTsU8IWJH8TU0Y1QMbBT
         UhIQ==
X-Forwarded-Encrypted: i=1; AHgh+RqTzcpVPUIgvoVMKNb1xEJwIZQZEv5bRawJAA0t+OKC9czaPL4iGOgNX6BjvsfkrjA+LkPqqytlu8Tg2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ8AKHBvr40TyEM+TOc44COzscOylQUs6+Ms2JFNyHz5NxWLX7
	ff0omd48znZ7dEQwwv92veiQVoaQDjeE2Sk5d/aVPkPBfQTuPzHoAU17
X-Gm-Gg: AfdE7ckomDg+iruxHgPpMgTlozKK4vE+9/8+dQv5kbz1pPGsH52D4FgL0zD8F/OAwof
	e2KWaenvBfZ525CcJtwoq2gw1bJi5Bk11WyAJWKMo9NQxEctjtWPAun4V7cEvoloQfcevm6DFoB
	SdmXkGCblFuc97H69rAfs/CjDpXbBbeWgO4nN0phMfzOcxYztAr6wIl1ju7h+4nejPx3uKYoFku
	AnA3KlGhBFbzrcBg6KNK/XYCQcdriv+snpa/enqSMx8JogrWfuQOJQcJr0aL4SsiyWw+gHuBeN0
	S9mNJg5wKkNwvpQYdFPlsFdGLlEF4vz4fyriOUEkHM7h5ZA8kVf7Oqi0UEYAs7jP9hfZ6Pe3rxA
	A2aRs9jqf8oTizS7zcqblGEzYUklAzwPK97KAStkfVbFa38mNWqqHmUEDjFFMuOBuGFBdSESPzV
	dLKREg8IgpbnGZbO+bGBMisdpWRlRbArrzM5VXBHENwGtk0ytQpdx98RU=
X-Received: by 2002:a05:600c:6c98:b0:493:f6c1:2f09 with SMTP id 5b1f17b1804b1-4954a3d2fcdmr83284595e9.6.1784470627212;
        Sun, 19 Jul 2026 07:17:07 -0700 (PDT)
Received: from localhost.localdomain ([188.26.50.240])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4954a2edda2sm193403455e9.13.2026.07.19.07.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 07:17:06 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Eduard Bostina <egbostina@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	goledhruva@gmail.com,
	m-chawdhry@ti.com
Subject: [PATCH] dt-bindings: input: Convert TI Palmas Power Button to DT schema
Date: Sun, 19 Jul 2026 14:17:01 +0000
Message-ID: <20260719141701.3565277-1-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Texas Instruments Palmas power button bindings
to DT schema.

During the conversion, 'wakeup-source' was added.
It was missing from the original text binding but is actively
used by in-tree boards.

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
---
 .../bindings/input/ti,palmas-pwrbutton.txt    | 35 -----------
 .../bindings/input/ti,palmas-pwrbutton.yaml   | 58 +++++++++++++++++++
 2 files changed, 58 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.txt
 create mode 100644 Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.yaml

diff --git a/Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.txt b/Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.txt
deleted file mode 100644
index c829e18e1a05..000000000000
--- a/Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-Texas Instruments Palmas family power button module
-
-This module is part of the Palmas family of PMICs. For more details
-about the whole chip see:
-Documentation/devicetree/bindings/mfd/palmas.txt.
-
-This module provides a simple power button event via an Interrupt.
-
-Required properties:
-- compatible: should be one of the following
-   - "ti,palmas-pwrbutton": For Palmas compatible power on button
-- interrupts: Interrupt number of power button submodule on device.
-
-Optional Properties:
-
-- ti,palmas-long-press-seconds: Duration in seconds which the power
-  button should be kept pressed for Palmas to power off automatically.
-  NOTE: This depends on OTP support and POWERHOLD signal configuration
-  on platform. Valid values are 6, 8, 10 and 12.
-- ti,palmas-pwron-debounce-milli-seconds: Duration in milliseconds
-  which the power button should be kept pressed for Palmas to register
-  a press for debouncing purposes. NOTE: This depends on specific
-  Palmas variation capability. Valid values are 15, 100, 500 and 1000.
-
-Example:
-
-&palmas {
-	palmas_pwr_button: pwrbutton {
-		compatible = "ti,palmas-pwrbutton";
-		interrupt-parent = <&tps659038>;
-		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
-		ti,palmas-long-press-seconds = <12>;
-		ti,palmas-pwron-debounce-milli-seconds = <15>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.yaml b/Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.yaml
new file mode 100644
index 000000000000..9f64caaac00d
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/ti,palmas-pwrbutton.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments Palmas Power Button
+
+maintainers:
+  - Eduard Bostina <egbostina@gmail.com>
+
+description:
+  This module is part of the Palmas PMIC. It provides a simple power button
+  event via an interrupt.
+
+properties:
+  compatible:
+    const: ti,palmas-pwrbutton
+
+  interrupts:
+    maxItems: 1
+
+  ti,palmas-long-press-seconds:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 6, 8, 10, 12 ]
+    description: |
+      Duration in seconds which the power button should be kept pressed
+      for Palmas to power off automatically. NOTE: This depends on OTP
+      support and POWERHOLD signal configuration on platform.
+
+  ti,palmas-pwron-debounce-milli-seconds:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 15, 100, 500, 1000 ]
+    description: |
+      Duration in milliseconds which the power button should be kept
+      pressed for Palmas to register a press for debouncing purposes.
+      NOTE: This depends on specific Palmas variation capability.
+
+  wakeup-source: true
+
+required:
+  - compatible
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    pmic {
+        power-button {
+            compatible = "ti,palmas-pwrbutton";
+            interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+            ti,palmas-long-press-seconds = <12>;
+            ti,palmas-pwron-debounce-milli-seconds = <15>;
+        };
+    };
-- 
2.43.0

