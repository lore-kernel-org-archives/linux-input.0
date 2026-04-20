Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B888307AC6
	for <linux-input@vger.kernel.org>; Mon, 20 Apr 2026 21:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776721209; cv=none; b=u6lKA6C7+EhxcnI0nRkV7m5nVDKR6A5q4dEcbxQqEtT0Rjikw2zt0njQFH5TCd86MsvA6Bd8/2s21Z+CCAkNqt7YjkyaLInbq3X9mKieE1V6bK4r6KHYqhRNxQlN9a8JJKWYobb7WFlxiyXUPeWJhJtau1kz00rAFcf/SzByl6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776721209; c=relaxed/simple;
	bh=ferQ/I0Y9PK2QH16FMGnGF2+/wylIAM94hfiAZxJn5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBHed8toa7L3udomw3JtiJ0sA0BB59GqzJ9arZkbCHMq+1eZV3TG+A8NAvZTH3wd8FheIdNtFLwvpOkGfN7AtHc0emBp7W7bKPi32YCGO9Ri3BHZAEDfx6+NieWwdJLtzR1byqfByw/CtVGLnXovSff/01azr21ETdQ9/tXJznQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+CW/Lj2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+CW/Lj2"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so55438835e9.2
        for <linux-input@vger.kernel.org>; Mon, 20 Apr 2026 14:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776721207; x=1777326007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXtK/Bb6scSWKAWFi8Dh0zrFz4wUjG5d2vtkn8qVfbU=;
        b=D+CW/Lj2bp/pRhTxkcG1ElQEfkOoYApPZZy4Hgr6JE5O6u9V+srlWfdxt9wvyZ9J0T
         ib26Ydk7vFOPGUyQ0PxECO3r6IBdpw20M4zJfHHNkom9cD/ixuTaNMt/Enmm0MSaSey5
         qGunbsz6+msQaLfSTIkDN2IvaODGl9COscsVWV0eqVjT7ilDVqFelIt1eqtDeR6cCDND
         qTrtX4brYm41oQbEciQQ/oNISA4sI1C/7pBCcCBVXdkuj7N7bEOqFMON4u1ns9PUrsao
         CJxdXWi53xqe25TukBQwZhm0QR3Rb2J+Q/MvFHX24BOuIraDHQBIxXC1Rpb9BltmLAvW
         nwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776721207; x=1777326007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pXtK/Bb6scSWKAWFi8Dh0zrFz4wUjG5d2vtkn8qVfbU=;
        b=UhDLFJeofdN8d9Lx0OJkTwxxT0gmFVrprASqfAI2q4Odhy00f4wUtb1nBmo1HcXgL2
         WmWvUSGEuzRs++yI+fiAesY5kDFnFzwSQZze4Kf0Dml+tKcmGNk8y2iEs7NGp9WBZPF1
         rugn9PiKUHYCJw5lvfRv3i2pm/fgxHcf31MepajkRZ6El7iTb7WQW99qG6SPuFygNFHA
         pQA877s9ag5okY8J5bCrxYfrDXUzIPd296yV5lb2sFPFEDr/ghNWUEq9g9iVhZqZaW7b
         unf/RV3JH6XuKO/u6DvOqLl9MTN+PwXM5HwkKQjd+xUGRJU4GKeBPe5UCoDPviaIis5Y
         ZEFA==
X-Forwarded-Encrypted: i=1; AFNElJ+j3q18t2vG6auPRPXs6AdKnGPNmTxaXRUulXE0N0HzvVMltGm3UNQiutXLGT0SgoeX4gInq8wTsPYXmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YweUN1iVVyJz0ANioLML0g11Iq49/3meT0A+7kprM6lHDBmH7ml
	q/fOPXb4TauMovRzuSwHaEiBnTeW+f0n3FlpLIab7LK8k8K4rBe9IvVt
