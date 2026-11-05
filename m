Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876108;
	b=TFVX/gp8mXRl+/PO4WhhyCtOFuXbkVscaV6H95H1MDnlOAJnG0P6b7IoCo/AXbFNEnAU
	 pfrd+T/uvQoGrfpwSuwwLSMF1KXvgxSWIxm8TWYR23wzkLDd1nV7cDrOIi1D/wEJSm1NG
	 /MDwmy2MZWhe37ECkCOCy/668U/38CjsQwm5/qyvtm/s7oRmPCMoKDItrutWaA7A1Tk2+
	 WFBVnYFixXg9HskLpNTHaigBz+PIDGirCjudy0IdtAeO3TIpZPKqv3+RN1J3zfEfLXZ61
	 3UpcJzjRnAtwDFTO55bDKXEmzgbfGtRzosMPJpaM2fidcPrGfat4cVXocxt67wuCOYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876108;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9+BX+tt1gqzeoENqw9X+SAk7goeD0Yh+YmwwTNSJt4g=;
	b=g0qjCAFDfMiqZRhqG6XXh7rqC0RuEEZSkE3LfhuEraezKo1V/8IW/A4QPH1Hc1z/7JAh
	 tNKL9RUbebHlr7oL4GBqYV0uhu01ME238wj+chZ6rJcPRyUtB3l/xJyIqLGywUdyovaPT
	 UW14gx5m+EyKxz8NPvPqNKw0syrrpb5BqANkMnvHQJx/pFnkuQlNBvBMjwgRFoAbezDMt
	 +EDbmWdLT5EsX7gb8c9s2qqPQzua6v1JZk06c3xTN//ateLsEH7MKENtNAsodt2Csz9DW
	 fNPba66gt0HLK/7c3w6LMQhYOQbzpPEGxo1WAQaHKSYZ9XRx9XerlL+QS7vLS8TJR1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IGzUo3We;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8EC606D826;
	Thu,  5 Nov 2026 10:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IGzUo3We
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793876108;
	b=LJDlZ11Gn45iNVEpjJsuZdxnpzWjP4IAJy7IbZvwZHSxBy2oNURzxrKHkPnSvy8LKOFu
	 MkttNOtWdSI3lVH2uzQxXJZ8dFgpolwWDHjQHseDBevu52BTDuO5VelK5gB0bg+IUs+ao
	 cnkgLRABhqZ73X3wFqf0wGf/Vj6VF61WgxZvF5zu2+vf/r+ixWmoQBlCqf0nYb4/Pg242
	 KknnuMcfdX1z2V3CU+jgtmW5OKus7HNalypDllG89m15L3Hyguf1ngpFd5O2N855EK2HN
	 AJGT0OCot7NCR9w4wARFft06MIDIFz9L6JiG3J2lR/ldoOCXIArqgg76Li24cAgsgiA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793876108;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9+BX+tt1gqzeoENqw9X+SAk7goeD0Yh+YmwwTNSJt4g=;
	b=tmI0CcYgzQ3zD/He3r4hvdazRgC9Cfh6EKGhbcKZEvgjMhPtuHMNt01iWWDKI8wlBath
	 sbTqcn+fAmxQhE8Hj8Pf05wbku3iM3LJNg/qh4fjob3rc0OGbmTaqp0Z4GE/XZDZAgeYF
	 PLYUYPgaYHr00tXJO5UOs6aKG6W/OC2aFY6bMtKdpLcorGSO7ZPAFGN9GRuUCCoyHvjWo
	 RCn2rtEiKVCKhvdE82q5to7eeCh2rImONB3+719YaZ5OMSyoU7Xcqut/omkWttcHoj0v6
	 l/1xK6WI+BT7jvV3nwZGLHSgVVmDZ1h6+sjf+FC5WZp+TVCjnpZHZyCkMfUWfKkrEVA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id F00551F00A23;
	Thu,  5 Nov 2026 10:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793876108;
	bh=9+BX+tt1gqzeoENqw9X+SAk7goeD0Yh+YmwwTNSJt4g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=IGzUo3We1K/+wopMhTq5ZpdS++c4OqS4lu+8KyUDkHTBP+QxQas6cXd8vo8q7AYz/
	 oTmy8jMMcN00oQbtwq1jDTsyICWU0/8uCWjsmr+nDEw9pqI1ElS9GLHKwAU8Wy6JiM
	 2yAtHBYN9feGrBBjCxPFgW2Tu9ESE4IZwec9/mn74173QFeYm1trApeHSY09tcKglB
	 qERWZu1daVgAFulcs5ds8CQbk/hPGm+XycF04LQxuCEQeVYnEjD6jRRItiAU/JaRT1
	 7EkyIe5ihgP4Hv+FOj9VEUH1pUxnCrMx/xENPA66ciMRHCit/GDoec+8vJccGl+oKH
	 pj/opRXre5OWA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9E05147200;
	Thu,  5 Nov 2026 10:55:03 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Thu, 05 Nov 2026 13:54:15 +0300
