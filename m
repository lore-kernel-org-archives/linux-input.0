Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EBE3793DE
	for <linux-input@vger.kernel.org>; Sat, 18 Jul 2026 21:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411823; cv=none; b=YpfyFFpHWf2vVkO+SJG8P9ggPiwAYBbDPA57pp4gwPwO0w32WEqrCoSsuaDgdeXL0SuT1dWv1hFTN+Mgikc3YRewBOnSrzSdnOK8NAAe2mrDtpa9Xk2MD84Sd9eDycrrWHg0C1ApccxNq8bE2n8BuTrDqDdbijjaJhIv/rm20rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411823; c=relaxed/simple;
	bh=Hd+tupI66QuP1tLRrv+1JWvd/0wH4IvI6LIN4P/a8dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iU9InHE3w5Y0fyr8zfUT8J43ofS5mtNhERz6FxR7m3Hk0sb8RoiPo7vK1YcnV5JIzUuWBxlputD6kJ8yPfDZeEELOP3yy1alMChT/s9TffOMYF8ozyEGXMB5oBz2/3nK4XA5d1pLn41k+FFGUUHlDNSg/yigF/txK58L6rZsDqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsbNm/Ug; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsbNm/Ug"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso22603435e9.0
        for <linux-input@vger.kernel.org>; Sat, 18 Jul 2026 14:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784411817; x=1785016617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6hEJAtA2FmuGbMms2Cfe5VvNicgq5ngesjv9wLRLgDE=;
        b=OsbNm/UgKUmH5sFpZ2FcAzQTGBhgEPT9CWuSvzX2jSx4+stmpAYbcER8e6tJXIVxfX
         2cR7HFu4X0T1MO9NdTJbh9hIOslRyy6yU4I3nbf3OX2+vXbxt4Z1/bhnmfj86Y8rVZ/g
         X9mlOWd6OuuLP9+0Kk+vcViemvgX9b5YPIe8XT2x9kk4kkmZ3xPutN5ZlSz1B6qjoTRj
         UjsofnAOpI4bx7g1BoTfq0blow1A7dNfeBbn5PjntPu6GK5UfFVUa/SVYvSPec+NcxN0
         czPQifhNWt4/I9kFkcoaIW+9qn5HfL+GQe+LAE+wIUWKHK1PjCeaziiKMYBDnGMd+Yfa
         DvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784411817; x=1785016617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6hEJAtA2FmuGbMms2Cfe5VvNicgq5ngesjv9wLRLgDE=;
        b=McAvUuzTcCPuZhQwvYtu7rUnxonRTR1Luy0KUFMxV8gE4M7HaJIdYzujKaO1rW0dgy
         UuaVb5oc0AsT3zx8xB99aQTHRr5jh5d4xnUkP3Hj2FEle5PudP1ENpyxXwUKYUTYbbt3
         EIxrDSYic2zZIPLJ6CHSxCktWo8rhZ7UhvYYK1Tcmy8ars0WDBX3yo9Up35tIdIRj1QP
         Dd0cZGA9Oo/qjOygU3xQfyH6ksV1MEIYrfxBzdQGfBh7YxHyGv11ZxBFLEiIutJcuEwq
         BK561xW9uGDLnkqIv9d+dpRLxEzziFIiRI9+j7bMhGi04rpKXMxQvaga/Dn4ayA0jOZm
         imxA==
X-Forwarded-Encrypted: i=1; AHgh+Rr2AtCQSz9OTc4dB/r+sqQsXIYvIbrNV3PS1ZvwhirVyR0oInJSMYb8TlivCfiuDRrgsSLM/MYW+IpglA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjYXyaa/zq/Tl/AuvYsizDKivgcZSpHaRaAKwy7Hg0bsXwSb7X
	x9TSdQSv3w9oT0HDwtNPMr2pIgAbSEaftT4WJMyViGuz2qUSUl5cS4rQ
