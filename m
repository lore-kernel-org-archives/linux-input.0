Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0793C1F
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 00:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788134599; cv=none; b=scSe0BMwF1945pfzJKROlkqyGglIttjnGXXTXBqGobsg5ILZa5BPaw09isYU9lD1bsvurRpTjTUtmFf16bI75Y+uN/+QNgqu01ffS6nvufpJeHxiIpyFwvCR9/nygZt/rBzUj09aEp4Ncu0CVJZyZf9a1uedu8p9mzYHo0+BQu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788134599; c=relaxed/simple;
	bh=YeeR1YW8gWii64hu8zpiidikKHS+TPC08t95LC4u3Fg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nm4cGN1yGmCIKk8An1zWEt5cY5fzMKRYCexV+RptWWX4I3zdQZU5r+uTKIko480cSCjDTcEb+KO9lmeM+vE07MoA/FSGLVSO5ehioCbfdlMR6bkiOOGynaGES/78b/lG0JZw04/Gi82c7FT3ZoRuBbzX2gTf2IvrAtxDULK1u38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K717rpMA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K717rpMA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289371F0155C;
	Mon, 31 Aug 2026 00:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788134598;
	bh=oLx/uwFvHYAMNKxIpcRKqwpbASrXO80CdMqmbgrE8Yk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K717rpMAiVZkM8zgOBtfSD99sCEewjFdvtidSht5e2Ew3rYF8heA+9qJs2Jezi6fo
	 AM96PDLoBvcH1izPVL1jzYaI6Dj3WNYj9Ofl95qq7b76/HWO3E2BF8Smx8ZfZhnfgn
	 +Jjc/E2oa9NTYsS+JEgzo+eW2DTxPseYa7K4sw9nW5ciCZilwX0G5Md9v3KPoHvbv0
	 UAxz0vFyz0PJ7FGnc9mdDuAYZbUe7dHORPqkMhz768At+XRgDQ/YFhUkACBEpv0M0x
	 9XgL5j3/ehqbTHqnSCXrkoFUS1vmmEqI1AtciLBfyGdABTrXn9+uBnLJjpNpVFypi9
	 Qnipk2ZlHfPpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/13] HID: asus: add support for response curve
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260830234320.114356-10-denis.benato@linux.dev>
References: <20260830234320.114356-1-denis.benato@linux.dev>
 <20260830234320.114356-10-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 00:03:17 +0000
Message-Id: <20260831000318.289371F0155C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Time-of-Check to Time-of-Use (TOCTOU) race in `response_curve_ap=
ply` allows the hardware state to desynchronize from the driver's cached sy=
sfs state.

Pre-existing issues:
- [High] The `ally->config` pointer is never initialized to point to the ne=
wly allocated configuration struct in `hid_asus_ally_probe()`. This causes =
`ally_get_config()` to perpetually return `NULL`, breaking all ROG Ally sys=
fs configuration attributes by making them unconditionally return `-ENODEV`.
--

commit 07762bf7508ae913f738afee7cf15dc8cedbd887
Author: Denis Benato <denis.benato@linux.dev>

    HID: asus: add support for response curve
   =20
    ROG ally devices allows configuring the response curve of both joystick=
s,
    therefore add the ability of userspace to modify the response curve by
    exposing relevant sysfs attributes.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index c365b96d4486f..bd488acdb5d49 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
[ ... ]
> @@ -1849,6 +1872,400 @@ static struct device_attribute dev_attr_right_tri=
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
> +/**
> + * ally_set_joystick_resp_curve() - Set joystick response curve paramete=
rs
> + * @ally: ally handheld structure
> + * @hdev: HID device
> + * @side: which joystick side (0=3Dleft, 1=3Dright)
> + * @curve: response curve parameter structure
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +static int ally_set_joystick_resp_curve(struct ally_handheld *ally,
> +					struct hid_device *hdev, enum ally_joystick_side side,
> +					struct ally_joystick_resp_curve *curve)
> +{
[ ... ]
> +}
> +
> +static int response_curve_apply(struct ally_handheld *ally,
> +				struct hid_device *hdev,
> +				struct ally_config *cfg, bool is_left)
> +{
> +	struct ally_joystick_resp_curve curve;
> +	int ret;
> +
> +	/*
> +	 * Snapshot under the lock so a concurrent sysfs write cannot change an
> +	 * entry between the monotonicity check and the packet being built.
> +	 */
> +	scoped_guard(mutex, &cfg->config_mutex) {
> +		if (!cfg->resp_curve_support)
> +			return -EOPNOTSUPP;
> +
> +		curve =3D is_left ? cfg->left_curve : cfg->right_curve;
> +	}
> +
> +	if (!(curve.entry_1.move < curve.entry_2.move &&
> +	      curve.entry_2.move < curve.entry_3.move &&
> +	      curve.entry_3.move < curve.entry_4.move))
> +		return -EINVAL;
> +
> +	ret =3D ally_set_joystick_resp_curve(ally, hdev,
> +					   is_left ? JOYSTICK_LEFT : JOYSTICK_RIGHT,
> +					   &curve);

[Severity: Medium]
Does dropping config_mutex before calling ally_set_joystick_resp_curve()
introduce a race condition?

If a concurrent sysfs write updates the curve between the scoped_guard() bl=
ock
and the transmission, could another thread transmit its updated curve first,
causing the hardware to receive the stale snapshot last and leaving it out =
of
sync with the updated sysfs cache?

[ ... ]


[Severity: High]
This isn't a bug introduced by this patch, but is the config pointer
ever initialized to the newly allocated configuration struct in
hid_asus_ally_probe()?

Looking at hid_asus_ally_probe():

		spin_lock_irqsave(&ally_data_lock, flags);
		ally_drvdata.cfg_hdev =3D hdev;
		spin_unlock_irqrestore(&ally_data_lock, flags);

Because the ally_cfg returned by ally_config_create() is never assigned to
the handheld's config pointer here, won't ally_get_config() perpetually
return NULL and make all ROG Ally sysfs configuration attributes
unconditionally fail with -ENODEV?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830234320.1143=
56-1-denis.benato@linux.dev?part=3D9
