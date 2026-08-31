Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7793C1F
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 00:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788134892; cv=none; b=QMRtXK1GR1qLFxeLWIUOXyl8hpRQ7wjho8zw+XjD0ruMsQS1kdByvTW+oG4jSp/A3Xhbp6wp5edxU3Gy2rmj+RCn5BxKHeOppMAgYENNW6WlRMUK+VXZ5YLfvYWgQpaUQAnJ+82sqm0i4BGRhrdn85XLQBL2TzZydMaEu9PxfTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788134892; c=relaxed/simple;
	bh=l+kE2kXM2QwT1jLZ9gnMadUMtS/j6DrkwYutfwLNqIE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xwj7M9fNAoxFHHnaS8ji60VRrkAj0NC+fEudrDIWy7jys5r5XOUoppB3s3iJzzA+N+bqK3sk5UJ7g6hMVQkTXwdMQVhUvXcc+gpaEbrqIGUIUBgAAsT1YgiTjhmXp0Fo4nPkRutwPFx983UZBWTV+5z+ZO9Uvh/sCKt/6f49Z50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOnMNMTS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOnMNMTS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D6B1F000E9;
	Mon, 31 Aug 2026 00:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788134890;
	bh=G3JmBCQ9dIfOIDb/BTH42heC5fteXF9GxrntDlV0X6g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gOnMNMTSXj7AcWw5SxOG5g42iUoSJh4a6H6ciSxYQvTgK3qTu9F9c4axLYorfZQDk
	 7aEmkAfL0hgN3KKfPwc6SA49oYrGxtPS3ZC3ARbZsiNcm/LP69Y5tiClfCUeBFnN8F
	 LEc2sYnA4pbHK7BjQCL7eN8Ew/oXrexbhFTTvunpuey6oSMZBRzdVdQ7pTc+/9RN9P
	 zqFunmwQYdoEYxuJc91PU7upwWPOAj54PB6C/mfgbQHsmZVoRBa1wd/SorXUBkqh5H
	 k58v47Wa9X+wNSCf7MW79dnpAZZyUYMeo+7B8mQ75vhzUavEs6YvRhdtIVLEIYMAdU
	 W1o3c0MFDT27w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/13] HID: asus: add support for btn remapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260830234320.114356-14-denis.benato@linux.dev>
References: <20260830234320.114356-1-denis.benato@linux.dev>
 <20260830234320.114356-14-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 00:08:10 +0000
Message-Id: <20260831000810.97D6B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditional probe failure due to duplicated sysfs group registra=
tion
--

commit f172dc807c5df947db7dc83836bfd7370ad00d67
Author: Denis Benato <denis.benato@linux.dev>

    HID: asus: add support for btn remapping

This commit adds support for button remapping on the Asus ROG Ally,=20
allowing assignment of different events to physical buttons. It exposes a=20
remap_index sysfs attribute and refreshes the software cache when the=20
hardware defaults are automatically restored upon gamepad mode changes.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 7fc04d29de8de..b921e2af53662 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
[ ... ]
> @@ -3098,6 +4052,38 @@ static struct ally_config *ally_config_create(stru=
ct hid_device *hdev, struct al
>  		}
>  	}
> =20
> +	for (sysfs_i =3D 0; sysfs_i < ARRAY_SIZE(ally_attr_groups); sysfs_i++) {
> +		ret =3D devm_device_add_group(&hdev->dev, &ally_attr_groups[sysfs_i]);

[Severity: High]
Does this code inadvertently duplicate the sysfs registration blocks?

Looking at the full ally_config_create() function after this patch, there a=
re
now two identical loops registering ally_attr_groups and two identical
blocks registering ally_cal_attr_groups and ally_create_button_attributes().

When the driver initialization reaches this newly added second loop,
devm_device_add_group() will attempt to register the exact same sysfs
attributes that were successfully registered in the first pass. The sysfs
core detects this duplicate file creation and returns -EEXIST, which causes
an unconditional early exit to the error handler.

Can this second set of registrations be removed to prevent the probe from
always failing?

> +		if (ret < 0) {
> +			hid_err(hdev, "Failed to create sysfs group '%s': %d\n",
> +				ally_attr_groups[sysfs_i].name ?: "", ret);
> +			goto ally_config_create_sysfs_err;
> +		}
> +	}
> +
> +	/*
> +	 * Skip the calibration, anti-deadzone and response curve groups when
> +	 * none of the features they expose is supported.
> +	 */
> +	if (cfg->user_cal_support || cfg->anti_deadzone_support ||
> +	    cfg->resp_curve_support) {
> +		for (sysfs_i =3D 0; sysfs_i < ARRAY_SIZE(ally_cal_attr_groups); sysfs_=
i++) {
> +			ret =3D devm_device_add_group(&hdev->dev,
> +						    ally_cal_attr_groups[sysfs_i]);
> +			if (ret < 0) {
> +				hid_err(hdev, "Failed to create sysfs group '%s': %d\n",
> +					ally_cal_attr_groups[sysfs_i]->name, ret);
> +				goto ally_config_create_sysfs_err;
> +			}
> +		}
> +	}
> +
> +	ret =3D ally_create_button_attributes(hdev, ally, cfg);
> +	if (ret < 0) {
> +		hid_err(hdev, "Failed to create button attributes: %d\n", ret);
> +		goto ally_config_create_sysfs_err;
> +	}
> +
>  	/* So far the only hardware this is supported is the Ally 1 */
>  	if (cfg->xbox_controller_support) {
>  		ret =3D ally_set_xbox_controller(hdev, ally, cfg, true);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830234320.1143=
56-1-denis.benato@linux.dev?part=3D13
