Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D1947B43D
	for <linux-input@vger.kernel.org>; Fri,  5 Jun 2026 07:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780643410; cv=none; b=coopo5z1E7BJx6ICm7EUZHyG8wMU664HObbHyiKagdtiMLV0Ns4taRIgUYAerYKRxQMjWbzn3YAyQ6LAmqjwbtvUQLf7okpy8SyViy1c8os+VQkHg+0PdzcOAsnk4HbRrPxLL3fdWekIRc9jnnScXMgcW3oHs0zFPwlCVD1VGeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780643410; c=relaxed/simple;
	bh=pp5heEpgmgSTEW3K21CAryOZq4j/ircBiHwaoeSCdYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QnF7vJW+LBKlR8IN40TxIe6ThtBl+cBdQteXSnbHLhPrG6c9ADQTSrLP9olULvnTPS7xGDN1b9bBPgrJrt3emFTPbpviJh+G7q1yQTxThmph2nv8bRHwqqfYFoC+Q44RlTJVCVGvDKaXGgkB7ASN5pLrvhyQcu96X6qTv2VoQY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkeHVBUQ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkeHVBUQ"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4600ddc4017so1191201f8f.0
        for <linux-input@vger.kernel.org>; Fri, 05 Jun 2026 00:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780643406; x=1781248206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqzhMeEc+Wgxf+HH46mg5KPvRwxrTlYFNd0Qvb6R2sA=;
        b=SkeHVBUQwAUA+Hw8/ZWpTlLQCv512X85d9HQxtxxQ02JW9CYnUnOuq5YgnACQAZotR
         Pg++HUkl/N1maacdL1q7JuxfmTUQLXrFtb0tO9opd7SI/qvntZfoctW17Of3syocU1rh
         w5bjZ9CU2K1fUh69wkHMf47hPMx5mp1I+NHZeTpixI1Rnr3+PuhG9ybO4NXKrGYu96hN
         tbQRUinZgSo94edbHXLGLs+joEHe1cbUENWbHLh2tWhZkwZ/gp497+uU4GnRcwJ1ZX7N
         WpKttdEvENzSgIUwU45ChGAc304dwk86CS8GfeZfsldWzSb72uUsqIBHI2CwFCMtEukU
         zSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780643406; x=1781248206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uqzhMeEc+Wgxf+HH46mg5KPvRwxrTlYFNd0Qvb6R2sA=;
        b=hUaYhrSunHl8rfX5Vv1boEEgauq2raLzMyqCiL3HqpIoG0z4kLFownZsQq/4aKGE8I
         whU16FXuq255kjfs8fNs/hudxnergAPQKc8et9ibT+CO9P6bk0/moV+bSWX6U25oQhRI
         8Rub+bqVpbxJJ4xMbXv2Uz43ah3TT5KqrWFsxxQZOXbml2ESXpr1YPsBVqh/82v79ZTr
         hC/Pzb6/wAvqrhPmemgDkJuo8z4F1nuSm4WOOVBTVuNH5h67wGmGfRAaPE6cM2RqnyFc
         vg0Kv1VYO3Yi+rQ1gO5ORvQ/tl5bAiA2k9CWxotGPYop/r7WqNXWV7vIflbT0hEtxGlc
         7/4g==
X-Forwarded-Encrypted: i=1; AFNElJ8JKNS+9uA25W/Y315vc/6/iX7euPve5IHxWsNCQ/9C69lGTDb8Qx2GRC+1i1kgWDemX7yqEo9m1IOx4w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0EqQXVCl208+64SdrHjoeXeXwnBuh0rlRyG2J+8BGKLXBSydI
	vd0+nLQuQ7ciUJGbZpB/RUnK1X2HB3Mr7btA8xnlUtBPpw+nfEMEP1/q
