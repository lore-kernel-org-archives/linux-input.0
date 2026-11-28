Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795853925;
	b=xGq+UjfYuLVQxV+QGO/5SDtR8HUPsnwJCN6ZZIllODDybp82+bC7m4URZ64Rv4AwpJfi
	 D59Lzewy+g73ccjvYuN0QtgOe+hgJ30XuHyyNkD5wZTaLOYpXKW2D7ZrrVzAc7LMUqV0/
	 /4P+NGlh8GwFoa1K9cGtvCLlk8OO11gzyoLQ1TzoNSP6x3M3woy4QaCT1DBr2zbC4QhTO
	 V3S4L5ZDgyf6/RdJ/R6T16/QskNW6GtuyNAifenuiln2+7H9tb25eoPmGQH/db2gVdcxJ
	 j1NoFBXeRkqeOBnwDExX/eSysp4Og7lBYcSsbpwimfx6T8nbZmZ/3PmBfHzpShczbkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795853925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OYxs5uDpKgH0xFuFCpWuT5JmihYHR57LmroU0k+TYNg=;
	b=lYQsKQtTvcHpzGRkL73o8SlVeTva8Peqe6vH8pML45ycZ765MZrIOZRPrkil+Wb2wwgw
	 82nbdcjnCp32JE9QPqjEIg1veBVtCyT9m48q8vqKfqtllIfk6EQiHL8c+iymZFNGcD2JU
	 f1HNRzoES+Kb99yJaxWqtAOZT0e7dq7t1NPnJhUQ0aomkd5LQ5P+RpoWodGUyLbRK628A
	 capCdRTSBUTIlqfpNLuGiqFNP/LsUGMYfgpJNhqV3T6LT5iuaROC/fAF1YX8jl/fHIJX7
	 Yw/bTnH8t34dMfIXZ3BQ7IsGuDmHqvBAzFgL5Wu5xnvbN4hamQMMcFFeni28gQmcXzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o17SAo8d;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05A0606A33E
	for <linux-input@vger.kernel.org>; Sat, 28 Nov 2026 08:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F05A0606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o17SAo8d
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so4325247b3a.0
        for <linux-input@vger.kernel.org>; Sat, 28 Nov 2026 00:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795853924; x=1796458724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OYxs5uDpKgH0xFuFCpWuT5JmihYHR57LmroU0k+TYNg=;
        b=o17SAo8dtN6T/w6l4wPJRVwYOckpuXlc4NWF+jipEFUA8twjOrREZ0hhehFcC8+zJU
         9emERwxwuz1heHG3LMZOhvvQy8Uw3qrxO22p6mmvlZCI/69QyE3WJH9sdDj7csZ011w0
         H/+QPjZaXnomEG0UXFe2N3agZ+PrKVOgUhjTRFNnbA1clCjyXfOxjhpBkvsV4Cf7BiCq
         7ETfqS6aDMD+EFTRq70RCivbk25SKzQk75ikfhC+vQujmG9Xkqpr8qGyS71hh0s1jyZu
         55+bZ4cpVRK6hV0Mag5d9iSWUT1yNRQtr59o0GpRLDtWSu0ZX4TGaVEX8M16P4CfUE0Q
         Um6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795853924; x=1796458724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OYxs5uDpKgH0xFuFCpWuT5JmihYHR57LmroU0k+TYNg=;
        b=yZGRbbTzsZSWhfcfNL9daJRfqy7Z1leTFxzlLGaZ7u8lcBCQJ5ORZk8DDz0+VD2tSF
         V6LnjCm9HgNdb1J1NHUqOC92wEDaxrFaLhJTZCoXr0rDDDpOebdhKrvU5UlerbBMMKDS
         WOeXw1Qu0KLAO0e/aeBZ8M63FKQlsrImOPHCi3glFlK2DX9ldakLKNxAvqU8x1Qg+XKa
         6qXBJlFvpB6bCI+H8jCk+d23EHYOqE9gXp+ecqdYU/no5bNgL7Vx7gkeSGTw6EVnC3Zc
         STy0bSB6f0xXgZhsWNcYfL1j5U1qsJE5z/HCDCDaawYyFByIWca5PB6IoIujQFK+fFFe
         1GDA==
