Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB85D4FD289
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792168758; cv=none; b=otrAK5zHkHhJZquqLESBLnCEu03LOZ2CRle38Ri3f9JrfyHH6LTE4+9vmtaKDvfsZX6TRMo1mS3360ZFRmCpyyukXcLHX814bFWmyJjRveItgICyEx5axlYz4tSGFnVGF+dMWyULGkmS5QoJhTxrb/zP2Bsd1fQEtE/kjraUsYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792168758; c=relaxed/simple;
	bh=UrTqk122fjuebPWIsFomjpVopXMMpyx77gW8QHNBKy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1R3u0eUcuY3QzfAlw+bRLo+W4Jte4FahnTdbYgqjmShXoEc+Dact7rI9lrgU7eiHdGVqnHUaJXfxpUILs2QohGvh2CR31FZJHb2iWtjxjMMprtHrstYOTzd32U1+EmnUL43dtrJJOJnCnkkHttOLypOU1PayIaBBQ04lpMGbfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3HemHWh; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3HemHWh"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ab4178ee33so161125a91.3
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 09:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792168756; x=1792773556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/wY/9oiidFbXYRxIGG8QjryQPb39skOLzlzrFQAD6iw=;
        b=F3HemHWhnWekLc5+hQFG3ju1iGmDLkxlxMAtkOFntz7Zmc3F84/H7PtJMLBWRQCZsn
         GG4KQJePPNN+bq5SuCPuiwmNjkegeEHfH0K8cJNaHiWbwdOvkCGfwDqclr0o25ASA7Cw
         +c6OC3J58IwP4xnOHFL4E4izzKpdwh3Xoqoj9CcxsOxye3RYU1QA1qqi2dGfKnXqqA97
         kS55GPvO8DjzBt4dFEGeilKzas+9nmxiZCByr/SfmA/4ejgoAY7G1MNa6fP/b6kIv8gc
         6KrsXE2DyAlG2NoiZmzyQ3HXBzPyo1+wPqARaTCyJvf178H1SNeFXpZed84BBiws896R
         K/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792168756; x=1792773556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/wY/9oiidFbXYRxIGG8QjryQPb39skOLzlzrFQAD6iw=;
        b=A9X7l+hkt+f4f9nSR7SY8eHp2Mazp1Y05ExcTPKDuWGbY4A6XFtWyFxDvxFYpBjqgS
         4risIDmoGUHdt1k2RrCVnEBidFStqN9THl+EjqzkWkMt3tMLTqnHDJnzOi1nJSYgO0UU
         0by23jMHHINC7PbGImpuWWK0cvVy5LsEHoqjFnwno5mjYtyljb/Osh3QvbTuWJFfk7Na
         2r7khhXZbSthyDEcaplUdyw4N/34WwJ3Ns6d05gYgBUXXQ01ax3f16a/H+Xh4u5hLrxm
         dZp40Fx6DFgInw3OVMuUlBWrbkVv4RdILYVy79wF3K/WYXd+dLO5Vh3s1H0+Lkmbxg0Q
         PQkQ==
X-Forwarded-Encrypted: i=1; AKwUvBxNnKFuYOc6I/1yVAsuQBAS0SQgyD3p7v6trQuJcbxN501bS1mnzE9U39SlVgGct3ooIcFRq6LUhW824A==@vger.kernel.org
X-Gm-Message-State: AFq9FYIvrmS2gBTIT6ZM7EEa1x9yAuAYZ9QxLsdXZfx2W8ab0jbUnUPF
	uE1/Q/DEvmkxEM8ed8RpXJX35mYI00N6tsnQgxAo3lNkkQCUE2q7BMzn
X-Gm-Gg: AYBFou0rEi6Tq5g+60X/EgFDFv/U2eQpbT1qwjyCAYt2/l1yO+mrSlY7F+2Jonkh6Bv
	g2Lv6jX1gImsUX+8Hb7qgyDwVKYFBCiDI7GdWRdz6AaxTBx0q2/4ZaT35KUrBBZdOYWQQkLjWnM
	gBDWM69po/pihxCSPkKbgB+oOXNY9u0Gj27bvSWSFVpVvnkHRtWlOc/VVsEET4Df7rubQl05gyX
	jRdBLSRYUW5K22Itm/EFZRFDBS/Y3ez0s4Zu/EIxOpJtDaLGlO+LRviqT5NiOnzAZ5VdxPc/pRj
	rLlgib0SL7xRjb2sg8Xaq/sqTPyi3nedOOeDFaWEhAUtmR2mngNjI4RsKtfD6RLZ8iOU0/gW0U0
	aPBMDmwDEMZARaqJF00w5Qgj+lykJqjLDU7X/OPemGT3O2VMCPPA4U1MPgqOmsuylBVbU0xwWWW
	0rh+NHs7iF9wViqq94oPpr7zl3nos2bDKjLSpO8R/yNO+fnqdfuftn/61Ro0GJSboyTME=
X-Received: by 2002:a17:90b:4a03:b0:3ac:8dfe:8ec9 with SMTP id 98e67ed59e1d1-3acef50676emr284431a91.47.1792168755967;
        Fri, 16 Oct 2026 09:39:15 -0700 (PDT)
Received: from wyb-ms7e59 ([38.55.195.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc46ecd32sm4899797a91.3.2026.10.16.09.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 09:39:15 -0700 (PDT)
From: wyibo6109@gmail.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yibo Wang <wyibo6109@gmail.com>
Subject: [PATCH v6 1/2] dt-bindings: input: add OnePlus pogo-pin keyboard
Date: Fri, 16 Oct 2026 11:38:58 -0500
Message-ID: <20261016163859.1070138-2-wyibo6109@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016163859.1070138-1-wyibo6109@gmail.com>
References: <20261016163859.1070138-1-wyibo6109@gmail.com>
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

The binding documentation was prepared with the assistance of an AI
language model; the technical content was reviewed, adjusted and
validated by the author.

Assisted-by: Z.ai:GLM-5.3
Signed-off-by: Yibo Wang <wyibo6109@gmail.com>
---
 .../bindings/input/oneplus,pogo-keyboard.yaml | 76 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml

diff --git a/Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml b/Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
new file mode 100644
index 000000000..78d398912
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
@@ -0,0 +1,76 @@
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
+description:
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
+    description:
+      GPIO enabling the keyboard supply, held high while attached.
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
+    serial {
+        keyboard {
+            compatible = "oneplus,iceland-pogo-keyboard";
+            power-gpios = <&pmic_gpios 12 GPIO_ACTIVE_HIGH>;
+            tx-enable-gpios = <&pmic2_gpios 6 GPIO_ACTIVE_HIGH>;
+            wake-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
+        };
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

