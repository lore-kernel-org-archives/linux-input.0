Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25A24A3D3F
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 10:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791887552; cv=none; b=TbKscPkC0W8IvohcdZRNcyYRA8KtuUSsiM+EhlQzhrAK4Cu0aX7dm1kpZ80JXft6zkR4GQlbWOgLyGUa9hxRHLnnbQ5aOXK1TRYo/6MwsvdDx1WXQHXmkkHT7g6chhb3HmBlDAlGYS11BeoK/LFP5TYMojzDq4uvx6HtbeXn1Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791887552; c=relaxed/simple;
	bh=qSVdsbNuzfYJGq7+F7SDV7bBtFjwm/TiFbVJCz1F5uM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ES9n7SRsfnz5FV6jQ2C7UwTVPHdwRF+TB6i5lx0I3tbxTD+UPGjJjbmaCgIG6+ElsfsMDLIB4151h55A+a2hAIjCYGkfmgyn7s6LqCnyJs4J0UPtoWnKtvNCg7ApuKRzAlibcZwk+E0ZoAlJfURSy5bDdPAp/Wwsrdptn5oGclA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxYTvUUJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxYTvUUJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814B21F000FF;
	Tue, 13 Oct 2026 10:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791887550;
	bh=rwXW3HfhrZR3/hBegi4cxnPU8Qwm7FDUvk8QoAFIajc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oxYTvUUJxnQbjiufCaV5sdBTSpm2A7KMbjHmLPusEgb+WospUBdgTMbr54M0NGSGX
	 ddHXAEHZSGHptXQ1V86a7p7uMT80XJwNMHiuAZny+ewip3A/TWxy81mnkxZCUMYYdo
	 wZRCWqtn6nBUE7Nkt6gJMDVEZuRGxMgR+fYLpWvAWCuJzkASJMc67BNYupLZaSqbaD
	 /layP2QtWiLx01n2aR7qvV0hKFOMV+6aCroP7Rnc93pYhTD4IwpPCWjZ5xM1qR7YzD
	 PK41QbLL+3s8Q0Q15vuNqhYyxcv/+8SHxfRE/aJZWWKZ9Ex4XgZj3h+VyJB/tpBhEG
	 DeLyXiszg6K+A==
Message-ID: <sashiko-outbox-169515@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [STABLE v6.1 6/6] HID: steam: Clean up locking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
In-Reply-To: <20261013091204.529049-6-lee@kernel.org>
References: <20261013091204.529049-1-lee@kernel.org>
 <20261013091204.529049-6-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 10:32:29 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] hid: steam: Race in steam_unregister() causes UAF on probe error p=
ath
- [Medium] hid: steam: TOCTOU race in lizard mode management due to cached =
client_opened state
--

commit 0277b6436a42d5feb84d587b977aa32f278d2fe5
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Clean up locking

This patch cleans up several issues with locking behavior, including RCU
accesses not being guarded behind a lock.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index aa001a293a361..bbc150167a7f1 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c

[ ... ]

> @@ -294,22 +295,30 @@ static void steam_set_lizard_mode(struct steam_devi=
ce *steam, bool enable)
>  static int steam_input_open(struct input_dev *dev)
>  {
>  	struct steam_device *steam =3D input_get_drvdata(dev);
> +	unsigned long flags;
> +	bool client_opened;
> =20
> -	mutex_lock(&steam->mutex);
> -	if (!steam->client_opened && lizard_mode)
> +	spin_lock_irqsave(&steam->lock, flags);
> +	client_opened =3D steam->client_opened;
> +	spin_unlock_irqrestore(&steam->lock, flags);
> +	guard(mutex)(&steam->mutex);
> +	if (!client_opened && lizard_mode)
>  		steam_set_lizard_mode(steam, false);
> -	mutex_unlock(&steam->mutex);
>  	return 0;
>  }

[Severity: Medium]
Could this split locking pattern introduce a race condition?

The client_opened state is cached under the spinlock but acted upon later
under the mutex. A concurrent hidraw client could open or close the device
(modifying steam->client_opened via steam_client_ll_open or close) in the
window between dropping the spinlock and acquiring the mutex.

This time-of-check to time-of-use race could result in the driver making
incorrect lizard mode state transitions based on a stale client connection
status.

[ ... ]

> @@ -565,9 +578,11 @@ static void steam_unregister(struct steam_device *st=
eam)
> =20
>  	hid_info(steam->hdev, "Steam Controller '%s' disconnected",
>  			steam->serial_no);
> +	mutex_lock(&steam->registration_mutex);
>  	steam->registered =3D false;
>  	steam_battery_unregister(steam);
>  	steam_input_unregister(steam);

[Severity: High]
Does this lockless check of steam->registered at the top of steam_unregiste=
r()
create a race condition with the asynchronous registration work?

In steam_probe() for a wireless device, a connect event can schedule
steam_work_connect_cb(), which begins executing steam_register(). If
steam_probe() fails (for example, when allocating client_hdev), it jumps to
err_stream_unregister and calls steam_unregister():

steam_probe()
err_stream_unregister:
    if (steam->connected)
        steam_unregister(steam);

Because steam_unregister() checks if (!steam->registered) locklessly right
before the quoted section above, it returns immediately if steam_register()
hasn't set steam->registered =3D true yet.

After returning, steam_probe() calls cancel_work_sync(), which blocks until
steam_register() finishes registering the input and battery devices. Then
steam_probe() returns an error and devres frees the steam struct. Could this
leave the registered input and battery devices with dangling pointers,
leading to a use-after-free when userspace interacts with them?

[ ... ]

> @@ -1108,6 +1118,8 @@ static int steam_param_set_lizard_mode(const char *=
val,
>  {
>  	struct steam_device *steam;
>  	int ret;
> +	bool client_opened;
> +	unsigned long flags;
> =20
>  	ret =3D param_set_bool(val, kp);
>  	if (ret)
> @@ -1115,10 +1127,13 @@ static int steam_param_set_lizard_mode(const char=
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
> +			guard(mutex)(&steam->mutex);
>  			steam_set_lizard_mode(steam, lizard_mode);
> -		mutex_unlock(&steam->mutex);
> +		}
>  	}
>  	mutex_unlock(&steam_devices_lock);
>  	return 0;

[Severity: Medium]
Is this another instance of the same time-of-check to time-of-use race?

This pattern seems to allow the driver to apply a lizard mode change even if
a client just opened the device, which might improperly interfere with the
raw client's control over the controller.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013091204.5290=
49-1-lee@kernel.org?part=3D6
