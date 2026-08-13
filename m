Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AA1471437
	for <linux-input@vger.kernel.org>; Thu, 13 Aug 2026 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633021; cv=none; b=mvDm4JawW48FQPHSh7JllQHayXqmxnr4dDbP+tlVUpHv9YJ/P67SJuyGb4PFIN/vrAa+NfaPr+ZVOZ+i0KTb0hjZDeTE2Kgnn4VaZ2JZBEiyJJPxq+Z+8wOylIynjjkGYu/chrz7jOFsEZqyd5wBQEjjkKgrE9QGXNCQyS5ztoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633021; c=relaxed/simple;
	bh=ChNn8LKP6gnP9LReqxlyNtFx9XcHxu583dWgIDG3/eA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r//nlhoBJX9bmkx66zlGR/4PpdRlVHFBrtnweN4QRZn2efCmDgQ2f46a64cZ/MwlaWDZFIrjRbVccsk27V7I85VCFRbrJj1pkoDhSkRBs6hrqwso+OoDtv/Qb7dGPb2mjXLLAP7/tBpzpFvqgwwYBy1zXySDhbenrrSQ0Xx3+XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvIlGnOM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvIlGnOM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC521F00A3A;
	Thu, 13 Aug 2026 14:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786633017;
	bh=Pv4t+3YDB+O38zewGSiOWoJyzswNbgIOhuRKtXJfVDA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XvIlGnOMk71e48GPBluxrmusxdmMU/ZWYUMWby0KirN6hDJdwK/JP+AO6zaxMTkkf
	 own/8CHmUhwQa3dSM8P9SF9kl+vTDaBh1SmDe0NphyMWIk8Q6KYXI06n8bQzRyLtrD
	 zjGeB808r2jgR/mkksXZDkC2SmvHj1Gflq7V25tfJy6NiHIxs1W/I6Sxa5h54es1FB
	 3NWxDIgG+FFLM5lpbTkoglUDDZDyv734aof2NoHLz8LZ640MGFFhoxTh2ECUiA1dCW
	 xr+QoVCDiWF5650VjdN2gT7PUWSTDm1RZz0W0oFOBksyalpKw8yZzQi4PYYUXdPcXC
	 y/mBmhV0qkDtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/12] HID: asus: add vibration strength configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260813144736.2477941-5-denis.benato@linux.dev>
References: <20260813144736.2477941-1-denis.benato@linux.dev>
 <20260813144736.2477941-5-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 14:56:56 +0000
Message-Id: <20260813145657.0FC521F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Lockless read-modify-write (TOCTOU) race condition in vibration =
sysfs store functions causes hardware-software state mismatch.
- [Low] The patch introduces an unused struct field `vibration_active` and =
an unused function parameter `cfg`.
--

--- Patch [4]: [PATCH 04/12] HID: asus: add vibration strength configuratio=
n ---
commit 88d84618d4463bdab2563d7c2980a265cf17afa3
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add vibration strength configuration

This commit adds sysfs attributes to allow userspace to configure the
vibration intensity of the motors on ASUS ROG Ally handhelds.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 6a15380488efb..48cc867aeea86 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -205,6 +205,11 @@ struct ally_config {
>  	u8 left_trigger_max;
>  	u8 right_trigger_min;
>  	u8 right_trigger_max;
> +
> +	/* Vibration settings */
> +	u8 vibration_intensity_left;
> +	u8 vibration_intensity_right;
> +	bool vibration_active;

[Severity: Low]
This isn't a bug, but vibration_active is added here and initialized in
ally_config_create(), but never appears to be read or used elsewhere.

[ ... ]

> @@ -724,15 +729,177 @@ static ssize_t xbox_controller_store(struct device=
 *dev,
> =20
>  static DEVICE_ATTR_RW(xbox_controller);
> =20
> +/**
> + * ally_set_vibration_intensity() - Set vibration intensity values
[ ... ]
> + */
> +static int ally_set_vibration_intensity(struct hid_device *hdev, struct =
ally_config *cfg,
> +					u8 left, u8 right)

[Severity: Low]
This isn't a bug, but the cfg parameter is never utilized inside this
function.

[ ... ]

> +static ssize_t left_vibration_intensity_store(struct device *dev, struct=
 device_attribute *attr,
> +					 const char *buf, size_t count)
> +{
[ ... ]
> +	ret =3D kstrtou8(buf, 10, &value);
> +	if (ret || value > 100)
> +		return -EINVAL;
> +
> +	ret =3D ally_set_vibration_intensity(hdev, cfg, value, cfg->vibration_i=
ntensity_right);
> +	if (ret < 0)
> +		return ret;
> +
> +	scoped_guard(mutex, &cfg->config_mutex)
> +		cfg->vibration_intensity_left =3D value;
> +
> +	return count;
> +}

[Severity: Medium]
Does reading cfg->vibration_intensity_right outside of cfg->config_mutex
create a race condition here?

If concurrent sysfs writes happen for the left and right intensities, could
they read stale complementary values, interleave their hardware I/O
requests, and leave the hardware state permanently desynchronized from the
driver's software cache?

[ ... ]

> +static ssize_t right_vibration_intensity_store(struct device *dev, struc=
t device_attribute *attr,
> +					 const char *buf, size_t count)
> +{
[ ... ]
> +	ret =3D kstrtou8(buf, 10, &value);
> +	if (ret || value > 100)
> +		return -EINVAL;
> +
> +	ret =3D ally_set_vibration_intensity(hdev, cfg, cfg->vibration_intensit=
y_left, value);
> +	if (ret < 0)
> +		return ret;
> +
> +	scoped_guard(mutex, &cfg->config_mutex)
> +		cfg->vibration_intensity_right =3D value;
> +
> +	return count;
> +}

[Severity: Medium]
The same lockless read-modify-write pattern occurs here with
cfg->vibration_intensity_left. Would it be safer to take the lock before
reading the complementary intensity and hold it across the hardware request?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813144736.2477=
941-1-denis.benato@linux.dev?part=3D4
