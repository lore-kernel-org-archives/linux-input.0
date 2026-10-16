Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A296D486647
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792154049; cv=none; b=Ox3IkrcW7JFe86PXHvsE8JWijB/w82byzeEL83PPzdMdOisLOqB9cqMWt6LetETTohmvtkk3tZucdbWTYAWg6VHy3hi197fLUxienD1mIECwdjwHZpvVoTzQzfF+Mgp8HydyFyHSBhWmFVzMx81q/V+xpEZp4XIB5WG3P8LO9qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792154049; c=relaxed/simple;
	bh=SZWhmf9C6mUSFMD4aeE/X1ERq6k9DBMOexQWgtsKUZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uisMzz5MgPifhhCNtEHJ9f2P19EIvBzVjqJ/MfBeUYx8YDe7FK0XZU5cGPz+axJtyiU+9mrOOnL2O3/Fc+vfrXSv4JWkC9/yrW9KAYFvbfswbQdzoLbMHbxaxvnmHKRXPbO0f/moiedIxF7z0rXwYNs6jYqJp8GZpPg5sCMSHBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0ZwRQo+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0ZwRQo+"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e940d5d2beso11877215ad.0
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 05:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792154047; x=1792758847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DiYYlyF1lIbTm6X3s4KBJvrBiAMqzqKJoaNU1Rv1Vt4=;
        b=E0ZwRQo+1QdMNc7Wk0B8Gk1KlpcRNE1FYgokmKCdgwH69Ufy/mPGio1WnKrH5a9Iod
         6Y2GKOmGvu4KzPYRghKAltIy+pz9VngDbn+I9mGFos7EUWiHpYPf3+YxGejWvt+kly75
         QCeciYZ7X4oeevs67F0Xzz0rLNy5hQQn3MLN7iRKeJj4mXtdICYGxsGUdQelOVpvwzA2
         j0B+TH7tAP4EAaS9UtBPZmuAhR3ce3797be3rryautWgOMUn8PhSRfYkBfswLwEh804G
         YEmFRQdsNQTDU3oXBoaPcmv7AqC19fds2Eot11SMWcMnlBCUz0IIfY6qIcweTn6x3hdq
         7CZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792154047; x=1792758847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DiYYlyF1lIbTm6X3s4KBJvrBiAMqzqKJoaNU1Rv1Vt4=;
        b=spcW+08frnXCmhk0KgyBF42Ur6ZM3iOulMV3mzJExWrWxzu0vIjLfoDLkUwBXOXyEx
         QlLPtpRq3pzGUxphmG8KbzUPv6ptKJKOdgGAhEYkFQcJlqdKfEEhRPEXb0XDltZV1Avv
         qC+6IBga5AEMpQWLsvDERQh7epwwKuiBdT3mVR8O6p1K3ZgfIHL4pfVXs9B1Ffd6WqMG
         aIC0RF7nlYePe5Zo4WpqLaQ6ySw2sHs6v0XXTvsiWCQPo2jkc9fDVVf70fplpjh0WHpc
         XmsNmc32qMKq8pks9xdY98mL037WaV4100McA4evLSwgVpjnG/EObjl9esSpHV6/vfjB
         6lgA==
X-Forwarded-Encrypted: i=1; AKwUvBz9LrhY4XWhxJlurfkLCTHN7F0JY5Z7BlrrDxMvvBZaW829IVKcfZo1t77oLqNsCMb0RKXPcx4Nh/MeEg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIDsYWMH4a/I2ok2thkDctsSRIjOrrPds6bPlIC+zuBz/k5N8px
	F7k4YBtzZ29Yv5WfCH5t3MGpaIacfBegB7JIqYVZWZQw0bpRJcTb3Kej
X-Gm-Gg: AYBFou1aCBk64wqmy56WqldFlmOohEceYKXFXyeU40Ob0F7gkaS3BRKCahhFDP6Uj7n
	+yJwCU1gKmooj1YSZO/rv4LdbwiWIpkSj26+qVCCxfHib0YQ7ukmDMoM+auinoOrcjBxYGS6HCt
	Nxywd0GqjF8Nkzo1igycGYguvR/0eUkVTIzpmAW7WCNigFvzEaZR/QPy5d7jhx4JAPxYNHIVdja
	2JNEkI3bTJOoiyU7m64dqhcjudqHb+DLKiGUZu/cAUgbcTFJ8hpuD1Qoxcf6gCb+6lH38NDWHYq
	HzSDNA2eJsNVI7bzbmhy+vpEr5YeRblfspWg7WvtdvvxRhfClemOJhR5bUDLe4OEkzWIe9ig/7s
	PE41fNTXdekgcjScNUxxOtHCri5kNLP8Q8CPA6/kH4IA6O6VDnl794JttMTBPwwDFdZfDoh7coa
	uSaJsh/4r4uhm2PYCToGBTrXZXph1F/ytzydOadOhjZc9P5iCONaFidlnq+vFzlajD3WcPulGnT
	cZOag==
X-Received: by 2002:a17:903:124c:b0:2e8:e17d:c8b8 with SMTP id d9443c01a7336-2e8e17dedffmr131533275ad.63.1792154047009;
        Fri, 16 Oct 2026 05:34:07 -0700 (PDT)
Received: from wyb-ms7e59 ([38.55.195.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e87993esm9286735ad.59.2026.10.16.05.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 05:34:06 -0700 (PDT)
From: wyibo6109@gmail.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yibo Wang <wyibo6109@gmail.com>
Subject: [PATCH v5 1/2] dt-bindings: input: add OnePlus pogo-pin keyboard
Date: Fri, 16 Oct 2026 07:33:33 -0500
Message-ID: <20261016123334.1019257-2-wyibo6109@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016123334.1019257-1-wyibo6109@gmail.com>
References: <20261015110859.203989-1-wyibo6109@gmail.com>
 <20261016123334.1019257-1-wyibo6109@gmail.com>
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