X-Gm-Gg: Acq92OFxkeTfaeZuxrJheq8rNVXDzoIahb+oA2Zb+zFB6ZUjsdxjaoJiDqaLpoo9IIt
	LIMZxdG1X65jOgsf9LqboRsCnIAYeXb7Y1+y1CEBGG2eMxd0IIBi4hniho0IxbYYsIcch5CEox3
	wOKoZyyCloFilSYIbd7sgju0LXbevIes+Gy+ZY4zvm+FrcTMvTFitwxbEjUqueKO+Hih9dVtS0x
	7sH9s7CSUCMieDFWeOZuk2NUDL0i2N8NPRrhWISjBHvvp7USD/OSX0WVsoidRNQI6xvZK1Yt/6V
	3J7cwJdt7qX3v1OSZWb0KRkh7eV4nF7IRWjtus5rTLYKpGty/MMHyw3gCFGI5YmO8v5vPFb9Wn3
	SfF0hFQf7X5WPsG2lhTYZ0jNAzqpHTss74bPYaZwMF+6VSnLZjdF7gLPhhvFv/Lcb3U8u8Lk0/i
	F3fPEqmvhyP4fqgWIDExxdvsLy1Kc+R7wBsb0huteRS899FXWUGszwPUnDBi8GUeZbbR6qqXWz5
	8OTDznrS2cfOlxpJj3mCQ==
X-Received: by 2002:a05:6000:e52:b0:45e:a0ab:8bcb with SMTP id ffacd0b85a97d-460302e45f7mr2476891f8f.15.1780643405978;
        Fri, 05 Jun 2026 00:10:05 -0700 (PDT)
