Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8991E36A363
	for <linux-input@vger.kernel.org>; Sat, 20 Jun 2026 20:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781985780; cv=none; b=HgUPBZlSNDCGMHmwJ47lWRosSJUD0u04AAAOhTi6Ch/HJ7X7vfW2gUQA0+xyaC5GK/F8aTS+64Eev+Fijtjo89Rk4rbAKxg4x5DXkVUHWY19AGHs/vc4TH4tX4W2vFUwXe73jk2T8zoFUGGaRNqea5WR84GaC+0JlNg99gWdhGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781985780; c=relaxed/simple;
	bh=DyUYpkJ4idO1NDseET/QMPcS41WzmgGFOPp4+aPtdUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLHMw548SOTOoC847xIkVCW5AS/cGDU8xTCNH+tDM19O7+VzzxiDDZW50+oTmltlWFXYMwXbuQg+LbtWErKjg+sXpM4gX4V9BARG+9kJAjD5KdF2EenCguEy8sBLy8Acvfpe3SYHAFqxXxMyWkUJXB7rS46f9MHoIXes4uEZg00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGf2soMZ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGf2soMZ"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45ef779c1c2so2421115f8f.1
        for <linux-input@vger.kernel.org>; Sat, 20 Jun 2026 13:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781985777; x=1782590577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dt8oMFSBDgldcmRls8UUYxStsjEcsWhbys7AxWlQg3Q=;
        b=XGf2soMZSyL/4Tp2XKBk7XCtFORwkOHQTskswUdP/1R8YEi4G4X7qJklqKuoQIGG5p
         IoExxqvQrDfOWDcUwiqSHy9Pnnx0GKOPtScs02LQqYfV/vIc3TQOVsb0uGxo6am+kGHv
         fpI5UEKuhL2cXtaxHUZ0BszCtZABYcg/elTOv0frDKXptFKkV5TF5/5Q/QyuvgCj+PnC
         iQC4Og6hNOgazXi0G8K3DXWIZY5cfIqzH/jQIwlRM/dG6vGF6GqpWCxpFCF47mxIMgGy
         JvMRIxDihX97+NxJBH+4hmGh9sAVZ6t4/Qh/tSrHmc6bryHazJEuI33xUSiogXin9wnY
         mneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781985777; x=1782590577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dt8oMFSBDgldcmRls8UUYxStsjEcsWhbys7AxWlQg3Q=;
        b=q4vnH1eF5iFGjKJcRc5P9TvOnavqq/DpF5ybTBn02xpbGLSofRPaJiNwRcjdmEv7Ii
         kcaEXCvW5KxtWwtGpIl/xiSKxmMG8SIN9c9c/yKoUSuYVAiuEsptb7+IN5j+gpZIc42N
         EjqkJuLYLtsFTrfoDyU0o8K6MFY812g543FeWSqxPnPcFLVWS9DFPzqqcbXsMHWu83rc
         9AO69lnk4h8IY2Lm2zQtK+lKfiBpj8xxgE0Lx7xSXZJHwW2pn2LGrmyjbTTEQGOVe+pC
         Q7DzI1MgQvu003VrbfG7pxKaJUmsPLWCWeADR3NRn4NU8EyTLtdwzFaJyRZNKHw0Qs5z
         grCg==
X-Forwarded-Encrypted: i=1; AHgh+Ro+d346csZY6cU7TclFVdw+lqE3HCPUR2nHpJAhsXxebLUdZPxjvpbd4Qme+selKoo5AR6utF+EGzfdRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOiysvjYuM9Vk5lfzMXbGj9KF2wa0zQc0uXK8MFY8iYNVMZetb
	j8GpWgfd5r+KPdN39sms8nyPXgT/gj/se8ZxAiJy9Pp5xd6yzgFM6gIY
X-Gm-Gg: AfdE7ckpQ9/yhU0wKm5ockT4Mfcx/VAXWJt/B1JiZRzYvtmJC7PZlIpNdV3DOKPcwfS
	/4drblfCWlGOhtZ8K9jb8HHljzo5Xzd94gtBn5vD8HzrP5sIVuYpsCZTVdpBvymC8RAKWr/GaHT
	cp00Y1TTJITFm4fpa+OGsZMR/0EW5TcbuU+/HikQrJ1ZiqX2eTwTP3/+CPjiNFiB7C2s2b1IYso
	omJRHNk65jAYwiBic1h49zZe/Ngp4rL2FNmCnXxhZQ+xI45ahZR2AWC7wBUsMmIT0Q5lu6U9GMA
	9tFqIBqWm3h+ZH+6/uXnWN5p2Wcp5aowgmHP9YTn5jIzQAj5y5udT+TS8iY4iQfae5Rg8pHPiUQ
	8JyAkyBUVKLZ639PGpjSNhsM7dHmMcIq+mFACPQ+g8NmsSg3hNmHNrZwaBVh0ssfe6rs0JEXshh
	ql2RObyw==
X-Received: by 2002:adf:ed0c:0:b0:44f:da54:da6c with SMTP id ffacd0b85a97d-46508afad8cmr12607549f8f.26.1781985776753;
        Sat, 20 Jun 2026 13:02:56 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666788226sm10708354f8f.23.2026.06.20.13.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 13:02:55 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Val Packett <val@packett.cool>,
	Luca Leonardo Scorcia <l.scorcia@gmail.com>,
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
Subject: [PATCH v8 9/9] arm64: dts: mediatek: Add MediaTek MT6392 PMIC dtsi
Date: Sat, 20 Jun 2026 21:56:55 +0200
Message-ID: <20260620200032.334192-10-l.scorcia@gmail.com>
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

From: Val Packett <val@packett.cool>

Add the dtsi to be included by all boards using the MT6392 PMIC,
providing support for regulator, keys, pinctrl and RTC.

Import the new file in the shared device tree for the Pumpkin boards.

Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt6392.dtsi      | 148 ++++++++++++++++++
 .../boot/dts/mediatek/pumpkin-common.dtsi     |   2 +
 2 files changed, 150 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/mt6392.dtsi b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
new file mode 100644
index 000000000000..19321ae010bb
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
@@ -0,0 +1,148 @@
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
+			mt6392_vrtc_reg: vrtc {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+		};
+
+		mt6392rtc: rtc {
+			compatible = "mediatek,mt6392-rtc", "mediatek,mt6323-rtc";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
index 805fb82138a8..6bc80924cb6c 100644
--- a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
@@ -6,6 +6,8 @@
 
 #include <dt-bindings/gpio/gpio.h>
 
+#include "mt6392.dtsi"
+
 / {
 	aliases {
 		serial0 = &uart0;
-- 
2.43.0

