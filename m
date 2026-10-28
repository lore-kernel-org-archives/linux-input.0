Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793186918;
	b=bQ7CxqSjw9bpzZT0t92V3nA0RdLT4wUyaD5hHrANErdx/ObzDhNNWvJ5I7Qyl1a8UURd
	 TOb53lYVGc4JamqGNpnaf/1ygvMphgvdTAbJ76/U747WPvbyukouYqvYx/zTKpSYtX+un
	 G3KFS8S5QzoZ7S2uh9pdAPIKZKBbMP+f7DXP6Mjwu8yHL+hc2+QOHPjbGWxjnaXsLpMCE
	 kQAj/2P324LNHVtkSmQuAhK+xH4TOEkyfeDy5z7LsIf8BJLXar4Abf6YRBKatj4jmsRU1
	 5V1dDClMG9xka0P/FqlM1CRLMT6xFu+lX60YsR6AZ/UR6wrAyfMp4y/Xdvr84O4IO8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186918;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iJThpt3wCaw21tvb3jioV8nU1M0htI/CM4Pk5Zc2xX0=;
	b=mWUiZxl7h/cjy1lzo0xecbMNnjksWnsccF0oOqksbsD+63nya8sstJUbnRSAgpoaUZES
	 wKzP3aP1X83foL37T8mzasWtevMdFy3yfNQz/Y6q3gwkgL4NYS/5ThJOfwfskJr7byRJx
	 4zIuWmFHg6lAU5fPMhcGj4F5bv/7JmLQBqXdQ7A62G5qPe0HIApv8Lor4kAqxh2z3thLL
	 6/pcdXIxPYY+n+ZEOmKDhqNI1znwT4qjQ+pZmJUK/DL/7AhY0Vzjs/sPlC1yg/QHshc6K
	 /iEEzJsJDVqDvDWpT0cnGsbcxS56k2tT54iga4OeViovZpPjwAqcCsDuC9HpTKyYR0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M8xo1RPq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8551A606A32D;
	Wed, 28 Oct 2026 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M8xo1RPq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E8D1F031E1;
	Wed, 28 Oct 2026 11:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793186917;
	bh=iJThpt3wCaw21tvb3jioV8nU1M0htI/CM4Pk5Zc2xX0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M8xo1RPq3m1el5NnQFxaMNYToKnJOouDD6hjkVmwaTEouQhhSn5TJqkJGFnBoOd7B
	 jJo3D3ac51iHmLzrlyHvXYRqs6nOYjNtcRXSlNa6C40R4hlTST/PLMW4ELpiqMPeQM
	 Ilmb5HzKvPsqnLNmpifl/qWsKjMbhztF1oalJ/97ITEw/338h3/9cDoGFqCdMv/mLx
	 7gEHfgaJK6x17g6y0IvJfY3fBlASqqgUm9D1fhwc5pCxSQS1zijx2JB+yNHCrw6/Bk
	 KQJUGGBswXsaWexFfNYga5Gol/Sa3oVGf8TRjjqnzq91gM89bGaSuc2pbKTdk2gVrj
	 CsL/tYrmrnwIQ==
Message-ID: <sashiko-outbox-187817@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/11] arm64: dts: qcom: generalmobile-shamrock: new
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261028-msm8952-initial-support-v6-11-e07ddd8bcf4c@mainlining.org>
References: <20261028-msm8952-initial-support-v6-0-e07ddd8bcf4c@mainlining.org>
 <20261028-msm8952-initial-support-v6-11-e07ddd8bcf4c@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 11:28:36 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] arm64: dts: qcom: shamrock: missing color property on status LED=
s breaks RGB
--

commit 8fec21f5539dc733f3dc08f3078a4a994d335e11
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

arm64: dts: qcom: generalmobile-shamrock: new device

This commit adds initial device tree support for the Qualcomm MSM8952-based
General Mobile GM 5 Plus (shamrock) smartphone.

> diff --git a/arch/arm64/boot/dts/qcom/msm8952-generalmobile-shamrock.dts =
b/arch/arm64/boot/dts/qcom/msm8952-generalmobile-shamrock.dts
> new file mode 100644
> index 0000000000000..26a269f0f7694
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8952-generalmobile-shamrock.dts
> @@ -0,0 +1,439 @@
[ ... ]
> +	multi-led {
> +		compatible =3D "leds-group-multicolor";
> +		color =3D <LED_COLOR_ID_RGB>;
> +		function =3D LED_FUNCTION_INDICATOR;
> +		leds =3D <&red_status>, <&green_status>, <&blue_status>;
> +	};
[ ... ]
> +	led-controller@68 {
> +		compatible =3D "si-en,sn3193";
> +		reg =3D <0x68>;
> +
> +		shutdown-gpios =3D <&tlmm 68 GPIO_ACTIVE_HIGH>;
> +
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		red_status: led@1 {
> +			reg =3D <1>;
> +			label =3D "red:status";
> +			led-max-microamp =3D <17500>;
> +		};
> +
> +		green_status: led@2 {
> +			reg =3D <2>;
> +			label =3D "green:status";
> +			led-max-microamp =3D <17500>;
> +		};
> +
> +		blue_status: led@3 {
> +			reg =3D <3>;
> +			label =3D "blue:status";
> +			led-max-microamp =3D <17500>;
> +		};
> +	};

[Severity: Medium]
Should the child LED nodes under led-controller@68 use the color and functi=
on
properties instead of the deprecated label property?

When is31fl319x_probe() registers each child LED via
devm_led_classdev_register_ext(), led_classdev_register_ext() in
drivers/leds/led-class.c only populates led_cdev->color when the color
property is present on the node:

	if (fwnode_property_present(init_data->fwnode, "color"))
		fwnode_property_read_u32(init_data->fwnode, "color",
					 &led_cdev->color);

Because red_status, green_status, and blue_status only specify label and om=
it
color, led_cdev->color remains 0 (LED_COLOR_ID_WHITE) for all three LEDs.

When leds_gmc_probe() in drivers/leds/rgb/leds-group-multicolor.c subsequen=
tly
probes the multi-led node, it sets each channel's color_index from
led_cdev->color:

	for (i =3D 0; i < count; i++) {
		struct led_classdev *led_cdev =3D priv->monochromatics[i];

		subled[i].color_index =3D led_cdev->color;

		/* Configure the LED intensity to its maximum */
		subled[i].intensity =3D max_brightness;
	}

Without color =3D <LED_COLOR_ID_RED>, <LED_COLOR_ID_GREEN>, and
<LED_COLOR_ID_BLUE> on led@1, led@2, and led@3, multi_index in sysfs reports
"white white white" instead of "red green blue".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-msm8952-in=
itial-support-v6-0-e07ddd8bcf4c@mainlining.org?part=3D11
