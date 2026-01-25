Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B44C324B16
	for <linux-input@vger.kernel.org>; Sun, 25 Jan 2026 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769355983; cv=none; b=aHVO18iOjJj/8X8/HzVcpHuPWKFMU1MIqa+lBa4p805+d5NgBJoLZjekdaGHyaV777k7c0tJWjMqWxCSQEVzJF93S9PY8EZ1b/atQNTD7598Du09oWMZezxtvKIDsOjI/qZ8pTLid4bKPR/1g457LcIUrVUG9naPJAl9aD8mzXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769355983; c=relaxed/simple;
	bh=l9NQa79di/jjOBPV+OqER4b7B0YtHihmaNsEeJfrOXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thzXmFKRhUX8wSbwnKyztxgDoTQKqKbvcuT+BmO1yMDbHcVZsk1luYlpkmoQGYwjmNr3IN0mLlH08FLB4CuPNxWF6MfKIjnrqUyry+7hzJpBM151H/K30TGrOZ2xm6Z/Y2ACZt3HiyJ719w4UyWGT9CUpPItcJtJxvkmovRzoEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3fmAaeu; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3fmAaeu"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-432d2670932so3449310f8f.2
        for <linux-input@vger.kernel.org>; Sun, 25 Jan 2026 07:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769355980; x=1769960780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlJduHNY4/ATTPZTxaM+BbgtP/PXXrqKo+1qMJ4eq2o=;
        b=F3fmAaeug7JSKwtgWO9y0ScX6T3U5IkAfF5ARAucjIWxqoNH5ao5WLybGCozGswVwv
         f+3bvTb91treFIVH+a22cGvnlHi3m0Hk4d+xJVEmhLZkF8ALm6ZY+eWisZ3ckLC9x47X
         wXEGsF4YZhaHGTMhmEqFwL7RW8SzITieRBWocGFZuYPsVDlgZCve+ZmM7ikpFfExxW3d
         OuQadCrdNDyKmJGbrT6RdtJ/EXz8SzM/EZET8kiNv9l2lQli3BwTzpb2ob25m6G7tEzM
         vDHafM7lNWTwfYnz/YVdKTLCqZXQWF3b4r6Yf0gsek1xbaesDrz1m06i1u/T0ZRSdJMY
         hsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769355980; x=1769960780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IlJduHNY4/ATTPZTxaM+BbgtP/PXXrqKo+1qMJ4eq2o=;
        b=BCSlIf7R3iE68Xfps1K+++4EWDPuqU7yE+7Qed7j0K74LpBi7uTlcyNP4cqEG1Jv3h
         d+MgZIbXaA4X7bESDTL5hoaIrwARf4rTLfNo4kI6GRKBd8dsbNhpP/HoT07rmAqd7AwE
         4Uo4cMs0C4C9JpJCmz8DAS/wwSOC0RAlyZBoZ5PDpsGHBDkwddQLV3g0DidRv0Souh7r
         PW7hS/jetcg+V/uLMJ5boA59X9edsE/LDTfCJXq5azHwjnkeeK7iuLZd7/kZkIXvhxf4
         8xjcvC9zl08PpMR1mnruxnMQTEBd2afDVwM15izxZlNWjIVTvWbuWWkZmGgngZbzYQsg
         vlAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxcEHiZlJSwq8Zt1tWrPlB7PQf3IKx+/yYzDXnAwMR21CdSdvJYxUkHUzOZgE+rRc3XDWSnjCKMMfnkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzls67anohWqrVnbfLLCwE14zjFknD52gXkQkRbPJkXXHDp6yeH
	JmRZLQbMVI8njGw2zNE4UFiRqQ+zv0k/gg0JydvBStS7+wYILpCvmuJGdupe8Q==
