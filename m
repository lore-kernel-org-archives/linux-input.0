Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DF0534452
	for <linux-input@vger.kernel.org>; Wed, 14 Oct 2026 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985993; cv=none; b=tAsvPPnZ0OwM3BhkSf9nmd0wDT1uh1H51FroGhq/8gD2dzAG66prxNHPf/7ysvmMDkwhZR1T3+nJzuTjsTkUufNiCZMglJQiEx/pCH2xXyfElSCRDRKtqYjbqjepfdhsPdWpjCnurNe/u+jNdDFfEL/Bw3PgJSNpV7JWbo6tdeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985993; c=relaxed/simple;
	bh=0icqhKr6MsJgiZdcEAm0LDF2/5Cq9MdogAKND+4eIdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMDDtrmoxB4uSyjMURx9xpyAo1zvcjba006JuhH2CCHEMXINrcAqmTK8JkD3WfbNQ/LjUDUtEiSSNdeJtNapJ3V1vWsRrEBS1X8QETVv1FLxXg0q0TOFDL2j36RQHlmPIa1fmce6ucxiAViHcQY+GtNsc44odB7PcAACEwlKfXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q0p9CEDO; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0p9CEDO"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc7d154ec4fso1558197a12.0
        for <linux-input@vger.kernel.org>; Wed, 14 Oct 2026 06:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791985989; x=1792590789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wI86ONB8uqjA0vZcYHaXMUTTr01KnzjoyVx6R5+2APc=;
        b=q0p9CEDOxKGhdA7O65f3RgtI+RrlnWjGH7MTM0TD3kJOf7Ea5a3MPUbPgWzf3qYVBm
         N042UFfv6dnOZHCSLesOLUahCx93DADCyFnVKwX5S40Ajxe7IZH6nseIiMEJi3m8Ddzr
         av3E1svvjyPdqN4HTi/g4hYsb+xp22b/9AmFNz/YZUcaEDQX9B0cYKqoWjY8OGWWkKON
         fwqE/AZqxHiLlJws+Fdp0OKFA6Chuctl9eEwM7gk95F+4S8jlzLf8fIzcuqzw/rJpUBW
         IdQZ/4OIqHox2Kj2QbNvx5UZV7drwZZjWUOLmZgX86U9wh4i/YIaQvrHFpK4nFyG7k7M
         h6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791985989; x=1792590789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wI86ONB8uqjA0vZcYHaXMUTTr01KnzjoyVx6R5+2APc=;
        b=mq5pQ/uT07oULfWQefYWm8JVLFu0bk9i5qQaPZcLjosW6m5ZpYYM1RX0PjwaZz82nx
         7mlbO1WaQ5/iahXTUpAnDkLk1x9bgVJAEtNNqfd4RYhj84jLtSW3w6mEvtO6WfGyYhLp
         dI+r1Th7RFpazUZlQ5M3+F5KGMUHLpsKf6iBRwwKQAFty6otiiYmdukRWH27C1CXkDMw
         5ehGj+IDcm8Lndw2oqR/eaYajC2hYsLhypx/BdBPfUTEPXDnfo0YKjVCBd8X46fa6YYQ
         NDGPyvz9PXZw1NVqhWa/v7gOTNGsCWoWIJdM7OBl8Nx8MDRtm/maoSLIkmq5pl9NljDY
         RPxg==
X-Forwarded-Encrypted: i=1; AKwUvBzjU5ZLDPT3p0uRvrMgd5ExgA33PSG1SPac2laEpaSDAhHH0LT7VzwvKYzNlY/C9i2XfkAFeqcbBiRrTA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9rsbJT3P6AwqjZOhuCZGKTKyJtqicKP0B60kwPe3BatQ5fR6d
	3N4he4ID55nP/dcU89wJ3GD8KsaI0Xlb2A9nksBX4ByRaB7Gmc0hGbpqYDXhF22DAkc=
