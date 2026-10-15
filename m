Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD6D41D640
	for <linux-input@vger.kernel.org>; Thu, 15 Oct 2026 11:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792062577; cv=none; b=SF1tSEp/87TgJjCeEMBa2x9Lj6RkTpmZVRHHHsqgKYBTAAMNzKTTFx6rR2vju0Ux0qoAXcPT0aYLLBDyxBWV0AGQ3GvnKym/JAVU/kXMDgd9wSFxTiatWeXJiflp+IiX0lELw7nXlJaFaJhaVm5EXXNMTqUcCo+tAaIS26NY4l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792062577; c=relaxed/simple;
	bh=pKxqo2a8lR7KI9kYDWC2Cr540MwQu7AcYvHikWXJN0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVVudUwy1fr9i8nyMyZmxTYTNX9dpRyyXLXCVib3QUGCG8ydBLTFgZ/bTxvpJeK2l4nyWHziNamI4fe3vUR1hJaDtckgSeky2KSPkwyOsMhw3SRc0XzC4jSYJAf+ak9hHBSg5xAj5F4tnuI8b+/5A+rf0oMZZXwHV+HL/BdyjwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGf+5lyK; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGf+5lyK"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2dd76b1361dso13803305ad.1
        for <linux-input@vger.kernel.org>; Thu, 15 Oct 2026 04:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792062574; x=1792667374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3blbaeYggHmVF464JV+Zlli+aD6d3bzh/Mw8o5F5mrY=;
        b=UGf+5lyKOwbTOvhV9L3VUYlXNw1KuVJNBXP7QEsNtQgDosUu2OIb6Z82kT2P0m7kvv
         ZE1c4e0hpWzFwR2EQfdDyKALhlf+zX4Z5I+yoxQ7hcSKJEAuXmx+McZ8X4bsCjxP/Lgs
         LKJvDDUc26UaW6cmxRYIR1vxZmLofGjOzmnr8TRsEtbompvHgjDptIFje/6RrVWI5cG2
         KsCpPosuKXLWRDOqOdRdXQ3AdF34+JXopq5C7IZaJY4EUfVjG+ierJBCQMPgX6UkK2nG
         D+oBMskOepbsqnyY1T7LtonYkuYR4dA8VcC0BHGjP0O0gMcRJoSQF4G6JT0zUQm4RFW5
         GzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792062574; x=1792667374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3blbaeYggHmVF464JV+Zlli+aD6d3bzh/Mw8o5F5mrY=;
        b=MGvOpcf5vVvuVZ+AtiGKMNy5ApgkL2drRV4JUYs1Dtv1GY+dXyVPpNpUBBFqn40ibV
         9KVI2+GLg7ocGhLkBsw69XjjOL72C7YVxo+ne3dEQbinYFE7Ykxtn9iex+/vIPTFbLO0
         MpfGRVe1oG2CDVxnIVr3JYbuHFmOI8Rtaq/jIj5xGHcfCx5aqLWJhVdEqYy/EYBI2LaP
         CrcuHXR7T3Rby5dXGy2Ia3+UuDW0utxgIlD5BLw8RlMqByegEPr+leJIwz6iOjbsSdhL
         E7oJvv2yl0/pEwobkpYxPGX15fUy1d5x4AlheDufrO/wUFuNh3q9rFFq/kJCf1P6QyqR
         QUYg==
X-Forwarded-Encrypted: i=1; AKwUvBzStynM/PT5t3HEPtW3UvlJJ5+QWOD2W9CVMcFoRA0XgH3TqGmY/S41CO6bTQCOvMZFelpIbsRnM9t3wg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKNNJ4j5jOOyq2sPCxKwu9vuZXyDwuBmaF93EKuz4Q4EU0gT6f2
	BwkDfROSWeX/a1CEYZ/fezgvo9KbeyHj3zZJtgohcTaaZAm3SgMBjNy9
X-Gm-Gg: AYBFou3sMkFbe280ywgja41Y4UQmhbIPCvDyHg2pzuCEb5EJnlNxF5sArboU6iCPbPO
	4zMfHVjqCG1oV3dZbW8qUaArgv06F4cFLAFD0j/aJl1ZYel+gPRZ8xikvnjq+ngRKjYW91L9dc+
	VD5rfSkuqYmUfJR0vhIP+VA3uOSPuJ8WcMTJvX6nr/FO3Yv21wWtHFQ+hhsJ++bTPyM3iHxMVgL
	vyQXCni3958wrNLklwsEJ9Kj8qLxnWAgiIQg9vOK01B5x17JuvM6WQLChdWr9+MngLSXIdyV4QD
	URwsAke4LchN1ezN6+R5u2KTkPGD9drxM/y4wAdzgWch+wgd5yGuv5K0+aAquPziAVIgPSQcpd0
	2KKI8ssiqxSoU/OwjiPJyS5P8L4xtNRh/CJ7K1QXyo391L8y+xl40dExYl0yiLZQJVDfOyhSrsL
	2u/0PV16WLEHdxoZ8pFqyQeiuQ0vqxaso6z3h+Pc7PIY2EjcAYM4X8L2yfL+AaQJ6zfAcnM+ib1
	Ov9EQ==