X-Gm-Gg: AeBDievRRwDRvCf6AHjS3WzvI9oslWztup2Pwt7x+8SBdYNXqoAioh2jtReWn4v+5Ta
	7mcijeyar1wPlCAAioXhoPzwqIOlgNVu2tk3xIXUSa98jBuY1cxLdMRAChv7FDC17NI9FmIfKVn
	pgQNiscXdAiyBNfCAH6Bm+1+IZrfos+OzSiSDJHooDgABelhBjllBxaaHqZeekUMgHmZ9svpQ9D
	rEKjmt/y0T5KlKe4npAOwJZ2u4axSUhgCdjesrwUHdUS9XodLGB33K71yyjpnpsrJ+9CZvi4Gxo
	f1cweIc2FUq6B58oOYHGMGmykEVA004Y/80fff8hkXpLpp3CPn5bXeRabxfTr5zdxve9FNPdD9N
	ZoUUHZhNSZeoDK3d0athR89ZVR6oOtP5S7rwluvdZPnBQCC4J0aRbMZU1u5Nmy0JRdcpV9Cr8aD
	cDZujaq3fmQnb5xyDXag/PUzEfuHLVSg==
X-Received: by 2002:a05:600c:4f13:b0:489:1a65:dd6e with SMTP id 5b1f17b1804b1-4891a65de3emr105875175e9.8.1776721206634;
        Mon, 20 Apr 2026 14:40:06 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc140c82sm289500355e9.12.2026.04.20.14.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 14:40:06 -0700 (PDT)
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
	Linus Walleij <linusw@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Gary Bisson <bisson.gary@gmail.com>,
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
Subject: [PATCH v5 9/9] arm64: dts: mediatek: Add MediaTek MT6392 PMIC dtsi
Date: Mon, 20 Apr 2026 22:30:08 +0100
Message-ID: <20260420213529.1645560-10-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420213529.1645560-1-l.scorcia@gmail.com>
References: <20260420213529.1645560-1-l.scorcia@gmail.com>
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
 arch/arm64/boot/dts/mediatek/mt6392.dtsi | 73 ++++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/mt6392.dtsi b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
new file mode 100644
index 000000000000..750ee9b2856f
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
@@ -0,0 +1,73 @@
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
+
+		pio6392: pinctrl {
+			compatible = "mediatek,mt6392-pinctrl";
+
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		rtc {
+			compatible = "mediatek,mt6392-rtc",
+				"mediatek,mt6323-rtc";
+		};
+
+		mt6392regulators: regulators {
+			/* Fixed supply defined in the data sheet */
+			avddldo-supply = <&mt6392_vsys_reg>;
+
+			mt6392_vcore_reg: vcore { };
+			mt6392_vproc_reg: vproc { };
+			mt6392_vsys_reg: vsys { };
+			mt6392_vaud28_reg: vaud28 { };
+			mt6392_vxo22_reg: vxo22 { };
+			mt6392_vaud22_reg: vaud22 { };
+			mt6392_vadc18_reg: vadc18 { };
+			mt6392_vcama_reg: vcama { };
+			mt6392_vcn35_reg: vcn35 { };
+			mt6392_vio28_reg: vio28 { };
+			mt6392_vusb_reg: vusb { };
+			mt6392_vmc_reg: vmc { };
+			mt6392_vmch_reg: vmch { };
+			mt6392_vemc3v3_reg: vemc3v3 { };
+			mt6392_vcamaf_reg: vcamaf { };
+			mt6392_vgp1_reg: vgp1 { };
+			mt6392_vgp2_reg: vgp2 { };
+			mt6392_vefuse_reg: vefuse { };
+			mt6392_vm25_reg: vm25 { };
+			mt6392_vdig18_reg: vdig18 { };
+			mt6392_vm_reg: vm { };
+			mt6392_vio18_reg: vio18 { };
+			mt6392_vcn18_reg: vcn18 { };
+			mt6392_vcamd_reg: vcamd { };
+			mt6392_vcamio_reg: vcamio { };
+			mt6392_vrtc_reg: vrtc {	};
+		};
+	};
+};
-- 
2.43.0