X-Gm-Gg: AYBFou1KiENwFe8YLhSe3HtR8AHHZHIMz4T94/Wm/YqBKcvsweShu0xtrcLOAdAq9xJ
	i0X4QomwUFVo/nJ/uFmlnIeNGiIg+hNlXTkZnFVXXYQGxSRy5G1KmwSYiRcR79iGig+rOBySWx4
	JlF39Cw5q2RJ3aFhmY5l3p+9zIZqixqYKibs5lz8yfOWS2Z2AhcbYuCuwCqbXasIBzFjjm6MfzJ
	DQqqt+xbxW++GwqrP9M2sjY2WG1grmUxkDCJubXQrPsxbA3rmwJYAyacsl83e6WWhARoHE/JcKJ
	Kkh7p/YW67bpehK3pkokJoWRgwXpfLZ5zj/ip6QGu0e2dI6nMb271VgSYJBk6ZjiaKKeh8gCN9Q
	Ao5sZb/y7/hSs+JjqwZBRCHgYWGv2beHkIYQeyiZ2eyMfXBvXxaKpxn1LL4fsRmJ92e1xFgm00R
	knLfWxgABid4SsqrCEFpimp1QMacE1UGnKzzgd8d0OhuISQzETPOP++WYs+9TkBMZPgEeuf4rpX
	NhbV+s=
X-Received: by 2002:a05:6300:6d90:10b0:3e1:6c6d:ffd5 with SMTP id adf61e73a8af0-3e16c6e02f6mr8912915637.33.1791985988869;
        Wed, 14 Oct 2026 06:53:08 -0700 (PDT)
Received: from wyb-ms7e59 ([38.55.195.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89d804e6e77sm1121244b3a.40.2026.10.14.06.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:53:08 -0700 (PDT)
From: wyibo6109@gmail.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yibo Wang <wyibo6109@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: input: add OnePlus pogo-pin keyboard
Date: Wed, 14 Oct 2026 08:52:50 -0500
Message-ID: <20261014135251.11234-2-wyibo6109@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014135251.11234-1-wyibo6109@gmail.com>
References: <20261010143836.173883-1-wyibo6109@gmail.com>
 <20261014135251.11234-1-wyibo6109@gmail.com>
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
Describes the supply, TX-gate and wake GPIOs, with a MAINTAINERS entry.

The compatible names the tablet project the pogo port belongs to
(caihong, erhai or iceland), which pins the keyboard MCU generation
and with it the protocol extensions the host may use: the 0x3A general
sub-commands grew over time, from the caihong (sm8650 era) MCUs with
neither wake notification nor backlight, through erhai (sm8750 era,
wake notification) to iceland (sm8850 era, keyboard backlight).

The touchpad geometry and the product names are fixed per project and
live in the driver; the common touchscreen properties
(touchscreen-size-x/y, touchscreen-x-mm/y-mm) remain as an optional
override if a variant ever needs one.

Signed-off-by: Yibo Wang <wyibo6109@gmail.com>
---
 .../bindings/input/oneplus,pogo-keyboard.yaml | 73 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml

diff --git a/Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml b/Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
new file mode 100644
index 000000000..fa1579ed5
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
+  The Tinno keyboard MCU used by the OnePlus Pad 3 Pro / Pad 4 and OPPO
+  Pad 5 Pro smart keyboards.  It is attached to a tablet UART and speaks
+  a framed half-duplex protocol over a shared single wire; host
+  transmission is gated onto the wire by a PMIC GPIO for the duration of
+  a frame.  The device provides a keyboard matrix, a touchpad and a
+  keyboard backlight.
+
+allOf:
+  - $ref: /schemas/serial/serial-peripheral-props.yaml#
+  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
+
+properties:
+  compatible:
+    description: |
+      Names the tablet project the pogo port belongs to, which pins the
+      keyboard MCU generation and the protocol extensions the host may
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