Received: from localhost.localdomain (72.92.4.85.dynamic.cust.swisscom.net. [85.4.92.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm25132882f8f.5.2026.06.05.00.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 00:10:05 -0700 (PDT)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hans de Goede <hansg@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Jun Yan <jerrysteve1101@gmail.com>,
	Lukas Schmid <lukas.schmid@netcube.li>,
	=?UTF-8?q?J=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
	Eric Biggers <ebiggers@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Luca Weiss <luca@lucaweiss.eu>,
	Sven Peter <sven@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v4 7/7] arm64: dts: allwinner: A133: add support for Baijie Helper A133 board
Date: Fri,  5 Jun 2026 09:09:21 +0200
Message-ID: <20260605070923.3045073-8-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605070923.3045073-1-alexander.sverdlin@gmail.com>
References: <20260605070923.3045073-1-alexander.sverdlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Baijie Helper A133 board is a development board around Baijie A133 Core
SBC. Features:

- 1/2/4GiB LPDDR4 DRAM
- 8/16/32GiB eMMC
- AXP707 PMIC
- USB-C OTG port in peripheral mode (via onboard hub)
- 2 USB 2.0 ports
- MicroSD slot and on-board eMMC module
- Gigabit Ethernet
- Bluetooth
- WiFi

Add initial support for both the Helper and Core boards, including UART,
PMU, eMMC, USB, Ethernet, LRADC-connected buttons.

UART1 can only be used for Bluetooth module, but BT-WiFi combo Allwinner
AW869A chip has no mainline driver currently.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
Changelog:
v4:
- renamed "sun50i-a133-baijie-helper.dtb" -> "sun50i-a133-helperboard.dtb"
- added "model" property into root of sun50i-a133-helperboard-core.dtsi
- added "cap-mmc-highspeed" and "max-frequency" into &mmc2
- added "x-powers,drive-vbus-en" and "*-supply" into &axp803
- dropped all "regulator-enable-ramp-delay" properties
- replaced &reg_dcdc3 with a "polyphased" comment
- exact DRAM voltage in &reg_dcdc5
- disabled &reg_dcdc6 to avoid "[   31.710641] dcdc6: disabling"
- added &reg_vdd5v "root" regulator
- added "disable-wp" into &mmc0
- commented &usb_otg
- assigned usb1_vbus-supply in &usbphy
v3:
- added my copyrights into the newly introduced DTs
- all DT nodes sorted alphabetically
- all always-on regulators commented/propetly named
- all regulators got proper voltages (not default ranges)
- ADC-sensed buttons K1..K5 added
- re-labelled "eth_phy" -> "rgmii_phy"
- usbphy 0 switched from host into peripheral mode (downstream from an
  onboard hub)
- typo sun50i-a133-baije-core.dtsi -> sun50i-a133-baijie-core.dtsi
v2:
- introduced baijie,helper-a133-core compatible for the Core (SoM) board

 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../sun50i-a133-helperboard-core.dtsi         | 197 ++++++++++++++++++
 .../dts/allwinner/sun50i-a133-helperboard.dts | 148 +++++++++++++
 3 files changed, 346 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a133-helperboard-core.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a133-helperboard.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index d116864b6c2b..cf8434064b0d 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -18,6 +18,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-baseboard.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-teres-i.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h64-remix-mini-pc.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a100-allwinner-perf1.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a133-helperboard.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a133-liontron-h-a133l.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-bananapi-m2-plus.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-bananapi-m2-plus-v1.2.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a133-helperboard-core.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a133-helperboard-core.dtsi
new file mode 100644
index 000000000000..545972d2324a
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a133-helperboard-core.dtsi
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2025 Arm Ltd.
+ * Copyright (c) 2026 Alexander Sverdlin <alexander.sverdlin@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "sun50i-a100.dtsi"
+#include "sun50i-a100-cpu-opp.dtsi"
+
+/{
+	model = "Baijie A133 HelperBoard Core";
+	compatible = "baijie,helperboard-a133-core",
+		     "allwinner,sun50i-a100";
+
+	aliases {
+		serial1 = &uart1;	/* BT module */
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
+&lradc {
+	vref-supply = <&reg_aldo1>;
+};
+
+&mmc2 {
+	vmmc-supply = <&reg_dcdc1>;
+	vqmmc-supply = <&reg_eldo1>;
+	cap-mmc-highspeed;
+	cap-mmc-hw-reset;
+	max-frequency = <100000000>;
+	non-removable;
+	bus-width = <8>;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	status = "okay";
+};
+
+&pio {
+	vcc-pb-supply = <&reg_dcdc1>;
+	vcc-pc-supply = <&reg_eldo1>;
+	vcc-pd-supply = <&reg_dcdc1>;
+	vcc-pe-supply = <&reg_dldo2>;
+	vcc-pf-supply = <&reg_dcdc1>;
+	vcc-pg-supply = <&reg_dldo1>;
+	vcc-ph-supply = <&reg_dcdc1>;
+	/*
+	 * PL0/PL1 are the I2C connection to PMIC, but it would create a
+	 * circular dependency:
+	 * vcc-pl-supply = <&reg_aldo3>;
+	 */
+};
+
+&r_i2c0 {
+	status = "okay";
+
+	axp803: pmic@34 {
+		compatible = "x-powers,axp803";
+		reg = <0x34>;
+		interrupt-parent = <&r_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		x-powers,drive-vbus-en;		/* set N_VBUSEN as output pin */
+		aldoin-supply = <&reg_vdd5v>;
+		dldoin-supply = <&reg_vdd5v>;
+		eldoin-supply = <&reg_vdd5v>;
+		fldoin-supply = <&reg_dcdc5>;
+		vin1-supply = <&reg_vdd5v>;
+		vin2-supply = <&reg_vdd5v>;
+		vin3-supply = <&reg_vdd5v>;
+		vin4-supply = <&reg_vdd5v>;
+		vin5-supply = <&reg_vdd5v>;
+		vin6-supply = <&reg_vdd5v>;
+		drivevbus-supply = <&reg_vdd5v>;
+	};
+};
+
+#include "axp803.dtsi"
+
+&ac_power_supply {
+	status = "okay";
+};
+
+&reg_aldo1 {
+	/* PLL + LRADC analog reference */
+	regulator-always-on;
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "vcc-pll";
+};
+
+&reg_aldo2 {
+	/* LPDDR */
+	regulator-always-on;
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "vdd18-lpddr";
+};
+
+&reg_aldo3 {
+	/*
+	 * Port L, but linking it to &pio node would create a circular
+	 * dependency because of PL0/PL1 I2C connection to PMIC
+	 */
+	regulator-always-on;
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "vcc-pl";
+};
+
+&reg_dcdc1 {
+	/* Besides Port D it also powers analog part of USB IP and SoC I/O */
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-3v3";
+};
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <810000>;
+	regulator-max-microvolt = <1200000>;
+	regulator-name = "vdd-cpu";
+};
+
+/* DCDC3 is polyphased with DCDC2 */
+
+&reg_dcdc4 {
+	/* Digital part of USB IP, "System" SoC power rail */
+	regulator-always-on;
+	regulator-min-microvolt = <950000>;
+	regulator-max-microvolt = <950000>;
+	regulator-name = "vdd-sys";
+};
+
+&reg_dcdc5 {
+	regulator-always-on;
+	regulator-min-microvolt = <1100000>;
+	regulator-max-microvolt = <1100000>;
+	regulator-name = "vcc-dram";
+};
+
+/* DCDC6 unused */
+&reg_dcdc6 {
+	status = "disabled";
+};
+
+&reg_dldo1 {
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "vcc-pg";
+};
+
+&reg_dldo2 {
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "vcc-pe";
+};
+
+&reg_dldo3 {
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-name = "avdd-csi";
+};
+
+&reg_dldo4 {
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-name = "afvcc-csi";
+};
+
+&reg_eldo1 {
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "vcc-pc";
+};
+
+&reg_eldo2 {
+	regulator-min-microvolt = <1200000>;
+	regulator-max-microvolt = <1200000>;
+	regulator-name = "dvdd-csi";
+};
+
+/* ELDO3 unused */
+
+&reg_fldo1 {
+	/* CPUS power rail */
+	regulator-always-on;
+	regulator-min-microvolt = <900000>;
+	regulator-max-microvolt = <900000>;
+	regulator-name = "vdd-cpus";
+};
+
+/* reg_drivevbus unused */
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a133-helperboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a133-helperboard.dts
new file mode 100644
index 000000000000..694c0cacf906
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a133-helperboard.dts
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2025 Arm Ltd.
+ * Copyright (c) 2026 Alexander Sverdlin <alexander.sverdlin@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "sun50i-a133-helperboard-core.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/leds/common.h>
+
+/{
+	model = "Baijie HelperBoard A133";
+	compatible = "baijie,helperboard-a133",
+		     "baijie,helperboard-a133-core",
+		     "allwinner,sun50i-a100";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led {
+			function = LED_FUNCTION_INDICATOR;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&pio 7 13 GPIO_ACTIVE_LOW>;	/* PH13 */
+		};
+	};
+
+	reg_vdd5v: vdd5v {
+		/* board wide 5V supply from a 12V->5V regulator */
+		compatible = "regulator-fixed";
+		regulator-name = "vdd-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&emac0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii0_pins>;
+	phy-handle = <&rgmii_phy>;
+	phy-mode = "rgmii-id";
+	allwinner,rx-delay-ps = <200>;
+	allwinner,tx-delay-ps = <200>;
+	status = "okay";
+};
+
+&lradc {
+	wakeup-source;
+	status = "okay";
+
+	button-115 {
+		label = "K1";
+		linux,code = <KEY_1>;
+		channel = <0>;
+		voltage = <114607>;
+	};
+
+	button-235 {
+		label = "K2";
+		linux,code = <KEY_2>;
+		channel = <0>;
+		voltage = <234783>;
+	};
+
+	button-360 {
+		label = "K3";
+		linux,code = <KEY_3>;
+		channel = <0>;
+		voltage = <360000>;
+	};
+
+	button-476 {
+		label = "K4";
+		linux,code = <KEY_4>;
+		channel = <0>;
+		voltage = <476471>;
+	};
+
+	button-592 {
+		label = "K5";
+		linux,code = <KEY_5>;
+		channel = <0>;
+		voltage = <591946>;
+	};
+};
+
+&mdio0 {
+	reset-gpios = <&pio 7 11 GPIO_ACTIVE_LOW>;	/* PH11 */
+	reset-delay-us = <10000>;
+	reset-post-delay-us = <150000>;
+
+	rgmii_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+	};
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_dcdc1>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
+	bus-width = <4>;
+	disable-wp;
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&rgmii0_pins {
+	drive-strength = <30>;
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pb_pins>;
+	status = "okay";
+};
+
+&usb_otg {
+	/*
+	 * Connected to a downstream port of an onboard hub, therefore only
+	 * "peripheral" mode will work here.
+	 */
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usbphy {
+	usb1_vbus-supply = <&reg_vdd5v>;
+	status = "okay";
+};
-- 
2.54.0