X-Gm-Gg: AZuq6aKWNnITMR0yk4O3B568zXq7kdLlqAsvTsw6PlT/pWgONq/EvK4VybhKBUubxPw
	AD3jPUO+gLGaw9CFpTjy4aQy0TBQuTBNLuRBKYCsLYHadace/Si7/rZMbPGobmtqltKXgRaG0l7
	4xm4lBajSdLQyEQyK+n7WA6j1fOSJeOTWWNNalR8DubLDtX0fkx105IIvWnY/8lph6ZLTBY/OfY
	b7eZmZw0kwt4BCTNb75YZ+8hFpS94xdMVamAUCxZH1gwBLpjo8f27Ex28LoFL6pT4kD9sGiY8mt
	NQdbgUrdLGhj/Jyp7mIQl3RUUlhaWIg6shwKY3Z6arCaDCbjmsATb52CDRmyG7G3xmXLcqK2Vqu
	f8095Dy3oBcKuimF0AYbHU4P66elSr/IYA4NpgiAUFLm0fTUGJK4SA39umS25im15CFLhpXWUVU
	Lv
X-Received: by 2002:a05:600c:4f43:b0:477:a54a:acba with SMTP id 5b1f17b1804b1-4805cf5f2b9mr31969485e9.17.1769348592595;
        Sun, 25 Jan 2026 05:43:12 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c246ecsm22459688f8f.10.2026.01.25.05.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 05:43:12 -0800 (PST)
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
Subject: [PATCH v1 01/10] dt-bindings: regulator: cpcap-regulator: convert to schema
Date: Sun, 25 Jan 2026 15:42:53 +0200
Message-ID: <20260125134302.45958-2-clamor95@gmail.com>
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

Convert devicetree bindings for the Motorola CPCAP MFD regulator subnode
from TXT to YAML format. Main functionality preserved and added compatible
for CPCAP regulator set found in the Mot board.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/regulator/cpcap-regulator.txt    | 35 -------------
 .../regulator/motorola,cpcap-regulator.yaml   | 51 +++++++++++++++++++
 2 files changed, 51 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt b/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
deleted file mode 100644
index 36f5e2f5cc0f..000000000000
--- a/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-Motorola CPCAP PMIC voltage regulators
-------------------------------------
-
-Requires node properties:
-- "compatible" value one of:
-    "motorola,cpcap-regulator"
-    "motorola,mapphone-cpcap-regulator"
-    "motorola,xoom-cpcap-regulator"
-
-Required regulator properties:
-- "regulator-name"
-- "regulator-enable-ramp-delay"
-- "regulator-min-microvolt"
-- "regulator-max-microvolt"
-
-Optional regulator properties:
-- "regulator-boot-on"
-
-See Documentation/devicetree/bindings/regulator/regulator.txt
-for more details about the regulator properties.
-
-Example:
-
-cpcap_regulator: regulator {
-	compatible = "motorola,cpcap-regulator";
-
-	cpcap_regulators: regulators {
-		sw5: SW5 {
-			regulator-min-microvolt = <5050000>;
-			regulator-max-microvolt = <5050000>;
-			regulator-enable-ramp-delay = <50000>;
-			regulator-boot-on;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml b/Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml
new file mode 100644
index 000000000000..b73d32a86904
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/motorola,cpcap-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Motorola CPCAP PMIC regulators
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+description:
+  This module is part of the Motorola CPCAP MFD device. For more details
+  see Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml. The
+  regulator controller is represented as a sub-node of the PMIC node
+  on the device tree.
+
+properties:
+  compatible:
+    enum:
+      - motorola,cpcap-regulator
+      - motorola,mapphone-cpcap-regulator
+      - motorola,mot-cpcap-regulator
+      - motorola,xoom-cpcap-regulator
+
+  regulators:
+    type: object
+
+    patternProperties:
+      "$[A-Z0-9]+^":
+        $ref: /schemas/regulator/regulator.yaml#
+        type: object
+        description:
+          Valid regulator names are SW1, SW2, SW3, SW4, SW5, VCAM, VCSI,
+          VDAC, VDIG, VFUSE, VHVIO, VSDIO, VPLL, VRF1, VRF2, VRFREF, VWLAN1,
+          VWLAN2, VSIM, VSIMCARD, VVIB, VUSB, VAUDIO
+
+        required:
+          - regulator-name
+          - regulator-enable-ramp-delay
+          - regulator-min-microvolt
+          - regulator-max-microvolt
+
+        unevaluatedProperties: false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+...
-- 
2.51.0

