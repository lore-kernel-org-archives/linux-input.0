Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793908457;
	b=jx/REwhKzVIuCD29kKWMOSQhBEgrkb7ZtESv0TtUe3h1+lykCRF5ArrR0bC96VRoD5lb
	 l/4ATdMxn5sKAnWC2XfvLnVXEbDYRwXAZHWdSXaSOYbt7FTi8mukmEI/2yxPh82KrU4DJ
	 qZ5yvBcyVXXQYb1EqA5Zutmzb9rt2he3YaUJrFvrT55G/cxJ9zXUJ7a+Atz9nXhPoeG99
	 Dc7wA8qW20jw6cPCIu3ESQk9qJl09iFF6oW4DQLMrE/FvTYPkceWqQ6zB/dSz3DlDrtbl
	 xZbKFNnpLRn5nuDc00QZGMnDc6SimoauBhy2D4z8ZEn9iwHTB3UtdMI988BTGPedJIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793908457;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=F23t8iLTcn/LXqN2lEEgBTUnPAkeyO0taUnuYVGHe48=;
	b=Yfkp9wefyS6CbUx3P8m+i0mTD/ht5c2e4CXsmfiRQlgEt089WizD6odjsb6DzE8u1MXB
	 5Q7v4Y8goja9C+HKLhl2uphaykXLzQzwt9PhqmA9UU/Vn9zT74xWEnkGch+0zLuaBbygg
	 I7XW3m4whalZczqD1s6uNMQBTSHuTQHvmAlpD+UMoUc6a1wVSlQA1jAw8R1sy2eW/krGU
	 LmB6NZOCc1knFXW/VtuP6Ug9rUD9N+G++IH+i7z+ThPInmfFZaWzEogwCP5lmXAEb3T0I
	 9JKlE++XqPAPnxmfCXnqArCqiiUXzExbUX7jaDUPs0Cb1GmjEwb9CDHdAuZcyno4iEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TLSAlbea;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC29606B9F6
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 19:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FC29606B9F6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TLSAlbea
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4b4571ff080so24860165e9.1
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 11:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793908455; x=1794513255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F23t8iLTcn/LXqN2lEEgBTUnPAkeyO0taUnuYVGHe48=;
        b=TLSAlbeaansg0obWrRFjVue5VIj8K54CuD58TZVYawDVa4jC5Uz9kGlj6X+bQBpoU0
         RMBDWWyagEX6GxxiTtav2lZiMx51AzWiDd242sMFyg0JYKbuAIclvNHGXMYeBoaF+GEj
         dO6CXIPqvt5I+wkTxKYuSbW45HO2URYgVgVt/5cuL14Mh4l1eNjAHwZeeXdu/qLd+0yr
         Ou9zJcL2JKJD9DPQKkK5QUMeAHOxDNl//pWvCBpXDBjwS9uRqP2i5lNvSNr35i6QXNoR
         vUexFPZPxi0E/3kIuJbVbmK6ODD6pGq+a/aARv0alyMkBu7IIi6a3cwcKGqYTJpDrKXL
         Sr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793908455; x=1794513255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F23t8iLTcn/LXqN2lEEgBTUnPAkeyO0taUnuYVGHe48=;
        b=h45XJFCm5DAf6TL5zgsKYc8IhlfE0V+1jhL3ltLQFsfnGAK18SJFhIMmSkaUvOqU7W
         6VrrocQN0pe0+KLEhJ/5CfwXC6EX9xKjBwXGzVPdbqscSmWn3lpkRsJVZ960IF8pOzBm
         s4ndKGuLq8YSPNtBjOZwCF2ucSEQD/2vF2/SK+3i6kpc4SDsDO8zxwkzeXPTARR0P8/7
         lJphC2Tx7lsgWMDDeB46ZWm4LV3QHdxD2tgsAmpoOMJB+OFrKvQg0wOpppxQ/ZKEMlWg
         c+dCmH9RZN1NG1Ui214khD3LHxg4MQxgJkAv8hb4ex35Dc6FFSLdVn2R53j92Ik/0ekC
         UfLA==
