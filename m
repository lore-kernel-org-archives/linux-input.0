Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1361423151
	for <linux-input@vger.kernel.org>; Fri,  6 Feb 2026 17:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398961; cv=none; b=Lvzsjr8jX2E40IcISV0jYAAxfgtuCWGN4H940XdBqmFKkvVyMvzN5rbzJwDqj+IAGUZGXPfnpXisbs/Yy0IRKhGAQi9DrUnwMr4Ug7J6cNJtaVVa422suWMO6HorWrgNr/WGB+dA5aZn1CJcXOiJOJYBBOlarcATENEU/NF1IuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398961; c=relaxed/simple;
	bh=+xCYYkFGQ4JgB4ICZr6PyE2V+kBr+3lOCPplqVBjWes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgA89MlELskVqzCeu7f99KAr6b7Jd6WFyBfQf/9RpsRaN73SH3yhBZXJcGSzJAuMyOKzpbwuLAxfx58989/7Yo4kBS7a0y1xt6Ad+YoefY0I40cwVRaO7wAsEFG+bFDYKYaH+MzLriHDgKaXEx6JHA8Fd/emePd4DDUPkH3AzvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Riy2l0yL; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Riy2l0yL"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-43622089851so1828426f8f.3
        for <linux-input@vger.kernel.org>; Fri, 06 Feb 2026 09:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770398959; x=1771003759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLyVcjdxnN/By9KBCrGjy5x8Jg9Sn7LCgXxWdazKspA=;
        b=Riy2l0yLjmRwP1ulNGS9BVzMh/hEKtZqCbooYDKNdtnbQ0VQ8bRBTwHK8CxnJztbsv
         Lz/FJ+5gnMO9shXOrrKes9P2eIhryTUzzZ7NzJ24Se2FXx/PBSf9UM2M+6nJM1E5hrP7
         BOiXfz8edzIXP/HcRJr94XLm6TwjXLYOHezwKCd+njpvWA7z3DSsvDdmwpKZAcKUhn9L
         a2QbnJ9jvpvWV+YP7d4DxAIypNovWMP/qJvwnqNJ3N0yVhEoBRlZ+A+BVZTJz1U0uFdJ
         V9MUcmcERsmMnpY0jWr4XSQTUYRVdHJGsFh1JeE/hIhKGJp397+U6jDkoMSeGTJEodZS
         l/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770398959; x=1771003759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MLyVcjdxnN/By9KBCrGjy5x8Jg9Sn7LCgXxWdazKspA=;
        b=IBfoF2iOUk3qag999Sn6qjbmgx+5o8asKVMStMm9P+dPiQaA1pwDLaRA0R/M1QB+DX
         g2rPdETGPjY+P3WIUsCY40i+XqW5Sx1ygiGTnU745IgUazYTsdl/m/PnGgYreZbO+kOs
         PjGgugTv4ukQs/y3T4kskt8/7ZE9dA81/U1sB4tmDcNwYU1ZXCMT3pFLe3f3emsHok4Q
         D7/79P1I3weI8DPFrYIObm+cVAoGF5rbyA8saUZOFJ8TaF8IIReaOdDSKRhYRdSDqANx
         4fnjpcWOCUNciyOvQE2/Z0+e85eW3zbfeGshP9ZEaVrpwpz6JC/Tj/SqVGamqFLHY/NQ
         nQ9w==
X-Forwarded-Encrypted: i=1; AJvYcCX9ils1U+LWUpYXJLtf4tWxQuUzXn0UUn9zimHYPF9DKYUjDYM10wSyZSHIBalxptcx30VTCzR2JPXjIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyligjhCAoPYBwEhtipbjj1c/25UtXAmKk+0NI08UbEvCu2Nl6V
	f7F6PCQsLdpRhsW7dt9TFOnckkMbxrHR+CgcfO5j+4wrTawVetB+7EDf
X-Gm-Gg: AZuq6aJNPyMc3RwsFCSlD0cS493VM8Ke3RpE4357m8BrSXeKAMMNFqsCvnZNgwdEPGa
	bLYHcNwHY/TMLJCaHAmRQF4uW0DdA/Y4VBuyIr98pNEL0aUp4wjZ/kkKVZBwOnmRgkn2euifujs
	OwdwXvG4mIp1CWeMD366JUMys7q1iwz0SbAyNxkHWShZDi52atksk+Ab+zu7tRlqe8y5fxLolG+
	TePV+WWLBE4k2bLiVupNIZp0ewDSXtlVdl9S/OJ6JAwFMzK506H3OoCqZMMmYY1j9DYS+He8n81
	1d1qfA3pQPHbjTYO/iIupiA5aDg2Q2IpbW66LU8ypJ+gx+L1YqthFraMCIpNbdK5bD+6nO1hgp4
	ceNs5J7lUzp+QJvbiKoTvWmc7y6npF8reir1Ixn12Eu+Gz6hArGHoVL7/dcyY+6vxT0GfTiwHZC
	Y4
X-Received: by 2002:a05:6000:2485:b0:435:9ee1:f91a with SMTP id ffacd0b85a97d-4362938b450mr5960628f8f.53.1770398959002;
        Fri, 06 Feb 2026 09:29:19 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629734268sm6846033f8f.24.2026.02.06.09.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:29:18 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v2 07/11] dt-bindings: input: cpcap-pwrbutton: convert to DT schema
Date: Fri,  6 Feb 2026 19:28:41 +0200
Message-ID: <20260206172845.145407-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260206172845.145407-1-clamor95@gmail.com>
References: <20260206172845.145407-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert power button devicetree bindings for the Motorola CPCAP MFD from
TXT to YAML format. This patch does not change any functionality; the
bindings remain the same.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/input/cpcap-pwrbutton.txt        | 20 ------------
 .../input/motorola,cpcap-pwrbutton.yaml       | 32 +++++++++++++++++++
 2 files changed, 32 insertions(+), 20 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
 create mode 100644 Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml

diff --git a/Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt b/Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
deleted file mode 100644
index 0dd0076daf71..000000000000
--- a/Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Motorola CPCAP on key
-
-This module is part of the CPCAP. For more details about the whole
-chip see Documentation/devicetree/bindings/mfd/motorola-cpcap.txt.
-
-This module provides a simple power button event via an Interrupt.
-
-Required properties:
-- compatible: should be one of the following
-   - "motorola,cpcap-pwrbutton"
-- interrupts: irq specifier for CPCAP's ON IRQ
-
-Example:
-
-&cpcap {
-	cpcap_pwrbutton: pwrbutton {
-		compatible = "motorola,cpcap-pwrbutton";
-		interrupts = <23 IRQ_TYPE_NONE>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml b/Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml
new file mode 100644
index 000000000000..77a3e5a47d1a
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/motorola,cpcap-pwrbutton.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Motorola CPCAP PMIC power key
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+description:
+  This module is part of the Motorola CPCAP MFD device. For more details
+  see Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml. The
+  power key is represented as a sub-node of the PMIC node on the device
+  tree.
+
+properties:
+  compatible:
+    const: motorola,cpcap-pwrbutton
+
+  interrupts:
+    items:
+      - description: CPCAP's ON interrupt
+
+required:
+  - compatible
+  - interrupts
+
+additionalProperties: false
+
+...
-- 
2.51.0