Subject: [PATCH v8 11/11] arm64: dts: qcom: generalmobile-shamrock: new
 device
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261105-msm8952-initial-support-v8-11-311ae8e8f14b@mainlining.org>
References: <20261105-msm8952-initial-support-v8-0-311ae8e8f14b@mainlining.org>
In-Reply-To: <20261105-msm8952-initial-support-v8-0-311ae8e8f14b@mainlining.org>
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Abel Vesa <abelvesa@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-remoteproc@vger.kernel.org, linux-input@vger.kernel.org, 
 Muzaffer Kadir <muzafferkadir@mainlining.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793876100; l=11481;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=HymBjmE3sNKbpYsY/r6M8zEjNfwrtuOvrLXhgf1+qtM=;
 b=xBs4NXkNFugK6GQ8bfia3EiCuhsAZu+poizw2oTtl0xbw5R5/Ww2Mucq4NtGImPLLUVOiVxtc
 5uaF2nzkrSuCVLSQYYE81nYKyffOyoKN1kD7gPdTMF15f3Vzs/THama
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org
Content-Transfer-Encoding: 7bit

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Add General Mobile Shamrock (GM 5 Plus). Shamrock is designed
similar to L9300. Downstream reference is [1].

[1] https://github.com/Asderdd/android_kernel_generalmobile_shamrock/blob/cm-14.1/arch/arm/boot/dts/qcom/msm8952-l9300.dtsi

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 .../dts/qcom/msm8952-generalmobile-shamrock.dts    | 442 +++++++++++++++++++++
 2 files changed, 443 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 88230c4e00ea..898df8754657 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -130,6 +130,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-samsung-a7.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-sony-xperia-kanuti-tulip.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-wingtech-wt82918.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-wingtech-wt82918hd.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8952-generalmobile-shamrock.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-flipkart-rimob.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-deen.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8952-generalmobile-shamrock.dts b/arch/arm64/boot/dts/qcom/msm8952-generalmobile-shamrock.dts
