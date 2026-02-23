Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2798B34A3CD
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 06:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771828757; cv=none; b=EcLXZI892Otxwp09xdNWSjhhNc9lzpyc6Sovdu4ZRHVmfYr00LCBQ+nFfLFB7N6ns+Os9ZNVFx6ObdzHNwpWShLHDbqgB+6b0c6ju1B/jIih+ThcCBTYsNlMbqMahTEw8F1O5GpQOZf6PY0/dMarsTLmo9N2Kyf9FcuFX7O1G98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771828757; c=relaxed/simple;
	bh=DrNGeBlRxTjZoXBtwt3WHPiWKByZ7OZ+6oYAQENqEx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exi2J+lNC3g6hTZkPJZQvRb504O8x/idFnNb+HRcsTt0zIpeQgNFkHK/Kbbj19LO0VUlZ4i4UcaxDsLfSm7ALQu2U4qC1eE5nmg68pKhKPwiekmEdknjikLLr+LuTi1izzMStod/VqbqzncAZ6ReaHOOvVJ0Y/uR9cR8jnvGzpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2eMHGEA; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2eMHGEA"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59e646a4b9eso3655424e87.3
        for <linux-input@vger.kernel.org>; Sun, 22 Feb 2026 22:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771828753; x=1772433553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFT7mMG9k0k/BXen8CQg8hnB8vdYe60xOPZB+uYBrVs=;
        b=Q2eMHGEABW0iPZncMKAdkd/FmCqkRsgrq8iKs/P5IyiMmfzC4OjuDStGC0l+hbv0Ap
         EqqiH/SUXaSsOdQBMxDFN40lH+kPKWJRJeexa1NTfu/kj66h0DLri/2veEDU/n+iFuAC
         xkBdXb8zz9RX5koHzXHltOHkkV7NgmBdJe0G9ZMmJCYVIRYu4GwqT8LOI9pxJ98sU8HM
         ejG2pL57FDeX31NiW12ahjNr07GbwJIOormjukC5FVd8lrXJPfcmCP58lVDcWdYpA+y0
         w07Ae2EVaKOxqhkgD8pdbS3fRBAV0VmJ4fcvcbUxv5OTNxb9HS3JNi5UI1UgceC4Fw/W
         M/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771828753; x=1772433553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KFT7mMG9k0k/BXen8CQg8hnB8vdYe60xOPZB+uYBrVs=;
        b=THZFy5zGjqAqlwTT2UMRyb9PIB1wJ05N1pucZ+kI+iLO+Qj0BTmAilIrmTD6ehQmnr
         S/qdJDDB8FOXBeejCUyBS3otkVgRvTsQWMBFLX5drifYQhgNKT80BWF3EWsNWGKqk9ao
         dCytvMMvcBBEt8f/kXSHCTOk2RbC/B45IKScLaJnYClG/EQ9lIKVrbIzshd3443DcwiP
         n7/mb4nvnngH1A6AkygRFOJupBhVIBQ7ArDziHHi8weCVNXfm+ORkS6zm/nh/3QKZCxX
         R9w2UtGruJMdrdH1Cr3+xJV4gJ0QQTmPEdw/vWIbWHBZMUuKg0Md8yDKhOtAqPdH2Te1
         gQtQ==
X-Gm-Message-State: AOJu0Yz1lyzueRINRrF7W5n9K9mCIWLGsTv74uSQFIo9M5IK+iSzzTNh
	BJUdMklLadWcOVt7DRUabyJVfHDB1S/IAaXtSxY2j+D62y/QoF8XymD9
X-Gm-Gg: AZuq6aLvxaDLrr6zdw2Z5z8pUxp/XouCrsqcI9iBGHvsatNXgyxxOy//dT+LASiMxSg
	GG4EhyaO+ldFTQXr9HcWoCFP6luAV2h3kmLc2E74C7Dyp8jU4woN0kojVjdgj89VcyfhFyUeWyb
	i25ep6g/VHpH6n320LSEUAEY8+Sp2BC/hLQWq5vxT0IdQ4slhUycGc0hfWykEYdko3bFKza/YIy
	tw7cAUaxDo/Umksgvc7GWNrlY9D5n2G17TdI8OG07oALVZCdOWusfj12sK6XBOSobHGzwSK4KHC
	4awU84SI2lncYjL35zMPtkeVW9IkNzPWmqmoRpYHqYD7tIVSj505BH1jc5YgNK8gTfDYJb3Kg75
	et7DsMlAZGoOPxD0peV69gLOHoBGqEIX7aCB4uRmfOkuolEeRc74mBiVEqyIdqhKOV3sHotDams
	v1uqNm57JE47un
