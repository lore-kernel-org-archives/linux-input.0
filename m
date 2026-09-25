Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFB0303A37;
	Fri, 25 Sep 2026 22:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790376360; cv=none; b=Cr+uII/3Z/tkfFc+0dP/3ZRRT2JHzcXZY5TkCA/XNW2JO4stuxKK+VyZbBDC4+nK+RU3+ezAXQbbChLeg4FLw9jmJNbdtJqUuMOwb/UepzaAck/LaQJmRJPh8elP3oQCtsIlWRxkiQQCwnGuaBIceWh0vBzrCEhjcYGTM1loBjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790376360; c=relaxed/simple;
	bh=1LTLSmmDIm3zEHWlztd9u1KmLa10pIzF1K9lw/Xe3uo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=gT0pza95DKO4h50vZ2T+2AAN8PiAtMTwWmOcXbW1I5gmbQruvDeJTUvk9+xECBp/U5YpAFNW1bQH2yU6cG/3WjCkBAxajVJcjWWv0yn/HByxc0j4OitClxR6saaqlHxC6C8lLu+u5F/ElLTEUlvh1e25xbC7BaTEQQlzQ+EDvyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=NRt1HdD0; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=f49sx4Ub; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="NRt1HdD0";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="f49sx4Ub"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790376346; bh=3fP4A8XqSiZproBMyI4rt5Z
	MRgAfuAYNcNwBKsQAy3c=; b=NRt1HdD014G4QY7CdzYDHjQbkvWTm6mHN46uNbM7XSyQIwLqXo
	J2SN5jP5e2++SSwC3foVKgx8Xidj2yxSgvGeZR8jeLG+Cqq7GMr2Chi/7GUWjP67vmXdrdkqwVB
	M3vAl658btE21945iZuANxlZd/gw/dzAViHyqZ9Bz44DAa1iJr6LXQiZ8IWsJBcykdjYTUKs2Tr
	pcnowi6Nruh71R6IP1WHpqMH32z+Mx5HFNU2AxoLSvyvyNQocirqum7/MZAw823V/itty8BBySc
	nrpx1hXW36ipJ/HFCzAxWgyGc92TrbLIl3kPYUPzFpmEa19bYJUM5thE5BXLfqIUm+w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790376346; bh=3fP4A8XqSiZproBMyI4rt5Z
	MRgAfuAYNcNwBKsQAy3c=; b=f49sx4UblQKoqfUpRSOpx7ezK1eYpLiC47p2aQg2M4FSBFLDEl
	O3cmF693e3Db/DRdJz5iX96ZYRKZWRohtZBw==;
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 26 Sep 2026 00:45:46 +0200
From: =?UTF-8?Q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?=
 <barnabas.czeman@mainlining.org>
To: =?UTF-8?Q?Y=C4=B0=C4=9E=C4=B0TCAN_KAVAKLI?= <kavakliyigitcan@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, Jingoo
 Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, Abhinav
 Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>, Marijn Suijten
 <marijn.suijten@somainline.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
Subject: Re: [PATCH RFC 10/10] arm64: dts: qcom: sm6125-xiaomi-ginkgo: enable
 display, backlight and touchscreen
In-Reply-To: <20260911-ginkgo-submission-final-v1-10-0e68e63a18d4@gmail.com>
References: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
 <20260911-ginkgo-submission-final-v1-10-0e68e63a18d4@gmail.com>
