Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304643A6400
	for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777390600; cv=none; b=DIhZXOnPba6rW2ANq0jd1o/3v9Qkrg48dt/chNqQRyu7fLtu1gFHemysGQLpoW5j4oLY3+tephRHNGpEFDYSe57B8lJDBSNaIRO9/LOkwK+D8i27JZcIHDxFHRRa/lEtqy1KL+jku/3xLA9N0aX6RNdMpQd7IUbzK/RGhQFKVsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777390600; c=relaxed/simple;
	bh=sJYSHWc09xFtiXGLxIY3eCmrqPgEujr443cRCV1hpP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cra3qZOnmc6Txunfn/t+iRe4Zj12gmRrLmouSzQFzs4b4lCYeB/0KZd7cOVgeUg2cEN8mzu+BcA+0vfZYd2iSWbT+ZNiJd16jff4WUQnNAJWA8dv/rH1TZ80z3DjYrCxzLJkbUrKmKe342gbsVCmDDNMtbUyZF/0Q7KsZrWus98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKQxq5RZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKQxq5RZ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48896199cbaso114187835e9.1
        for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 08:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777390597; x=1777995397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eV+WP61ShKOblE3anHz+BLN4XFN+aFPa0yNq3Cy5s6A=;
        b=lKQxq5RZnkQ4Hi3yGJe+jF39DGat91RyckNI+sUpdg7kG8ih0pSRMGlSN6wE/xPoJB
         XZQBA35MHWCkYVlGgs8Jg6vYIOVkWRzzR5Bp5Zbd4Cu6Wa70pWNPEhGDQ8HnWfJcgvbo
         0NvxOqbvbORZTRL7hQIHKjAobwwiv8X6Vbs0JxXIn2U1yKbGz9nZtLxb1Hh6GkLyhzX6
         wSLnFMt67jwc2nOAFKE3uYH1c3KIJLKMsZxBFh2KQ9rG0Tt23HZbus9So7q3ZEckLDlu
         6PkAaBgqDaibVHLW6/vXUxAifQLuLDiuTPXpNrHA0cMhqa6ZZCG4xK2Nrh2/2u87L2kl
         BFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777390597; x=1777995397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eV+WP61ShKOblE3anHz+BLN4XFN+aFPa0yNq3Cy5s6A=;
        b=NstBrz1lgh02VtPJsFJwIGwu5P3CScPySrjqw2ELAgfmT6tO6Fcr9shnnfbjtbfrwp
         HYmor8pSqiaIzgoT40AbraZOhIy0XmyTRxqtYMxH7ouEypByjx4HxZlQyP+hluB30W5l
         ddgy/2vyykJD9gQa7IZhOzKU4ryFhHj9ewyaTS4afSFp8WdoO23tzkWd8wdDvGaQG2JI
         JoXU7gSkJZhAl8XYjmYCwVZbJRmD1M8Hh9E4+v2i2C+CZLrXsXVSTUrtjCiNHsFrEozO
         doirnx2ei/GMzttbNbftG5tcsWDWZYI7ociusZIyZNaRg7D1MXWKbmDVgsPC67K9BM08
         dJCw==
X-Gm-Message-State: AOJu0Yw0hF5/DfVzJXab5C5Duhg+y2u92SnFB8j3yA68D7BwIs7MV1Q2
	BucXUdTJEvxJqDBPuQ8afN2jsD1kxxh+xJ16MZ3spdS8IYE2WMIY3pJl
X-Gm-Gg: AeBDiespgs6nsoe0yHEndP8RCccZf1LDfexrDXCgqTX781+msOgFT/qPDlY30rRHWYM
	/gnTtmxdihYN2jt90hIyIEmvVbyufmZXw/QDUxcmcZC2HgczribZLD1nDgk3R67vF3DtFK/ijyO
	wKzQjLzcRW2tXzArdesWBBkFxDNCUyPOV+DN0DFaoHkTLfDv0IMQECpPzi9UCUgXMoLepsQ2CFw
	PMWA3UE5RaFr5pdapMlAUS76vRnoi/hFUkohp03O2S/2n30rEORC3mphvLDH8ALis9xFnrQv8UR
	QEX0hIUjc4HdJiFyKbBQaLi7Xf7zscCmd6QDAvZ/Gu2Nv/In+sT9WB7wzwvsWHGz2fFZJttefld
	CFhuhIxy/+nRdDDCk9aABVdCyGR7gb/G6TMSbvGKrCmH9CYpfTEyKtYOrbcHxjvHditIKx/Klq3
	5NwuojdR4fIiFaxLFKaV+FaRo=
X-Received: by 2002:a05:600c:4745:b0:488:9bf8:7f17 with SMTP id 5b1f17b1804b1-48a77b054d8mr51874665e9.14.1777390596486;
        Tue, 28 Apr 2026 08:36:36 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7b56c2d0sm1358875e9.11.2026.04.28.08.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 08:36:35 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v4 2/6 RESEND] dt-bindings: input: cpcap-pwrbutton: convert to DT schema
Date: Tue, 28 Apr 2026 18:36:07 +0300
Message-ID: <20260428153611.142816-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428153611.142816-1-clamor95@gmail.com>
References: <20260428153611.142816-1-clamor95@gmail.com>
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