X-Received: by 2002:a05:6512:39c6:b0:59f:6e82:dcfc with SMTP id 2adb3069b0e04-5a0ed99d476mr2557597e87.39.1771828753224;
        Sun, 22 Feb 2026 22:39:13 -0800 (PST)
Received: from xeon ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb13abbsm1369626e87.23.2026.02.22.22.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 22:39:12 -0800 (PST)
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
Subject: [PATCH v3 4/9] dt-bindings: leds: leds-cpcap: convert to DT schema
Date: Mon, 23 Feb 2026 08:38:53 +0200
Message-ID: <20260223063858.12208-5-clamor95@gmail.com>
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

Convert LEDs devicetree bindings for the Motorola CPCAP MFD from TXT to
YAML format. This patch does not change any functionality; the bindings
remain the same.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/leds/leds-cpcap.txt   | 29 -------------
 .../bindings/leds/motorola,cpcap-leds.yaml    | 42 +++++++++++++++++++
 2 files changed, 42 insertions(+), 29 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-cpcap.txt
 create mode 100644 Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-cpcap.txt b/Documentation/devicetree/bindings/leds/leds-cpcap.txt
deleted file mode 100644
index ebf7cdc7f70c..000000000000
--- a/Documentation/devicetree/bindings/leds/leds-cpcap.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-Motorola CPCAP PMIC LEDs
-------------------------
-
-This module is part of the CPCAP. For more details about the whole
-chip see Documentation/devicetree/bindings/mfd/motorola-cpcap.txt.
-
-Requires node properties:
-- compatible: should be one of
-   * "motorola,cpcap-led-mdl"		(Main Display Lighting)
-   * "motorola,cpcap-led-kl"		(Keyboard Lighting)
-   * "motorola,cpcap-led-adl"		(Aux Display Lighting)
-   * "motorola,cpcap-led-red"		(Red Triode)
-   * "motorola,cpcap-led-green"		(Green Triode)
-   * "motorola,cpcap-led-blue"		(Blue Triode)
-   * "motorola,cpcap-led-cf"		(Camera Flash)
-   * "motorola,cpcap-led-bt"		(Bluetooth)
-   * "motorola,cpcap-led-cp"		(Camera Privacy LED)
-- label: see Documentation/devicetree/bindings/leds/common.txt
-- vdd-supply: A phandle to the regulator powering the LED
-
-Example:
-
-&cpcap {
-	cpcap_led_red: red-led {
-		compatible = "motorola,cpcap-led-red";
-		label = "cpcap:red";
-		vdd-supply = <&sw5>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml b/Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml
new file mode 100644
index 000000000000..c8e7b88a05cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/motorola,cpcap-leds.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Motorola CPCAP PMIC LEDs
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+description:
+  This module is part of the Motorola CPCAP MFD device. For more details
+  see Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml. LEDs are
+  represented as sub-nodes of the PMIC node on the device tree.
+
+allOf:
+  - $ref: /schemas/leds/common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - motorola,cpcap-led-adl # Display Lighting
+      - motorola,cpcap-led-blue # Blue Triode
+      - motorola,cpcap-led-bt # Bluetooth
+      - motorola,cpcap-led-cf # Camera Flash
+      - motorola,cpcap-led-cp # Camera Privacy LED
+      - motorola,cpcap-led-green # Green Triode
+      - motorola,cpcap-led-kl # Keyboard Lighting
+      - motorola,cpcap-led-mdl # Main Display Lighting
+      - motorola,cpcap-led-red # Red Triode
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - label
+  - vdd-supply
+
+unevaluatedProperties: false
+
+...
-- 
2.51.0

