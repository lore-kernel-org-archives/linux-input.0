Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4CE34A79F
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 06:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771828757; cv=none; b=rFrRvtHg/Jk6y3+6Fh0N2vXUeNbvySnwrkYFjNpbErLGc6cGyQ0x0rAkXCaWCWCq8p0nlqts4KcroEsxxOkRvueSlPFHBN1ovYl94Wi17ByhepV0VL1X315e07pxs+DX8MK3ComO+luIeROpSQ13R1Kk+QGA0+CedZEgFmJgd64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771828757; c=relaxed/simple;
	bh=+xCYYkFGQ4JgB4ICZr6PyE2V+kBr+3lOCPplqVBjWes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBBLBz4JxK/vM8GC2D57rXI/MYMlu/MhmEtjIIEdrQoM41SHZrw+7XZpwYr4PhoSubHgpEMwtSPZTenBpU0ZePFkPHpAhGZ/jqBqyl1TSB1cqKC2qwEOar4z/TJ2FbkL8oXxribgtoEmUFg5qizSqgC/SztzIJv4KE1yqQztpJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eo9QYRJ3; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eo9QYRJ3"
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-59e6c181402so5032038e87.3
        for <linux-input@vger.kernel.org>; Sun, 22 Feb 2026 22:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771828754; x=1772433554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLyVcjdxnN/By9KBCrGjy5x8Jg9Sn7LCgXxWdazKspA=;
        b=Eo9QYRJ3oQ+cWNy1xyZ218YlS+X/rJmtiE9RBqrb/h7Vqwudy+DzlA+hPcrR3EZ/DW
         RgXkvfiUpPhqg6Fa36OFFhaOPSUHe3GtHSh/DtpGMAQRH8DAJKhig+jxGvue43afS75h
         LPTKhj4yZ6hI3IZrTzRnCrL8o45ywqCY73W5KSOGypAJQyqEEL9yBjBDSlmt3uoFNWsa
         eT4CgDunHFq2IJYZ+BL3qsFsGMNZ3sd9UXEKpZgbDZuew94Jn4CjG+sGZY3t28GOm/Sd
         icW0sUfUf9sw0h51U+0qFJ8v0Uv/cgkWF0yE1TNYvjVOU35OsNk7EuzzDGzzuY2dkRTp
         Pg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771828754; x=1772433554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MLyVcjdxnN/By9KBCrGjy5x8Jg9Sn7LCgXxWdazKspA=;
        b=MPB6t38hoPE/g5x9mUWFMDxAszvqZSHwflLilp78zs2VBDCWyKegr2BjJIxZ9aNuP4
         R3i7ZAH5y8a35JMGmzi3wYMcf9Dhy55TC25Se2eunm9zGuXOw3Xsto6jcFIbh8PCGSnH
         d4XIPx0GroCcwdE8j9c9I350w4VLNafKsVYY5DVpzv1VdMA1Tv7g+tb2jzkHPxFB5mUg
         okmsZ5e48kmnNrzAZkjQG6q4MN5oaoFAk6H6M1cLse2BofundotwSZf83wce0hfcJD1T
         e1nj/8M7l2IdZn2M3k8LgV62UNqdDOERVjPSkVnr3bdh3Rl/gV+E1CrENQegzFSR9Rze
         MUUw==
X-Gm-Message-State: AOJu0YxZscihkhw0qI8ybiHZ6uR9f799kW+d6zxucYm3jBGhCeUVlvnm
	SeyMZ4r3+w41cwDsF+//TP04R8Cxn6q/e+4fcJzBlU3JrDTDwE5A4SMo
X-Gm-Gg: AZuq6aIeRNLsIxcSNbzoKMkLGtM1Vi8+VGmgzQuX+fB4mMhsk1mFb3iUBD8jmpPrsdh
	b3gCEF800QYCqceYVNJJ/Z6Vl0Y3OHaweJte4YtsqwFdRoVzlVbhbxIiSjQMDunTxnW+2DbVj7Y
	karJExWNRZymS/4E219X2a8uBVICJsU7Frg1cS4yy997SPjmqR3CLBPGthxfAG0nqBLxUwuWE9U
	9Ab8klOJ29Gap644MiNYRADFCX9nEG480dCXR8hDXBIMc4alIg9T9gwEsNHMwuMfk8StVt4kAPM
	V5qMwOhVkESU5Ze9Uu9qDwTvBoCeEJ/iakEdd6dWyTHQAirQDC+4DVxHIxwR0z16SDl/c0DoS+k
	L8FfbLHNfZpy8PI7betT266325eiLhLrbS8d68qoB8XBmqftslLP3CrHAmPBU9PPhjHYQwI6Ut6
	VCu5SHM+70+kznytaiEhEXySo=
X-Received: by 2002:ac2:4bc1:0:b0:59f:84ed:f1d with SMTP id 2adb3069b0e04-5a0ed87df5emr2535363e87.14.1771828754254;
        Sun, 22 Feb 2026 22:39:14 -0800 (PST)
Received: from xeon ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb13abbsm1369626e87.23.2026.02.22.22.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 22:39:13 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v3 5/9] dt-bindings: input: cpcap-pwrbutton: convert to DT schema
Date: Mon, 23 Feb 2026 08:38:54 +0200
Message-ID: <20260223063858.12208-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260223063858.12208-1-clamor95@gmail.com>
References: <20260223063858.12208-1-clamor95@gmail.com>
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

