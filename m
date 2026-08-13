Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703A7320CD1
	for <linux-input@vger.kernel.org>; Thu, 13 Aug 2026 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633197; cv=none; b=my2UxN4cDgYL0A6IT3/ytvM5a0o4jHdkiwfN98t2IYy7EAgHQJZ340mPs4dZFAttdWWx8EHzV6+CVcxy6UnyhhU8SHsUETD8tKgOLAzKsi1JDUlNeHWej0mMGXNCbo2d2aTTmk9F+mWfHee1rocQVtyIjlyh/B7JbiNWXKRhMPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633197; c=relaxed/simple;
	bh=xkwiVR3B8iBRd7d0V62if0q6T0rxLtIGxPyP+GoVQKM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r9ewTbp4Orr0mAIksgF5SqHeyiFkpomvmzM6GaincxolsKkXkAbfPBEC4CujtSPeucoTbUCicINGYBZCOQleu0WVJGi0nOBi65bhWikoahuKmxAwhRRaoSzGpnJCgAjsVa2qZtboH/2bDDCICy/zfkYJYC1/opkmh2sfdvyL9d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZRZZl/r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZRZZl/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671521F000E9;
	Thu, 13 Aug 2026 14:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786633187;
	bh=mBLK9ESMMn7ipML8orTMWhQcgLGzIogwD8wD7ieSSlw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mZRZZl/rcaeMOnpvf1UATXoMkS5GxGT24u7l8JKnfJL7+IDAt7ADxkmmaDH8Yslo6
	 duvplD7CdgmJ6zBvtPEbAFJtyENBvTaiz4sj41BSNoPqlmEFpzbqISLOp+UYyE0JNM
	 l7Hq+FHOfqstIPXur9kMyy1lJUoFO5FSH7Xd3UfYhbjYBCmhl4nv4qqB7g84VjW/Cu
	 +egCunBGryhmpjBGJptT6+BtX2usIQc16x5VPy2SDLECKKpySpmJEVmw7QshVo45iA
	 uY8BzzDRphFeIR4v1G0k+euNCc7MZzYqnp3v9nozMAVe7KusXtq1y9ibu4DpHQxSyL
	 VohQJSaf4Eejw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/12] HID: asus: add support for response curve
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260813144736.2477941-9-denis.benato@linux.dev>
References: <20260813144736.2477941-1-denis.benato@linux.dev>
 <20260813144736.2477941-9-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 14:59:46 +0000
Message-Id: <20260813145947.671521F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Missing NULL pointer checks in sysfs callbacks cause a reliabl=
e kernel panic during device probe (NULL pointer dereference).
--

--- Patch [8]: [PATCH 08/12] HID: asus: add support for response curve ---
commit 6ba0f4853fce7434b3f1730f265395260f85991d
Author: Denis Benato <denis.benato@linux.dev>
Subject: HID: asus: add support for response curve

This commit adds support for configuring the joystick response curves on ROG
ally devices. It introduces several sysfs attributes that allow userspace to
modify the response curve parameters.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 8ed10c5b22ab5..8018e61cf0264 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
[ ... ]
> @@ -1584,6 +1607,319 @@ static struct device_attribute dev_attr_right_tri=
gger_range_upper_limit =3D
>  static struct device_attribute dev_attr_right_trigger_range_upper_limit_=
range =3D
>  	__ATTR(range_upper_limit_range, 0444, right_trigger_range_upper_limit_r=
ange_show, NULL);
> =20
> +enum ally_joystick_side {
> +	JOYSTICK_LEFT =3D 0,
> +	JOYSTICK_RIGHT,
> +};
> +
[ ... ]
> +static int response_curve_apply(struct hid_device *hdev, bool is_left)
> +{
> +	struct asus_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	struct ally_handheld *const ally =3D drvdata->rog_ally;
> +	struct ally_config *cfg =3D ally->config;

[Severity: Critical]
Could ally->config become NULL here if the device is concurrently unbound?

The check for !ally || !ally->config happens in
left_response_curve_apply_store and right_response_curve_apply_store before
calling this function, but it is performed outside of any lock. Could this
lead to a NULL pointer dereference if the state changes in between?

> +	struct ally_joystick_resp_curve curve;
> +	int ret;
> +
> +	/*
> +	 * Snapshot under the lock so a concurrent sysfs write cannot change an
> +	 * entry between the monotonicity check and the packet being built.
> +	 */
> +	scoped_guard(mutex, &cfg->config_mutex)
> +		curve =3D is_left ? cfg->left_curve : cfg->right_curve;
> +
[ ... ]
> +#define DEFINE_JS_CURVE_PCT_FOPS(region, side)					\
> +	static ssize_t side##_response_curve_pct_##region##_show(		\
> +		struct device *dev, struct device_attribute *attr, char *buf)	\
> +	{									\
> +		struct hid_device *hdev =3D to_hid_device(dev);			\
> +		struct asus_drvdata *drvdata =3D hid_get_drvdata(hdev);		\
> +		struct ally_handheld *ally =3D drvdata->rog_ally;			\
> +		return response_curve_pct_show(					\
> +			dev, attr, buf, &ally->config->side##_curve, region);\
> +	}									\

[Severity: Critical]
Can ally or ally->config be NULL here when userspace (like udev) reads
these sysfs attributes during device probe?

If they are accessed before drvdata->rog_ally is fully populated, would
&ally->config->side##_curve cause a NULL pointer dereference? The older
sysfs attributes appear to include an if (!ally || !ally->config) check
before dereferencing these.

> +										\
> +	static ssize_t side##_response_curve_pct_##region##_store(		\
> +		struct device *dev, struct device_attribute *attr,		\
> +		const char *buf, size_t count)					\
> +	{									\
> +		struct hid_device *hdev =3D to_hid_device(dev);			\
> +		struct asus_drvdata *drvdata =3D hid_get_drvdata(hdev);		\
> +		struct ally_handheld *ally =3D drvdata->rog_ally;			\
> +		return response_curve_pct_store(dev, attr, buf, count,		\
> +						side##_is_left, ally, region);	\
> +	}
> +
> +#define DEFINE_JS_CURVE_MOVE_FOPS(region, side)					\
> +	static ssize_t side##_response_curve_move_##region##_show(		\
> +		struct device *dev, struct device_attribute *attr, char *buf)	\
> +	{									\
> +		struct hid_device *hdev =3D to_hid_device(dev);			\
> +		struct asus_drvdata *drvdata =3D hid_get_drvdata(hdev);		\
> +		struct ally_handheld *ally =3D drvdata->rog_ally;			\
> +		return response_curve_move_show(					\
> +			dev, attr, buf, &ally->config->side##_curve, region);\
> +	}									\

[Severity: Critical]
Does this also need a check to prevent a NULL pointer dereference if ally or
ally->config are accessed during probe?

> +										\
> +	static ssize_t side##_response_curve_move_##region##_store(		\
> +		struct device *dev, struct device_attribute *attr,		\
> +		const char *buf, size_t count)					\
> +	{									\
> +		struct hid_device *hdev =3D to_hid_device(dev);			\
> +		struct asus_drvdata *drvdata =3D hid_get_drvdata(hdev);		\
> +		struct ally_handheld *ally =3D drvdata->rog_ally;			\
> +		return response_curve_move_store(dev, attr, buf, count,	        \
> +						 side##_is_left, ally, region); \
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813144736.2477=
941-1-denis.benato@linux.dev?part=3D8