X-Received: by 2002:a17:902:e892:b0:2e8:21ee:f196 with SMTP id d9443c01a7336-2e842bcd165mr159384125ad.29.1792062574452;
        Thu, 15 Oct 2026 04:09:34 -0700 (PDT)
Received: from wyb-ms7e59 ([38.55.195.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e93f1d1ea6sm17881585ad.8.2026.10.15.04.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 04:09:34 -0700 (PDT)
From: wyibo6109@gmail.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yibo Wang <wyibo6109@gmail.com>
Subject: [PATCH v4 1/2] dt-bindings: input: add OnePlus pogo-pin keyboard
Date: Thu, 15 Oct 2026 06:08:58 -0500
Message-ID: <20261015110859.203989-2-wyibo6109@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015110859.203989-1-wyibo6109@gmail.com>
References: <20261014135251.11234-1-wyibo6109@gmail.com>
 <20261015110859.203989-1-wyibo6109@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yibo Wang <wyibo6109@gmail.com>

Binding for the OnePlus Pad 3 Pro / Pad 4 and OPPO Pad 5 Pro pogo-pin
smart keyboards, built around a Tinno keyboard MCU and attached to a
tablet UART.  Describes the supply, TX-gate and wake GPIOs, with a
MAINTAINERS entry.

The compatible names the tablet project the pogo port belongs to
(caihong, erhai or iceland), which pins the keyboard generation and
with it the protocol extensions the host may use: the 0x3A general
sub-commands grew over time, from the caihong (sm8650 era) keyboards
with neither wake notification nor backlight, through erhai (sm8750
era, wake notification) to iceland (sm8850 era, keyboard backlight).

The keyboard is a fixed physical device, so the touchpad geometry and
the product names are per-project constants and live in the driver;
the common touchscreen properties (touchscreen-size-x/y,
touchscreen-x-mm/y-mm) remain as an optional override if a variant
ever needs one.

Signed-off-by: Yibo Wang <wyibo6109@gmail.com>
---
 .../bindings/input/oneplus,pogo-keyboard.yaml | 73 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml

diff --git a/Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml b/Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
new file mode 100644
index 000000000..bab9ff3d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2026 Yibo Wang <wyibo6109@gmail.com>
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/oneplus,pogo-keyboard.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OnePlus / OPPO Pad pogo-pin smart keyboard
+
+maintainers:
+  - Yibo Wang <wyibo6109@gmail.com>
+
+description: |
+  The OnePlus Pad 3 Pro / Pad 4 and OPPO Pad 5 Pro pogo-pin smart
+  keyboards, built around a Tinno keyboard MCU.  The keyboard is
+  attached to a tablet UART and speaks a framed half-duplex protocol
+  over a shared single wire; host transmission is gated onto the wire
+  by a PMIC GPIO for the duration of a frame.  It provides a keyboard
+  matrix, a touchpad and a keyboard backlight.
+
+allOf:
+  - $ref: /schemas/serial/serial-peripheral-props.yaml#
+  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
+
+properties:
+  compatible:
+    description: |
+      Names the tablet project the pogo port belongs to, which pins the
+      keyboard generation and the protocol extensions the host may
+      use: caihong (sm8650 era) supports neither the wake notification
+      nor a backlight, erhai (sm8750 era) adds the wake notification,
+      iceland (sm8850 era) adds the keyboard backlight.
+    enum:
+      - oneplus,caihong-pogo-keyboard
+      - oneplus,erhai-pogo-keyboard
+      - oneplus,iceland-pogo-keyboard
+
+  power-gpios:
+    description: GPIO enabling the keyboard supply, held high while attached.
+    maxItems: 1
+
+  tx-enable-gpios:
+    description: GPIO gating host TX onto the shared one-wire bus.
+    maxItems: 1
+
+  wake-gpios:
+    description: GPIO signalling attach/detach, also used as the wake line.
+    maxItems: 1
+
+  touchscreen-size-x: true
+  touchscreen-size-y: true
+  touchscreen-x-mm: true
+  touchscreen-y-mm: true
+
+required:
+  - compatible
+  - power-gpios
+  - tx-enable-gpios
+  - wake-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    keyboard {
+        compatible = "oneplus,iceland-pogo-keyboard";
+        power-gpios = <&pmic_gpios 12 GPIO_ACTIVE_HIGH>;
+        tx-enable-gpios = <&pmic2_gpios 6 GPIO_ACTIVE_HIGH>;
+        wake-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 8014b9f82..9c29eb961 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20156,6 +20156,12 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-dev
 F:	drivers/usb/misc/onboard_usb_dev.c
 
+ONEPLUS POGO-PIN KEYBOARD DRIVER
+M:	Yibo Wang <wyibo6109@gmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
+
 ONENAND FLASH DRIVER
 M:	Kyungmin Park <kyungmin.park@samsung.com>
 L:	linux-mtd@lists.infradead.org
-- 
2.53.0

