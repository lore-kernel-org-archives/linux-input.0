Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794921157;
	b=qeNZ2RTFjIg56pVzW9Dc01BMe3dgj2pcfJ/GmB97NdVrv7xEgLmWBYik+DFNLGzlUwvq
	 XL5cgCmrHfEiOsnab9K38h6j5Wo9HqmCppgwC5EozG2ArcoSNu8Ty+9oXWr+JYkKdgGv8
	 0KWRnveJojtWJE2XTGCx6iypsonAiXtfg0pQpFxRU5hNvjjJtWraJ9xfFY3cn/Qze5qID
	 /tjJu33UDBEGx/ku1yTac11xb0OyjvyNr9Y7aanM+hZCkxMhYUp1cBHPbqMw9bf7Qi4pm
	 uGTQUUmkpKaUdOFm5vytomeRkPZdedQXnFfmP45xDp4rYcz+sMwKqvxvwRtyBCRrnig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794921157;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MdVqw0F5CfoMgltcebKZnz2NwUzBuH6PWbQR6PRHA8w=;
	b=cyQTPZ8X0bZe9kE1i5H2YDgNZ1tRzOmEEN1V+ciivwYUcM6OTayaQOJpLDprBH4v84nS
	 AvjlQ4dnme2wXu9Gcl7OnnbTq08iSWHFmE75HZtdC6bFdXWyDmVrufrFK5YVpScbdp9AG
	 gBkpjAQoVJSIDm8N/9Y4/w7V7zcyq6dt3YfQERti4+plWy/bWisMP+5BE1xbVbSeEU7t1
	 Aenxjzw309Dgo5T6VJ0TWgKz40VqAnzpfKD8+vVy93NLChjpdVwXkJKF3AurnHvlTC2XG
	 9Fl6goHCUhQ8pjUK0sLt2qI2oHT7PAPPYz3j/T9YUapaXbiv7v7g/yVnykbQXEzJ0/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CTfP8oKv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3904F606A31C;
	Tue, 17 Nov 2026 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CTfP8oKv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4F81F000C4;
	Tue, 17 Nov 2026 13:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794921156;
	bh=MdVqw0F5CfoMgltcebKZnz2NwUzBuH6PWbQR6PRHA8w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CTfP8oKvQiGbvvW8+dwm34sXTVzlnAdMybf9ixbWZHqnXLu926UDeXWb9bepTvgaz
	 qND2/U1G1We7VZDgvq9ea/4XG34Cpl5ikgycFCaxYunknd+Irm8FoGUcpgHXMWXDtS
	 RFqEVgwTbp67qQdNC94v6vvd738SKj66o5TRvuFBO3Y1AMi06v/jf7AR4mPhIrYe2Z
	 fVRh+qehQg344DuzFylDMY2X89OImK2lhskqa+zNynBirMCZ0/OAO4hdE3DQEGn1uA
	 1nL+c879a4q3LaqqtP7j5r30Fp0P51Bw7GTFw6jIBQ9yrjYwFaP3dPN22L+bauIcfa
	 zArAAfyzZY8Kg==
Message-ID: <sashiko-outbox-218846@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 08/11] arm64: dts: qcom: sm8250-lge-timelm: enable
 SW43103 panel
Reply-To: sashiko-reviews@lists.linux.dev
To: rofikkerneldev <rofikcoga@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261117123946.668557-9-rofikcoga@gmail.com>
References: <20261117123946.668557-1-rofikcoga@gmail.com>
 <20261117123946.668557-9-rofikcoga@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 13:12:36 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] arm64: dts: qcom: Signed-off-by and Author use handle
  rofikkerneldev
- [High] arm64: dts: qcom: enabling mdss with gmu disabled breaks
  a6xx_gmu_init()
- [Medium] arm64: dts: qcom: missing enable-gpios in sm8250-lge-timelm
  panel@0 node
- [Medium] drm/panel: sw43103_remove() calls sw43103_unprepare()
  unconditionally
- [Low] arm64: dts: qcom: redundant dispcc status and unsorted mdss
  nodes
--

commit 3038d85d6373aad3b6104c371b0b0d8abde1a320
Author: rofikkerneldev <rofikcoga@gmail.com>

> arm64: dts: qcom: sm8250-lge-timelm: enable SW43103 panel
>=20
> Enable DISPCC, MDSS, DSI0, and its PHY. Attach the SW43103 panel with
> its power rails, reset GPIO, and four-lane DSI link.
>=20
> Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>

