Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15134657DD
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 09:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627834; cv=none; b=NeFmoccTCjDQ1e+BVdBkzgwZiOep6ikYUIeLsS1wHB9hr/6sSWcwPp+FHE923j8gvM4Yes75xgjt7eWFnFaddjMeKPKkk5NTp9iU1Mhsg3d8w3IRaU5rxamA0MVXWiPT9twhGzhSQKkMUjEL9U4BjzAZEK44Y97q6UxSU6/M1DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627834; c=relaxed/simple;
	bh=RBDHYLiiGGp3BaQ8/XtDl9OWbQotU9JbN3S+l/s0tUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZ2GycU2XTidMu6MFZfPoK9G/72+Yde6xwzun7IjM5QhDkCxWJvS2maW6G+d6bsQ/kJVqTV4Iv42NvhdYo4bDaetEDwnSs0jweOu8EQfFBb10bbvcbQn1EOJiV7s/it27lJFh8qerwBDYl5h8WRcKbug+vyXKaniHeLerMELg4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwxNAxRn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwxNAxRn"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4955158f26aso18167295e9.3
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 02:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784627831; x=1785232631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qQ1n8qBbrRCl6/QmqbC+EltxCalkkOGHUFrRH2C/N8I=;
        b=UwxNAxRnLMDLNFc2iGRELsDv3XCzrgvLKW87DAPZPO4ItUi6lFROh6q7nA1ZSGWAH7
         1YMUApgVzLsfTid2oTNUO4PsqFNpcz06yxQi7EbOtDDKzyt3uZ0cy7dNWYPNDWBOnQPE
         1M/qoM6TmMePbZWO/ZRCsGzjgmNg55kCRctwg3t7WlrEotqsSoT4HT0QXn3VVzGpO7Lj
         hSYAkJPEHOk6S0ZRCffApDbnhWHkLsYi7C0JoVOb0Mv84hUCVZewO1C9bsccDzC78IxI
         Smxj9fsbKgb/IeduTaLhkulNcYjBqmfBE4k+1NSyJ/yEyHQE2xJ5pmPv5fcNhh65qeWs
         VYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784627831; x=1785232631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qQ1n8qBbrRCl6/QmqbC+EltxCalkkOGHUFrRH2C/N8I=;
        b=mJUPBDY9n16Ytk2Qw7we01wz5lN1Aqa6d8MvqRlAV3e0QiGal3cUFM5FWRJD6sEo8i
         2rBd/P0n7ScnlmX2Pkvk6Ry5bnxDRyRdJp4yUUDIno2hNsiBd63Nf0Gl3KutDyl1ABpO
         AIgG4rEnNCL1rfThr2uUJlOE5hV4OsmiNE1BAVh6KU5dlq6pP1VRtI+l8+nij0mi1GHo
         pFd/MtttSF5g5Yj2bwY6l/DW5aLyahLLycseQGh17IZQeigNsoyTuJZflyexjKAciDGR
         KUZNmbpe/n8IGO6JbTr3OWHnmwMK0r0kQT9w1MiCgpWm4AJ/NDWQfHbXE42aAyGyoA1E
         AgTQ==
X-Gm-Message-State: AOJu0YxEb8vPqvbmri2iPN50aSyko6VY50IdtfVT2idZV3WUwiFJMVDB
	HkyfTr1stAwaRoml85XXJPJiIF/xButV2lkG76ewhuLg9SAM2n6xZElQ
X-Gm-Gg: AfdE7clQUtVadRpO34dyuleAzHW5qLcTDJ0eovFP4fiuFKAwfXIVcinivQvsDoMvft2
	55wZ/zJfmrzbXu/ZqO1Gf1aHAufkZ7KavVsjAgWcaaLu8cu37yGTDcb8TInMIu75a1PLuvoPLCL
	DE1l0qfIcS3fiTasGuSspXwprJc8oU1COUGYMsu/JE5ua1QTodzTTBAQV4rxz4ZoP3J8nJ/rLD8
	xMxjKhYjZ6a5tEnX7J+31wwoaCy0X7GrIfJNfiXr8KTDYWAyXwb7npPiBoIocUq0wUvfH6rt+3O
	Ad+DYTToNt13A6oGW84ApUl/QbWYFl+ec60gp9dNpFdiK91IR7HjgGpoKXb7qtsXcPIsdKMvd/y
	0fjKf6IN1aMgi62f3qBiCHrH9sMzCJ+hX4KdzSw8Wztobve3pTMMHYVO5raTZH1EeW9I2yOrpJY
	COaY5jDQsF/Ne6xulpqL9zsDg=
X-Received: by 2002:a05:600c:1f8e:b0:493:f639:9b2f with SMTP id 5b1f17b1804b1-4954a513f80mr185203615e9.39.1784627831197;
        Tue, 21 Jul 2026 02:57:11 -0700 (PDT)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954995b78dsm227476185e9.0.2026.07.21.02.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 02:57:10 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v7 2/6] dt-bindings: input: cpcap-pwrbutton: convert to DT schema
Date: Tue, 21 Jul 2026 12:56:49 +0300
Message-ID: <20260721095654.429346-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721095654.429346-1-clamor95@gmail.com>
References: <20260721095654.429346-1-clamor95@gmail.com>
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

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/input/cpcap-pwrbutton.txt        | 20 ------------
 .../input/motorola,cpcap-pwrbutton.yaml       | 32 +++++++++++++++++++
 2 files changed, 32 insertions(+), 20 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
 create mode 100644 Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml

diff --git a/Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt b/Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
deleted file mode 100644
index 0dd0076daf71f..0000000000000
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
index 0000000000000..77a3e5a47d1ae
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
2.53.0

