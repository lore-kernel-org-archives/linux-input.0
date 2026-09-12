Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6CA3803E3;
	Sat, 12 Sep 2026 08:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789203044; cv=none; b=uVRayQAb+bnrcL2xkpJjyQ/uHcG28YFRNXL9h0Q7U/5Y4DZvyluoTo4bOI4HsmTqhEXTJhm56KUO4oncFZbLADp4vic30IP8+Uc81plGGlzrSQWwppQH3wCFc3Xw/Z5r/tpexJ2rC7KXkkchntIHq2AT1ULr6ymR6b+kWXcSO1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789203044; c=relaxed/simple;
	bh=FmOWPRMPH2JkQ6Lct0P6dYnpZNqnJIodRp6a0L0SIws=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CQWUHehwIWBUNuui4DKFt2zyYH75B016T8Qa7MueVFDLuNEOpiCGpW+f6x02pUWd7orcLFEqS8xQ3LD8VetpE3+TCTBCXU/qPJ62xOcOHppKX96vBXFYkfwkGH7rmaCwv0gwZ6EGLTlqDCfrGaFCSgQi3KZQ67pDmmMNCOEdpNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEtNwTC/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEtNwTC/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E281F00893;
	Sat, 12 Sep 2026 08:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789203038;
	bh=K8a9tjlOwMEeSuapMqmjurP67FK+pH5T2UYAMi16GKI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SEtNwTC/I3NUfxRl0aE32tfrx+3gcFaS8ynIcC4+X9zl5haJSiHw2x9B1Do55nuEG
	 DCS7CuNaEUa3CdQNHw9x0ctTGcudSno2qJUkxU7+w2mYRSngkkkJsaJWdw3ZkIQD1B
	 umgLKq2WQZUuPwvW62UuHUmgB14Eq6tAXKGKrsAVnSX4lOhIC/Zxb76gV9pZrfOidQ
	 H5q8YDXqXfWjUpf6Etg7ZkU45aEnRuPKtpC5GxmFGjXuaLgmTBky+25pQMh5Qtx7xR
	 AdOnDlR4LvYIsnueaLq2nZhuirqebsejD5rzPzi6SZ+It3X3NfZg58qOVnmj7nZzlI
	 iinGegedqfThQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 19/20] dt-bindings: input: touchscreen: goodix: Add
 binding for GT970
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, lee@kernel.org, dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org, conor+dt@kernel.org, mfd@lists.linux.dev, linux-input@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260912-msm8952-initial-support-v1-19-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-19-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:50:37 +0000
Message-Id: <20260912085038.19E281F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Heap out-of-bounds write in init_8952 due to hardcoded sensor init=
ialization without validating num_sensors.
- [High] Missing upper bounds check on num_sensors causes a NULL pointer de=
reference in tsens_threshold_violated.
--

commit e2c03bc036014af0112367e60c92c407413054c8
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

dt-bindings: input: touchscreen: goodix: Add binding for GT970

This commit adds a new compatible string for the GT970 touchscreen controll=
er
to the Goodix binding schema. It documents GT970 as falling back to the GT9=
11
compatible string since it works with the GT911 driver.

> diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.y=
aml b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
> index a26a54d63a1c0..4be2c137abd7c 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential heap
out-of-bounds write in init_8952() due to hardcoded sensor initialization
without validating num_sensors.

If a device tree specifies a #qcom,sensors value less than 11 for a
platform using init_8952() (like msm8952), tsens_probe() allocates a priv
structure with a smaller flexible array for sensors.

drivers/thermal/qcom/tsens-v1.c:init_8952() {
    ...
	priv->sensor[10].p1_calib_offset =3D -3;
	priv->sensor[10].p2_calib_offset =3D -2;
    ...
}

Does this code overflow the priv->sensor[] array? Because init_8952()
unconditionally assigns values up to priv->sensor[10], this can overwrite
memory past the allocation if a malformed device tree property is provided
by the bootloader.

[Severity: High]
This is a pre-existing issue, but there appears to be a missing upper bounds
check on num_sensors that causes a NULL pointer dereference.

In tsens_probe(), the unbounded value is introduced here:

drivers/thermal/qcom/tsens.c:tsens_probe() {
    ...
	if (np)
		of_property_read_u32(np, "#qcom,sensors", &num_sensors);
    ...
}

If #qcom,sensors specifies a value greater than priv->feat->max_sensors,
tsens_probe() sets priv->num_sensors to this larger value. init_common()
allocates regmap_field entries in priv->rf only up to max_sensors.

Later, tsens_irq_thread() iterates up to priv->num_sensors and calls
tsens_threshold_violated(), which dereferences the uninitialized regmap
field:

drivers/thermal/qcom/tsens.c:tsens_threshold_violated() {
    ...
	ret =3D regmap_field_read(priv->rf[UPPER_STATUS_0 + hw_id], &d->up_viol);
    ...
}

Does this cause a NULL pointer dereference when accessing priv->rf[]? For
sensors beyond max_sensors, the regmap_field pointer is NULL, causing
regmap_field_read() to crash if a malformed device tree property is
present. Could we validate num_sensors against max_sensors during probe?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D19
