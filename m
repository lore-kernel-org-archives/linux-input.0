Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C793B38E5CD
	for <linux-input@vger.kernel.org>; Fri,  6 Mar 2026 12:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798831; cv=none; b=k1TMLHUKEdiNkTolGqplPyfr94dO45o0D4fg/0lX5XlG6fMBFuMIv1tsnpMzcfIxfs0GbsSN0oduaLScihwdUwLZBa5uhYVAfHzISuBulNXEdDLc3PRepVp6oZItBNaPhMduPIryHjPsPNsJ2ZFGnCVja4ykTEbyx4P11yNEfpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798831; c=relaxed/simple;
	bh=fW2pEq4Cji8dD0Hh/gE2qYrgIEWkc9Og8y/3NnzjrqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRMadHQrZwzGCayQr3Uz9/tRhX5WXMKYQsy5lzvi+lNw/neyDJSRBOjiOTd4aF7F5UftRT1v0R+2vclThg8w55eyKQCVsibkPe3vQikdEhWHO18X0FQ67SAbMeYgBFT407G0RlYZmFd2kCyb5FTw7slE2uOLXJ99EjKRcblpkK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lm/F7Yry; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lm/F7Yry"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439aeed8a5bso6270655f8f.3
        for <linux-input@vger.kernel.org>; Fri, 06 Mar 2026 04:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772798828; x=1773403628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlP4+/T8HO4OS9CBYj2Xq6DuqZPRSrnhT+fSfVGyrPw=;
        b=Lm/F7YryunauMMLTkTo65VhtI5x0hNm7SE9fuj24ABjoqOir9dFoHrNTJkN8Fd9DJq
         2683aUI7jAe9c6eZHsroKuwqW1pfxm8libTDcL2MftNj9ul6OS8R11GA7Zsl9wpu8HVh
         PNPIMj0jBgiZj0Ki8+fid0qyL5vt6/bMfh/BDpAzToOR6PKpp51iXo8Ye8ML69n9z3V/
         /FCExhrLoHkjIWSPyK68Ehypx/XFFYXYQdDLBxzqdwxb20zJrk1BQLsKuVsoMaG55J8o
         GR4XLQwguxQx5j9sA5lv4L0L7cSD69BrrL7pc7URry5yJiYitTI+Y1ch/PuOKkTvAywp
         ARvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772798828; x=1773403628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SlP4+/T8HO4OS9CBYj2Xq6DuqZPRSrnhT+fSfVGyrPw=;
        b=GTB7NVHwF3iK0pr1lspM+2fmH6jrXh1CbIqK7IUN9U5lGcPYfKOKCn4XuFqs6eA1sL
         Q4Gmy6n9zY1Cpa8olqWLGnwJw8iOql7aSZfxr0A1nmKemDc2dZ7Blqccp8G5UAXtjayZ
         QZ2ho3vSLRpts7dcXaACqyF31He863kW/TaMBW1PRiEUTZUxGK4ZwVpPsu0zCuCnWME7
         Py6MEqVCgeFHZUGSz2wXiMKge6Lecs2dfWEcPpmzBwXvodlj1r3kf7qQdZS31HhX+y89
         yr6uW/RT1kSjI/Wnp/ZzYQIK+FlubDoUkLmfv6X9aVyxncgsVVsr83w90hTHaAxmtSZ4
         ZYew==
X-Forwarded-Encrypted: i=1; AJvYcCXd5cJF5MvhyD6cLzaUwPteojigRbk1no2TyPj8m+hcWeZafzxgl7v1CHaj4FZPltT2wR4Vvsxky6u2sA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlBtH4HcBHVVwNPGV0HX17go+gmm4clkrJN1TGK9hHZXjZFYwO
	OFZeCx7RzJvsM6DBxT5Z7Q5N8KM/yM/cEwCSJ9f+QgyJ3JrwhXFa+/hy
X-Gm-Gg: ATEYQzy6BipEO2lPDbrdQJPB46wt04al3ACw6iSOg7atlUtY3zREUMp6t4VbEBykWRw
	NQeuMglMqXjnr4Tq700q2VYZ2NOaI+alfDiWTU89ioHqDSejEaJeZVQMvuKK+3HkPKa3xhp0Gv9
	YSx1K4k3cAofPF11lfo6eRi35zlxxQG/xI9XLx8WYZ34jVFek3y3npV55tvYcfc7PwqGFt73rSm
	8xjnT3M4nO+Jx5Y2DamAGOr6mnFe7Wpr4T7eAnsKxDyi/wouJM9F2WRtJLtS7xV8UdjQ57Dzdap
	prrd6KeyeOuDYMS+P6kBnOjOVlsEfORLBAj7SxHB5rPwgGYJv2OXw0s8fipqA1CuIJn+PXn1ddz
	iP2fr3ZjVb4eOxqYYgaOvs2af5R7bzypyCcdqoQkr92daaDolUDz2OgTG6wcfdx4YbmmVPdwOYt
	qRbaeoQRtMxo0vm8lEBfA=
