Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331A03E8C70;
	Tue,  6 Oct 2026 12:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791289521; cv=none; b=Rx3hZyI9Q9j/Ro7MDuGGsPOWEFOO2PuG6APN/LvQaCGtzoiAY2GUIxBlObaI/hgXR+T2hyrbRS+QqTyOV/223h0hcUfIU52Wa5Z8GnR158CLjX9dHp7VihWmOYtkHjlkl3y9YiZvn4bIL2PkPOf/c1IdZQea2a6MfRO3G+2vh/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791289521; c=relaxed/simple;
	bh=Q3F9bJ9LYp7FxEu2eLPfqNZigSWwnUf7jZxVyWKavoY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ejdi5lSzMGOIjzw4fkij+fMm74WuAZUdZ+xcTPct5wCLx+eXW4ml8SF/hhTZoUKgaxmZYl+pToWKi67xq/Q9vx+/Pm5j/KqQpHbx19GUNYkuynU0TJEpOl7HEsOaCqKyi6dNxGEK+N2uljiIEkM8JMuA5p8kc2w/+mLOqaJH4/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjbeUpyu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjbeUpyu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276E51F000FF;
	Tue,  6 Oct 2026 12:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791289515;
	bh=xsqwsFF+UBGZZI3/h9ItaNeGKOcN0peONYRe71S7p5A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PjbeUpyuKSzOQqCGSy0KIyeq3csJZYHRbqe8s+asWR8DFw8AfPgH2lz+tF/90w6Le
	 v9jknLsfILvUU5L7diDTxOrguNMNjYOP4tt0a1vHGaSkwooVpUvwTAnz0ebqcmKaFM
	 HWK5f2ka9B1RYh+F18cwIiS2NPVMyC0FDfmNmD17xNeRzZr56zySHg431BYYrPuwI0
	 ubaaBuDeVBMDo8hZvZfFERrjWEGo8rnGUyJ0szudv8MKs3IKvTNOo0OztK09rb10ul
	 9ckmksNoEdVOS0OHL4fGe5a5J/vAkQ1oTRlyed9uEvLR9kzn7713bAhonX2VquY0Aw
	 hUQAd+adqOJMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/7] thermal: qcom: tsens: Add support for MSM8952
 tsens
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20261006-msm8952-initial-support-v4-4-ecdcc1ac620c@mainlining.org>
References: <20261006-msm8952-initial-support-v4-0-ecdcc1ac620c@mainlining.org>
 <20261006-msm8952-initial-support-v4-4-ecdcc1ac620c@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 12:25:14 +0000
Message-Id: <20261006122515.276E51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] thermal: qcom: tsens: heap out-of-bounds write in init_8952() due =
to unvalidated #qcom,sensors
- [High] thermal: qcom: tsens: use-after-free in tsens_probe() when executi=
ng __init init_8952()
--

commit 485835aa537dd437aeac92e15ded8ca82d079ba0
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

thermal: qcom: tsens: Add support for MSM8952 tsens

Add support for tsens v1 block that exists on MSM8952 with 11 tsens
sensors. Sensor Offsets and slope values are taken from downstream.

Link: https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-w=
ear-7.0.0_r0.3/drivers/thermal/msm-tsens.c#1621

> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens=
-v1.c
> --- a/drivers/thermal/qcom/tsens-v1.c
> +++ b/drivers/thermal/qcom/tsens-v1.c
[ ... ]
> +static int __init init_8952(struct tsens_priv *priv)

[Severity: High]
Is it safe to mark init_8952() with __init?

The pointer to this function is stored in the ops_8952 structure below,
which is non-init data. If tsens_probe() is deferred due to calibration
nvmem cell returning -EPROBE_DEFER, or if the device is manually unbound
and rebound via sysfs after boot, it will eventually execute
priv->ops->init(priv).

Could this result in a use-after-free regression by dereferencing
discarded init memory during a later probe?

> +{
> +	for (int i =3D 0; i < priv->num_sensors; ++i)
> +		priv->sensor[i].slope =3D 3200;
> +
> +	priv->sensor[0].p1_calib_offset =3D 2;
> +	priv->sensor[0].p2_calib_offset =3D -1;
[ ... ]
> +	priv->sensor[10].p1_calib_offset =3D -3;
> +	priv->sensor[10].p2_calib_offset =3D -2;

[Severity: High]
Does this sequence unconditionally access up to 11 sensors?

In tsens_probe(), the priv->sensor array is dynamically allocated based
on the num_sensors value, which can be restricted by the device tree:

drivers/thermal/qcom/tsens.c:tsens_probe() {
    ...
    priv =3D devm_kzalloc(dev,
                 struct_size(priv, sensor, num_sensors),
                 GFP_KERNEL);
    ...
}

If a device tree provides a #qcom,sensors property with a value less
than 11, could these assignments overwrite heap memory and cause a
corruption regression during driver load?

> +
> +	return init_common(priv);
> +}
[ ... ]
> +static const struct tsens_ops ops_8952 =3D {
> +	.init		=3D init_8952,
> +	.calibrate	=3D tsens_calibrate_common,
> +	.get_temp	=3D get_temp_tsens_valid,
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-msm8952-in=
itial-support-v4-0-ecdcc1ac620c@mainlining.org?part=3D4
