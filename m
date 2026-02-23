Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FE0345754
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 06:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771828754; cv=none; b=BjgNnLmMZuYIsluO1DVDHfJ9lGACA11dcSuHAjtXS2mTnKqG3R/U/TEYR2xtf46Cu0VS7gJY+jGf51H5UDSjiq6M6ETFIMcKJP3Umkk16ruer5wVF5kZ5aw70lAlvkDp+cg119q2O3xFUeTj2rLdGr4niG9x0JKHzC0CJAdlkMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771828754; c=relaxed/simple;
	bh=q8Lq6+Cvt3B/SkkRYA6XHIWjWyV8PlukszbooxWFxR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5+c/n+f5FE7E872zEIDYdS1u+O4gw+8yAEBJYn2YLHyt3gVFMJQuEDskOMMCTWrMiIJxzxMYKveb5eXzctzHr4yAtOwtGHojFcQaJvY26p2gQqiYxfDZo+2P/j1XDJilQHtBoFo3IaEUKv6JR6QMuHdV4kLanQHUlfBpeLjiJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUQAthXI; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUQAthXI"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59e4989dacdso4135966e87.1
        for <linux-input@vger.kernel.org>; Sun, 22 Feb 2026 22:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771828750; x=1772433550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBhVm8HFMDMXwYhsB0aG8oH//jaDuQqOFuWYFh+Nf9c=;
        b=iUQAthXI7eW3yNfemv5ufny2ApHP+iy+QlPJVPg1eUqsI2LPfFKjUDaK4582E+mr2t
         BhfuS7lBObeOd9GdLj3WJQ2ZiMPiu35nLckH6OiXM4W5bDNxpe1DpaZ/qxN2enWQAvUP
         uxn5z+ouJAyWi2b8Oty/2Mlt74sB19IygSfSzST3jOYoWKEP7+jLceKSpEKeFKQGgQqw
         3BvvsuFiWhAMqiQb5qeXug9ST/BClrW44NTh6DA59WzwRGyPTmAWJJx6Mb5rVZAM5VI5
         RiKKZv0zJ58e2uTpi11OyMPOf7VZat3orHqMwCDhNoUsuK+EV0CHvwPxpAu1ljsWbQDJ
         NBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771828750; x=1772433550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QBhVm8HFMDMXwYhsB0aG8oH//jaDuQqOFuWYFh+Nf9c=;
        b=DGDZiBpRNXIaAQEG/aSaJ5cqSQimo3fRpeIjXytcs8w5WRK6ah9G88xWDG5mosWsax
         iPTJn4I0y9TBYo5TE34tHusFyLy+DjJ3ceTVpv1yb/BLvDewDKgKOGC+Xz7Qhf388kIr
         8h8VMmiwbgihUeb4u8T36WnNTMztSq4kM2+0R/JOGXF9j8G+vf0Nw8ljtpPCKJzaG1XP
         Ho8BsWouFcIYVmwV2GAGTz88H2RpgOzVVmrl+PPVU66xvk3nh4SH9maMesdToQe4FNMx
         pDQYkVn683i8kFzXj63qYYG+2IJT9c41ecqpGcpFPYcqjl3zZt6r04wuVaory/r4Psh5
         7SGw==
X-Gm-Message-State: AOJu0YzILFf6tGYLQnRz5VoK///Pao/QQITqyxJ9GqLTHSwoqOCuLKBZ
	Sdqk8+KwWH01WGUfmONmRu1Vf3HnAw7T6CNfFIMVIasjapFWApW+pA6G
X-Gm-Gg: AZuq6aIaDWGNTQaJZ5z7VFF/uoLsoKvBr00sP9XHoELN6Zij18alEdrZOeY2FPmWsDR
	oGi0F1WbwGWDo5eS+4QkCQuEruSgChZzzggovzLpT0MWrU9Y8v095FQBZRVKzbBrxuPlBNEpNrm
	cZ3p3iJ4YQ6qL6KRtIJ//mSnlgKe4acOkejvY2c+Ek7PNWYDP148sjFHbrv0B/6SW5982UC0vKn
	ww1jN9zqShVKzfKIWnjfL4qKtlsrJi5AL0sIdBwcu1GCliDTh3Q11GtNNecBIDQMYvS7sBqGZ32
	pcqxo+ua1IlhS94rvIsfJbMxMgQwEKg0+rNM/kBdOPbUa6a9bugNna83GhPykCYAWr/SgpzbWiz
	JC26e2qPUxr/Wlm7uiZKInC9VQukdqCYyPHTi85rxbUW+EPERPPRFISk/+T0hDQDtX1QLYEhzUN
	91o5sUSy6MiesU
X-Received: by 2002:a05:6512:22c3:b0:5a0:f49a:353a with SMTP id 2adb3069b0e04-5a0f49a359amr282610e87.39.1771828750144;
        Sun, 22 Feb 2026 22:39:10 -0800 (PST)
Received: from xeon ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb13abbsm1369626e87.23.2026.02.22.22.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 22:39:09 -0800 (PST)
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
Subject: [PATCH v3 1/9] dt-bindings: regulator: cpcap-regulator: convert to DT schema
Date: Mon, 23 Feb 2026 08:38:50 +0200
Message-ID: <20260223063858.12208-2-clamor95@gmail.com>
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

Convert devicetree bindings for the Motorola CPCAP MFD regulator subnode
from TXT to YAML format. Main functionality preserved.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/regulator/cpcap-regulator.txt    | 35 --------------
 .../regulator/motorola,cpcap-regulator.yaml   | 46 +++++++++++++++++++
 2 files changed, 46 insertions(+), 35 deletions(-)
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
index 000000000000..ed28d2653a55
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml
@@ -0,0 +1,46 @@
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
+      - motorola,xoom-cpcap-regulator
+
+  regulators:
+    type: object
+
+    patternProperties:
+      "^(SW[1-6]|V(CAM|CSI|DAC|DIG|FUSE|HVIO|SDIO|PLL|RF[12]|RFREF|WLAN[12]|SIM|SIMCARD|VIB|USB|AUDIO))$":
+        $ref: /schemas/regulator/regulator.yaml#
+        type: object
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

