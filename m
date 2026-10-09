Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697264BD103
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 12:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548474; cv=none; b=i8WMVYZOtyTZgEWfqWcf513LZyOpbV0r93xi8vsJMiH2O14f2OoKd7Gyh3hZ53vdF/At4mWfP2Tzl/jqJINnZYyVUZi/nkRTf2DMlON32/nrQgMHAxwKTVMPb2vOi6eyQ5dGRHjgqUwkcfC0s16NqahfB2lkOtxzq2upwtaKuww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548474; c=relaxed/simple;
	bh=DxUv0mvssxN3iJhOpegrRee7xWpW2o1yHuPk8Cu2DW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTz+ee9H07nzdBZu42+3jff6ED1pMDd12ToengbCf8Yl8PXEQSYYIarfmrJYujLX0BKDEkqcjzcsUweLi4c2hvXNBGtaKEes5ri764pxc1hiFoZZAkZNYOzDY+zB5kSwMFAStQDdt/r/3YEtKQEogVa2shCPOcPys7/Bx+NSYTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSbj8JKG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSbj8JKG"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2df982e04c1so24493385ad.2
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2026 05:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791548469; x=1792153269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gs2kW6mPfU0JJJVaVDYl+M+hweObzydf3vfAXZLYSp8=;
        b=SSbj8JKG0VG9obdGXHSm1fLWklGAMIpt0PIrJIKjkddSQ9Tzk6EwpfH4Sn2BHRYAj0
         UcGooJbhuhenL96ZZB0+uuR3fmmG2+vWVog28bsEieMqarpm4xxWCok4gPT8Wqjy293b
         1dSGwN3EN9wdxhMNHOwbsofqxTOHoEDdD2vhUElLLzoYyw+r5LNG3ClW1rX05Ikc9QPJ
         6/GkDEu7gj+E16GZsaAb+BIye2k9APbpDrU8hX/yCQowjAg2oat8BGzEmMylV84bfeEo
         VlESBjDqoXTT0bn1zBCYW3gxFy/7Et5Vif+ZP30g1jt/VerC3FfJmPXM0fIP6wHeS2N0
         YM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791548469; x=1792153269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gs2kW6mPfU0JJJVaVDYl+M+hweObzydf3vfAXZLYSp8=;
        b=TdAiXmMEAMMPPXQJCi5hFU4sMRIW9veuJaFCjl/xis3GbQUAFOsyNK0wTllWRZ7DH2
         VHYOiCLX1a3ydvio/zkBTqAaOR8VGNcGYJLVnWPUtyhbBlpuGPetOH8hCFXspP0izxwq
         ZdwLsN9z+ILmBjIuJiejVofjNi18HQ1v1yIE6IQWIEivHArQRW6yyf4jDcagmZZ3FgRx
         gvJFX4ufSjneB86gxun5gHnz3mfwo4GUdnK5CRN8tnMS2sRpYv/PqgYOZjiMIMYSG8lY
         mzpJiK6dVohh/g/KQn0vyWyV+IdJepmKe7FaYpWaqimMn1ogF0F8/dXYLtV9nOAr6aM9
         nY7A==
X-Forwarded-Encrypted: i=1; AKwUvBwp5dHAIWYDNbIoWtbKzttIn1vCjr0jAoEGvjops0Xi6NyWG6tLoxD1pvb6EWVMXDhN0nj7fDHbj/djAA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJeBippCFbGGttOOmUCTfk0HFg/+dlUej2fENFYw8Kp5cFUZ6fI
	xbLA1sllJi3UjnziB/g+O8r5J3wIDE/WfAecGLGFcPwznUX20nMo7Lrv
X-Gm-Gg: AYBFou2V/G+r4ZabsBrkHkO6NAZrQ7KjaC0doFbHu50MPdnO/rHlSoH8DJ8KJI3TlNN
	UHv6ytM7TKJlTC3p92dnLw8qi6yH9vSqvPedCykYi1+M+Noef8/dMYWlUPm0+USok6cs8Ctk4da
	hQYeDWTqcUfqZuZO8KRiYQCzoLGQBlzE4D8M5mrEjPGpbtwCQiB83zP71DoeeQ4GxzVOit3O7af
	5s0n/xjCFq+QgUMOI4NB7t4We2OiwRX6zIu0YVznhWBcCD/HObcXJcJLTt/UEHUpaJfrzWIGIFc
	eOrlUU1xNld4PYKeAswv9JXZssQI7o2zbNN9Bg214Ni/cjjyULrfCweer3eRD+RwCnjNQBqxUpu
	Du5RvAmBREnAFWEDOE4bMIVcb8rZog+AVqH9EY9x8PVdA0Rj+Y7y7oI3wiAxdrgtXY1b54uU99A
	9wD9MA77oqT5F6o65eTskr6TghMpuYS89cpKPdPg4T+9pLpNOLyOT0Od1EOSkwNTVw2978DmcEY
	r6iQA==