new file mode 100644
index 000000000000..d9ffdcf24634
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8952-generalmobile-shamrock.dts
@@ -0,0 +1,442 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8952.dtsi"
+#include "pm8950.dtsi"
+#include "pmi8950.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "General Mobile GM 5 Plus";
+	compatible = "generalmobile,shamrock", "qcom,msm8952";
+	chassis-type = "handset";
+	qcom,msm-id = <QCOM_ID_MSM8952 0x0>;
+	qcom,board-id = <QCOM_BOARD_ID_QRD 1>;
+
+	aliases {
+		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
+		mmc1 = &sdhc_2; /* SDC2 SD card slot */
+		serial0 = &blsp1_uart2;
+	};
+
+	battery: battery {
+		compatible = "simple-battery";
+
+		charge-term-current-microamp = <100000>;
+		charge-full-design-microamp-hours = <3100000>;
+		constant-charge-current-max-microamp = <3000000>;
+		constant-charge-voltage-max-microvolt = <4400000>;
+		voltage-min-design-microvolt = <3400000>;
+		voltage-max-design-microvolt = <4400000>;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+
+		framebuffer {
+			compatible = "simple-framebuffer";
+			memory-region = <&cont_splash_mem>;
+
+			width = <1080>;
+			height = <1920>;
+			stride = <(1080 * 3)>;
+			format = "r8g8b8";
+
+			power-domains = <&gcc MDSS_GDSC>;
+
+			clocks = <&gcc GCC_MDSS_AHB_CLK>,
+				 <&gcc GCC_MDSS_AXI_CLK>,
+				 <&gcc GCC_MDSS_VSYNC_CLK>,
+				 <&gcc GCC_MDSS_MDP_CLK>,
+				 <&gcc GCC_MDSS_BYTE0_CLK>,
+				 <&gcc GCC_MDSS_PCLK0_CLK>,
+				 <&gcc GCC_MDSS_ESC0_CLK>;
+		};
+	};
+
+	/* Front Flash */
+	flash-led-controller {
+		compatible = "sgmicro,sgm3140";
+
+		enable-gpios = <&tlmm 33 GPIO_ACTIVE_HIGH>;
+		flash-gpios = <&tlmm 128 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-0 = <&front_flash_default>;
+		pinctrl-names = "default";
+
+		front_flash_led: led {
+			function = LED_FUNCTION_FLASH;
+			color = <LED_COLOR_ID_WHITE>;
+			flash-max-microamp = <1000000>;
+			led-max-microamp = <625000>;
+			flash-max-timeout-us = <1280000>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-0 = <&gpio_hall_sensor_default>, <&gpio_keys_default>;
+		pinctrl-names = "default";
+
+		button-volume-up {
+			label = "Volume Up";
+			gpios = <&tlmm 85 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			wakeup-source;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+
+		event-hall-sensor {
+			label = "Hall Effect Sensor";
+			gpios = <&tlmm 46 GPIO_ACTIVE_LOW>;
+			wakeup-source;
+			linux,input-type = <EV_SW>;
+			linux,code = <SW_LID>;
+			linux,can-disable;
+		};
+	};
+
+	multi-led {
+		compatible = "leds-group-multicolor";
+		color = <LED_COLOR_ID_RGB>;
+		function = LED_FUNCTION_STATUS;
+		leds = <&red_status>, <&green_status>, <&blue_status>;
+	};
+
+	reserved-memory {
+		cont_splash_mem: cont-splash@83200000 {
+			reg = <0x0 0x83200000 0x0 (1080 * 1920 * 3)>;
+			no-map;
+		};
+	};
+
+	vph_pwr: regulator-vph-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "vph-pwr";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&adsp {
+	status = "okay";
+};
+
+&blsp1_i2c2 {
+	status = "okay";
+	/* SMB1351 @1d charger */
+	/* wsa881x-i2c @e @44 @f @45 audio amplifier */
+};
+
+&blsp1_i2c3 {
+	status = "okay";
+
+	/* himax,852x@48 Touchscreen */
+
+	touchscreen@5d {
+		compatible = "goodix,gt970", "goodix,gt911";
+		reg = <0x5d>;
+		interrupts-extended = <&tlmm 65 IRQ_TYPE_EDGE_FALLING>;
+		irq-gpios = <&tlmm 65 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
+		AVDD28-supply = <&pm8950_l10>;
+		VDDIO-supply = <&pm8950_l6>;
+
+		pinctrl-0 = <&touchscreen_default>;
+		pinctrl-names = "default";
+
+		touchscreen-size-x = <1080>;
+		touchscreen-size-y = <1920>;
+	};
+};
+
+&blsp1_uart2 {
+	status = "okay";
+};
+
+&blsp2_i2c1 {
+	status = "okay";
+
+	/* FUSB301 @25 USB-C Controller */
+
+	tpa6130a2: audio-controller@60 {
+		compatible = "ti,tpa6130a2";
+		reg = <0x60>;
+		pinctrl-0 = <&tpa6130a2_default>;
+		pinctrl-names = "default";
+		power-gpio = <&tlmm 61 GPIO_ACTIVE_HIGH>;
+		Vdd-supply = <&pm8950_l22>;
+	};
+
+	tusb320: usb@67 {
+		compatible = "ti,tusb320";
+		reg = <0x67>;
+		interrupts-extended = <&tlmm 45 IRQ_TYPE_EDGE_FALLING>;
+	};
+
+	led-controller@68 {
+		compatible = "si-en,sn3193";
+		reg = <0x68>;
+
+		shutdown-gpios = <&tlmm 68 GPIO_ACTIVE_HIGH>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		red_status: led@1 {
+			reg = <1>;
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_STATUS;
+			led-max-microamp = <17500>;
+		};
+
+		green_status: led@2 {
+			reg = <2>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_STATUS;
+			led-max-microamp = <17500>;
+		};
+
+		blue_status: led@3 {
+			reg = <3>;
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_STATUS;
+			led-max-microamp = <17500>;
+		};
+	};
+};
+
+&pm8950_spmi_regulators {
+	/* PM8950 S5 + S6 = VDD_APC supply */
+	pm8950_s5: s5 {
+		regulator-min-microvolt = <1050000>;
+		regulator-max-microvolt = <1350000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&pm8950_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+
+	status = "okay";
+};
+
+&pmi8950_wled {
+	qcom,enabled-strings = <0 1>;
+	qcom,current-limit-microamp = <30000>;
+	qcom,ovp-millivolt = <29500>;
+	qcom,external-pfet;
+
+	status = "okay";
+};
+
+&ramoops_mem {
+	status = "okay";
+};
+
+&rpm_requests {
+	pm8950_rpm_regulators: regulators {
+		compatible = "qcom,rpm-pm8950-regulators";
+		vdd_s1-supply = <&vph_pwr>;
+		vdd_s2-supply = <&vph_pwr>;
+		vdd_s3-supply = <&vph_pwr>;
+		vdd_s4-supply = <&vph_pwr>;
+		vdd_s6-supply = <&vph_pwr>;
+		vdd_l1_l19-supply = <&pm8950_s3>;
+		vdd_l2_l23-supply = <&pm8950_s3>;
+		vdd_l3-supply = <&pm8950_s3>;
+		vdd_l5_l6_l7_l16-supply = <&pm8950_s4>;
+		vdd_l8_l11_l12_l17_l22-supply = <&vph_pwr>;
+		vdd_l9_l10_l13_l14_l15_l18-supply = <&vph_pwr>;
+
+		pm8950_s1: s1 {
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1225000>;
+		};
+
+		pm8950_s3: s3 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		pm8950_s4: s4 {
+			regulator-min-microvolt = <2050000>;
+			regulator-max-microvolt = <2050000>;
+		};
+
+		pm8950_l2: l2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		/* pm8950_l3 is managed by rpmpd (RPMPD_VDDMX) */
+
+		pm8950_l5: l5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8950_l6: l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8950_l7: l7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8950_l8: l8 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2900000>;
+		};
+
+		pm8950_l9: l9 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		pm8950_l10: l10 {
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+		};
+
+		pm8950_l11: l11 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+			regulator-allow-set-load;
+			regulator-system-load = <200000>;
+		};
+
+		pm8950_l12: l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8950_l13: l13 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3075000>;
+		};
+
+		pm8950_l14: l14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		pm8950_l15: l15 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		pm8950_l16: l16 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8950_l17: l17 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2850000>;
+		};
+
+		pm8950_l19: l19 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1350000>;
+		};
+
+		pm8950_l22: l22 {
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+		};
+
+		pm8950_l23: l23 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+	};
+};
+
+&sdhc_1 {
+	vmmc-supply = <&pm8950_l8>;
+	vqmmc-supply = <&pm8950_l5>;
+
+	status = "okay";
+};
+
+&sdhc_2 {
+	cd-gpios = <&tlmm 67 GPIO_ACTIVE_HIGH>;
+	vmmc-supply = <&pm8950_l11>;
+	vqmmc-supply = <&pm8950_l12>;
+
+	status = "okay";
+};
+
+&sleep_clk {
+	clock-frequency = <32768>;
+};
+
+&tlmm {
+	gpio-reserved-ranges = <20 4>; /* Unknown, TZ Protected */
+
+	gpio_hall_sensor_default: gpio-hall-sensor-default-state {
+		pins = "gpio46";
+		function = "gpio";
+		drive-strength = <6>;
+		bias-pull-up;
+	};
+
+	tpa6130a2_default: tpa6130a2-default-state {
+		pins = "gpio61";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-down;
+	};
+
+	touchscreen_default: touchscreen-default-state {
+		reset-pins {
+			pins = "gpio64";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		irq-pins {
+			pins = "gpio65";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	gpio_keys_default: gpio-keys-default-state {
+		pins = "gpio85";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	front_flash_default: front-flash-default-state {
+		enable-pins {
+			pins = "gpio33";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+
+		flash-pins {
+			pins = "gpio128";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+	};
+};
+
+&xo_board {
+	clock-frequency = <19200000>;
+};

-- 
2.56.0


