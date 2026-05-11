Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AE847CC96
	for <linux-input@vger.kernel.org>; Mon, 11 May 2026 22:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778537364; cv=none; b=WjD6LRNh58aPwkVBbrIga9YigTwvtbkzycJ4BlnX4oJXltS4dNg7KAZU4yVaU6kbpW7Eb9FvoBrPNUwAD5PSj2mMycVceghlmxQp5g9h2K5ccIBZfN4J0vCzZUys6pRB1U4ro9E7ZqjZ/sSMxvM7oqCliJjuWhOCKf7gz6+xqD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778537364; c=relaxed/simple;
	bh=cu1gkt4vdTqXkCWUH+ckP9XNzBS77GdCLpSo9ojeLSs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ViE0ZlAgRZZ13YDmfaOuR5p6MJu8W4eAlH5JSmz9wT7FDw5dHGfZApUFNwf6Wn1rIoJOKWUQ+qrEme0ew6lp5udBFS62HiwULh1y9CebIUvNyXCWc+ZcBOAgfaIwd2uGOi8ViDsZCaTcGEfNT77xH6vICqzOBDy6pdD7IuzP4JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnFSg2tp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnFSg2tp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E62C2BCB0;
	Mon, 11 May 2026 22:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778537363;
	bh=cu1gkt4vdTqXkCWUH+ckP9XNzBS77GdCLpSo9ojeLSs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JnFSg2tp/NNKjme16zJvOMlYHB9WTXFZQpg3wgQqE4SivnKMnemQMEwYiSbR7ZRRh
	 u5QmlPRNAX1eOTtaWPo9vvJfmWCuT+wq9ArxqKfghJv5iVUWpvNv6LanqlhX3dyxAw
	 +NPCmcLHz8hJPKtHiQv+SR7ry4rrkUWEzYnXakKgecysNeBEBoHh99H+DH0AT5MAO8
	 j0+5LdjEVccWlK/lv+615Fm67PId6b4UUZWzold20mFI0UXp1e+6Zxs/zgYPrQwtuw
	 xAr21mxiahzLoV/FkI3rJgKVhGvF37GrEj0CZR4tkvY39afanBPsTRppH9tlkiKMWY
	 cTDYc/FACnQ0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] HID: hid-msi-claw: Add Rumble Intensity Attributes
Reply-To: sashiko@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260510043510.442807-5-derekjohn.clark@gmail.com>
References: <20260510043510.442807-5-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 May 2026 22:09:23 +0000
Message-Id: <20260511220923.98E62C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] The underlying `mcu_property_out()` function uses an improperl=
y scoped `guard(mutex)`, breaking all driver synchronization.
- [High] Unprotected modification of `drvdata->profile_pending` causes race=
 conditions during concurrent sysfs reads.
- [High] Torn transactions in sysfs store handlers lead to state mismatch b=
etween hardware and software.
- [Medium] Failure to reset `drvdata->profile_pending` on `mcu_property_out=
()` error paths corrupts state machine.
--

commit 2a92587430af9e91f5af5fbf2205fea99b2d1000
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi-claw: Add Rumble Intensity Attributes

This commit adds intensity adjustment for the left and right rumble motors
via new sysfs attributes.

> diff --git a/drivers/hid/hid-msi-claw.c b/drivers/hid/hid-msi-claw.c
> index f4fe74a784c29..6d089f49abdb4 100644
> --- a/drivers/hid/hid-msi-claw.c
> +++ b/drivers/hid/hid-msi-claw.c

[ ... ]

> @@ -795,6 +811,116 @@ static ssize_t button_mapping_options_show(struct d=
evice *dev,
>  }
>  static DEVICE_ATTR_RO(button_mapping_options);
> =20
> +static ssize_t rumble_intensity_left_store(struct device *dev,
> +					   struct device_attribute *attr,
> +					   const char *buf, size_t count)
> +{

[ ... ]

> +	ret =3D mcu_property_out(hdev, CLAW_COMMAND_TYPE_WRITE_PROFILE_DATA,
> +			       data, ARRAY_SIZE(data), 8);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mcu_property_out(hdev, CLAW_COMMAND_TYPE_SYNC_TO_ROM, NULL, 0, =
0);
> +	if (ret)
> +		return ret;
> +
> +	drvdata->rumble_intensity_left =3D val;
> +
> +	return count;
> +}

Could this sequence introduce a regression if interrupted by concurrent sys=
fs
stores?

Since there doesn't appear to be a lock held across this sequence, concurre=
nt
writes could interleave their WRITE_PROFILE_DATA and SYNC_TO_ROM commands.
This could cause the hardware to synchronize an unintended state or cause t=
he
local driver state to fall out of sync with the actual hardware value.

Also, regarding the underlying mcu_property_out() function: does it use an
improperly scoped guard(mutex)? If the configuration mutex is acquired
strictly inside a limited scope, the lock would be released before
hid_hw_output_report() and wait_for_completion_interruptible_timeout() are
executed. This could leave all concurrent sysfs calls unprotected, causing a
regression with overlapping USB output reports.

> +static ssize_t rumble_intensity_left_show(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{

[ ... ]

> +	drvdata->profile_pending =3D CLAW_RUMBLE_LEFT_PENDING;
> +	ret =3D mcu_property_out(hdev, CLAW_COMMAND_TYPE_READ_PROFILE, data, AR=
RAY_SIZE(data), 8);
> +	if (ret)
> +		return ret;

Is it possible for concurrent sysfs reads to cause a regression here?

Since drvdata->profile_pending is modified without any locking, if two sysfs
attributes are read concurrently, one thread's modification could overwrite
the other's state. When the asynchronous USB response later arrives,
claw_profile_event() might rely on this clobbered value to route the incomi=
ng
data, which could result in userspace reading incorrect data.

Additionally, if mcu_property_out() returns an error, the function returns
immediately but leaves drvdata->profile_pending set to the pending state.
Could this stale state cause a regression where a subsequent unrelated
asynchronous profile event is incorrectly intercepted by claw_profile_event=
()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260510043510.4428=
07-1-derekjohn.clark@gmail.com?part=3D4
