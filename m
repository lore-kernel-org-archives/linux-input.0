Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A654542C50E
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344851; cv=none; b=gl2o+cPC8FmciuYqBgYt4Kt4K1WkAZoQeRqKhfmeZD+jLV56eA0WRRwzd+50k0ZLoenWNDFvMRm1wYPC7PLuE8q84Iyr8tGH7aJkBdM2OWfPiTuP/wNZQBJNa/IhQEcIXxS+oG/LuKAV5ez5A1yN0sCoIMH9x/YjS/mpnFx7YRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344851; c=relaxed/simple;
	bh=znaRvqhzLEzSKPWl4Kq+fujpAJXllfUWzCNpt2qn3wo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WOxoDt5pX0bdKXQEf9/mRvNuoCKkoPZ4LuXSTgSOhJQyZ4ipLeyCWqmyhyEpMDozM7kq7aHkMR2ZMvpbgZCwwfSA35Pu0wr1WDACCDW73FIhM4Ztpj5vo7rhW9iHCBxwUJ35/CZVDXvuKnALTwITWeRhMHv743SKfUFh41j70dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyXuUr0a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyXuUr0a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032D01F000E9;
	Wed, 29 Jul 2026 17:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785344849;
	bh=zajNpEOWGxD12EwVJ47hKEOWxvSfzoyCWAax6i/AIzw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GyXuUr0aFoNnh44FuZUBODhpOdEOcVezTT+NX1myqpqVzGMqkrk6M8JsyCWuhqjeo
	 Z3Jarup+h2fbEv4GL4zrmcGiqMw+G27Uekf9qdynL7K7vE8x/w9WN9n45zC+G0OWAP
	 DlQEiJX6dYgfnm0eGyWgtUX2lU1KRh6CZr1XZP9L+najGFUjHHCes+eacJP7PfV+8u
	 BIjcu8Ici9cBduzWdaqydkNVk+X8JZbcDg7z254//pj7nlT4CfqEO7XHhzvHOHMvRZ
	 d1JrIIw6Q4sCSgpfH74CLOTJS3FdS+N103wHq/NMx6hxk9cBP+kR2jkp96c9V0uI2U
	 S9R1V7ucKuV4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] HID: wiimote: turn on the LEDs indicating the
 controller id
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael Passos" <rafael@rcpassos.me>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260729164928.1138468-2-rafael@rcpassos.me>
References: <20260729164928.1138468-1-rafael@rcpassos.me>
 <20260729164928.1138468-2-rafael@rcpassos.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 17:07:28 +0000
Message-Id: <20260729170729.032D01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The allocated device ID from `ida_alloc_min()` can exceed 255, c=
ausing silent truncation when stored in the 8-bit `__u8 player_id` field. T=
his truncation leads to an out-of-bounds array read, a kernel WARN, and an =
IDA resource leak.
--

--- Patch [1]: [PATCH v3 1/4] HID: wiimote: turn on the LEDs indicating the=
 controller id ---
commit 966105f47fb17a006aaf5e35062d7f59f8e3dc45
Author: Rafael Passos <rafael@rcpassos.me>

HID: wiimote: turn on the LEDs indicating the controller id

This commit implements the original console behavior of turning on a specif=
ic
LED indicating the controller ID. It uses an IDA struct to assign a cycling
1-to-4 ID to each controller.

> diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
> index 9c12f63f6dd2d..a53f72d5077ef 100644
> --- a/drivers/hid/hid-wiimote.h
> +++ b/drivers/hid/hid-wiimote.h
> @@ -153,6 +153,7 @@ struct wiimote_data {
>  	struct input_dev *mp;
>  	struct timer_list timer;
>  	struct wiimote_debug *debug;
> +	__u8 player_id;

[ ... ]

> diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-cor=
e.c
> index 63c4fa8fbb9b6..48830f2ffcb50 100644
> --- a/drivers/hid/hid-wiimote-core.c
> +++ b/drivers/hid/hid-wiimote-core.c

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

[Severity: Medium]
Could ida_alloc_min() return a value greater than 255 here (for instance, if
256 virtual devices are created)? If so, since wdata->player_id is defined
as a __u8 in struct wiimote_data, wouldn't this assignment silently truncate
the ID and store 0 instead of 256?

[ ... ]

> @@ -671,6 +678,12 @@ static void wiimote_modules_load(struct wiimote_data=
 *wdata,
>  	spin_lock_irq(&wdata->state.lock);
>  	wdata->state.devtype =3D devtype;
>  	spin_unlock_irq(&wdata->state.lock);
> +
> +	scoped_guard(spinlock_irqsave, &wdata->state.lock) {
> +		/* after loading modules, set the Player ID LED cycling from 1 to 4*/
> +		wiiproto_req_leds(wdata, player_leds[(wdata->player_id - 1) % 4]);
> +	}

[Severity: Medium]
If wdata->player_id was truncated to 0, wouldn't (wdata->player_id - 1) % 4
evaluate to -1 due to C integer promotion to int? It looks like this would
result in an out-of-bounds read of player_leds[-1] and send an arbitrary
byte to the device.

[ ... ]

> @@ -1862,6 +1888,8 @@ static void wiimote_hid_remove(struct hid_device *h=
dev)
>  {
>  	struct wiimote_data *wdata =3D hid_get_drvdata(hdev);
> =20
> +	ida_free(&wiimote_ida, wdata->player_id);

[Severity: Medium]
If the ID was truncated to 0, would passing 0 to ida_free() trigger a kernel
WARN because 0 was never allocated (since the minimum allocation is 1)? It
seems this would also permanently leak the actual underlying ID (like 256).

>  	hid_info(hdev, "Device removed\n");
>  	wiimote_destroy(wdata);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729164928.1138=
468-1-rafael@rcpassos.me?part=3D1
