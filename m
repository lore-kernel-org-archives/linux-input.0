Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBAF415F2F
	for <linux-input@vger.kernel.org>; Thu, 13 Aug 2026 14:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633141; cv=none; b=gNgfz/MUc3aj9qKKUGrH7UuQbyrU03CZbQ9i1gFb5Q8/kL0O2UnILdpnD9CpihBWBAe0L/gmK9Cee5KkJImUrV4m956Z5m9esZMXe31MRVF2phKY8hsIJFOSIjqqEsCMNRqXPo7Zlx/p+Cprf7FTse36PN80vTCr97J34BwUOYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633141; c=relaxed/simple;
	bh=w7Q9hHxQJlCFPY3qTQV+m6EZZqd89H50oAvnABxGHtE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=do3V/Fx0ZikcZpzhmn9pI+3C5eFCtpThFPACY6qHfJK/GoEwWTfc81y++mGh//DsMiQmIn5hBlD0P7e+3vXaAwZcqoFSzvJG3uiTWH86QFqZh1wYp3WPQ/X6Jlbv+d54S8j6OrKQFAfATbTH9WjonVAVRNFEzLsAVMDNCBmo+pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIszcgvf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIszcgvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77691F000E9;
	Thu, 13 Aug 2026 14:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786633140;
	bh=DWj4oH78oPaxC2uKkaEWmkaoAqvbl8swlE2WCWAfd0E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RIszcgvfgZVq/rNob7wqI82y2iU+9IpJEpTCq5mcp5t89lrERBsxWhQCuSqx+7y/Z
	 yE0X1Gld4votGX/RNN3q3D/u231wkm0FWslvQIllNeDiH/BB/X5zcItSaDbZ8o4fZH
	 NaMxJeSouI62l42wriDhPgrtRI1Wd4baZJ385tNYW7SMkvsIgjWwQGvctOMzUzu/0+
	 1zKZvXzRiVpKYKYfGe3G8VrBHCXj2PrtL9wpkxVST6LX1nyPyu7ga0aywujt0OS733
	 tQ5BjW5e9bd20RQg/K7zT/SijElbpAhWoaZswLqPqPyEiHCr3da98xatlbZEtGuND7
	 gLG37aEPuyZ5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/12] HID: asus: add triggers inner and outer range
 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260813144736.2477941-7-denis.benato@linux.dev>
References: <20260813144736.2477941-1-denis.benato@linux.dev>
 <20260813144736.2477941-7-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 14:58:59 +0000
Message-Id: <20260813145859.C77691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Time-of-check to time-of-use (TOCTOU) race condition in trigger =
threshold sysfs stores causes hardware state desynchronization.

Pre-existing issues:
- [High] The `config_mutex` in `struct ally_config` is dynamically allocate=
d but never explicitly initialized.
--

--- Patch [6]: [PATCH 06/12] HID: asus: add triggers inner and outer range =
configuration ---
commit bf1ab6fc2d6df4d87a7b2cef0f0cf8628bb2f010
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add triggers inner and outer range configuration

This patch adds sysfs attributes to configure the inner and outer ranges for
the left and right triggers on ROG Ally devices. It implements the store and
show functions for these limits and sends the updated configuration to the
hardware.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 010b33533068a..eb735ec8f065c 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> +static ssize_t left_trigger_range_lower_limit_store(struct device *dev,
> +				       struct device_attribute *attr,
> +				       const char *buf, size_t count)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct asus_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	struct ally_handheld *const ally =3D drvdata->rog_ally;
> +	u8 value;
> +	int ret;
> +
> +	if (!ally || !ally->config)
> +		return -ENODEV;
> +
> +	ret =3D kstrtou8(buf, 10, &value);
> +	if (ret || value > 50)
> +		return -EINVAL;
> +
> +	ret =3D ally_set_trigger_ranges(hdev, ally->config,
> +					   value,
> +					   ally->config->left_trigger_max,
> +					   ally->config->right_trigger_min,
> +					   ally->config->right_trigger_max);

[Severity: Medium]
Could this cause a TOCTOU data race if multiple threads write to the trigger
sysfs attributes concurrently?

Since the other limit values are read locklessly from `ally->config` before=
 the
hardware is updated, concurrent writes to different attributes could interl=
eave.

This might result in one thread sending a stale limit while overwriting the
other thread's hardware update, permanently desynchronizing the hardware
configuration from the driver's software cache.

Should the mutex be acquired before calling `ally_set_trigger_ranges()`?

> +	if (ret)
> +		return ret;
> +
> +	scoped_guard(mutex, &ally->config->config_mutex)
> +		ally->config->left_trigger_min =3D value;
> +
> +	return count;
> +}

[ ... ]

> @@ -1246,6 +1540,10 @@ static struct ally_config *ally_config_create(stru=
ct hid_device *hdev, struct al
>  	cfg->left_outer_threshold =3D 90;
>  	cfg->right_deadzone =3D 10;
>  	cfg->right_outer_threshold =3D 90;
> +	cfg->left_trigger_min =3D 0;
> +	cfg->left_trigger_max =3D 100;
> +	cfg->right_trigger_min =3D 0;
> +	cfg->right_trigger_max =3D 100;

[Severity: High]
This is a pre-existing issue, but is `config_mutex` ever explicitly initial=
ized?

In `ally_config_create()`, `cfg` is dynamically allocated via `devm_kzalloc=
()`
which zero-initializes the memory.  However, it appears
`mutex_init(&cfg->config_mutex)` is never called before the mutex is locked=
 in
functions like `ally_detect_capabilities()` or the sysfs store operations.

Could this lead to a kernel panic or lockdep warning when the uninitialized
mutex is locked under contention?

>  	cfg->vibration_intensity_left =3D 100;
>  	cfg->vibration_intensity_right =3D 100;
>  	cfg->vibration_active =3D false;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813144736.2477=
941-1-denis.benato@linux.dev?part=3D6
