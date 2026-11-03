Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793681558;
	b=oFOnlUZ9r2ZVwf5EtJiCVaN02EPpECmDA2KwETkdSe4raIfqOmNaxnCuN2PvLCrEQ4BR
	 mBhldAR66O5qX+/BBc0/JOlNQOGUgNa7XQub/ZpJJNoHQjRiUrTwK3wlbcdFuvBcUsZrL
	 ke2KCCeGbHyYcb5pr7OyCDRiUFhFRV2604O117Qw4YVqx0oTdIJbdfBxVT9HoBDEku7gW
	 8jbjh2X4w1jX7G65JYtgcwXA+9GmpuKJpz40qNWsBqzsNNzOkweyDYWcBhx2xCZ0SQ7mJ
	 4siMgkol4wIzklBoeS0hKg0/brIeGh7OShb+ly4VKZB+v7NYDFlSAn6kybV5Vyqy29A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793681558;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=v1i5re8NwFOOtVsv6Epqv+P7oggVp+WbMhkgKAYwimo=;
	b=ck55bR9rDdeoiU3/MY+qjTzD8rO+8ykANauRqaY/XlUsoV87AfuuTbA3qHdXja43g+BR
	 +XIse66dctIUjShOGk4TYYBPwubvoY/HwH04gwfShXzdGMQoBv4sVLo7LiZsra/dbPAX8
	 LqTyL+SkDDIatniaGqlPxvHtRQN9ZfxLrp7vma4Hsn5hGAIfEPD55Fh1B/NtWvUuyapPJ
	 JBWTvxc/AJddvKCj1uDeVHO7fEj/NpPZjIhxlZWQei/53m4icWQh+8lzkz77J8ezBfywC
	 l4hexGYAvQnJgXURZA4h/ciaK1PFMOoHPoo5uluyaxX1iIEYaGIXiizdAexN08YcFag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X0j9qFw6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172FD606A329;
	Tue,  3 Nov 2026 04:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X0j9qFw6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA7E1F0093A;
	Tue,  3 Nov 2026 04:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793681557;
	bh=v1i5re8NwFOOtVsv6Epqv+P7oggVp+WbMhkgKAYwimo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X0j9qFw62XWa/cb4cEe2kxUAKogeyRfA3ljwErUPjKYcGO4NWF+unQ7hnSifa2s1m
	 f8hmJf81idGZwpur/ploMUF7G9KciquS7JCxywcRn2//R0M3bx5m16qpbMhKpkIuFV
	 qe6U4jXHcuixQoKn4dNyu0JBQ1CPXFxihIQQDgB3tbLYRjDmor5RgZbDiy1ANm+whi
	 Bjuu+buBFDp+XkQT1dmzx54IMoslsCSCA5l341sRz42ro++IQPgwtVNWaoYeTKhqK6
	 JIrbfdx1cmJbRakmJ7EbffT8wKH+eW1qIp64TkSq6AMvSbFb4mkwE300Pw1zl3aLz+
	 MU1hQytEl73AA==
Message-ID: <sashiko-outbox-194583@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/8] HID: i2c-hid-of: skip post-power-on delay if
 powered on sufficiently long
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen-Yu Tsai" <wenst@chromium.org>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261103043734.2179858-4-wenst@chromium.org>
References: <20261103043734.2179858-1-wenst@chromium.org>
 <20261103043734.2179858-4-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 04:52:36 +0000
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
- [High] HID: i2c-hid-of: skipped post_power_delay_ms in i2c_hid_of_power_u=
p()
--

commit ac10ce6c4cef7a3904b81ccfc0086f427b98f32b
Author: Chen-Yu Tsai <wenst@chromium.org>

HID: i2c-hid-of: skip post-power-on delay if powered on sufficiently long

This commit replaces regulator_bulk_enable() and the unconditional msleep()=
 in
i2c_hid_of_power_up() with regulator_bulk_enable_and_wait() so that the
post-power-on delay is skipped when the regulator supplies have already been
enabled for at least post_power_delay_ms.

> diff --git a/drivers/hid/i2c-hid/i2c-hid-of.c b/drivers/hid/i2c-hid/i2c-h=
id-of.c
> index 59393d71ddb9d..fdaad451e7102 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-of.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-of.c

[ ... ]

> @@ -48,16 +49,14 @@ static int i2c_hid_of_power_up(struct i2chid_ops *ops)
>  	struct device *dev =3D &ihid_of->client->dev;
>  	int ret;
> =20
> -	ret =3D regulator_bulk_enable(ARRAY_SIZE(ihid_of->supplies),
> -				    ihid_of->supplies);
> +	ret =3D regulator_bulk_enable_and_wait(ARRAY_SIZE(ihid_of->supplies),
> +					     ihid_of->supplies,
> +					     ihid_of->post_power_delay_ms * USEC_PER_MSEC);
>  	if (ret) {
>  		dev_warn(dev, "Failed to enable supplies: %d\n", ret);
>  		return ret;
>  	}
> =20
> -	if (ihid_of->post_power_delay_ms)
> -		msleep(ihid_of->post_power_delay_ms);
> -

