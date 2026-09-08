Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBEE55930D
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891232; cv=none; b=eC70wZxeP5/X0OlFBep+wWMUB05BtpTu3xdmQvkWlGaDRxMxlXeo5Nl0YPXKRCQ/6vvz2B68/C2sBTsQloNgViqe+jGRhn4yZGlzQEix4JjS28vOHLh/K5aAVTuPLXoIXHZvP6HdkYaJ2coEpHiQtTHE2COyE3IfOAvG8mjaPog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891232; c=relaxed/simple;
	bh=IGScqvzFL2Qm24DnBr2ognwQGuUYStBXp29y9bKFlzQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sm9WoIzNk1hVAW5i3aPkysdtVwdp+DUPMolWcZi2ahLkvGs8ITWJEbEMY0JSsVT1uH0eSSrZKwVqNFBeRDJ2ypRUc5SYoq8tw4AxAKEGdc7H0XcFdO2ehpcuS3nLWCbMz903qAHXqak7Bebfx37gSXwUu06FNTuuN1pcFkkHFO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kygdnS60; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kygdnS60"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B080E1F00A3E;
	Tue,  8 Sep 2026 18:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788891230;
	bh=Orpk2RTJYjqAR3+B0jXJWdUm7n+bV/kCFio8tRhjOUw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kygdnS60QhXIpKqh4YiJagOivLtaX43pCvnapOko28j9fQSG0ObvQlEUT4IekEsFE
	 OJ+4LQXqF2FjeyLZ2wHNk/h6uOdYvMptNwdlYvbu8OLI2gMvy4JoP5WJ0Lwgrf1mN0
	 OvqE8wRPuviGOLzAcSnJyxQqRnYDqDepNw2DFDE6ps20Q0A5qKVoVeyv9h4lG3NCVz
	 mDQX0IfkIoYTGRHygFrsJZwyLPwU+o8AhbjGG8kyCOGVs3tkC7++F/PuZF+Z2DIMSK
	 Sk52WUArcEGUfcKdoHGwwqZ3aG8d3cnFFbRDvjoIHtKhcZkIw3cIOU5jgQVVRpWnBf
	 I9tz4LItkNQ7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/13] HID: asus: add support for response curve
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260908174433.74260-10-denis.benato@linux.dev>
References: <20260908174433.74260-1-denis.benato@linux.dev>
 <20260908174433.74260-10-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 18:13:50 +0000
Message-Id: <20260908181350.B080E1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Suspend/resume silently drops the active response curve or incor=
rectly applies an unapplied staged curve.
--

commit 67958cd2657dbe5bf7b4f12a20b0fbd79fa19fbf
Author: Denis Benato <denis.benato@linux.dev>

    HID: asus: add support for response curve
   =20
    This commit adds support for configuring the response curve of both
    joysticks on ROG ally devices by exposing relevant sysfs attributes.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 4ed438121cc97..f338c0eed54b3 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> +static ssize_t response_curve_move_store(const char *buf, size_t count,
> +					 struct ally_config *cfg, bool is_left,
> +					 unsigned int idx)
> +{
> +	struct ally_joystick_resp_curve *curve;
> +	u8 value;
> +	int ret;
> +
> +	ret =3D kstrtou8(buf, 10, &value);
> +	if (ret)
> +		return ret;
> +
> +	if (value > 100)
> +		return -EINVAL;
> +
> +	guard(mutex)(&cfg->config_mutex);
> +
> +	if (!cfg->resp_curve_support)
> +		return -EOPNOTSUPP;
> +
> +	curve =3D is_left ? &cfg->left_curve : &cfg->right_curve;
> +
> +	switch (idx) {
> +	case 1:
> +		curve->entry_1.move =3D value;

[Severity: Medium]
Since this directly mutates the active configuration structure (cfg->left_c=
urve
or cfg->right_curve), does this cause issues with suspend and resume if a u=
ser
has written uncommitted changes?

If userspace stages partial sysfs modifications to response_curve_move_X wi=
thout
triggering the apply attribute, and a suspend/resume cycle occurs, could the
resume path be impacted?

Could we store the staged curve separately from the active curve to prevent
uncommitted edits from interfering with the system resume path?

> +		break;
> +	case 2:
> +		curve->entry_2.move =3D value;

[ ... ]

> @@ -2421,6 +2879,31 @@ static int hid_asus_ally_init(struct hid_device *h=
dev, struct ally_handheld *all
>  					 ret);
>  	}
> =20
> +	if (cfg->resp_curve_support) {
> +		/*
> +		 * sysfs stages the entries without validating them: do not
> +		 * push a curve to the MCU until userspace has applied one
> +		 * that is valid.
> +		 */
> +		if (ally_resp_curve_is_valid(&cfg->left_curve)) {
> +			ret =3D ally_set_joystick_resp_curve(ally, hdev, JOYSTICK_LEFT,
> +							   &cfg->left_curve);

[Severity: Medium]
Will this restore an uncommitted partially edited state if it happens to be=
 valid,
or silently drop the previously valid state if the uncommitted edits made
cfg->left_curve invalid?

> +			if (ret < 0)
> +				hid_warn(hdev,
> +					 "Failed to restore left response curve: %d\n",
> +					 ret);
> +		}
> +
> +		if (ally_resp_curve_is_valid(&cfg->right_curve)) {
> +			ret =3D ally_set_joystick_resp_curve(ally, hdev, JOYSTICK_RIGHT,
> +							   &cfg->right_curve);
> +			if (ret < 0)
> +				hid_warn(hdev,
> +					 "Failed to restore right response curve: %d\n",
> +					 ret);
> +		}
> +	}
> +
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908174433.7426=
0-1-denis.benato@linux.dev?part=3D9
