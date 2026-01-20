Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B886544A717;
	Tue, 20 Jan 2026 21:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768945265; cv=none; b=BXYAfjLc29lYXNmO4fH7C9Ur/v4Yjr4FteSSDVMQPswViKbe20NhV+JoWExK67jiAp0JX2j4o3/GogBi7z8C8/vQru+xuVn3HeCrPHq6RlFlwPgykZQ0mrEcHh0m3UK5/ZSDU9Kr4KYqdnPz3jg+xYN5Zb3n6oZndYUXH/7Q0+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768945265; c=relaxed/simple;
	bh=l67nESRyJfuCWmAR9yt7cBpBMGDGFkmCexiZLpjYsKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rATP64mBE/3vLEcQdhiwsUx1RNvH/8yGsqen6ItHDmed+OQr3MPK0TdiXxwOzCnkkFz0XOJwArPKuxp8ecquTYt2PKll0KBBkmUua8U7z2C1qvBY5mNkywtEqvcMzMcCaxN4uAKP6Xw1M8t9d1okR8ZC7VHXL6ISEUm4WgHC52c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JoLRF7xk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoLRF7xk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 250A6C19425;
	Tue, 20 Jan 2026 21:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768945264;
	bh=l67nESRyJfuCWmAR9yt7cBpBMGDGFkmCexiZLpjYsKo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JoLRF7xkj/uq242BK0GAhN+g3cRIW8PYHOAVTKyodHTiv6KUlN10Vv7zNKYhIUwXH
	 mSZXiw+6/XAQwpYiSxzHL9l5dM2ELe4P0feU0HTSpFzkOnV9USaTzgM8xuXKxf73fd
	 ATVT3Dxv/0m6F/vbdpAZfKVXfsdTnFDpzhimOqc5W+618+/E7pk8UUrQ6JRdGaT5e0
	 WG66+pHLbivkKfOsb5biKPLwbS+tyBtFk3T3Qk2wGesBQ2pBpainKPGKlx166kneQ/
	 3Qpi11Q4CS3G+t+eioBtnY90GwTmAoVjA+UxzCvs95+7aOIcU2rRmYxM445Ny4bFQh
	 wzOHNsqwbUOjA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD37D262A7;
	Tue, 20 Jan 2026 21:41:04 +0000 (UTC)
From: Yedaya Katsman via B4 Relay <devnull+yedaya.ka.gmail.com@kernel.org>
Date: Tue, 20 Jan 2026 23:40:56 +0200
Subject: [PATCH v4 3/3] arm64: dts: qcom: sm6125-xiaomi-laurel-sprout: Add
 Focaltech FT3518 touchscreen
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260120-touchscreen-patches-v4-3-30145da9d6d3@gmail.com>
References: <20260120-touchscreen-patches-v4-0-30145da9d6d3@gmail.com>
In-Reply-To: <20260120-touchscreen-patches-v4-0-30145da9d6d3@gmail.com>
To: =?utf-8?q?Kamil_Go=C5=82da?= <kamil.golda@protonmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Yedaya Katsman <yedaya.ka@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768945262; l=3196;
 i=yedaya.ka@gmail.com; s=20260113; h=from:subject:message-id;
 bh=0OJcZN5EkgFMxF6oJTCa+mjxwCLl+uegWcoEfOLwYYU=;
 b=hdxeCV8WmSK99x2zhrzB4aAtWrvG3y+/Smar6Z5HHOl+meNxRBjTRmGbHE2yr1oI0/iIc9PhF
 8fTVBNiphLYB+euiIalcxllSwHKAF/Lbu5fcquWWbAEaKPBb0uQvSYb
X-Developer-Key: i=yedaya.ka@gmail.com; a=ed25519;
 pk=CgNmxD3tYSws5dZfpmJfc6re/bV/f47veVijddHLytk=
X-Endpoint-Received: by B4 Relay for yedaya.ka@gmail.com/20260113 with
 auth_id=601
X-Original-From: Yedaya Katsman <yedaya.ka@gmail.com>
Reply-To: yedaya.ka@gmail.com

From: Yedaya Katsman <yedaya.ka@gmail.com>

Add device tree node for the Focaltech FT3518 touchscreen on
Xiaomi Mi A3 (laurel-sprout).

Note that gpio pin 83 for the regulator isn't documented downstream
except in the touchscreen node so it's not defined in the tlmm.

Enable qupv3_id_0 and i2c2 bus that the touchscreen is on.

Downstream references:
Link: https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/laurel-r-oss/arch/arm64/boot/dts/qcom/trinket-pinctrl.dtsi
Link: https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/laurel-r-oss/arch/arm64/boot/dts/qcom/laurel_sprout-qrd.dtsi

Co-developed-by: Kamil Gołda <kamil.golda@protonmail.com>
Signed-off-by: Kamil Gołda <kamil.golda@protonmail.com>
Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
---
 .../boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts  | 65 ++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
index 994fb0412fcbdf5466f87a325c48b697a37b514b..ea9dbc6927a14ca66da818b81aeb0c95ec3c2e7a 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
@@ -82,6 +82,18 @@ key-volume-up {
 		};
 	};
 
+	ts_vdd_supply: regulator-ts-vdd {
+		compatible = "regulator-fixed";
+		regulator-name = "ts_vdd_supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 83 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		startup-delay-us = <70000>;
+	};
+
 	thermal-zones {
 		rf-pa0-thermal {
 			thermal-sensors = <&pm6125_adc_tm 0>;
@@ -128,6 +140,27 @@ &hsusb_phy1 {
 	status = "okay";
 };
 
+&i2c2 {
+	status = "okay";
+
+	touchscreen@38 {
+		compatible = "focaltech,ft3518";
+		reg = <0x38>;
+		interrupts-extended = <&tlmm 88 IRQ_TYPE_EDGE_FALLING>;
+
+		vcc-supply = <&ts_vdd_supply>;
+
+		pinctrl-names = "default","sleep";
+		pinctrl-0 = <&ts_int_active &ts_reset_active>;
+		pinctrl-1 = <&ts_int_suspend &ts_reset_suspend>;
+
+		reset-gpios = <&tlmm 87 GPIO_ACTIVE_LOW>;
+
+		touchscreen-size-x = <720>;
+		touchscreen-size-y = <1560>;
+	};
+};
+
 &pm6125_adc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&camera_flash_therm &emmc_ufs_therm>;
@@ -220,6 +253,10 @@ &pon_resin {
 	status = "okay";
 };
 
+&qupv3_id_0 {
+	status = "okay";
+};
+
 &rpm_requests {
 	regulators-0 {
 		compatible = "qcom,rpm-pm6125-regulators";
@@ -387,6 +424,34 @@ &sdhc_2 {
 
 &tlmm {
 	gpio-reserved-ranges = <22 2>, <28 6>;
+
+	ts_reset_active: pmx-ts-reset-active-state {
+		pins = "gpio87";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+
+	ts_reset_suspend: pmx-ts-reset-suspend-state {
+		pins = "gpio87";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	ts_int_active: pmx-ts-int-active-state {
+		pins = "gpio88";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+
+	ts_int_suspend: pmx-ts-int-suspend-state {
+		pins = "gpio88";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
 };
 
 &ufs_mem_hc {

-- 
2.52.0