X-Forwarded-Encrypted: i=1; AL+hErF5Zh9XrpVmMnDVx2izWBH5qAiS0hrFJE+9yp3M/dyUSvTg7nqEO2DX8XfsRT9/9xQ/9+/d92vyywJfvw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8QWfxM+G/4zyu/LHCYher2ZBEFqTbM6mz0CID0RA/rA6+IVeFj
	hoKXoP0Cvyci2luQiR4mOpmctGEDueh0DbnoMpcM6513Vk63QAB0tVK23jgZtfDs
X-Gm-Gg: AZFdTZd32KbiWPDhxktIiDI9EyKFL+VGVoTbEPQEV1qfqgltwGR0lV2Bm1PE1R40f6c
	cENcXqFmCChV+9kptxKcK2F8LfVuxJYVbxRJBqaHBlQY53YZ8q/9XmlUbRuTPGHQo9B469UIpc+
	ojxXuIXd9ZFDuIZboxV0Uk9dH7Umeeddf1kIfvQ9mm7iy5MLGI9ySAOn37eX47oDkrxIAFrXazW
	/jN88nVzSws73sIipGY6wTm/Jni21yqO4LQMXDh9jmZ2o+vtDrasj2VONzbXyf08Ep4/2ML1moo
	QqUosggSq7ROuRI2m3CkdSDkiHgYBs0/jx/A+zvgtvSfoUO8tD77VjnqKVlOVf40Ovh+lr+cZ1b
	B6Ga/C/AnWLPnaEYD55TxL3ioclrfsK8W3Nnnjw8/TPiV24EkrscJpYPXirm1o7DhXa1z8Vn81L
	PlBgMnM7KVi91GFx92ckyo0JOExuhxsXVsJG/WPGFqPTxnTnjVG0X4ZlWe8lhho2I9G/5bHVN9v
	txO8gO7ywgvgNX2WZcHVy7Rd4WnUTq0qZpdtlQfj3pB2YM40J4rrH6Nd5tK5wn/hjxn36jNiMEl
	jZPaKA==
X-Received: by 2002:a05:6a20:7489:b0:3dd:d729:c62c with SMTP id adf61e73a8af0-4014df5e9b9mr30546154637.54.1795853924162;
        Sat, 28 Nov 2026 00:18:44 -0800 (PST)
Received: from wyb-ms7e59 ([2001:df1:7880:4::50a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde7f91c6f5sm11550749a12.27.2026.11.28.00.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 00:18:43 -0800 (PST)
From: wyibo6109@gmail.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yibo Wang <wyibo6109@gmail.com>
Subject: [PATCH v7 1/2] dt-bindings: input: add OnePlus pogo-pin keyboard
Date: Sat, 28 Nov 2026 02:18:34 -0600
Message-ID: <20261128081835.366128-2-wyibo6109@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261128081835.366128-1-wyibo6109@gmail.com>
References: <20261128081835.366128-1-wyibo6109@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
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
the product names are per-project constants and live in the driver.

The binding documentation was prepared with the assistance of an LLM;
the technical content was reviewed, adjusted and validated by the
author.

Assisted-by: Z.ai:GLM-5.3
Signed-off-by: Yibo Wang <wyibo6109@gmail.com>
---
 .../bindings/input/oneplus,pogo-keyboard.yaml | 70 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml

diff --git a/Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml b/Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
new file mode 100644
index 0000000000..e76e82ea6a
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
@@ -0,0 +1,70 @@
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
index 8014b9f825..7730128d6c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20163,6 +20163,12 @@ S:	Maintained
 F:	drivers/mtd/nand/onenand/
 F:	include/linux/mtd/onenand*.h
 
+ONEPLUS POGO-PIN KEYBOARD DRIVER
+M:	Yibo Wang <wyibo6109@gmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
+
 ONEXPLAYER HID DRIVER
 M:	Derek J. Clark <derekjohn.clark@gmail.com>
 L:	linux-input@vger.kernel.org
-- 
2.53.0

