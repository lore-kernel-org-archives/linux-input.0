Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0153835FF6C
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 12:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547937; cv=none; b=DdE7oxk0BC00hYop+BPi4ptOMaTywRcOwyRWvHzeiZhAJd1c7jKyIy4w8bj2BRCQ7riLk3x7grg4/XZfMFZg6BnzK9EdnJQRbegrrqYyh/yqb74vXRKBSwUKjzx4PnOOMAjTRsKGMhDyHN3RR276yN0TnuAO6BaNDklHuAlpTp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547937; c=relaxed/simple;
	bh=DxUv0mvssxN3iJhOpegrRee7xWpW2o1yHuPk8Cu2DW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKBvvIZBU5W71ZxRTAjhXkrey7+MmTQV1TSHxPvqCUi403CMsnp71XCyb4CcRcr6RRtgNbtbrPt8moq+KIevmXeH3/ZfACbnHMc3rkRJZgPozrLa0GszyHQ4KUWmkZM3hW2K9ImPM9vXnXHvnDdwJLblXjxTFby4BVJCZEh+uIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q7eftOCQ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q7eftOCQ"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-868b3248b2cso3357211b3a.1
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2026 05:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791547928; x=1792152728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gs2kW6mPfU0JJJVaVDYl+M+hweObzydf3vfAXZLYSp8=;
        b=q7eftOCQFL/ND2nrKQhri/Ob2QMezalXYZi2D8cUEmp4yBewe8DzaC2XNFmSFxDi+F
         DlHGJR2oo+ryPD6MyvyR6Dbpfk9WfjdOS1CobbO+w3mCZCKFg5E9GM+EtNhNrqmXvlRQ
         O/WHuqcMP6gotbStQJlOKYlloLhmeUkpUSWNlgK/vBexnsiI+GIQ+qXsT0H7UpUbVLnQ
         kL0fB429qIlcojp9+XkMPI83I6xhmib8EwXDf3YG0HMqMRtMpEuxRje/9HIEE7fxFbaW
         QD/72nXYz3n+7V1RdnQyiHFOm8p8O9eTd6C2PQClEtJZJJ/utNxonz2zLxP9jjUHFeRs
         Dhyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791547928; x=1792152728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gs2kW6mPfU0JJJVaVDYl+M+hweObzydf3vfAXZLYSp8=;
        b=lnH5Z8xh6D1nWHQvVCANDs6sQPce/nRYoBVtxnOkZGNkcYgBIOSGIV3vg46lIkc3iO
         M3gS8VRsyY+I9xRc8EbBCi1fr8vil+uP3huNsI7nRd8A7krQHqKRFHgrzTcU1dzsWcKn
         tlsYfamd45LxOBLDvFT7U4obh3zo9Gqyw4M9SXxisBvc94WlU/lLUBvtV1ySrFkLpIVb
         P5RguBOqWo1M3ZPB2sQ3HhNzves/R/iQAz6Gs22F0YFmT/if5PIZpAwZYlBReb2Uo8WO
         xKmyGb5UP8GbVKVYreorJwJynQU8vMXxEqfrNdJ5uSKkZxWmeYPW16poDPOBuFGmrv1O
         2ktw==
X-Forwarded-Encrypted: i=1; AKwUvByp97+DLW3Lu31ZimwOubkBMlNGHmg/GC+M8Ea379FmJbDyEjHLDDv4yHIZGiLYdRvI/cRnU4tha/SuBA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJoSNUYFrBZ9kPnXeKroIjVKFMVGwf+aVcN5nkAGBTAFCKSMRon
	/Y9Fj4jd+tqKrW1IVuv05lRbmoC1pgbmQAmruY1WHSdYa5sDxZs9m5Y/
X-Gm-Gg: AYBFou0vCDVUzxcC4fz8nOV7V3W4t93CSELJITRSXLjq3T9wf8LpbuIr6fCB+51nPAx
	Z+iSs7eWE5uXA+A1yKmNofP6Hs5qioPwi8hZtvhL9ZAWyjz+uRdEMQJNuGJYJQ+i0j6DYjqp1rz
	hxDsczUOVoNB1kx1cZBnPj/NpQ3Ajc928MS2eKr8FJzoYrVgzh71tOh8htffTn68sbCR3UygeK3
	MFbTpj76O0OkEhD1/81K8AnlxOt+GcJHuzzFi4vScnz3vEQR2qsOm8cs2kC4fPvgLKtGkXFxrmC
	LxsxwHR6MEUKnoCBYzvpBNc7OE4wuqMPWlXJe8zZBhJgpT0b/h0lq8ZCFKLuuLik6Eq19ECeoKK
	HjHN2+qStO9IRBuHH7PReDVsuhPt13Tvb9Zc+NwrgOHv3DnT5uM+y/xEgir3nXhyyuvftstJnvL
	kFTajwzfQICxQRBCdW6BTcc/w+C8S78bZLbDNDK5OEon3r21+INpRadKXlOW2SjR5yc767mkkw+
	ro=
X-Received: by 2002:a05:6a00:f94:b0:880:74b9:dd07 with SMTP id d2e1a72fcca58-897c8d80f39mr1466367b3a.57.1791547928207;
        Fri, 09 Oct 2026 05:12:08 -0700 (PDT)
Received: from wyb-ms7e59 ([38.55.195.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c3eca287sm786243b3a.37.2026.10.09.05.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:12:07 -0700 (PDT)
From: Yibo Wang <wyibo6109@gmail.com>
X-Google-Original-From: Yibo Wang <2024312277@stu.hit.edu.cn>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yibo Wang <wyibo6109@gmail.com>
Subject: [PATCH 1/2] dt-bindings: input: add OnePlus pogo-pin keyboard binding
Date: Fri,  9 Oct 2026 07:11:42 -0500
Message-ID: <20261009121143.550498-2-2024312277@stu.hit.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009121143.550498-1-2024312277@stu.hit.edu.cn>
References: <20261009121143.550498-1-2024312277@stu.hit.edu.cn>
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

