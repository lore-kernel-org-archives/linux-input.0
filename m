Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218E635A385
	for <linux-input@vger.kernel.org>; Sat, 20 Jun 2026 20:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781985692; cv=none; b=DgjJqVkF7VXjEvX3kRjP+MrqY7cednUplHBUTZ5GpGEXKCpkr6oPGjMM9lUoWqAfzRrKmKKqlgathqzcw5Kchcgfo0sGdr5dTZqofFK75TXnnQxXMIy9AShWiGu8U7ucFtPAPQMBHf+UmOD8jv/c/zD/PDRy6CjltwIET+htaLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781985692; c=relaxed/simple;
	bh=lUssnadtXFpcswpoeo6viSrsHtSq9oHAKwST+vFL/dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SmLyr+D+OwjUmLatcM+1+bubtYi7wwMjkuPX1TLtcDN5WVqorAh7LIYJ8VIueJhvLX7mfEz9hpu8sxNB6jdtphpguyeOHuaD0JyPAdaCDOIAUgMekcTyMObrl4iEr2ZJErBLDmCPSaaUBnUMN9LOxpcEneWn+LEfdZ+o9JR43CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnINfC+T; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnINfC+T"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso32088585e9.3
        for <linux-input@vger.kernel.org>; Sat, 20 Jun 2026 13:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781985690; x=1782590490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxe0F21akykBChd9b7ZIMr9bfYgwXWJeztqohM0WWO0=;
        b=WnINfC+TsTb43BdS9/CBotyIG0iW9V6CSfJzPq5Q/2ZEb3DRrNp4mnnyrwpekB2gPA
         dolKWzYytqG7JD0OHLNq9nY+uAlTuYB86oeb8cBRffFLofNgSwCLOXBpGGG4qOFPlwVp
         /NSZWXXPbC47d7NBXL/mWSZw23FkyRtYMfc+U1cwp8ByzTWTbN2IAk8eGOU3BRyFmHmw
         pMVJb9HdF4iH5f19JR9zwdPIQg4zZwZ++qYct0gDloAJ/vIMDcdS4eRJ/pHqx3hnkhEA
         zAjpPtrCcTvnIS2JhIYd/ytJIg5zfvrLZHx61XzklZpFvsRV1MFFeqcqydHcpgi/ak/U
         hEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781985690; x=1782590490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xxe0F21akykBChd9b7ZIMr9bfYgwXWJeztqohM0WWO0=;
        b=gRWn4jOTPHWDcS6ivZgGh1pmtYWP2RID8N+MSHrkWQL39z43lOw9Ts4UE1Zsl+Ze0X
         E2RqodiHR29EI7rxoF+3mEdVnHyovFq1p0MqIDW1HE33XyDuUBFlPjcY1PDXYkXUvVSp
         tf4olxf+FAYzbfJczvt7+LWThqgV0LkFuAm7Uu46B9RC4ywWlDfxN2+ZbSot4cGzCmCT
         VliRvdY2o66mB/S4eNwe13GtQ87fIsTZw57AcY4HNak3+eH0BmmWKrYYVipsEsC6U4z1
         np1DrmVtEBDcCMgtjhLijzjd/ot3pPKxN7jX/hst6yEIN+GNHjqexqwWg0J5LrVroB7l
         9+8w==
X-Forwarded-Encrypted: i=1; AFNElJ/Vfi55LMAAt5XGwTpcizYCkv2Evifn5wb6tf2jFIBXNE8E5QKviqFoWzILAs9HbgfAT3nS+FjQPW8cjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvz5SduEQY9rG7rnn8ScrzuVZiyeG/VWsG/Et1/yMKqUIwdKO6
	/DyZ456ufm3tGgjvjZUJQnMwpWVZ0ubhNeSfB2LpmAYp19Bnj9I5AQdq
X-Gm-Gg: AfdE7cnQYZNV7qvdTGNYwmfH7L1kMhfzkKvKyAsTTo5SxgnozulLeoKhm5geBowyWks
	TnNmUs6TLHnrUijftfb7Am+dVeS6A3c+hXA0bLQ69F49NXCBfAE2kYooougAHvSFE2Z7OwW8zm6
	ZcAh21BP7RYFkaREvXl9AdfILndGZc2zZflvTYKrn+PwbKUlVTr576eZ/tikGMcqtZfFIoqHXex
	pSNsMSd4LSY2+ud2R3/WDgN2HBq2AaDDbUijU8H0NWmDWW43bdYB5JqbRdQ4wDgoyndu3sxLz1G
	qlBCim5lybvtRx/R2RQspfn43+oIBDrdDTFCMsOBvypD25BP65H163+702bBkfyX3jrluK7Sg6t
	9mTMS5n4idrHIsMVfNgUEnhSOBVJ+vTOC2W2OqF2AYetljKcO5ug1QzpbW4FpGchZM1zSw1Tdn0
	X3w8MDwptFB9Je6f+v
X-Received: by 2002:a05:600c:a43:b0:490:50c5:8153 with SMTP id 5b1f17b1804b1-4923ef47dcdmr159838425e9.2.1781985689314;
        Sat, 20 Jun 2026 13:01:29 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666788226sm10708354f8f.23.2026.06.20.13.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 13:01:28 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Val Packett <val@packett.cool>,
	Julien Massot <julien.massot@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v8 3/9] regulator: dt-bindings: Add MediaTek MT6392 PMIC
Date: Sat, 20 Jun 2026 21:56:49 +0200
Message-ID: <20260620200032.334192-4-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260620200032.334192-1-l.scorcia@gmail.com>
References: <20260620200032.334192-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for the regulators found in the MediaTek MT6392 PMIC,
usually found in board designs using the MediaTek MT8516/MT8167 SoCs.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 .../regulator/mediatek,mt6392-regulator.yaml  | 118 ++++++++++++++++++
 .../regulator/mediatek,mt6392-regulator.h     |  23 ++++
 2 files changed, 141 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulator.yaml
 create mode 100644 include/dt-bindings/regulator/mediatek,mt6392-regulator.h

diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulator.yaml
new file mode 100644
index 000000000000..f3d5a3498d18
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulator.yaml
@@ -0,0 +1,118 @@
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
+        items:
+          enum: [0, 1]
+        maxItems: 1
+
+  "^v(adc18|camio|cn18|io18|xo22|m25|aud28|io28|rtc|usb)$":
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
+        items:
+          enum: [0, 2]
+        maxItems: 1
+
+  "^v(cama|dig18)$":
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
+        items:
+          enum: [0, 2]
+        maxItems: 1
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

