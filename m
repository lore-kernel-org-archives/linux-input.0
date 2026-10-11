Received: from mail.nozomi.space (mail.nozomi.space [139.162.184.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F273353A65;
	Sun, 11 Oct 2026 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.184.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791742930; cv=none; b=KwGbqMN31HObTPlUwPF6E79XOKdnVjwekzcTHA2SD2uaAJbq+WkmHO9N+gCX4YfZwbdWiToXVLyoSGxRxDOrKpnFkW+34DSAWp81ol2ReNdlL5Qn1YMrMTBwX5VyVm4eO1p+fLGZTMiIeJK4yjwM8Cs8nC069kcmR+pL+8rBS/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791742930; c=relaxed/simple;
	bh=KVwA7vT/ArTQGCB2bwxvwiKApYsI4viXyt2Kc6Gkwhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XArun2cRPRWNiRT8z6XQwdQS9uvQ0cBRmN3bO9VsDqeWsiCPk0jJid/n8X1linUohXCG4d7o41LWvjugjBWOBW997xnG31wsy8ungo+myVH/LqJ2wZ92zhu27OxBxyk2CfI1auqISEbDysW//jV+Y0JhAF4bNXTA2Jki8DulA6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nozomi.space; spf=pass smtp.mailfrom=nozomi.space; dkim=pass (2048-bit key) header.d=nozomi.space header.i=@nozomi.space header.b=cCyVbH8h; arc=none smtp.client-ip=139.162.184.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nozomi.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nozomi.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nozomi.space header.i=@nozomi.space header.b="cCyVbH8h"
From: =?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nozomi.space;
	s=mail; t=1791742600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2HEH7oeKiBSjnbJC+gkf/Mqi6o2Ayip8oLyi5hJLcY4=;
	b=cCyVbH8hAniVsd4zmfUie2RIqtgWs6mX9w+Yu9fcOG8lHW6Ytm/cvRzeJSFxnm5JdvqHsS
	51ESEXV5mnh6fdYbq4hfhjQKZpOC+B+d6OhjicJ0E5Nzl5cfscQtNrCEps14BXiBV5Xzux
	SxVS8e/nvLd1v/D6Ymm+55P6rBqcBlm/7Jw/j0NgsNNctUhb8ep66DwbxgHNPjdZg5tCv9
	O7HEJGrAya0Aqj50maSXRfD3FwDANG+lg8pCQZJT0RTw7pP55OFRX0NO5zbZwFy+aVOCD1
	xjDiPoz21YIN36p9LzWPrT/nCBS0GlhGSp0C+AahBg+nuwhclnbtxfpsN1ryxw==
To: linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org,
	dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	allencl_lin@hotmail.com,
	tylor_yang@himax.corp-partner.google.com,
	felix@kaechele.ca,
	dianders@chromium.org,
	=?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>
Subject: [PATCH v6 3/3] arm64: dts: mediatek: mt8188-geralt-ciri: Add the touchscreen
Date: Sun, 11 Oct 2026 20:16:33 +0200
Message-ID: <20261011181633.1778969-4-michal@nozomi.space>
In-Reply-To: <20261011181633.1778969-1-michal@nozomi.space>
References: <20261011181633.1778969-1-michal@nozomi.space>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Ciri uses the touch function of its Himax HX83102J TDDI controller,
connected over SPI1. It shares the analog supplies and the reset with
the panel, so describe those and follow the panel for power sequencing.

The controller has no flash; the firmware is loaded from a file that
depends on the panel: himax_i2chid_1002.bin for the BOE panel and
himax_i2chid_1003.bin for the IVO panel, as on ChromeOS.

Signed-off-by: Michał Kopeć <michal@nozomi.space>
---
 .../dts/mediatek/mt8188-geralt-ciri-sku1.dts  |  4 +++
 .../dts/mediatek/mt8188-geralt-ciri-sku3.dts  |  4 +++
 .../dts/mediatek/mt8188-geralt-ciri-sku5.dts  |  4 +++
 .../dts/mediatek/mt8188-geralt-ciri-sku7.dts  |  4 +++
 .../boot/dts/mediatek/mt8188-geralt-ciri.dtsi | 33 +++++++++++++++++++
 5 files changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dts b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dts
index ef5ea9d12b1de..6377354440d68 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dts
@@ -57,3 +57,7 @@ codec {
 		};
 	};
 };
+
+&touchscreen {
+	firmware-name = "himax_i2chid_1003.bin";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dts b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dts
index 524f7f0064c1a..2a51c610758f7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dts
@@ -30,3 +30,7 @@ &sound {
 		"Left Spk", "Front Left BE_OUT",
 		"Right Spk", "Front Right BE_OUT";
 };
+
+&touchscreen {
+	firmware-name = "himax_i2chid_1003.bin";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dts b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dts
index bf87201ccf273..8fb0036aa14d0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dts
@@ -70,3 +70,7 @@ codec {
 		};
 	};
 };
+
+&touchscreen {
+	firmware-name = "himax_i2chid_1003.bin";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dts b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dts
index 825015b452d59..2bd178116423b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dts
@@ -46,3 +46,7 @@ codec {
 		};
 	};
 };
+
+&touchscreen {
+	firmware-name = "himax_i2chid_1003.bin";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri.dtsi b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri.dtsi
index 6815c435a57e1..e611fb73ddb01 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri.dtsi
@@ -121,6 +121,27 @@ codec {
 	};
 };
 
+&spi1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	touchscreen: touchscreen@0 {
+		compatible = "himax,hx83102j";
+		reg = <0>;
+		spi-max-frequency = <12500000>;
+		interrupts-extended = <&pio 143 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touchscreen_pins>;
+		reset-gpios = <&pio 5 GPIO_ACTIVE_LOW>;
+		display-reset-gpios = <&pio 25 GPIO_ACTIVE_LOW>;
+		vccd-supply = <&mt6359_vm18_ldo_reg>;
+		vsp-supply = <&ppvar_mipi_disp_avdd>;
+		vsn-supply = <&ppvar_mipi_disp_avee>;
+		panel = <&dsi_panel>;
+		firmware-name = "himax_i2chid_1002.bin";
+	};
+};
+
 &pio {
 	gpio-line-names =
 		"GSC_AP_INT_ODL",
@@ -313,4 +334,16 @@ pins-en-spkr {
 			pinmux = <PINMUX_GPIO111__FUNC_B_GPIO111>;
 		};
 	};
+
+	touchscreen_pins: touchscreen-pins {
+		pins-int-odl {
+			pinmux = <PINMUX_GPIO143__FUNC_B_GPIO143>;
+			input-enable;
+		};
+
+		pins-rst-l {
+			pinmux = <PINMUX_GPIO5__FUNC_B_GPIO5>;
+			output-high;
+		};
+	};
 };
-- 
2.56.0

