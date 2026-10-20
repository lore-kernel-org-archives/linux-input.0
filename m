Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792517835;
	b=qKotWQnnLZTLbIDlAdhc7mCQu3wEMbuUDmZQzCxZOldeMsxOzcZyF0jfIBPOBbbgVOfK
	 KTJXfXkcXh7M51TLENIE36fRIAwBDldNWgl7RJpBLIXzFO0358B1pAFlgHNvy9zA8vK4q
	 sQi2p+/w1dSbeT/k2C3taUJLYON+XIffWN+QXPpYZKRRS1OZTqMxBvX4maLJJ5aVEU99P
	 bbidRRxU00vcuheJ+vPcKqOu90zh4ZlSYnfxUv3dOalQWA8Ie/S5qWRSXNAI5mIFq2Stc
	 zEuZGQlljIKg1Rdd8YN+G/CHycCXLMfsFwxvc61DXBiyKc4rzWdgCASekf3NTKOg54Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517835;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=F23t8iLTcn/LXqN2lEEgBTUnPAkeyO0taUnuYVGHe48=;
	b=y25FJ3iqrszwJLSjyEkfcnV3MV303rPWFFVBf6TMvMDoDxSzUD5z5ff/WYYb0MgEDQrJ
	 f/UTqlbQ6aU5/jGmgHu/wskwFxH9MSasgftzV2oGRqCAAyEGOgUzn51NR0fw1jMCWOvuk
	 LJfh12SBZkj0FNZug/FyRglttMmajgbH05dmhG47LzReSUxlWMeYtPEgnuANfy9z5k2nI
	 3ackMt8/FC152isaLg/TdiBMIK9DT0oLHMoY4SkIZUazGEFV0dwYNFQ+Db+D6pIrWUrDa
	 PYI2DDLgFTcg3TEUwMwmxZVhRPOmYo2TL4vGpRomvPyyi+UFgBNqukqPV6NWq3LiIpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AaiJqS9G;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4392C60A2625
	for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 17:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4392C60A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AaiJqS9G
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1df146015so21589295e9.0
        for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 10:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792517833; x=1793122633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F23t8iLTcn/LXqN2lEEgBTUnPAkeyO0taUnuYVGHe48=;
        b=AaiJqS9Gz12esgke7m1Q84kHjyc+jKEs/aIvOyFuAWQNZ+aDH7+Mdf5PSge4QwYQQ8
         zSrtNxs8qrzk1DrEt3Qi+Bx0NuQKSAt4zWnmQUO3e8X87lU9S5ehbr+XOKhW9IfYLJHF
         3WVgspb8gMpLU+83Wo1sxRf4p5gxrBMi8lGlq0+waymHUo1hYAj7YhQwWoJkB0DeekP+
         V8LBsrIFAPTiTrJ1TtNRVQPUxDk9Dc72WMJhU7daUdHmsiIRsxVe6GU1tdZNBoAhCau2
         mxA5dy0NtBpS9K6WHxwcsed46lycesFSbIgOj1Zy89EOX8cVwNyKLz2yZ/SpXiNFKDPi
         s8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792517833; x=1793122633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F23t8iLTcn/LXqN2lEEgBTUnPAkeyO0taUnuYVGHe48=;
        b=etqx0BeJdQJ3pEhMvXoqi0Fs1bIHNQ/Q3SKURfmcfG7HeNSy13+Fqz6GwZI8W62Z6x
         GErFKVevT11X/UJ/AGITn4SaWGau7ht3edL0Q5JWIVkLDjNFijgnM5DaVddDoHSOT0+C
         WM4Lc6WKbGJZAO2yOX0V99QozUMAsSx3xwwIS7EyymNeADZZgEuInJBDPCLJYsVRF3SL
         EAblXsBcFgUyFERXp+Lalg6aiMenMY86/or1cX1iAVF7ebrK+ns1+mywUzv9Y5kGQJaV
         OaI1cbTKk6bzcJcSGrGBuhskJi+z84cBjsVJkHHSpIg+YUak8VRWdCOQmlldZWgoUfWa
         5DIw==
X-Forwarded-Encrypted: i=1; AKwUvBzICBeRJzLSQ1Q8N7EHatYtb5TgGUWqGdoMEcL2X4XkJ4B5fghEPyUWDz9hJaREBnYpKXmN0iWjmGQ7tQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYL6yG735ZaX2PpMTuktqT1qnqrOb26bV2ts2F2cqHgH7kiYEETL
	BS7/uaRJFQCa165YkYCZw0lVcs+hmDJWWC0MZmtZvNdTjqd2bx5rvXc/
X-Gm-Gg: AYBFou14Op3osGTohhGw2ymzlVpVKlfqVSyXXJ3J0JNcVp7BiqNew1Uac4L3QeV/uNn
	YGi/lmYy1XwcEArw2RRdgUtO//UaZjrsXZPT16/bXcenh4DqRd0l1xVR3bH0Og3pOX5sEvZrSka
	u6BW3bK4ykT+f772ayty0SWqJNNt4tRsMTgHLk6b5dvvNPcJtn2dtuyZJx55/xqN9KBvjrFX+Dz
	fXBSnU/a7tVQgh3owSdho5QaiJvszMHdn3QTXaT1yYCwXOGchRrY6QocFkX3IRv9QEJB1pf2Iyb
	tnKhw/JLzYhJjWg0RrpdRjb09eNOzUcdCt1xwQ3gPBk44mRLgbL/PmHfhoYKcSh6En5h922C4C9
	bXnAJnT3HNSVIZ/ayGvqxtZLuLZ5IYGveYMMYjttzsu17/MT4PxBab5FJE6HEhium+MDtrKU8sK
	LWcx0yxNjvFnqypDcXCW3nwq5rax5L3NoeP7cDGCJifXDvGvjG6whvsMf7MI63ssL2rw==
X-Received: by 2002:a05:600c:3d8f:b0:4a1:e31f:e86b with SMTP id 5b1f17b1804b1-4a1e31ff798mr182062865e9.28.1792517832525;
        Tue, 20 Oct 2026 10:37:12 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f8016c93sm52505235e9.5.2026.10.20.10.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 10:37:12 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Val Packett <val@packett.cool>,
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH RESEND v10 3/9] regulator: dt-bindings: Add MediaTek MT6392 PMIC
Date: Tue, 20 Oct 2026 19:33:24 +0200
Message-ID: <20261020173556.632798-4-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020173556.632798-1-l.scorcia@gmail.com>
References: <20261020173556.632798-1-l.scorcia@gmail.com>
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