X-Forwarded-Encrypted: i=1; AKwUvBx96YCl7JWSPBqknf7c+VlDe6W9IWRkT5DbZjx0SRd0DAi8/VXZYjHqDhhXAS9rS1t1gw/SLesJlOWWvQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9r+ouLnaIEfxyE9mlaeTqSWlftGxZu2Xe6Kpw8srauEcjkp5E3
	zQsTZmeUbRNECuJFvf6dmisLc5/LftZBcaL4sAlpdoB25Lf2z5vqC13b
X-Gm-Gg: AYBFou2nN0wKM8FBCmvvbLqr//Olv+ySsPuOh0E1N33rna3gIxf36YZ0ZjbkS5y7QNu
	4/Wqyu3YNSKnKBor7L6AW+kpCaE9asLbThKaoSXCfeIcl4YU7SeVyav+zAh2yRzCTXBv+lkwU7I
	m+2az/7xYIZAQjEWmDKQrssQSkJ8OsCX/udXakWJ8YoKmLJMRlLZnQLws7Ru5Ri2fYdrklsMMN+
	5z6VbVrXsG62kqVJub2zJAF1O8bAhiRHPdj46v8X97lF7sNjGTz3sgJQt+b9X+1TYQ7oqY1Ie28
	J0hXyUfPVrel1L9eMJNViUPxEi/dmQB1J2cXz7MbHp6hf4Z10gAh3G5/z/cOZfONwnFJwV+Q7Nz
	OF7d2B2EIbJoTgL1Uf9wSU7MryyOzwikzojO0bJFS6ZoGtpcRHqeBU8glNWCVxSFVTX2QX0PM6z
	KuvscOhBeUGYBVe3o885m+ZpN3eobLUJtwvmXQ7G08OxBqlhjywtpXYnF5PBGYudq+JpEHOJIbE
	saS9C8hFARPHg4pabt6Y8HOUAPBVDNp1pT2Mji48T3rBxxmXILlWXh53XnnzhWRSgVLtxmVzko5
	7DkUjq1wyS6AMe0hvsn/mEMUDXHpWsLu1smCHCcE80VgBg==
X-Received: by 2002:a05:600c:3f10:b0:4a1:777b:8a12 with SMTP id 5b1f17b1804b1-4b6dea69280mr3035835e9.14.1793908455226;
        Thu, 05 Nov 2026 11:54:15 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b5725fb0d1sm83862895e9.8.2026.11.05.11.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:54:14 -0800 (PST)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sean Wang <sean.wang@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Val Packett <val@packett.cool>,
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-gpio@vger.kernel.org
Subject: [PATCH v12 3/8] regulator: dt-bindings: Add MediaTek MT6392 PMIC
Date: Thu,  5 Nov 2026 20:50:23 +0100
Message-ID: <20261105195206.3440-1-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for the regulators found in the MediaTek MT6392 PMIC,
usually found in board designs using the MediaTek MT8516/MT8167 SoCs.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../regulator/mediatek,mt6392-regulator.yaml  | 112 ++++++++++++++++++
 .../regulator/mediatek,mt6392-regulator.h     |  23 ++++
 2 files changed, 135 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulator.yaml
 create mode 100644 include/dt-bindings/regulator/mediatek,mt6392-regulator.h

diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulator.yaml
new file mode 100644
index 000000000000..d74721d8f2ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulator.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mediatek,mt6392-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT6392 regulator
+
+maintainers:
+  - Luca Leonardo Scorcia <l.scorcia@gmail.com>
+
+description:
+  MT6392 is a power management system chip containing three buck converters and
+  23 LDOs. All voltage regulators provided by the PMIC are described as
+  sub-nodes of this node.
+
+properties:
+  compatible:
+    items:
+      - const: mediatek,mt6392-regulator
+
+  vproc-supply:
+    description: Supply for buck regulator vproc
+  vcore-supply:
+    description: Supply for buck regulator vcore
+  vsys-supply:
+    description: Supply for buck regulator vsys
+  avddldo-supply:
+    description:
+      Supply for AVDD LDOs (vm, vio18, vcn18, vcamd, vcamio). According to the data sheet
+      this is an internal supply derived from vsys.
+  ldo1-supply:
+    description: Supply for LDOs group 1 (vaud28, vxo22, vaud22, vadc18, vcama, vrtc)
+  ldo2-supply:
+    description: Supply for LDOs group 2 (vcn35, vio28, vmc, vmch, vefuse, vdig18)
+  ldo3-supply:
+    description: Supply for LDOs group 3 (vusb, vemc3v3, vcamaf, vgp1, vgp2, vm25)
+
+patternProperties:
+  "^v(core|proc|sys)$":
+    description: Buck regulators
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    properties:
+      regulator-allowed-modes:
+        description:
+          BUCK regulators can set regulator-allowed-modes to values specified in
+          dt-bindings/regulator/mediatek,mt6392-regulator.h
+        items:
+          enum: [0, 1]
+        minItems: 1
+        maxItems: 2
+      regulator-initial-mode:
+        description:
+          BUCK regulators can set regulator-initial-mode to values specified in
+          dt-bindings/regulator/mediatek,mt6392-regulator.h
+        enum: [0, 1]
+
+  "^v(adc18|camio|cn18|io18|xo22|m25|aud28|io28|usb)$":
+    description: LDOs with fixed output and mode setting
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    properties:
+      regulator-allowed-modes:
+        description:
+          LDO regulators can set regulator-allowed-modes to values specified in
+          dt-bindings/regulator/mediatek,mt6392-regulator.h
+        items:
+          enum: [0, 2]
+        minItems: 1
+        maxItems: 2
+      regulator-initial-mode:
+        description:
+          LDO regulators can set regulator-initial-mode to values specified in
+          dt-bindings/regulator/mediatek,mt6392-regulator.h
+        enum: [0, 2]
+
+  "^v(cama|dig18|rtc)$":
+    description: LDOs with fixed output without mode setting
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    properties:
+      regulator-allowed-modes: false
+      regulator-initial-mode: false
+
+  "^v(aud22|camaf|camd|cn35|efuse|emc3v3|gp1|gp2|m|mc|mch)$":
+    description: LDOs with adjustable output and mode setting
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    properties:
+      regulator-allowed-modes:
+        description:
+          LDO regulators can set regulator-allowed-modes to values specified in
+          dt-bindings/regulator/mediatek,mt6392-regulator.h
+        items:
+          enum: [0, 2]
+        minItems: 1
+        maxItems: 2
+      regulator-initial-mode:
+        description:
+          LDO regulators can set regulator-initial-mode to values specified in
+          dt-bindings/regulator/mediatek,mt6392-regulator.h
+        enum: [0, 2]
+
+required:
+  - compatible
+
+additionalProperties: false
diff --git a/include/dt-bindings/regulator/mediatek,mt6392-regulator.h b/include/dt-bindings/regulator/mediatek,mt6392-regulator.h
new file mode 100644
index 000000000000..2e1f41e0ebfe
--- /dev/null
+++ b/include/dt-bindings/regulator/mediatek,mt6392-regulator.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_REGULATOR_MEDIATEK_MT6392_H_
+#define _DT_BINDINGS_REGULATOR_MEDIATEK_MT6392_H_
+
+/*
+ * Buck mode constants which may be used in devicetree properties (eg.
+ * regulator-initial-mode, regulator-allowed-modes).
+ * See the manufacturer's datasheet for more information on these modes.
+ */
+
+#define MT6392_REGULATOR_MODE_NORMAL	0
+#define MT6392_BUCK_MODE_FORCE_PWM	1
+
+/*
+ * LDO mode constants which may be used in devicetree properties (eg.
+ * regulator-initial-mode, regulator-allowed-modes).
+ * See the manufacturer's datasheet for more information on these modes.
+ */
+
+#define MT6392_LDO_MODE_LP		2
+
+#endif
-- 
2.43.0