X-Received: by 2002:a17:902:ef49:b0:2e6:c39:b25b with SMTP id d9443c01a7336-2e842ab6910mr13464835ad.14.1791548468607;
        Fri, 09 Oct 2026 05:21:08 -0700 (PDT)
Received: from wyb-ms7e59 ([38.55.195.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8421b15f4sm7622505ad.45.2026.10.09.05.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:21:08 -0700 (PDT)
From: wyibo6109@gmail.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yibo Wang <wyibo6109@gmail.com>
Subject: [PATCH 1/2] dt-bindings: input: add OnePlus pogo-pin keyboard binding
Date: Fri,  9 Oct 2026 07:20:45 -0500
Message-ID: <20261009122046.551915-2-wyibo6109@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009122046.551915-1-wyibo6109@gmail.com>
References: <20261009122046.551915-1-wyibo6109@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yibo Wang <wyibo6109@gmail.com>

Binding for the Tinno keyboard MCU used by the OnePlus Pad 3 Pro /
Pad 4 and OPPO Pad 5 Pro smart keyboards, attached to a tablet UART.
Describes the supply, TX-gate and wake GPIOs and the touchpad
geometry properties, with a MAINTAINERS entry.

Signed-off-by: Yibo Wang <wyibo6109@gmail.com>
---
 .../bindings/input/oneplus,pogo-keyboard.yaml | 81 +++++++++++++++++++
 MAINTAINERS                                   |  7 ++
 2 files changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml

diff --git a/Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml b/Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
new file mode 100644
index 000000000..849558458
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
@@ -0,0 +1,81 @@
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
+  The Tinno keyboard MCU used by the OnePlus Pad 3 Pro / Pad 4 and OPPO
+  Pad 5 Pro smart keyboards.  It is attached to a tablet UART and speaks
+  a framed half-duplex protocol over a shared single wire; host
+  transmission is gated onto the wire by a PMIC GPIO for the duration of
+  a frame.  The device provides a keyboard matrix, a touchpad and a
+  keyboard backlight.
+
+allOf:
+  - $ref: /schemas/serial/serial-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: oneplus,pogo-keyboard
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
+  touchpad-xy-max:
+    description: Touchpad maximum X and Y coordinates in units.
+    items:
+      - description: maximum X
+      - description: maximum Y
+    minItems: 2
+    maxItems: 2
+
+  touchpad-xy-resolution:
+    description: Touchpad X and Y resolution in units per millimetre.
+    items:
+      - description: X resolution
+      - description: Y resolution
+    minItems: 2
+    maxItems: 2
+
+required:
+  - compatible
+  - power-gpios
+  - tx-enable-gpios
+  - wake-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    serial {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        keyboard {
+            compatible = "oneplus,pogo-keyboard";
+            power-gpios = <&pmic_gpios 12 GPIO_ACTIVE_HIGH>;
+            tx-enable-gpios = <&pmic2_gpios 6 GPIO_ACTIVE_HIGH>;
+            wake-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
+            touchpad-xy-max = <2560 1440>;
+            touchpad-xy-resolution = <24 25>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 8014b9f82..e978a26c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20149,6 +20149,13 @@ S:	Maintained
 T:	git git://linuxtv.org/media.git
 F:	drivers/media/i2c/ov9734.c
 
+ONEPLUS POGO-PIN KEYBOARD DRIVER
+M:	Yibo Wang <wyibo6109@gmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
+F:	drivers/input/keyboard/oneplus-pogo-kbd.c
+
 ONBOARD USB HUB DRIVER
 M:	Matthias Kaehlcke <mka@chromium.org>
 L:	linux-usb@vger.kernel.org
-- 
2.53.0