X-Gm-Gg: AfdE7claYlX0V0lXnKfpqszgmhCME0xh6P2PAYtSD9Gr2+69EaHxlENwzAUhkV/YwK0
	hBisJgyz1+JOXs9CCxkMNuL99Rk7xsjWye4mnQU9vs7hFxMR0FjXO9ts1GelESg+J2wUTdU2mTX
	mxSMz8kXElrb7MXFtCBwLRM/t90XcAHYMSSzOpMJ5w58bY/AfWFK8hEifjQmNsXyxGwYpNFy4g3
	7q0IDJYOxZNNUJS47HjxwxPlFGcqGDBedTi1wqACoJU4ZhJNN8lx23ea5JPFp2sMatfZBlyz1kx
	BGkQ8eDsu6pIg/GIJgubpJuHDcBcp03175t35oHYQPBF6+qSuSFLwi1Bkd1sugdUfeznd7uX5c6
	RBmBFhCX8oFVjukE0aYUGcTi2lcKvkRDRXFRoRCMsFzXP8plMbFaJmh8nUEkRMjT42aqw6UOPzU
	DSgGn+oWu8lY5IK1EhybDafc/H2OBB5ogJaAh1N2JHioXZj1GgRA5yNkc=
X-Received: by 2002:a05:600c:1d18:b0:495:3e08:ad19 with SMTP id 5b1f17b1804b1-4954aa1a264mr86084215e9.9.1784411817252;
        Sat, 18 Jul 2026 14:56:57 -0700 (PDT)
Received: from localhost.localdomain ([188.26.50.240])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4954c0a81f7sm101199835e9.1.2026.07.18.14.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 14:56:56 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	devicetree@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	dri-devel@lists.freedesktop.org,
	Eduard Bostina <egbostina@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	goledhruva@gmail.com,
	m-chawdhry@ti.com
Subject: [PATCH v2 2/3] dt-bindings: input: Convert TI TPS65217 power button to DT schema
Date: Sat, 18 Jul 2026 21:56:31 +0000
Message-ID: <20260718215632.3295049-3-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718215632.3295049-1-egbostina@gmail.com>
References: <20260718215632.3295049-1-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Texas Instruments TPS65217 and TPS65218 Power Button
bindings to DT schema.

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
---
 .../bindings/input/ti,tps65217-pwrbutton.yaml | 42 +++++++++++++++++++
 .../bindings/input/tps65218-pwrbutton.txt     | 30 -------------
 2 files changed, 42 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/ti,tps65217-pwrbutton.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt

diff --git a/Documentation/devicetree/bindings/input/ti,tps65217-pwrbutton.yaml b/Documentation/devicetree/bindings/input/ti,tps65217-pwrbutton.yaml
new file mode 100644
index 000000000000..3526d8b045fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/ti,tps65217-pwrbutton.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/ti,tps65217-pwrbutton.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TPS65217 and TPS65218 Power Button
+
+maintainers:
+  - Eduard Bostina <egbostina@gmail.com>
+
+description:
+  This module is part of the TPS65217/TPS65218 PMIC. It provides a simple
+  power button event via an interrupt.
+
+properties:
+  compatible:
+    enum:
+      - ti,tps65217-pwrbutton
+      - ti,tps65218-pwrbutton
+
+  interrupts:
+    maxItems: 1
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
+    pmic {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        power-button {
+            compatible = "ti,tps65218-pwrbutton";
+            interrupts = <3 IRQ_TYPE_EDGE_BOTH>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt b/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
deleted file mode 100644
index 8682ab6d4a50..000000000000
--- a/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Texas Instruments TPS65217 and TPS65218 power button
-
-This module is part of the TPS65217/TPS65218. For more details about the whole
-TPS65217 chip see Documentation/devicetree/bindings/regulator/tps65217.txt.
-
-This driver provides a simple power button event via an Interrupt.
-
-Required properties:
-- compatible: should be "ti,tps65217-pwrbutton" or "ti,tps65218-pwrbutton"
-
-Required properties:
-- interrupts: should be one of the following
-   - <2>: For controllers compatible with tps65217
-   - <3 IRQ_TYPE_EDGE_BOTH>: For controllers compatible with tps65218
-
-Examples:
-
-&tps {
-	tps65217-pwrbutton {
-		compatible = "ti,tps65217-pwrbutton";
-		interrupts = <2>;
-	};
-};
-
-&tps {
-	power-button {
-		compatible = "ti,tps65218-pwrbutton";
-		interrupts = <3 IRQ_TYPE_EDGE_BOTH>;
-	};
-};
-- 
2.43.0

