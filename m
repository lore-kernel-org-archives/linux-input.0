Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD564078CC
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 10:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791887764; cv=none; b=nAZ7HTuFDOxBg5PdoyLUojTrRtuMrjvTp31cmfszot0fr8jnpUwNaQFJ1jXE2u9Ds6upoZeJfZCCL6CC23nqd/mUmgqeXd15RlSHVerFj8Z6USvnBoBDlDRLCoTr+61Avqap+xBiE+fUdgBrbn01Oj4JjnvTYcIfeBTAe9I5rfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791887764; c=relaxed/simple;
	bh=cTKhFlwiB2nAxcfaaB7oVIvLELROAGgAsTyJ1doyDdo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=IQLZ/8KgutAzHhZWpncdypM4lUxYV1TMmsla+g4qSa9nenCcNfcyU0jkHk0Pq+yLO2wAEduDpyGhQ4/3PH5YnF3FRFAC1w6I+/mzep8+SUIxYdwo6ip6rDD13lafedncioKgC9CmI+v3VC9eZPdhBXGGEYxYnLwco597pWJtMag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XC1mBCsY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XC1mBCsY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6FF1F00893;
	Tue, 13 Oct 2026 10:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791887763;
	bh=Kkx0yjoI7UHDMuD0e/S0CoKJNJ2Z74klh1XIWwcqgmQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XC1mBCsY+ay9QcAupTg69DJGsGOQH/HjiFP2yGQ8quXUb+coRG9Q8USOxLBD80wFs
	 pdY5ahu41JiUSdiZT3aIv7mOxOBve40kNxQG5TNTv9rvrED5gw7JtQdmPFv6ZFir+6
	 RgjfjJ7kPme+04ocP1mKEmh/BOWikcTD2KYcg5NfITivzQyZ7tawM4+bWWdafRszvx
	 gNYOPxA2HuDz+jZFuPN3KSHN8ssgJOysiXxZdlUmYmOezGiZ/ydaKiIs+Tp+VJ4PgE
	 OYe8RdMD1RhO37o9s/ev/+BmKZEMrP85phyBpwx9WoWhFEgvjFfN7pAMME6l/VhBgE
	 upqHuJ2zb8qxQ==
Message-ID: <sashiko-outbox-169522@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [STABLE v5.15-v5.10 6/6] HID: steam: Clean up locking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
In-Reply-To: <20261013091215.529531-6-lee@kernel.org>
References: <20261013091215.529531-1-lee@kernel.org>
 <20261013091215.529531-6-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 10:36:02 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] hid: steam: TOCTOU race in input_open/close corrupts lizard mode
--

commit ad9df30996ddcb8a183a74dda605518707156658
Author: Vicki Pfau <vi@endrift.com>
Date:   Tue Oct 13 09:12:13 2026 +0000

    HID: steam: Clean up locking
   =20
    This cleans up several issues with locking behavior, including RCU acce=
sses
    not being guarded behind a lock.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 5414f446753de..df21c48928303 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
[ ... ]
> @@ -284,9 +285,14 @@ static void steam_set_lizard_mode(struct steam_devic=
e *steam, bool enable)
>  static int steam_input_open(struct input_dev *dev)
>  {
>  	struct steam_device *steam =3D input_get_drvdata(dev);
> +	unsigned long flags;
> +	bool client_opened;
> =20
> +	spin_lock_irqsave(&steam->lock, flags);
> +	client_opened =3D steam->client_opened;
> +	spin_unlock_irqrestore(&steam->lock, flags);
>  	mutex_lock(&steam->mutex);
> -	if (!steam->client_opened && lizard_mode)
> +	if (!client_opened && lizard_mode)
>  		steam_set_lizard_mode(steam, false);
>  	mutex_unlock(&steam->mutex);
>  	return 0;

[Severity: Medium]
Could this introduce a TOCTOU race condition? We read steam->client_opened=
=20
under steam->lock into a local variable, drop the lock, and then block on=20
steam->mutex.=20

Concurrently, a raw hidraw client can open or close the device, which modif=
ies
steam->client_opened under steam->lock. Does this allow the function to act
on stale state while holding the mutex and leave lizard mode incorrectly en=
abled?

>  }
> @@ -295,9 +301,14 @@ static int steam_input_open(struct input_dev *dev)
>  static void steam_input_close(struct input_dev *dev)
>  {
>  	struct steam_device *steam =3D input_get_drvdata(dev);
> +	unsigned long flags;
> +	bool client_opened;
> =20
> +	spin_lock_irqsave(&steam->lock, flags);
> +	client_opened =3D steam->client_opened;
> +	spin_unlock_irqrestore(&steam->lock, flags);
>  	mutex_lock(&steam->mutex);
> -	if (!steam->client_opened && lizard_mode)
> +	if (!client_opened && lizard_mode)
>  		steam_set_lizard_mode(steam, true);
>  	mutex_unlock(&steam->mutex);
>  }

[Severity: Medium]
Similar to steam_input_open(), does this TOCTOU window allow
steam_input_close() to incorrectly turn lizard mode ON just as a concurrent
raw hidraw client is opening the device and attempting to manage it?=20

Since the Steam client only sends its initialization commands (such as
disabling lizard mode) once upon startup and does not continuously poll, it
seems it would not fix a spurious state change forced by the driver behind
its back.

[ ... ]
> @@ -1098,6 +1113,8 @@ static int steam_param_set_lizard_mode(const char *=
val,
>  {
>  	struct steam_device *steam;
>  	int ret;
> +	bool client_opened;
> +	unsigned long flags;
> =20
>  	ret =3D param_set_bool(val, kp);
>  	if (ret)
> @@ -1105,10 +1122,14 @@ static int steam_param_set_lizard_mode(const char=
 *val,
> =20
>  	mutex_lock(&steam_devices_lock);
>  	list_for_each_entry(steam, &steam_devices, list) {
> -		mutex_lock(&steam->mutex);
> -		if (!steam->client_opened)
> +		spin_lock_irqsave(&steam->lock, flags);
> +		client_opened =3D steam->client_opened;
> +		spin_unlock_irqrestore(&steam->lock, flags);
> +		if (!client_opened) {
> +			mutex_lock(&steam->mutex);
>  			steam_set_lizard_mode(steam, lizard_mode);
> -		mutex_unlock(&steam->mutex);
> +			mutex_unlock(&steam->mutex);
> +		}
>  	}
>  	mutex_unlock(&steam_devices_lock);
>  	return 0;

[Severity: Medium]
Does this have the same TOCTOU race with steam->client_opened as=20
steam_input_open() and steam_input_close() when setting the lizard mode
parameter via sysfs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013091215.5295=
31-1-lee@kernel.org?part=3D6
