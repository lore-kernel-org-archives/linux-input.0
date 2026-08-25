Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A934111CA9;
	Tue, 25 Aug 2026 04:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787633419; cv=none; b=GAvIXKWLrDqo9FStKKInjPr3AXGCzJdEMmuVfmHjFtRmRMdN34Fg+hrZ7XVL0FG0DWPBO1P4zML2FpZWhxW3c0vUhUZUz2IFcslUBIbm+dSpGBzKDIQ0TIPMbV8q/e4QWH1Oof+6zWMY63pmozkDw6rZCkMUbfkqQogxM74OTCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787633419; c=relaxed/simple;
	bh=Mld4hCmGZrV6SDsNYjYkTM/79WCpjWacokFCVsLbRDI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DXoqsHUacnIyldyRX7OprHcTJ2o7KO+vEpxvgW/sFsdBIqSd8lsaa1aKdu5S9ZQIMxNWEfo5y4pONFoyBSQJXNT0xHEi+sI7VOzGrUdrpCVa0WSJvLirWcDUkEnoZYwT4ts63fQ4PSLnRBffUc/6m8OeqOtj++LS+NiKOx0bTGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1PSNEVV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1PSNEVV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0E81F000E9;
	Tue, 25 Aug 2026 04:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787633418;
	bh=IZqIFXieIaYXv91HODlh4YD3nxCJ+X95SERGfiYzHN8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J1PSNEVVCC+1PsDbpnWINF6F9gjjvy6SYsoUvDxMtExQkT6PMpeV6fTK9MsTVTiN4
	 3/AydMartpb5ec55CKrABUnpaeRHEqKlIl8EegWi9odxfTKrQofWN4to9qqWfe+7n6
	 YijoyRopIwrCIIBF+cvAdBluEZ8+Ugt50YcfIQZmHSAk75SrIYOqdy1rpyntDkRnGl
	 YRyR17w1PDNgEMwj7QKBYEvoyIozhdKI5jT3JiQ1UdqLX6aMmnnR3O1W0IPv9ZQXvB
	 GjBlRGeEruDWhk/xtVHy3yEUY2PdS94IvS2X6ipj+yuJcBrFdCW6dqtL69+70v6e+K
	 n1Fd9mz5r2UUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/7] arm64: dts: mediatek: mt8173-elm-hana: Unmark
 trackpad supply as always-on
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen-Yu Tsai" <wenst@chromium.org>
Cc: dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260825041628.988369-7-wenst@chromium.org>
References: <20260825041628.988369-1-wenst@chromium.org>
 <20260825041628.988369-7-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 04:50:17 +0000
Message-Id: <20260825045017.DE0E81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing `regulator-always-on` breaks trackpad detection on Hana b=
oards because the I2C component prober configuration hardcodes a 0ms post-p=
ower-on delay.
--

--- Patch [6]: [PATCH v5 6/7] arm64: dts: mediatek: mt8173-elm-hana: Unmark=
 trackpad supply as always-on ---
commit 6318d2b884a1dcd37dded2350e385637ee0e9028
Author: Chen-Yu Tsai <wenst@chromium.org>

arm64: dts: mediatek: mt8173-elm-hana: Unmark trackpad supply as always-on

Up until now, the MT8173 elm/hana device tree has set the dedicated
regulator supplying the trackpad as always-on. This commit removes the
regulator-always-on property and adds the correct post-power-on-delay-ms.

> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/bo=
ot/dts/mediatek/mt8173-elm.dtsi
> index a0573bc359fb6..6b9f47f515c72 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> @@ -1093,7 +1093,6 @@ mt6397_vgp6_reg: ldo_vgp6 {
>  				regulator-min-microvolt =3D <3300000>;
>  				regulator-max-microvolt =3D <3300000>;
>  				regulator-enable-ramp-delay =3D <218>;
> -				regulator-always-on;

[Severity: High]
Does removing regulator-always-on here break trackpad detection on Hana boa=
rds?

When the I2C component prober runs at boot on Hana boards to determine which
trackpad is present, it uses the delay configured in its own array:

drivers/platform/chrome/chromeos_of_hw_prober.c:chromeos_i2c_probe_hana_tra=
ckpad
	/*
	 * ELAN trackpad needs 2 ms for H/W init and 100 ms for F/W init.
	 * Synaptics trackpad needs 100 ms.
	 * However, the regulator is set to "always-on", presumably to
	 * avoid this delay. The ELAN driver is also missing delays.
	 */
	.post_power_on_delay_ms =3D 0,

The prober passes this 0ms delay to regulator_enable_and_wait():

drivers/i2c/i2c-core-of-prober.c:i2c_of_probe_simple_enable_regulator() {
	...
	ret =3D regulator_enable_and_wait(ctx->supply,
					ctx->opts->post_power_on_delay_ms * USEC_PER_MSEC);
	...
}

Since 0ms is requested, it won't wait before performing the I2C read. Will =
this
cause the trackpad to fail probing since the regulator is no longer always-=
on
and the trackpad needs 100ms to boot up and respond?=20

Does the prober's post_power_on_delay_ms need to be updated to 100 to match
this change?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825041628.9883=
69-1-wenst@chromium.org?part=3D6
