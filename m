Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C96440A3A
	for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 12:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787228852; cv=none; b=YrcMNxR1t15hZC+6NHGXtl/LM3BIuDmRXXdctR50gk5rDpLnj4p8kEHLJvZL2P9RK5ttOJrGi8XvpFNxko3YRCrFks9NgflQegMX/8v7H4LlIM4LNXIlYe71KpZ3v77FAOamiCPLPy1TeJNgQXxsYMTUKtkNZaluZNbZGPfr7rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787228852; c=relaxed/simple;
	bh=V4KKdfr8DfRRh3LWQ8yuK8mbPU0WBdm0yMJnzWuIj64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nt8n+UME2VVSBsczCegwd8SOU0zLU7NRSHDHBndwzTEYvObb1dupWpx5YSuHZjtf2HladdHj/Cc/uCg2NUb/le0g5P+MXDIDKGAtIZAFFvmIipscEk9IZhelU7CQbHgDjdenZHxq2b0amP1h85oKX65myoAWkGtk3/h9EF0zLTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p06fBsBf; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p06fBsBf"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4980dc26022so22295465e9.1
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 05:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787228848; x=1787833648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0JuDNoBLL9wGwEY+LStgj97yBD0YrPno/mDC4ibcIpA=;
        b=p06fBsBfpIth6O8wiSOBY4iM+2DAPrKpwLMriMWEkh5Js8QHKsLE0QHfJErH61ZJUJ
         sO8GAGVWeLVaIOq9LkfFKB+C2qPZfPYz6Lf9rdIsMC/kUxbfOQTxtmUsPAeBNcpw0SmM
         YnPZa2ot6wXBgeg6x+8JMA7Zb/w+1Mw1EFXDEMkw2po61ueVdIWXC23THp7pvZ0qQzwk
         hUgYMSWadl9ztTAltbsAMk9aDLnvQPPyHEywuVuYak44+BlJJnbhW3Q69ikiJNLF1VEV
         En3krF5s1dyPP6qBFM5eeLZ4Rm8m7Lr5j/kynWVT4o191jwMl7k/JIyNx/Nk6b2TOAsS
         auRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787228848; x=1787833648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0JuDNoBLL9wGwEY+LStgj97yBD0YrPno/mDC4ibcIpA=;
        b=pB+yDmuAeP7xdtfO/a14Y0Rya5JY4TLYexGHdWB2+yt/FdO3QfsR+IcPGvEgBULPNX
         7L5vSWemG24gu1zWjO4bJ4O3J0hObK/KVTgPP22azHl+Vl8Kc5VJTIAurDGRneiVWYPj
         5VsyjLDl71DvJ+kh29bbCv7gacTdKc240NqvdBPSVeKOGOoWCQ0ErD122sYfOagkhpNJ
         jQqrraWmNxEr5YHZRRMRYuuZKA9rMxA27AT9Uko9LR/SLImZgDDnVeWu3ai68lQHXEoH
         8AdY3TxkHn9YI9h8nwG7sRAlvlHjLYawijcEhgEytY7Ftq5So9fI/cfpsARM9hq24kLD
         5JjA==
X-Forwarded-Encrypted: i=1; AHgh+RrlIkMx0Yg8fKUWZc+7XKvhM7uBCc+OrOCSlygXNe3BjA6+4nNwcEhFJFDjAvY1z7J6qMlUSunUa+Dfcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqBp55q1mEXosyt3JAuZdyXybVEQG037TEPaeQoDgoEEgDDpdC
	rjw/R5nyufZwnTCZWvQOwikEMsbM/53MpYEXxUm9/kV4XabnDH44PxYN
X-Gm-Gg: AR+sD12TsSexvgsKTxPpgr2CLyX2bag9m2coSWVVmtLT79aRG68kFLfcfSRjyDVQR5H
	npm6xbraUrj3TXINFy5J9WIXQXnoG9C37cpzkua2Q0+/gr8ChwxyZ16gJZN1DlKu+5TrLGXYGc+
	gKB+nOTgx2OoymqXzKT4Cfa0XShY0l7HFhnnImerHnVaG1c7lpYtr98yxra1W745Rt49RDZWask
	SK/qeffGJEtjgARRsKSl9AVdFVejMgOtTpZV/CkxSvw8NE2id4CmGT01QNctiaSoCv1d139Mgo8
	eHk4UGQxsReBHoAn/pkL7lnbPjBEg/0GfGiAJrG5owR8Ptr+w4ixrE4b5/KfyfizhGCROiYofe2
	S0cV4L0g4sGckTLo11w0NyX0vnvkCCUucpwIVj7i8I2qtUlbE6yUYWfEgjEsUthDKFSmkICETy1
	issKOBNJYF5/ufJAQt2qDyN0/ExllfMJRvzzlUq2OQK5SFDkQMGY9cog==
