Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283933;
	b=YulGxmWYFjR9Q0nv/ye2Tj9/WC3e9NTM1w+89TYAYjFOBTkQzJyktD4kCZUYNTnC9qHM
	 /5ET2nFLg8u5lghh6n4YK/bS1Quu7hN9IQSHb7jUhZ2VlXDDdx9hl9OQc+xROgStqbXiN
	 8Ns5krHgbhNcxLj74+Me7EUyFLUA5822FBKSnkWfug0OCGhdQmpjzwYeAutRsXPTes2Hd
	 PJCYfMnYJXNJBHb8aTRlLKYbsreJ9L+k2T+YYdfeDE9hhPKUDDWCpgZDZNRFr9riF7C7O
	 zcbiRb8EX2EJmvmJ8MmWDq7DuT5E3U9Pae3efXHZj115IbSKxWqIHxWLFTqNdylaUDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283933;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xM/qy0LDmGAX2gldlTS/zKbKhse2bwRxfBsg2sK9AYs=;
	b=eDZHmz8l+XP9VyF8P3NHui6TTWBOj2STK/DbFsQoQc+o1fOmdY08ebVFcbxgghKgTTtO
	 /gvmPP3tG0XkAhEkXz1s2XF6clKVARO5OhLPMILfjdI39vY7nJiPDcjfv1XAviyOMLT60
	 Bq/09y/0bh1LF/hNZnKdA2JWd9deujqxSixK3AqwwcZCIT1lSl3uk6PPKZf6ZWQK2bSv8
	 u9wzUF3uVaZvpxF44fhUZM9q12oFSwNRM6fN4PcFHBaI7VyFC183NKrIjPpsQRZFSKNRo
	 laaY06VZCAhmGKpF7Z5iCGa9SPsp31+P5Ua/gxq2h8Ith1roZuf9Y0JN7akThTwKyBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BhM521TZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A907606A33F;
	Tue, 10 Nov 2026 04:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BhM521TZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1A01F0089F;
	Tue, 10 Nov 2026 04:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794283932;
	bh=xM/qy0LDmGAX2gldlTS/zKbKhse2bwRxfBsg2sK9AYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BhM521TZv3m4O2TAooWY912f0uaCJrfkgK4cXlg6AbKE3eLmvdFpbmynhiXL1QqKy
	 A1AIDCJkZE8gE8ngKX6CENCqjUENkyKHfO5mwy9J7tibQcMhO5ateddHrvkweujjkS
	 OB7nb3YnYQ0B3Kh+EFTva8bTLmap+S9WBIwxPIqPLU+EzmWNUz9QiPjTNdfUhDk120
	 jVHajcTu8rJIB3EZ9PSSVps1uaIa8ennFiwdPC+DwO5nnHMYUHf9k3KlkTfUcZBcFp
	 RoeHCHzB+Be4JDekknEwOBZ62IN6unukUNYk7Z5yQcy5nS372JN2QSe1XIMOSpfNAw
	 J+QzQVz+6Ve5A==
Date: Mon, 9 Nov 2026 22:12:07 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: david@ixit.cz
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Petr Hodina <petr.hodina@protonmail.com>, 
	linux-input@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	phone-devel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: Re: [PATCH v8 5/5] arm64: dts: qcom: sdm845-google: Add STM FTS
 touchscreen support
Message-ID: <avKYaYOdaeSn2YoN@zenbook>
References: <20260925-stmfts5-v8-0-0fcf49e2c85f@ixit.cz>
 <20260925-stmfts5-v8-5-0fcf49e2c85f@ixit.cz>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925-stmfts5-v8-5-0fcf49e2c85f@ixit.cz>

On Fri, Sep 25, 2026 at 11:22:23PM +0200, David Heidelberg via B4 Relay wrote:
> From: Petr Hodina <petr.hodina@protonmail.com>
> 
> Basic touchscreen connected to second i2c bus.
> 
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Co-developed-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts | 19 ++++++++++++++++++-
>  arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi  |  2 +-
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts b/arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts
> index fa89be500fb85..51c835dca43f1 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts
> @@ -21,17 +21,34 @@ &framebuffer0 {
>  	stride = <(1080 * 4)>;
>  };
>  
>  &i2c2 {
>  	clock-frequency = <1000000>;
>  
>  	status = "okay";
>  
> -	/* ST,FTS @ 49 */
> +	touchscreen@49 {
> +		compatible = "st,stmfts5";
> +		reg = <0x49>;
> +
> +		pinctrl-0 = <&touchscreen_irq_n>, <&touchscreen_reset>;
> +		pinctrl-names = "default";
> +
> +		interrupts-extended = <&tlmm 125 IRQ_TYPE_LEVEL_LOW>;
> +
> +		mode-switch-gpios = <&tlmm 136 GPIO_ACTIVE_HIGH>;

It's not clear to me how this worked or when it started failing, but due
to a conflict with the reboot-mode binding dt-validate crashes when we
reach this property.

I opened a PR to handle it here:
https://github.com/devicetree-org/dt-schema/pull/212

Regards,
Bjorn

> +		reset-gpios = <&tlmm 99 GPIO_ACTIVE_LOW>;
> +
> +		avdd-supply = <&vreg_l19a_3p3>;
> +		vdd-supply = <&vreg_l14a_1p8>;
> +
> +		touchscreen-size-x = <1080>;
> +		touchscreen-size-y = <2160>;
> +	};
>  };
>  
>  &mdss_dsi0 {
>  	vdda-supply = <&vdda_mipi_dsi0_1p2>;
>  
>  	status = "okay";
>  
>  	panel@0 {
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi
> index f1379857e2742..6ae1973aa8ac7 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi
> @@ -504,17 +504,17 @@ firmware-pins {
>  
>  	touchscreen_reset: ts-reset-state {
>  		pins = "gpio99";
>  		function = "gpio";
>  		drive-strength = <8>;
>  		bias-pull-up;
>  	};
>  
> -	touchscreen_pins: ts-pins-gpio-state {
> +	touchscreen_irq_n: ts-irq-n-gpio-state {
>  		pins = "gpio125";
>  		function = "gpio";
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
>  
>  	touchscreen_i2c_pins: qup-i2c2-gpio-state {
>  		pins = "gpio27", "gpio28";
> 
> -- 
> 2.55.0
> 
> 
