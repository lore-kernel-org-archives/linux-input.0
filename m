Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAC83AD520
	for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 20:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782247730; cv=none; b=WHYjQj2tLiXCOo84+0eKfHGSkXZ6eyS8TFTYxZR7lRxcI1r2qIcuZAcsSBdy1h4flLGjcJB9ZjNPDtYV3nc2Zi4h7YOguEIOK5nxzf54QHcbd6AADjJbRQT37QAI78Ou/zxyxX1BEXu+RJiHI7redXYBfYRAH4wv5LyX7Hcovxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782247730; c=relaxed/simple;
	bh=imH5HQRFwuaZyrrTMfswXOP+C744Ym8WUzXtL2cxVSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0P48ZUdMxeSlTFOAZs6E0vgmBUMUp7UerLEvkJBdcxCvhnfujwToqQyuufhjUW6RoSWUNWmwnDHJqZ/YhH81qHPIuLsG+Z2kzRk9QM0rwc8h2WNA2UrKvKHJDSWQoUONRo3RXedfn9hLoEFY0I9wDvTF8iLfOjR6zW0kDxIkkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVUHq0Bl; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVUHq0Bl"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45f3cf907ceso138859f8f.2
        for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 13:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782247724; x=1782852524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpwmh+JDDGegnFSzMspybYCunWyCARRw7ITPQqgM/JQ=;
        b=TVUHq0BlCGoH0KKcxxS8NHFNSY2hg0obOYKso/Ou+b8KO3r5Xuc958ssYIsBO8L5nR
         v8Z4eKxWBkzKWWaQsJHanrDfibRs/uwdouiIbh+M8E1rPbi1sudSEhEpEa71m3WS4eP5
         2Xh++a4pz71sDFF9tatpUvyrXnZV9qPrgrSnApv4u40TKqrZzdAj2p+X3fF21oi//yEu
         J6Ee5OlYb8j6be/R9ilydhvBtPsPSAIkWIFIVYaq4TTI9U3tT3ogbBfA8L7WV3GJyRvi
         cZGXv4S0z1N7AkC2wSF+9qBuy7OFd++j7Zpc45LZXAPTNxHEScAHDXbed9SxvIkFZfxv
         QnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782247724; x=1782852524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gpwmh+JDDGegnFSzMspybYCunWyCARRw7ITPQqgM/JQ=;
        b=ToWr1qvW15KZ0ghvdPcybaFwHD4CjCh609AeCmEThu3H+1hVNaBghRlffqz9wKRLRi
         RoBFSMkOPQOKmynrmsjdUlc6aG8Nd1UZeOXRe1E9vPNT17/7qnHrIhZnaswKfmCEeBLN
         glY01WhkB65Tkm+gWXGX8JVbdYxGhFPryAHM34yVQuK6qvCrDrEpV06R6j+u+6oIBAVD
         qJVAqKyL8/Y9b30pnvQynVJemengiqdOedtqxvaXfmNkNaofBPrBtMMg8omBuBD/mJxN
         M5pQxVP2QV8bcMa0gW5c/vLPI4mWLEZG2dQS0rLUhMYYlLWzVfTHOGIjaOofq5AC4/Mp
         JWzg==
X-Forwarded-Encrypted: i=1; AHgh+RrL8HhFjo8Hvy2Zx063tFv6XxR3ZQQ57B408sL6LASgiOJqEJ+zINT9ZwZvsS4lWP0jQkU98hnh4l5iqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOuAGAhKJwZyS+jhD8EHI5PO+edHB8P4qWGj6XRw4Q67mjKewa
	sVBGFApJR9fMuf0fN4yqrVke3LLm4sobAlnWbDH0srwIqsHDa0J6daRT
X-Gm-Gg: AfdE7cmul0E1/LEDn4ud4DpyLiocBYXQPwqvwU2zcWqd7DzuW1Y1pn7aHscMjip2P8x
	F7plPDav3phqdy0LuzOZgkpH1L7t3Kz7URiOPqBQmp8qV1kg45GLfvcXOEIvxv2wWTsllKRleU1
	XgcjCwm6pf0V9nIY7mPZZdCJWsWNH6xKAWiZGjUi9dSD4bT4ObXUDslwPD4uCgxFHuy7GygxOWD
	DbigKjKJCnXvWCAsgbZlrIQMAtvumwquVjqwKFB9UK4/owC3RasZxMTtjWVFy/uGHQ+qQeYaKpU
	yu0UjnWHSFtWutPV3L9zgditLpcPhwsm/BGxw0pyPO3MUG1Ufc1BomoJJIAopmK7Ku+In+XDofF
	Lk5NQSnm/C2oEQMi02KcucVKzjEpdB541YWlz09OSSjbcogPMUQ+dGBLkxrgxkIziEDEeUpxP1/
	PZdGuXAEo94wj70KZdQ+X1C4g1JSHVdEHXlqIkNU2mCA==
X-Received: by 2002:a05:6000:2203:b0:452:273:5cd6 with SMTP id ffacd0b85a97d-46c04a33d97mr899375f8f.1.1782247724061;
        Tue, 23 Jun 2026 13:48:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1e840f80sm351996f8f.6.2026.06.23.13.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 13:48:43 -0700 (PDT)
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
Subject: [PATCH v5 6/6] arm64: dts: allwinner: A133: add support for Baijie Helper A133 board
Date: Tue, 23 Jun 2026 22:48:18 +0200
Message-ID: <20260623204824.691832-7-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623204824.691832-1-alexander.sverdlin@gmail.com>
References: <20260623204824.691832-1-alexander.sverdlin@gmail.com>
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

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
Changelog:
v5:
- no changes
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
index 53e6b701e7d3..aa21f58a4be1 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -24,6 +24,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-baseboard.dtb
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

