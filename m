Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A74331219
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867124; cv=none; b=SS347wv9WXtBwjjLMuhzMSx8ZZd2qRoQvVpblk/3H27PXTQAOQKLJztzr6xZQs3p07QVeqzb/v2ebFD8JTVC8U0q0qZuLBP+MTuq4xAaEfkuDW7nldnI6ZIYchE1t03Xce/bS8mnxt1neZiGa8uQWfiBJlLQe3dmt7GajWgC2dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867124; c=relaxed/simple;
	bh=4Z113nyzcPGx00yPVO/LcR2WeiIRYEYs+Bbmmt42G0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V0I8JekrrxxZdDO1IkbtZBN9z/WJVIEgSwhH5W9zZrNCHOta8wYeLJwVMyhBg1mvgmjSCLDX0Cq71XQGCXirwDFHp5GbIq/DoDX3DouVtm2As79x5iiNlIx0YX/p4kMUwJBgS8CZ/MTDOhhzTSdNeCUwSBb99Q0Vy8fkSBWMG4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nh68nnIi; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nh68nnIi"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-436356740e6so4830657f8f.2
        for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 09:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771867121; x=1772471921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cjndx/viWwHPLwXhm0pJTNs0ZpyDgThJGXcIfdXyo2Y=;
        b=nh68nnIilX/3GRqH8tZ3K16siX4oQJQb2rerE2FqT1QN1FI60MooDSDAKZDC3mDI9e
         g1PpoQryJ5mWzw6w+dDf4Wf7YFtX0vpu2JwpHqQxCurvmVj5s9S8XqcUC1tZAIHNL/Wa
         2BbaMcSW+riZLsuQ/ry10KjfDclOj/q4/nccf+HgwT9vVb7voZ1fut+dOnrUpJf2gNlO
         cQcE6KXVCLIHqTG9y2rh2NIwaHf0tES9lJ89/gQ9AYgYRZy9zgcGua02yS+4v81uQ7nS
         FTHXSQvkBaX1cCp1YTR0P1w+IQzU5iHD2P5mNG3U6vISeYJc0clU+RTBi5HIGJYHKtRf
         Kb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867121; x=1772471921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cjndx/viWwHPLwXhm0pJTNs0ZpyDgThJGXcIfdXyo2Y=;
        b=NLFtjJlMrdRqLmAn9wAfIDszhmPYfzXl40SmNK6+B8P39HlV2z0ul3wfG2VnucjlnJ
         wpIoRK0CFv04mDMNZ24Y/tgANbcGLbQzVMgIuIqAkEkImDHk9Th1Xr8miOvGUt5Yv6JQ
         Woxko+7kTB3Gdz5GEirlnVvPiag0S0mF6DWnmWpp898qMOFkgtejSeHqU+eAGXPWLkL2
         6BS6D8rgCUr0bUsfoOuhFpPIfSDT3yokKf1KLT6vz69fTsMhkk2gf8xaTQ/YzqrO7D/D
         XDBms/aXmVIxYvjAJP4CwF7jIkerDUXJl1M2oiviNEVWaTur/lblfoGptAGUOyBYPAW3
         liQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeSNcXvXHYCYAfLBi21Vm2OUqrLuTOF/fBXCia30dV0lU6133dEH9KySEKbiYr2VkYYZ+mvbbHlEFNiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOxCrCVXRtaKZxUl6QuVJHCH4w1cBii/gK5kt/PvwOb1jK9y7F
	TYPlPS8fhpU2+/dRkRV8GW8cSb2yf4OX3+5lSY8u42sp7jqZF1OWAHGJ
X-Gm-Gg: ATEYQzxaV8FzF58Pq2CB8UVBPFBYOeuCw/C/88dSWsnMu7qbQgPeCtsesuG8r9PR93w
	VlkJ7V6D1fvxb1S7F9Ezw+q8nlP9+A4yRUrm7Ls7WEzbiMXXEZGMFgb2OrUqUcDyFCMiUgVZLW+
	QDhv7XzTeajcrwKtDyHUMelzdvjafcDUh6tQsE2bl4cOK3Df8WU8Vvt0WHo6jxZa6PrR4qya983
	1WUvJJ3/iMQjhx+4n4XWGNjOkmH8fvOf8PcvmvbIQu8dTwC/uFZN7/U32kpdvZ075c84f9kvYBb
	P9Z+JBVajDfqaayY8ovZk0BKwpXxtHvPMM/y5ydqfQqeXGa3CXbNhCwah0JHM0zPsIfG8477/EU
	W85jfr6ocoQmicjgLxcFPIBy04JV2Fg+MbHqIRiFnxi3mg5RRrcthmMUNKwVUarXEpBzhv5jg+j
	ghTBSkr6iojEljCfeR8RQ=
X-Received: by 2002:a05:6000:2dca:b0:431:369:e7b with SMTP id ffacd0b85a97d-4396f157e6bmr19371413f8f.18.1771867120734;
        Mon, 23 Feb 2026 09:18:40 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4c982sm20871454f8f.31.2026.02.23.09.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:18:40 -0800 (PST)
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
	Eddie Huang <eddie.huang@mediatek.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Julien Massot <julien.massot@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Gary Bisson <bisson.gary@gmail.com>,
	Fabien Parent <parent.f@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH 9/9] arm64: dts: mt6392: add mt6392 PMIC dtsi
Date: Mon, 23 Feb 2026 17:12:48 +0000
Message-ID: <0eaee8c3be8dc848314b2e9aaac9303659fc2a49.1771865015.git.l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1771865014.git.l.scorcia@gmail.com>
References: <cover.1771865014.git.l.scorcia@gmail.com>
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
 arch/arm64/boot/dts/mediatek/mt6392.dtsi | 133 +++++++++++++++++++++++
 1 file changed, 133 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/mt6392.dtsi b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
new file mode 100644
index 000000000000..d0d86ae0f073
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
@@ -0,0 +1,133 @@
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
+		compatible = "mediatek,mt6392";
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
+			compatible = "mediatek,mt6392-rtc";
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

