Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05B83C2795
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784632914; cv=none; b=S+wULTCOMYxJtLCf0WmB4tYGosvSle9+BFVjNDfqASq9gDrIi2tiMOp5XM4WuX3t8iCCL0tfjcHwHOAYbYjB6ViY9RMzFvK30vWJv6yNY8uO+w1FQ0Nc1+gcHZmETUfHkjzdmaMMRHSgPc5USkh7rCrm37ef8UETcBuyWwMQALo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784632914; c=relaxed/simple;
	bh=L40lap8bnY8cNJW9mxIUGL/vmblDYxgqq3QuCHt2Y+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTBzR2w8ozp/420sqSES/bgw5KBXNcRs9qE4sDEYeFm/yjzk11XqBYNl8le1+GLvSbH1BSrxsKD7wDX57k7N7CJ935cfdQHvpg9IaVoZh0agkke/Qts2Dbjr3JLzWRGK7+ZutMQv0xAGbPod5ZCH2PnIZ4rKLynHyHX6V3u2AR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glVxivWz; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glVxivWz"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47de008b020so3601073f8f.1
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 04:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784632911; x=1785237711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ux9hmvQYpNrioGxp+5tKSBKeWP1obZYcrlrpcPAFDf0=;
        b=glVxivWzwrgp0wlu9/8vj11RzqSFAQLEXD+w5UydGUTFsZG/q5GdwEqra8MfDP2Jnv
         WHmVuMjnkWiDuUp2qdMcb8Z2AGCJSQ/OQBWTv6Bx5iPmPxByLMM4VFB/OG6mrPpHESm4
         Rprymk0KJx/M78W96QeWEoAeCq/DohMPdi7xYr0NcnUCMhC+8w2MNyStAcG02tfMDm/W
         YOD6YjGqYsi8S9QIgD2w930S1AaHWc08WxTN2MybQNUaY0inWv+LIeQucIZs5XvaOE77
         uLLYu2ON0zyLhZrj6EGyuXeKiIOUPhlyPyZ3HNzcb+/5DlLQgwpL1eBZ6z3waFvV7ejU
         tU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784632911; x=1785237711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ux9hmvQYpNrioGxp+5tKSBKeWP1obZYcrlrpcPAFDf0=;
        b=jiqvORwkV+RiujR0YdlrgMnZ0dmYkAQBLyxothu2QhES8/YiqmrW8ufywi5a+yJyKd
         cHEUIb3pqIHIKzl9+aI10Ih+3yVNi2yefv+H0slKQhGd1ZUnXLuVA/FSwdLTT3TziRVH
         vvYmrlNrTTUlqpvGCwBFgo2RU7j3lJmYpLc9gjIFFspwEfC1wFiL4xyfKTe+u+iuALa9
         KxOy+Wh6uP4yyLbSq0QA5V+hbaKUk7Spc7nH1Cxaa+l0H8agsKlHnKqGqtEAqetR5FC+
         ySn8AsFvMqyz7Xie9Tw0DEA2CRu+jnlIVyra9mLR4MlxKNDJBATUVyGNKDyr8KUPbtme
         bEGQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp2YoRL0xcyLr/8ia8qy1baUoFk1AUnBPXqFPQu2hXFzKjXoSYphjU/I6vbKA9QAgUUCFeeTfOVICNA7A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yypo+ibOGn2cLfAbqAPH1ixwAKLXTx2EK+lVMCsNQW4NzbPUubl
	tVZPfoFYhLLOiTwUY9G47SLlIiQttQvtHXmet9zNyYfTWBkzQLRS9EjD
X-Gm-Gg: AR+sD10TO5y6086VSx5JJ6MOClM1ouDBMdSIC4gP4O5uDOZsdUbC5kRjUA+It4yTH9/
	6MJbluEXJ2+o1f8QqCZQlhcEi5af1IxZE38VIvYj3Y/clEB9/CvkH7pKh8Un8ousy12lza1WKtQ
	zXxZErbEAA3f46Havkm8bua4ouzRMD8UF71eShGKE3IgzxBlsoqhU0UvEXmmztwGMSUAMpMeWF/
	7+lYmbIBSW7hHY/Nf66r79s7pEybdwvtCg3lipC6OR/p6Bu9JJWoS0vlhMZ5Qxbkn8jGnNVLXwr
	bDYMx4WL/MihaPdpCg3a2zqDoTfaQiKlvF18Pd80XZEEBlATYrpSTJ76X9rJGy2b60Qag0UKSYl
	IOxvWitOGDtX17zoVxSx5nXPzrr4aMf4HBBMM1nQtJPKQ2jwlElRVslTywPnYfkKlUclaLBLD6G
	Q6JJOF3dEtKjbR/1C0sgXwCu4qltpzAXsG2YhDiimLLc/a
X-Received: by 2002:adf:e003:0:20b0:47f:7864:1b7b with SMTP id ffacd0b85a97d-47f78641d6emr6602519f8f.24.1784632910754;
        Tue, 21 Jul 2026 04:21:50 -0700 (PDT)
Received: from localhost.localdomain ([188.26.50.240])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47f63e49ab8sm40232416f8f.5.2026.07.21.04.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 04:21:50 -0700 (PDT)
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
	Mark Jackson <mpfj@newflow.co.uk>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	goledhruva@gmail.com,
	m-chawdhry@ti.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 3/4] dt-bindings: input: Convert TI TPS65217 power button to DT schema
Date: Tue, 21 Jul 2026 11:21:27 +0000
Message-ID: <20260721112133.70382-4-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721112133.70382-1-egbostina@gmail.com>
References: <20260721112133.70382-1-egbostina@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

