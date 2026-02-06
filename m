Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C4B3EDADE
	for <linux-input@vger.kernel.org>; Fri,  6 Feb 2026 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398951; cv=none; b=F8Jwq4L4TcRxhqs7wwto+hI1msIaWnP3TeBCe7c4mA2PDQgsCK7briNDzBI95TI/UmhkWnAwmY5B0q39vCbRdOplKZoM54NanYpKnJsJQD3LIgSxsBgMqR+Y9p6u1gFhTtaJeXSpQsdwtVu+9w6HT7SlyIuhPqTPNO4KCkz1+PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398951; c=relaxed/simple;
	bh=go/e5AhcYE8/Tplv0QTwdsPe/+XcWA/g3Cpb4GxDoxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qsgnv8mFgkLntbXU01hD7YNy77eHgX82ZVAa/TiH62O39Dcv9QJ3Fl3sDHQjWh/m7pyZrHrYg2xzWf889pSs0n3+/PN0ugnMwV/EGVkCXZVUEm5ZkywUeHozut4e/P8j2WfqMUlaTUl1gw0/xhc6DdvGfYRDqdGrQS0RKDA86Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgPDQKSo; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgPDQKSo"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43622089851so1828168f8f.3
        for <linux-input@vger.kernel.org>; Fri, 06 Feb 2026 09:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770398949; x=1771003749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tz2XBML6rb46dksX4n5A3OWDvNM/mO62BfufBhK37w=;
        b=FgPDQKSoeO7hVk0TCLY1PKX9esGMzueRdENXD8NlMkhpoAC9AK7SRwBD8d8rT9Yj8D
         lIrBm8Q1xCKE2BsBHSFOC064QRHVJu13cIymDL5lm3SEVsbWGgJ3IfjMp6a2kHG1duSx
         0u1RYMMlzsloWQtG2672rbxHEBzrJaqjs1BiNb7fEwpKSG8F/M02yY+o9QQRX+Foqeoo
         LIdXUEYdGwg0vOzDi7oiFtVecyl+ovePElK0EKsOLJar+JdLyHBH98w8TA+voz5bPRyn
         vcGTApga0kl835KlauHYo5MEzAZV6wGitJ9vagJdeYUeUEx6ZNjjWKa2DFARfK1PWpgn
         iNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770398949; x=1771003749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2tz2XBML6rb46dksX4n5A3OWDvNM/mO62BfufBhK37w=;
        b=Nkl+70mtI5eHdhyKq3NkWOum2tB2nZg/Ou1B/VCaJFb8AsRoYmsxM1OqTnMvunU8z0
         Q4TT7usVu/jDFFfz9n5Y2BiaQAOK1diEDY0ylJZ0SAU2gO/WWh89lgTjcQnyTWsAkTYS
         XY7nZETXdZlpe69qfZg8VMzz+ndX8xGIRIRShZn1SbEEqMn/z/sCzI+hY8eZtOTbVfZj
         ATQ7n9sb4KaiAu36J85FR/kq2crAKPp2i3xPFZoV8TWA16G1XIfuOvj3Lsn4y/nzSPgi
         ooHcIJtwvS7zdtD38Kmi4yStGfamZfBzSaQORiqdw5JewMWgiRYlQ4E99yuwtoXUkdp5
         C32Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhu47DR1UE3wxQbj+CMdJKKX4EI0CG7+LVopSSqa1qAH+HIcthD9MwU5hSy1gO7JAyJMZxa/xly0mi8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlXuF+dPznNW2ertvkzCtggtefzkyymJ2d0xPb+/vx75MVk94J
	7yePNM1xdGujpWoglDho/uDjNIGEh+4KdHBV9000GIxDw08mS30QUuSa
X-Gm-Gg: AZuq6aIxQ0TW5yp4S+G04RkxyvAdYb61DKo6NhXnbFmw5a/AwEmm9k8IlO2Dig/vfEB
	ianRP5XCX30jYR3U7ERrPk3adT5hzroteHVYpgR0UuJQQFT09cSKRE8RqDgHEm9XC2rvVnYWCZj
	swbRI8R5kcK9GWxaW15OBlovercQ1+gSE/+55hGcQTgRDOutyyHXYhL6hMSR36fb0qgkB+4VHvN
	TQ2UaEmNyGOcCe2MPLy/OpwiXIJM+dvcrXrXNxl5Rzg8QN4fGEhusHwLOLsE02ekkadDO+WFswi
	XZaTAKZU3IWZjBzX+alvGNAN5rlLa8nAGdxC+tZ9mSzDAbuwu+DBgigXg71zzVYV/cDY52XjcJE
	s/J2oQzKdHVH8qrkVUOUUbr8gFq72BjT6t+lF5u5/Ou20TeWgC6FxC/7aHLcFWOHm0EdAlDabXu
	eO
X-Received: by 2002:a5d:5d87:0:b0:435:97ab:1288 with SMTP id ffacd0b85a97d-4362938ff35mr5394807f8f.58.1770398948881;
        Fri, 06 Feb 2026 09:29:08 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629734268sm6846033f8f.24.2026.02.06.09.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:29:08 -0800 (PST)
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
Subject: [PATCH v2 01/11] dt-bindings: regulator: cpcap-regulator: convert to DT schema
Date: Fri,  6 Feb 2026 19:28:35 +0200
Message-ID: <20260206172845.145407-2-clamor95@gmail.com>
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

Convert devicetree bindings for the Motorola CPCAP MFD regulator subnode
from TXT to YAML format. Main functionality preserved.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/regulator/cpcap-regulator.txt    | 35 -------------
 .../regulator/motorola,cpcap-regulator.yaml   | 50 +++++++++++++++++++
 2 files changed, 50 insertions(+), 35 deletions(-)
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
index 000000000000..50bc57f06b51
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml
@@ -0,0 +1,50 @@
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