[Severity: High]
As reported by Sashiko on v6 [1], could replacing the unconditional
msleep(ihid_of->post_power_delay_ms) with regulator_bulk_enable_and_wait() =
in
i2c_hid_of_power_up() cause initialization regressions on existing Device T=
ree
platforms where ihid_of->supplies are dummy or always-on regulators whose
last_on timestamp was recorded during early boot, even though the HID device
itself just exited reset or powered up?

When the delay is skipped, __i2c_hid_core_probe() or i2c_hid_core_resume()
immediately issues I2C transfers (such as i2c_hid_probe_address(),
i2c_hid_fetch_hid_descriptor(), or i2c_hid_set_power()) before the controll=
er
firmware has finished booting, which can fail with -ENXIO.

There appear to be three in-tree Device Tree patterns affected by this:

1. Pinctrl-driven reset deassertion at driver bind time:
Because Documentation/devicetree/bindings/input/hid-over-i2c.yaml does not
define reset-gpios or post-reset-deassert-delay-ms (which i2c_hid_of_probe()
only populates for x86 platform data), several boards hold the controller in
reset at boot via a pin pulldown and drive the reset pin output-high in
pinctrl-0 when pinctrl_bind_pins() runs right before i2c_hid_of_probe(),
relying on post-power-on-delay-ms to wait for the device to boot out of res=
et.

For example, in arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts, digitizer=
@9
omits vdd-supply (using the dummy regulator), sets post-power-on-delay-ms =
=3D
<120>, and releases reset in pen_rst_l:

	pen_rst_l: pen-rst-l-state {
		pins =3D "gpio21";
		function =3D "gpio";
		bias-disable;
		drive-strength =3D <2>;

		/*
		 * The pen driver doesn't currently support
		 * driving this reset line.  By specifying
		 * output-high here we're relying on the fact
		 * that this pin has a default pulldown at boot
		 * (which makes sure the pen was in reset if it
		 * was powered) and then we set it high here to
		 * take it out of reset.  Better would be if the
		 * pen driver could control this and we could
		 * remove "output-high" here.
		 */
		output-high;
	};

Similarly, arch/arm64/boot/dts/mediatek/mt8186-corsola-magneton-sku393216.d=
ts
(as well as sku393217.dts and mt8183-kukui-kodama.dtsi / kakadu.dtsi /
jacuzzi-burnet.dts) uses an always-on regulator while touchscreen_pins driv=
es
the reset pin output-high in pinctrl-0:

	touchscreen@10 {
		compatible =3D "hid-over-i2c";
		reg =3D <0x10>;
		interrupts-extended =3D <&pio 12 IRQ_TYPE_LEVEL_LOW>;
		pinctrl-names =3D "default";
		pinctrl-0 =3D <&touchscreen_pins>;
		vdd-supply =3D <&pp3300_s3>;
		post-power-on-delay-ms =3D <350>;
		hid-descr-addr =3D <0x0001>;
	};

2. DRM panel followers where the panel driver sequences power and reset:
In arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie-sku1.dts,
touchscreen_himax is a panel follower whose vdd-supply (mt6366_vio18_reg) is
marked regulator-always-on in mt8186-corsola.dtsi:

	touchscreen_himax: touchscreen@4f {
		compatible =3D "hid-over-i2c";
		reg =3D <0x4f>;
		interrupts-extended =3D <&pio 12 IRQ_TYPE_LEVEL_LOW>;
		pinctrl-names =3D "default";
		pinctrl-0 =3D <&touchscreen_pins>;
		vdd-supply =3D <&mt6366_vio18_reg>;
		panel =3D <&panel>;
		post-power-on-delay-ms =3D <450>;
		hid-descr-addr =3D <0x0001>;
	};

Here, the switched analog rails (avdd/avee) and hardware reset GPIO of the
integrated Himax HX83102 TDDI controller are toggled by hx83102_prepare() a=
nd
hx83102_unprepare() in drivers/gpu/drm/panel/panel-himax-hx83102.c. When
drm_panel_prepare() triggers ihid_core_panel_follower_work() ->
i2c_hid_core_probe_panel_follower() or i2c_hid_core_resume() ->
i2c_hid_of_power_up(), won't regulator_bulk_enable_and_wait() see the early
boot last_on timestamp of mt6366_vio18_reg and skip the 450 ms delay right
after hx83102_prepare() powered and reset the chip?

3. S3 suspend/resume with hardware-sequenced rails:
On boards using pp3300_s3 (modeled in mt8186-corsola.dtsi as a fixed regula=
tor
with regulator-always-on because it is sequenced by PMIC EXT_PMIC_EN2 during
S3), regulator_bulk_disable() and regulator_bulk_enable_and_wait() do not
update rdev->last_on across S3 suspend and resume while CLOCK_BOOTTIME
advances. On S3 resume in i2c_hid_core_resume() -> i2c_hid_of_power_up(),
won't this skip post_power_delay_ms even though the rail was just re-enabled
by hardware?

[1] https://lore.kernel.org/r/20260901074930.764550-4-wenst@chromium.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103043734.2179=
858-1-wenst@chromium.org?part=3D3