[Severity: High]
The Author header and Signed-off-by trailer use an account handle
(rofikkerneldev) instead of a real human name, which does not meet the
Developer Certificate of Origin requirements in
Documentation/process/submitting-patches.rst.

> diff --git a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts b/arch/arm64/=
boot/dts/qcom/sm8250-lge-timelm.dts
> index ecbff27976fc2..fca48472f5dfe 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
> @@ -557,3 +557,42 @@ &usb_1_qmpphy {
>  	vdda-phy-supply =3D <&vreg_l9a_1p2>;
>  	vdda-pll-supply =3D <&vreg_l18a_0p9>;
>  };
> +
> +&dispcc {
> +	status =3D "okay";
> +};

[Severity: Low]
This isn't a bug, but dispcc in arch/arm64/boot/dts/qcom/sm8250.dtsi is
already enabled by default, so this status override is redundant.  Also,
board-level label overrides in Qualcomm device trees are sorted
alphabetically, so the &mdss* nodes below belong between &gpu and
&pm8150_gpios rather than after &usb_1_qmpphy.

> +
> +&mdss {
> +	status =3D "okay";
> +};

[Severity: High]
Does enabling &mdss fail to bind the DRM device because &gmu is still
disabled?

In sm8250-lge-timelm.dts, &gpu is enabled, while gmu in sm8250.dtsi
defaults to status =3D "disabled" and is never enabled by the board DTS.
When dpu_dev_probe() calls msm_drv_probe(), add_gpu_components() includes
the GPU in the DRM component master match list alongside mdss_dsi0.
During component_bind_all() in msm_drm_init(), adreno_bind() ->
a6xx_gpu_init() -> a6xx_gmu_init() looks up the GMU platform device via
of_find_device_by_node(), which returns NULL because the gmu node is
disabled.  a6xx_gmu_init() returns -ENODEV, aborting component_bind_all()
and preventing both the display controller and the SW43103 panel from
initializing unless &gmu is also enabled.

> +
> +&mdss_dsi0 {
> +	vdda-supply =3D <&vreg_l9a_1p2>;
> +	status =3D "okay";
> +
> +	panel@0 {
> +		compatible =3D "lg,sw43103";

[Severity: Medium]
Does instantiating "lg,sw43103" expose an unbalanced regulator disable in
sw43103_remove() on driver unbind or module unload?

drivers/gpu/drm/panel/panel-lg-sw43103.c:sw43103_remove() {
	ret =3D sw43103_unprepare(&ctx->base);
	if (ret < 0)
		dev_err(&dsi->dev, "failed to unprepare panel: %d\n", ret);

	ret =3D mipi_dsi_detach(dsi);
	if (ret < 0)
		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);

	drm_panel_remove(&ctx->base);
}

Calling the raw sw43103_unprepare() callback directly bypasses
drm_panel_unprepare() and ctx->base.prepared tracking, unconditionally
calling regulator_bulk_disable() on vddi and vpnl.  If the panel is
already unprepared, this underflows the regulator enable count and
triggers a WARN in _regulator_disable().  If the panel is prepared and
enabled, sw43103_unprepare() asserts reset and cuts power while
ctx->base.prepared remains true, before mipi_dsi_detach() triggers DRM
atomic shutdown to send MIPI DSI commands and call drm_panel_unprepare()
a second time.

> +		reg =3D <0>;
> +
> +		vddi-supply =3D <&vreg_l14a_1p8>;
> +		vpnl-supply =3D <&vreg_l11c_3p0>;
> +		reset-gpios =3D <&tlmm 75 GPIO_ACTIVE_LOW>;

[Severity: Medium]
Should this panel node also specify enable-gpios =3D <&pm8150l_gpios 4
GPIO_ACTIVE_HIGH>?

The binding example for the timelm panel in
Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml specifies
that GPIO alongside the same vddi-supply, vpnl-supply, and reset-gpios.
Without enable-gpios here, devm_gpiod_get_optional(dev, "enable",
GPIOD_OUT_LOW) in panel-lg-sw43103 returns NULL, and sw43103_prepare() and
sw43103_unprepare() never toggle the panel's PM8150L GPIO 4 enable line
across display power cycles.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117123946.6685=
57-1-rofikcoga@gmail.com?part=3D8
