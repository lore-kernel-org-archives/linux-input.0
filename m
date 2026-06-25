Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31EC37CD41
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 08:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782375506; cv=none; b=ZkA1rDSODkwMIqtP7vUHe1GAYmOJvYOAbkNf8QgjUtN3DhCyooOgR6fTpNLe3kxE0cpET8croH8Xh0tqcTuCBQfOFEwxBwzbNigylhZ64v8iNlMNCq4rkWg5p7FQn5dZ4hs3aVxdytyOZ7pT+T4Jnt2CzENjtnJUH++roNJ9gQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782375506; c=relaxed/simple;
	bh=DrNGeBlRxTjZoXBtwt3WHPiWKByZ7OZ+6oYAQENqEx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Njm4VOZo0IsHUejyAiw63Cwf83TxV0QhYp2NXnfGqTXT7XiKKUvadS12ikuM0i6dn/svxawuJz7OOZAma3GsjXz85mKXkexujf1UyC8XSH2cbQmlU14YrXznoGFpaPnOS5x2e1jxVTFRgVtolqRL8vEstiOrYNf1WksShtYqdWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlD21WPN; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlD21WPN"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa68d7d757so2565180e87.0
        for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 01:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782375503; x=1782980303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFT7mMG9k0k/BXen8CQg8hnB8vdYe60xOPZB+uYBrVs=;
        b=JlD21WPNP1Ay8RyI+NL74dU3x+qHS5m5q8XRzWrZdGNynQLiWmdB1AwrPnIu0w/7jl
         bAI7cDQS/hKbRvcWhclL9rGGlxASL/tw4PqFUIZg+AXjW5pW9M0CYQ7tjKbE2WFo2D21
         hgooOyzsEWu2NU9Pw2LeXrsPytS61Vt5C4z5jr1eq0F6m7NXvhHSXoiiL9owVrefIO4d
         aqdSSNva50OF9CKiYNbZuRH2ftKGICC7N+mnb9zJD6D2A+ErT9VL98neRFfW6tB4DUza
         4Hv5Jjrbdgm1E+pv6GAGFOMX1styUN3rbFjkF++JVmv7dssDiSxTuqma/rWp5CsG6qkP
         ZFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782375503; x=1782980303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KFT7mMG9k0k/BXen8CQg8hnB8vdYe60xOPZB+uYBrVs=;
        b=lSIn8hhrqPE6y6vD6iFedaUbYj+pYPf3ODmEGmmsUJlY6cp5J0JQ+Y9kGtdyw5tTB+
         UJHAmiXGuwmfTBds4da8UBHR2rB5a9Ntf5fUovA5unGsIRcTt8kwbLnTcm592DHC9Ezn
         fs6uzLuNAtYaUzTBrUVppfG/jEOqYskD0m7fPSC5Crk/AyrhVCpGXq/xGM7k0nTCLDks
         Mtga+5OIkq34+fAvbzdmLsP/31ED/hUbXgavkkxyW0NdJ7o8Xx3jM7nAkRo5mExOeYTn
         dJQrIyVx6WB+xVAwVsCp67UIHgqkniTYVPrIj8KDkMp93IEGaMRu4kRp/SrGoK89dvNC
         gQGA==
X-Gm-Message-State: AOJu0YztDjYBcrCw+dme4YlN/bHS7Dc7BoU4o9u0O55TazKXF89MJBmK
	DKAvHTfN0fQEigzqfkoXPvzJXC/s/1x+uhu8EEzBKIAFo/5qBShqTRSB
X-Gm-Gg: AfdE7cnIkL1gjh3NahbQKEMK3Oap1lFO3WpR+WZU/UUcyDmrVrmYVXi0TedOiIn9lbU
	aHoZYXbh3CxL4rBHs19aH86nwmy6gBb1y02p4pszQHE0bLsqJQIvn4NNj8137LRm6Md/Pdk7xW1
	mnvIqSNDxXSUBA/3CmKMKT1VttqlyfxTKLe7PeRENiquhCR9Nbzb1Asob0fCQWUu8temjmdmW5v
	vYHx2NnApoLLkPsJFAj0dUaKz5A9d8z30eudRaZyFif+5YuVJ8EdKEX8fEbmGtEhN7jst1ZUDNh
	sCRnzsug5oV6pgsGi8hzyJ80U7FgNfDVw4OMxVfQOLH7S/TLBkSgio5x1mu+U7Fb66aZlITFiIz
	FdPnjQZr/gk6ukiQA1GDSP8usATRFv2NshqGYQh5SfIBotXNVtBs8A9ONubwlyG/pF1eFJbxL1e
	Hn1Kvejvg+Kses5MqEDz+ocEu+51QuoSYiSw==
X-Received: by 2002:ac2:43c7:0:b0:5a3:f25f:cc30 with SMTP id 2adb3069b0e04-5aea1f4cc39mr319980e87.32.1782375503093;
        Thu, 25 Jun 2026 01:18:23 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad6957a268sm2464601e87.38.2026.06.25.01.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 01:18:22 -0700 (PDT)
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
Subject: [PATCH v6 1/6 RESEND] dt-bindings: leds: leds-cpcap: convert to DT schema
Date: Thu, 25 Jun 2026 11:18:07 +0300
Message-ID: <20260625081812.33474-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625081812.33474-1-clamor95@gmail.com>
References: <20260625081812.33474-1-clamor95@gmail.com>
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

