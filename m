Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F531368D73
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 21:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784152133; cv=none; b=jA9ZgATXLlXi8KTMhdVw0MAzEB+nYFwPVqRbHq/7pK1/GVyAtsY/9qCp1lj6IR9h1DSoAfB613ze7oTfavB8wJb5bVVv4OWhGa08HDSM+4AJz5lqHHDXjTXtGcUWEdu4zCucM8suWH1NKGbpB6U3sDC/vKoK3XEME3/RZS33oLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784152133; c=relaxed/simple;
	bh=DJW1a1gW211URKk6Lu7Q+De9SOWWCxQmVK3b1Lp8kRA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j5fbKW2C2cAe3JokTDyMtu/6wZFFOuOYADqK1vKxWvVxHarJn7rwOYPyJvozDcj3bzpoJOhQPHyzK+JhHzvzMNGi2SzZNWOmelN1QOqrX3Tvc/rtZEeIlsenF/IsQuBmMnVkWRZbJQZ2ToUdGn8U+Ed2rlau5p50hgEUfsPARsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inyxF8N/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inyxF8N/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8821F000E9;
	Wed, 15 Jul 2026 21:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784152130;
	bh=/CUEiu9texsdG3i1xvdG3IOkWt7Lchc9K6iR6ViNl0U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=inyxF8N/sLy1wd3XI1jNS/A5hsKiU8Va1sZJxoT+ZFYArsVSO6rtmmEy/z9EqzbaT
	 qTFwKR6h9Fu+RpFW0woFk9+RCgTZusclDD1FeUfNk8OhpM5rFvEYy2ZJNftu0bCExD
	 dWsgVYyI5IfaLzOVf8IiU7SxLRDFuIFuQSSUKmP677F+IpLTzXOtCiX8/zDocjr0ly
	 ADXvxxSMUjAv70YERVxg/T7x3bCihpGmOhDCTGSCArMvMf6NrmVB79Hks2vq7jh4Pa
	 W5TKYYP/edQG80TY+9qqeV7WeEwLbBrgfFoAlbXRl4vbhwuBQTg5FKLpUlFXAdcbE8
	 wW+Atz4Z+GTUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] HID: wiimote: turn on the LEDs indicating the
 controller id
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael Passos" <rafael@rcpassos.me>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260715212501.3920033-2-rafael@rcpassos.me>
References: <20260715212501.3920033-1-rafael@rcpassos.me>
 <20260715212501.3920033-2-rafael@rcpassos.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 21:48:49 +0000
Message-Id: <20260715214849.CE8821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Integer truncation of IDA allocation results in out-of-bounds read=
, IDA resource leak, and kernel WARN.
- [Medium] Race condition causing use-before-initialization of `player_id`,=
 leading to an out-of-bounds read.
- [Medium] Mixing `goto`-based error handling and `scoped_guard()` in the s=
ame function violates kernel cleanup subsystem rules.
--

--- Patch [1]: [PATCH v2 1/4] HID: wiimote: turn on the LEDs indicating the=
 controller id ---
commit 49992cb763819a5276c65ada6594868205443ccd
Author: Rafael Passos <rafael@rcpassos.me>

HID: wiimote: turn on the LEDs indicating the controller id

The behavior in a Wii/Wii U console is to have each controller turn on
a different LED indicating the controller id.
This commit implements the same behavior using the ida struct.
Unlike switch controllers, each ID only turns one LED (from 1 to 4).

> diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-cor=
e.c
> index 63c4fa8fbb9b6..91c2cec35f6eb 100644
> --- a/drivers/hid/hid-wiimote-core.c
> +++ b/drivers/hid/hid-wiimote-core.c

[ ... ]

> @@ -671,6 +678,12 @@ static void wiimote_modules_load(struct wiimote_data=
 *wdata,
>  	spin_lock_irq(&wdata->state.lock);
>  	wdata->state.devtype =3D devtype;
>  	spin_unlock_irq(&wdata->state.lock);
> +
> +	/* after loading all modules, set the LED for the player ID cycling fro=
m 1 to 4*/
> +	scoped_guard(spinlock_irqsave, &wdata->state.lock) {
> +		wiiproto_req_leds(wdata, player_leds[(wdata->player_id - 1) % 4]);
> +	}
> +
>  	return;
> =20
>  error:

[Severity: Medium]
Does using scoped_guard() in this function violate the cleanup subsystem
guidelines?

The wiimote_modules_load() function appears to use a goto-based failure path
(goto error;), but introduces a scoped_guard() scope-based cleanup macro.

The cleanup subsystem documentation indicates that mixing goto-based error
handling and scoped_guard() in the same function can create confusing
ownership semantics and should be avoided.

[ ... ]

> @@ -1834,7 +1851,16 @@ static int wiimote_hid_probe(struct hid_device *hd=
ev,
>  	if (ret)
>  		goto err_free;
> =20
> -	hid_info(hdev, "New device registered\n");
> +	player_id =3D ida_alloc_min(&wiimote_ida, 1, GFP_KERNEL);
> +	if (player_id < 1) {
> +		hid_err(hdev, "cannot allocate controller id\n");
> +		ret =3D player_id;
> +		goto err_free;
> +	}
> +
> +	wdata->player_id =3D player_id;

[Severity: High]
Can this assignment truncate the allocated ID?

The player_id variable returned by ida_alloc_min() is an int, but
wdata->player_id is defined as a __u8 in struct wiimote_data.

If enough devices are created (e.g., via /dev/uhid) to allocate ID 256,
the value would truncate to 0.

When this 0 is later evaluated in wiimote_modules_load():

    player_leds[(wdata->player_id - 1) % 4]

The expression (0 - 1) % 4 evaluates to -1, which would lead to an
out-of-bounds array read on player_leds[-1].

Additionally, during device removal in wiimote_hid_remove(), calling
ida_free(&wiimote_ida, wdata->player_id) with the truncated 0 would
trigger a WARN_ON_ONCE in the IDA core (since ID 0 was never allocated)
and permanently leak the originally allocated ID.

[Severity: Medium]
Is there a race condition where wdata->player_id is used before it is
initialized?

The hardware I/O is started and opened via hid_hw_open() earlier in
wiimote_hid_probe(), before the player_id is allocated and assigned here.

If the device immediately sends an event, could a background worker
executing wiimote_modules_load() read wdata->player_id while it is still 0?

This would cause the same out-of-bounds read on player_leds[-1] described
above.

[ ... ]

> diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
> index 9c12f63f6dd2d..a53f72d5077ef 100644
> --- a/drivers/hid/hid-wiimote.h
> +++ b/drivers/hid/hid-wiimote.h

[ ... ]

> @@ -153,6 +153,7 @@ struct wiimote_data {
>  	struct input_dev *mp;
>  	struct timer_list timer;
>  	struct wiimote_debug *debug;
> +	__u8 player_id;
> =20
>  	union {
>  		struct input_dev *input;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715212501.3920=
033-1-rafael@rcpassos.me?part=3D1