X-Received: by 2002:a05:6000:4205:b0:439:c9d0:5fd4 with SMTP id ffacd0b85a97d-439da656affmr3257347f8f.16.1772798827969;
        Fri, 06 Mar 2026 04:07:07 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2b9d8sm3457225f8f.21.2026.03.06.04.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:07:07 -0800 (PST)
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
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Julien Massot <julien.massot@collabora.com>,
	Gary Bisson <bisson.gary@gmail.com>,
	Fabien Parent <parent.f@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 7/7] arm64: dts: mt6392: add mt6392 PMIC dtsi
Date: Fri,  6 Mar 2026 12:03:11 +0000
Message-ID: <20260306120521.163654-8-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306120521.163654-1-l.scorcia@gmail.com>
References: <20260306120521.163654-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Val Packett <val@packett.cool>

Add the dts to be included by all boards using the MT6392 PMIC.

Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt6392.dtsi | 134 +++++++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/mt6392.dtsi b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
new file mode 100644
index 000000000000..c7e54c30bc3a
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ * Copyright (c) 2024 Val Packett <val@packett.cool>
+ */
+
+#include <dt-bindings/input/input.h>
+
+&pwrap {
+	pmic: pmic {
+		compatible = "mediatek,mt6392", "mediatek,mt6323";
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		regulators {
+			compatible = "mediatek,mt6392-regulator";
+
+			mt6392_vproc_reg: buck_vproc {
+				regulator-name = "vproc";
+			};
+
+			mt6392_vsys_reg: buck_vsys {
+				regulator-name = "vsys";
+			};
+
+			mt6392_vcore_reg: buck_vcore {
+				regulator-name = "vcore";
+			};
+
+			mt6392_vxo22_reg: ldo_vxo22 {
+				regulator-name = "vxo22";
+			};
+
+			mt6392_vaud22_reg: ldo_vaud22 {
+				regulator-name = "vaud22";
+			};
+
+			mt6392_vcama_reg: ldo_vcama {
+				regulator-name = "vcama";
+			};
+
+			mt6392_vaud28_reg: ldo_vaud28 {
+				regulator-name = "vaud28";
+			};
+
+			mt6392_vadc18_reg: ldo_vadc18 {
+				regulator-name = "vadc18";
+			};
+
+			mt6392_vcn35_reg: ldo_vcn35 {
+				regulator-name = "vcn35";
+			};
+
+			mt6392_vio28_reg: ldo_vio28 {
+				regulator-name = "vio28";
+			};
+
+			mt6392_vusb_reg: ldo_vusb {
+				regulator-name = "vusb";
+			};
+
+			mt6392_vmc_reg: ldo_vmc {
+				regulator-name = "vmc";
+			};
+
+			mt6392_vmch_reg: ldo_vmch {
+				regulator-name = "vmch";
+			};
+
+			mt6392_vemc3v3_reg: ldo_vemc3v3 {
+				regulator-name = "vemc3v3";
+			};
+
+			mt6392_vgp1_reg: ldo_vgp1 {
+				regulator-name = "vgp1";
+			};
+
+			mt6392_vgp2_reg: ldo_vgp2 {
+				regulator-name = "vgp2";
+			};
+
+			mt6392_vcn18_reg: ldo_vcn18 {
+				regulator-name = "vcn18";
+			};
+
+			mt6392_vcamaf_reg: ldo_vcamaf {
+				regulator-name = "vcamaf";
+			};
+
+			mt6392_vm_reg: ldo_vm {
+				regulator-name = "vm";
+			};
+
+			mt6392_vio18_reg: ldo_vio18 {
+				regulator-name = "vio18";
+			};
+
+			mt6392_vcamd_reg: ldo_vcamd {
+				regulator-name = "vcamd";
+			};
+
+			mt6392_vcamio_reg: ldo_vcamio {
+				regulator-name = "vcamio";
+			};
+
+			mt6392_vm25_reg: ldo_vm25 {
+				regulator-name = "vm25";
+			};
+
+			mt6392_vefuse_reg: ldo_vefuse {
+				regulator-name = "vefuse";
+			};
+		};
+
+		rtc {
+			compatible = "mediatek,mt6392-rtc",
+				"mediatek,mt6397-rtc";
+		};
+
+		keys {
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
+	};
+};
-- 
2.43.0

