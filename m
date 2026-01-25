Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8ED19B5A3
	for <linux-input@vger.kernel.org>; Sun, 25 Jan 2026 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769354438; cv=none; b=BqFQmpbAnJ6bAHVM+Cg/UZFq2qYyoUIGlFWzdyotMg2fW1WPoewP6OSe/kQEbFY6ur5P8kGxc3przAZwzXNO7/xWFx/XMZ5YkDUWI9LS9F6j7F22QyTtZBg6Hd+R53CsB5Ep2EFhxigoyDHD/GvjQLs0HZOi2dr9B0N5hzzehrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769354438; c=relaxed/simple;
	bh=E7A9c27yUqkUqACBSnmKRI2cuBoHgawSFZnfB30gBd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OcUTHi7Q+9ENx5kG36fuWSitWhPoqIssnEsm1gmrRu8+OG5QLZJ+t/BVh3ooR/Vj9ravR93HDWMSwSvbwEhIZCkcNngBpOKbZ15wIs42PRMutKWewaHKL2b7I3UDm/gJNWKpBIrbtXJFRvCyGaCIUikeEp3eNzTyIkz4+eQVT9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEX+9SOX; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEX+9SOX"
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-658078d6655so7596489a12.3
        for <linux-input@vger.kernel.org>; Sun, 25 Jan 2026 07:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769354435; x=1769959235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opwAzXZXGpL/t9kjdWql8KWUaKqEP4kujq0iT4W20S8=;
        b=YEX+9SOXFs/maV3dTtVy5lbZKtf+J8m75kF47M0lFhRie4pB1ouXBs7FlZJ9B1iAxT
         CL2RxWgO/ru31TroYN+Nf6GyVBAzqQTEQUK1IhknrHri90a7Ewu12Df629PdxX1R/6nv
         GE9pwlZ2Yjibw/7GzHHSsbptdmPgex1e+W8Jeq9P3RZwpit/ohqA7FicqMaplccETTX+
         w/HZOfvGHgJ+P7cyFLBSmQ9XoFOBucbQo1/Mpk71sQncDUgfvSn52tQ7Zx1yuIics2iX
         wU8AZt4n0r7AJbFcQpSDPfZAbIFiKZjEjq5oUp4eRgQ/ch40X1e8zEzHqvnbru6qArfk
         4q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769354435; x=1769959235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=opwAzXZXGpL/t9kjdWql8KWUaKqEP4kujq0iT4W20S8=;
        b=TRkBaWa8WZJAgxEQQtlonn2SiIkezFJfe3FyTcdLoKw6Cz9ePKX0a1xlOsUi9y3n/l
         EBtl/mrbKe1fh0IMwldudJU5QsCF/AI+wvqHH+3GCCE6Srtiti52ZDR06YNo5rRGQTAb
         DCcXVXky0o0ineHLiREIuoKVT8EdfiQAkLCRRFXMoUGG85F2u81F3Zd9Z6EUb0vhV4r7
         X35Qs47Cli4QpJFueN9T8+CrFaGT0tez2PsURK+4rTYCkJiKRAN4Emn/b0lS4vGA+ZbZ
         Jr6smo32G5tv7KZ14HYdWTfr2RXHjf5bcO+B1Y1mTuoJlGaf7I5dOYlKyJNoAWW/qJ3i
         VQ7A==
X-Forwarded-Encrypted: i=1; AJvYcCX8ft1zpLWfzp3qNRMtpWiEm08/aVrPtORlFNSYU9sBXydRRb2OuUV0Nr5ZEBomjOunJ3ydRNGUtWsVUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQC0W4Nwnqfs/ja8GKIdED53vU+K8bfYmggLK4kL2JIkoSqRaO
	yT59w0sPvpPkz90j4cnJZEQ8yyBv6GYTSdsk5RFNJc8WxaDFTNXdBxRHpjkZnSbY
X-Gm-Gg: AZuq6aK8kyzBLDKO2uRjmyHRh0TbUlouJabkN/acsJN/E0YLcEMKhl/+r13tRLsYqYx
	j9APeh2TVN1U3jDi8jsRPUFwutzXGjnjGOJmN6Kq0o9VfrxzJZPCwTpG/UTaskmpRHmNb5wmyGP
	wA6OkPzYQLbHQipUKuafshFKI1RpRv2V0fC6NuiQzbmuH8tshedNVFlrOYDnMUeqISPQkQ88MGu
	a5n2yUM6Y0DhUGyhm6F9J6ek/9/cVUVF9A3xbhLEMQwHPPIcEPm2jBQZTWckuACSJDdN69t7JhL
	Z5PrEwQxf73zfQRnGoKZQj+5uMnpvXQP2s5bszBl6Aor1FJmBAFvss/h0yzNIv/PdnU+bfsAFFJ
	YIqScnhSXb6cOvKrSwYS7F8TC0VUxkcMEvH1cH9oU7vEXrvGMqOnc5J+5CkLbNPX+T5z6D4Pe8D
	FG
X-Received: by 2002:a05:6000:2483:b0:435:bdc0:48e9 with SMTP id ffacd0b85a97d-435ca1ab666mr2383866f8f.55.1769348600123;
        Sun, 25 Jan 2026 05:43:20 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c246ecsm22459688f8f.10.2026.01.25.05.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 05:43:19 -0800 (PST)
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
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH v1 07/10] dt-bindings: input: cpcap-pwrbutton: convert to schema
Date: Sun, 25 Jan 2026 15:42:59 +0200
Message-ID: <20260125134302.45958-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125134302.45958-1-clamor95@gmail.com>
References: <20260125134302.45958-1-clamor95@gmail.com>
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
index 000000000000..643f6b2b1f13
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
+    minItems: 1
+    description: CPCAP's ON interrupt
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