X-Received: by 2002:a05:600c:5253:b0:499:79b9:e226 with SMTP id 5b1f17b1804b1-499aa109edbmr192185265e9.0.1787228847876;
        Thu, 20 Aug 2026 05:27:27 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499ab2a8b34sm170494645e9.8.2026.08.20.05.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 05:27:27 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Val Packett <val@packett.cool>,
	Luca Leonardo Scorcia <l.scorcia@gmail.com>,
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
	Julien Massot <julien.massot@collabora.com>,
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
Subject: [PATCH v9 9/9] arm64: dts: mediatek: Add MediaTek MT6392 PMIC dtsi
Date: Thu, 20 Aug 2026 14:20:07 +0200
Message-ID: <20260820122242.120039-10-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820122242.120039-1-l.scorcia@gmail.com>
References: <20260820122242.120039-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Val Packett <val@packett.cool>

Add the dtsi to be included by all boards using the MT6392 PMIC,
providing support for regulator, keys, pinctrl and RTC.

Import the new file in the shared device tree for the Pumpkin boards.

Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6392.dtsi      | 145 ++++++++++++++++++
 .../boot/dts/mediatek/pumpkin-common.dtsi     |   7 +
 2 files changed, 152 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/mt6392.dtsi b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
new file mode 100644
index 000000000000..69d63c153d9e
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ * Copyright (c) 2024 Val Packett <val@packett.cool>
+ * Copyright (c) 2026 Luca Leonardo Scorcia <l.scorcia@gmail.com>
+ */
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/regulator/mediatek,mt6392-regulator.h>
+
+&pwrap {
+	pmic: pmic {
+		compatible = "mediatek,mt6392", "mediatek,mt6323";
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		mt6392keys: keys {
+			compatible = "mediatek,mt6392-keys";
+
+			key-power {
+				linux,keycodes = <KEY_POWER>;
+				wakeup-source;
+			};
+
+			key-home {
+				linux,keycodes = <KEY_HOME>;
+				wakeup-source;
+			};
+		};
+
+		mt6392pio: pinctrl {
+			compatible = "mediatek,mt6392-pinctrl";
+
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		mt6392regulators: regulators {
+			compatible = "mediatek,mt6392-regulator";
+
+			/* Fixed supply defined in the data sheet */
+			avddldo-supply = <&mt6392_vsys_reg>;
+
+			mt6392_vcore_reg: vcore {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_BUCK_MODE_FORCE_PWM>;
+			};
+			mt6392_vproc_reg: vproc {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_BUCK_MODE_FORCE_PWM>;
+			};
+			mt6392_vsys_reg: vsys {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_BUCK_MODE_FORCE_PWM>;
+			};
+			mt6392_vaud28_reg: vaud28 {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vxo22_reg: vxo22 {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vaud22_reg: vaud22 {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vadc18_reg: vadc18 {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vcama_reg: vcama { };
+			mt6392_vcn35_reg: vcn35 {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vio28_reg: vio28 {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vusb_reg: vusb {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vmc_reg: vmc {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vmch_reg: vmch {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vemc3v3_reg: vemc3v3 {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vcamaf_reg: vcamaf {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vgp1_reg: vgp1 {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vgp2_reg: vgp2 {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vefuse_reg: vefuse {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vm25_reg: vm25 {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vdig18_reg: vdig18 { };
+			mt6392_vm_reg: vm {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vio18_reg: vio18 {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vcn18_reg: vcn18 {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vcamd_reg: vcamd {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vcamio_reg: vcamio {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vrtc_reg: vrtc { };
+		};
+
+		mt6392rtc: rtc {
+			compatible = "mediatek,mt6392-rtc", "mediatek,mt6323-rtc";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
index 805fb82138a8..b19d5792bd89 100644
--- a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
@@ -6,6 +6,8 @@
 
 #include <dt-bindings/gpio/gpio.h>
 
+#include "mt6392.dtsi"
+
 / {
 	aliases {
 		serial0 = &uart0;
@@ -160,6 +162,11 @@ &i2c2 {
 	status = "okay";
 };
 
+&pmic {
+	interrupt-parent = <&pio>;
+	interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.43.0

