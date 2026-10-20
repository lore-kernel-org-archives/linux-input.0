Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792517908;
	b=ymiXKJkY8uTiFgkJ8DU00GcY7hdMobJAmeKsopxTs5RtCWzMTpvp3m/Hz5eBcZFDZCM3
	 1YXTQi+cXYP7lcJT4iapNi8DZqIcaa70Xj7Qpa9dy/QpCrvkzoBG6YLMlg5dhOmaBcc7w
	 ntWTkZfO43aR6G2vkEmQVmIS/cO2yso0ywgChxAFghIDV6k2wVvxIs0YA3BVOzfga3oqc
	 lc6ttgCXRr++LwZYc8mIyLQ0DBkVRQhiY/J4YlU+J3j2C1pdm0WmKtSesNbGMfk58PD2/
	 Zff/AaG1XMUD1s+2fis5y+FdMg6+nax755Td5XmQsbuJeQlv0oqqHUejksaVgb4LV4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517908;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ocwe/ua5bx6fTunJTjbDvG/Rp4d0BH8Fbx4UwIDjj0c=;
	b=Ngh1rfHJu9nq/PAPmTn/4bQJw7XrsfdL2FmKQc+DsToo0pH8bX8o6U/6hJyMswC5Wu6f
	 y6CT1hy9lWGk1eNfcizQZTdn/8jc5fWVidZ06/9fplXuZB6PRhWd44JyGV9HEMmLvPK2O
	 qcpl6hdwiV0N0elNL3KoDz/Bhxih+TPHTxIAjF1jA2vqnPNrbwC0Df66Gsz74as2gCAmI
	 6oFyKIRxTn40YyCDnkJKDCG+JmawoYElKSjguUpdF3D5ZX3WCbI+lkwF1d6XDTrFWHiS8
	 t21E+4snkFaBtiUjJ/KqEZlJPYRsvu242B6evT5Tnt3PSqtSUfgnvkx8zJ3YrYkKk2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dzAHyTZH;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6D160A2625
	for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 17:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB6D160A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dzAHyTZH
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a021c809e3so29416315e9.0
        for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 10:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792517906; x=1793122706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ocwe/ua5bx6fTunJTjbDvG/Rp4d0BH8Fbx4UwIDjj0c=;
        b=dzAHyTZH9KmnxvGzkLc4TBzZjYNmxyPET44e+8vYaLd50Da7xftyEBJXCp2EHpaxbi
         z+Ej7Tgure6ZjFr2dDhPYnLS7QB8nkMLWeWbG3+59ZWM0U4w2hKBQl5MNxqCfkaAD4la
         /dpeIPdlxbihyX5869qjfcaeU9uu8+TKSFeBDhsE6qtyZthuHCSloUyz9P87+scC14EU
         UyKmmyP4ysDTcoc39eSm6y9KQZ1sPyX6IvNU+OcrSrBEN1FfY2wSExF0Zev/PlERviHE
         G59yDW09gmU+hJ0yyIyPrCjlTEqZy5PR1LmFU7PXwSV+coISIv93hAyx0a2Yx/f2AmkJ
         mPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792517906; x=1793122706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ocwe/ua5bx6fTunJTjbDvG/Rp4d0BH8Fbx4UwIDjj0c=;
        b=V6JG3eBOLMekQ4C6L6XOM5YzPQeA+sgoHgGXAwVy9Mh+c2L530KWPkKL3yJxhZMrz6
         tEO5hgMPOvxJnyP9Lqa4323uEw0BkeprN9uYEleB+uUM+av45hmJowY0fkRJpcXt6ujy
         awWbrZ6KKsi0LP2+GbPjCkniaK5bqr/9TTpi3ncbH9EBQ6XkC+BMAtnWoVruD6PF+ksu
         uBpdFkx73r/r1bSCl5kkHzvbwWKSqQ6u4hzi9+IPXGBJ9x4h9B/INmFmMNh9bFjz6Tf9
         8h7U30nic6EhMJdHUvLdgFbgl4DN9ijDYVKnbzOp6ieWHOsLZH0Cf7pcYfL+1mBn4Ti/
         Rbvw==
X-Forwarded-Encrypted: i=1; AKwUvBwWdQngCUVP2/LuFf/Uwp2pRFJdNYnqHWKoxsHAdGBiXR+GRXBAr9nbyJxKrOB7qu372kZZ4IClNz5lpQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLK86yuDDmntFhwfWygnN4S+aZkJctwSDFbggJIlC98+gVr3t5D
	/y5So177IvdjWb5J8+5DZZKLWTsPB76Jd15/UlTPIHwT8YC4ntUgAvVg
X-Gm-Gg: AYBFou2u5PG9nwbEAFu8FGnJeSRhPievI5la6fQ3RjGXDVWhV8DKZ8eWW2FVRvhSiAu
	BtK2jUnkHVytEUyxM6Jg/oY6JM88g1L2DEjpQ8bRjMLijdTV2pwrCETJXA1CXg13mHiB0DYZhki
	1bA/uQFGq+sjx6CPoRny+bxeS+GOctTbkimcHRS88AvgD9YlTfjlsIb3aPAorY4K33bWPcz1Nkg
	Womdq3tbkMDn0NWo3EFPLXsdD+H2/sxSf861226uZB+KsR+DIx7pmPpBSMonEwiwyO9S7UxAHmk
	ivVbLrrjZO1DqSJnkxk6TGSTZ1EhGf3jzXlIfrEIpu3DH/wXB/dpDmtc8Iaa6Px8IK8eMbzK3S5
	xUCwmLEd2VvyYiZDQCf3So6fMYgBnmX1vzjItTEp67QjPE0PtEpuLA+9ECjnhReEfUYkMWbZVoc
	/AeNIMcGTKcC5cYH73ksda+tMWrPLBtNLXBPP89fwM+uazqS6grwwzbh3T9vvU15D/Og==
X-Received: by 2002:a05:600c:3b1e:b0:49f:fdca:c361 with SMTP id 5b1f17b1804b1-4a1d75f9341mr271641575e9.12.1792517906016;
        Tue, 20 Oct 2026 10:38:26 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f8016c93sm52505235e9.5.2026.10.20.10.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 10:38:25 -0700 (PDT)
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
Subject: [PATCH RESEND v10 9/9] arm64: dts: mediatek: Add MediaTek MT6392 PMIC dtsi
Date: Tue, 20 Oct 2026 19:33:30 +0200
Message-ID: <20261020173556.632798-10-l.scorcia@gmail.com>
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
index 000000000000..cc4770d70246
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
+		compatible = "mediatek,mt6392";
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

