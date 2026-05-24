Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A5F30C159
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779648073; cv=none; b=PW9Qk6VRUDyaL/MOpUwK8nrfvpdCW6BAYX4c5dxTqOj0jBAV9hsW/KlEzf93Hm72sMBsGOO472rky43dWk0edqlEZ+FiZvTUchRAdKJfv7RCuAeyMNuttKUkOlgl4d+NBuDQmaefarIkSi6ARiTq0cst+/5v/Jd92Tm/MRevLlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779648073; c=relaxed/simple;
	bh=WrySSnR66GAwhQT8uc9pDrdk9+7mrE/+kPFJ/CLSOtM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AJ8VfnMyh9TGf/sVxpZqmVOS92+hNzGT5d5uv9kyvEvUMoIBMI2c3MN6l75b2alPlAu4JKy5nJVOtOzho+O86JZ9ObEtELqtVDW5PCZpeeD0C74LRdS1A0IqARj9exzsfei2krDTqiPclwEmvnmjvJrNzugQ7QHV7nqkwp6m8wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQeohQ2b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQeohQ2b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1648B1F000E9;
	Sun, 24 May 2026 18:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779648071;
	bh=V83smv29ioc3R/Inhh25MEukr33aRKG7IpMAqOkZKyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XQeohQ2bLq53KnNHWs3pzEaqrTcFG2yVF7H1Eif0g36fRD/BSUide7epIII5kwe27
	 W8Cv9CzHAyR3G2tRoqPOI+JAK598D4uwyy0hPS20oaLAU1k2po0scAH0RnBPrmdFWf
	 S1mg9tkBp+UI8IBlhOgXTqkP6eVe7xFy1ZNuvUlhuenqsH7eutw83B+HOAvZq4evgA
	 ObFNdKobGz2CkNFxMUOcyHjrhOZWeUAXC17QMOa19lGNpJIdRTBhAGUgDTyxpM+Pik
	 kvygmmTnmSwhGmQgS99yj/u3UZp0r7PlCXHiGMIOWoV03AUcFQGVY0bCoq0i/5fkV7
	 coV+c8UfqqreA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: wacom: stop hardware after post-start probe
 failures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260524175552.1973-1-mhun512@gmail.com>
References: <20260524175552.1973-1-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 18:41:10 +0000
Message-Id: <20260524184111.1648B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The error path in `wacom_parse_and_register()` fails to cancel asy=
nchronous works and timers, leading to a Use-After-Free when the `wacom` st=
ructure is freed.
- [High] Dismantling software state before the hardware is stopped on failu=
re paths creates race conditions with active interrupt handlers, leading to=
 a NULL pointer dereference.
- [High] Releasing driver resources before stopping HID hardware in `wacom_=
wireless_work()` leads to a Use-After-Free on incoming events.
--

commit 6396bf377f7e81b67088a1a9500d030c3776a230
Author: Myeonghun Pak <mhun512@gmail.com>

HID: wacom: stop hardware after post-start probe failures

This commit modifies wacom_parse_and_register() to route post-hid_hw_start()
failures through hid_hw_stop() before releasing driver resources.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index a32320b351e3e..76dc833f5f2e9 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c

[ ... ]

> @@ -2456,16 +2456,16 @@ static int wacom_parse_and_register(struct wacom =
*wacom, bool wireless)
> =20
>  	error =3D wacom_register_inputs(wacom);
>  	if (error)
> -		goto fail;
> +		goto fail_hw_stop;

[Severity: High]
This is a pre-existing issue, but does setting the input pointers to NULL
before stopping the hardware create a race condition?

When wacom_register_inputs() fails, its error path sets wacom_wac->pad_input
to NULL. However, because hid_hw_stop() hasn't been called yet, the
hardware can still generate interrupts:

wacom_parse_and_register()
  wacom_register_inputs()
    fail:
      wacom_wac->pad_input =3D NULL;
      return error;
  goto fail_hw_stop;

If an interrupt arrives before hid_hw_stop() completes, will the interrupt
handler dereference the NULL pad_input pointer?

> =20
>  	if (wacom->wacom_wac.features.device_type & WACOM_DEVICETYPE_PAD) {
>  		error =3D wacom_initialize_leds(wacom);
>  		if (error)
> -			goto fail;
> +			goto fail_hw_stop;
> =20
>  		error =3D wacom_initialize_remotes(wacom);
>  		if (error)
> -			goto fail;
> +			goto fail_hw_stop;
>  	}
> =20
>  	if (!wireless) {

[ ... ]

> @@ -2496,6 +2496,7 @@ static int wacom_parse_and_register(struct wacom *w=
acom, bool wireless)
>  	return 0;
> =20
>  fail_quirks:
> +fail_hw_stop:
>  	hid_hw_stop(hdev);

[Severity: High]
This is a pre-existing issue, but does this error path leave pending
asynchronous works and timers running?

While hid_hw_stop() stops new interrupts from the hardware, works like
wireless_work, battery_work, remote_work, or timers that were already
scheduled while the hardware was active might still be pending.=20

Because wacom_probe() will propagate this error and trigger devres cleanup
to free the wacom structure, could these pending works execute later and
attempt to dereference the freed wacom pointer?

>  fail:
>  	wacom_release_resources(wacom);

[Severity: High]
This is a pre-existing issue, but does releasing resources before
stopping the hardware in other code paths create a similar race
condition?

For example, in wacom_wireless_work(), wacom_release_resources() is
called before stopping the HID hardware. This frees resources like
pen_fifo via devres_release_group().

If an incoming HID report arrives after devres_release_group() but
before the hardware is stopped, could wacom_raw_event() attempt to
push data to the freed pen_fifo via wacom_wac_queue_insert(), causing
a use-after-free?

>  	return error;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524175552.1973=
-1-mhun512@gmail.com?part=3D1