Message-ID: <6374e0a9d6ab38436d8f38c3903e1f78@mainlining.org>
X-Sender: barnabas.czeman@mainlining.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2026-09-11 10:51, YİĞİTCAN KAVAKLI wrote:
> Enable the display subsystem (MDSS/MDP/DSI0), Kinetic KTD3136 
> backlight,
> and Novatek NT36672A SPI touchscreen on the Xiaomi Redmi Note 8 
> (ginkgo).
> 
> Hardware nodes added:
> - Fixed LCDB regulators (lcdb_lab and lcdb_ibb at +/- 5.5V)
> - MDSS and DSI0 with Tianma 1080x2340 FHD+ video panel
> - I2C1 backlight node at 0x36 with PMI632 GPIO 6 hardware enable
> - SPI2 touchscreen node at CS0 with GPIO 88 interrupt and panel 
> follower
>   reference
> - Touchscreen active pinctrl definition on GPIO 88
> 
> Signed-off-by: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>
> ---
>  .../boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi | 100 
> +++++++++++++++++++++
>  1 file changed, 100 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi 
> b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi
> index 
> 59042a5937535c4acda064fa0f865f4f5a52d01b..f4b9e2092a814e56cdc23218025cb4166dec110a 
> 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi
> @@ -26,11 +26,30 @@ / {
>  	chassis-type = "handset";
> 
>  	qcom,msm-id = <QCOM_ID_SM6125 0x10000>;
> +	qcom,board-id = <34 0>, <34 1>, <34 2>, <34 3>, <34 4>, <0 0>;
> 
>  	aliases {
>  		serial0 = &uart4;
>  	};
> 
> +	lcdb_lab: regulator-lcdb-lab {
> +		compatible = "regulator-fixed";
> +		regulator-name = "lcdb_lab";
> +		regulator-min-microvolt = <5500000>;
> +		regulator-max-microvolt = <5500000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	lcdb_ibb: regulator-lcdb-ibb {
> +		compatible = "regulator-fixed";
> +		regulator-name = "lcdb_ibb";
> +		regulator-min-microvolt = <5500000>;
> +		regulator-max-microvolt = <5500000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
>  	chosen {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -356,6 +375,13 @@ irled@1 {
> 
>  &tlmm {
>  	gpio-reserved-ranges = <0 4>, <30 4>;
> +
> +	ts_int_active: ts-int-active-state {
         touch_default: touch-default-state
> +		pins = "gpio88";
                 pins = "gpio87", "gpio88";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-up;
> +	};
>  };
> 
>  &uart4 {
> @@ -369,3 +395,77 @@ &usb3 {
>  &usb_dwc3_hs {
>  	remote-endpoint = <&pmi632_hs_in>;
>  };
> +
> +&mdss {
> +	status = "okay";
> +};
> +
> +&mdss_mdp {
> +	status = "okay";
> +};
> +
> +&mdss_dsi0_phy {
> +	vdds-supply = <&vreg_l7a>;
> +	status = "okay";
> +};
> +
> +&mdss_dsi0 {
> +	vdda-supply = <&vreg_l18a>;
> +	status = "okay";
> +
> +	panel: panel@0 {
> +		compatible = "tianma,fhd-video-ginkgo", "novatek,nt36672a";
This should be moved out from the common, you should split the 
devicetree becasue
ginkgo and willow have three display variants:
- nt36672a tianma and shenchao with novatek touch controller
- ft8719 huaxing with focaltech touch controller
> +		reg = <0>;
> +
> +		reset-gpios = <&tlmm 90 GPIO_ACTIVE_LOW>;
> +		vddio-supply = <&vreg_l9a>;
> +		vddpos-supply = <&lcdb_lab>;
> +		vddneg-supply = <&lcdb_ibb>;
> +		backlight = <&backlight>;
> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&mdss_dsi0_out>;
> +			};
> +		};
> +	};
> +};
> +
> +&mdss_dsi0_out {
> +	remote-endpoint = <&panel_in>;
> +	data-lanes = <0 1 2 3>;
> +};
> +
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	backlight: backlight@36 {
> +		compatible = "kinetic,ktd3136";
> +		reg = <0x36>;
> +		enable-gpios = <&pmi632_gpios 6 GPIO_ACTIVE_HIGH>;
> +		default-brightness = <2047>;
> +		max-brightness = <2047>;
> +	};
> +};
> +
> +&spi2 {
> +	status = "okay";
> +
> +	touchscreen@0 {
> +		compatible = "novatek,nt36672a-spi", "novatek,nt36672a-ts";
> +		reg = <0>;
> +		spi-max-frequency = <4000000>;
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <88 IRQ_TYPE_EDGE_RISING>;
You can use interrupts-extended here.
> +		pinctrl-0 = <&ts_int_active>;
> +		pinctrl-names = "default";
> +		panel = <&panel>;
> +		touchscreen-size-x = <1080>;
> +		touchscreen-size-y = <2340>;

You should add a status = "disable"; here since this device have 
multiple touch variants,
novatek touch only should be enabled for novatek displays.
> +	};
> +};
