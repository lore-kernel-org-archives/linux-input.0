Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F5C471408;
	Tue,  1 Sep 2026 08:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788249682; cv=none; b=ixxpdfuqOnGJIY1awXrByUh2YPBZKuMZ9m9Xo5ZLEawG+fYng8un3+ULKqPCUWKHVKFDVwDCzXa8swJEMbpGgFFA7cvmnm/O2YUlHKGEwYXXnLUbWUywJRUHnYblaaH2e1MSiRSgcWtFgK3ge7Hwarv1bie/BZGLSV6/OSxllPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788249682; c=relaxed/simple;
	bh=hVynNOjiZDtkP6eNeMdl1o6o3p1W7wISMrexN4WxSAw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cPYz5GcHuJ5rRmUoV2CqFPsKpfyKUIrksP+UqEX7+qb653E9JcekEJuhntZRFCVLp7DrOd/MAp1d5SWnZqcL9LlphTFJuR0/NUAEBsHU4KO7lTDbEwoWnb/UrdtNu4PXjl4tM6rRsZFt5LW2N+JiPTqu5ivm3EU5qChAi+9Mzlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGvExHOY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGvExHOY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6B21F00A3D;
	Tue,  1 Sep 2026 08:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788249678;
	bh=zNZp76LmMZW3NXwmMTUnhjhTpOUBg0Q4ECe+ZH4uME8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fGvExHOY45FNQdEKgde1XkrvPlPl/UO8x+rWWxRJTa2pEnWtqx8DqGbmp/Lcn7LmB
	 lnsPNhuTDU3H/zynKvAH8nERttKjASIr8o6Mzk/gGypOH65gWeCHOHe7ZYAp58hUpc
	 D25mecs/wlA40uEzxHJSnqCheEoZJqB292OI5h5dufqGxPR8UTug3eBwl59ukrIqX8
	 FE3e/NXFI0v357q3pWRuski93Ekay3eJ0AiJ+ufAHQJNQ6L2t8GQFcmvgoVvS5X4Ao
	 5pKbKYeqV9Q+7FFd4uGWBpWkq6snE/XeaILChm8jpgm4ngIAIi61NoD7N+Tbv6ZkOT
	 USIRIInDx9T6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/8] HID: i2c-hid-of: skip post-power-on delay if
 powered on sufficiently long
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen-Yu Tsai" <wenst@chromium.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260901074930.764550-4-wenst@chromium.org>
References: <20260901074930.764550-1-wenst@chromium.org>
 <20260901074930.764550-4-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 08:01:17 +0000
Message-Id: <20260901080118.5C6B21F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Skipping the post-power delay when regulators are already enabled =
removes the implicit minimum reset pulse width (T_reset), which can leave d=
evices in an undefined hardware state.
--

commit b221f2dda3539367a70e306f0fab88390cca40e7
Author: Chen-Yu Tsai <wenst@chromium.org>

HID: i2c-hid-of: skip post-power-on delay if powered on sufficiently long

This commit replaces regulator_bulk_enable() and an unconditional sleep with
regulator_bulk_enable_and_wait(). This skips the post-power delay if the
regulators have been enabled long enough.

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
>  	gpiod_set_value_cansleep(ihid_of->reset_gpio, 0);

[Severity: High]
Does skipping the post-power delay when regulators are already enabled remo=
ve
the implicit minimum reset pulse width (T_reset)?

The driver unconditionally asserts the reset line initially in
i2c_hid_of_probe():

    ihid_of->reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT=
_HIGH);

If a device's regulator is shared or left enabled by the bootloader,
regulator_bulk_enable_and_wait() skips the delay. This causes the reset line
to be de-asserted immediately here, creating an extremely short pulse.

Could this regression leave the HID device in an undefined hardware state a=
nd
cause it to fail to probe or become unresponsive?

>  	if (ihid_of->post_reset_delay_ms)
>  		msleep(ihid_of->post_reset_delay_ms);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901074930.7645=
50-1-wenst@chromium.org?part=3D3
