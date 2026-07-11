Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1D815687D
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 12:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783771338; cv=none; b=PCasz5xTWB77OxqJMEyYVkLW9i2UFVizIHobLzEPT4WBL7LHy0APKarjBFVgNJLKeOCaa7RiSLBL98XgmNf7yTNWKvHfICf3i3qsNz5y5Txop81iwQV2aL5AkPBUReJuS+fowTIJMrcLbIUt6Mxw8Uo9RbbIQnMTQ4i17589Trc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783771338; c=relaxed/simple;
	bh=861q7Dh/5q4N7ML75eyEL2T50h9SeSU4zMgX1gJiDvE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ifumBDb5ykV4o6WSwNPq5wQCqC5yDNJN7e0G8DB4Z8Hyh0PbzYIdRyq3VO82ooNNqfBnXLZfqwsNQ/TsO5kNctwblB+X3hMxvsVSDtr7uwoIc8zcONmIU+kQUTCqSb3OUUy9lwwXBTCl+lGvCGbecMgeK1/lgkW9NfobdbDeBJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1viY66y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1viY66y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0523B1F000E9;
	Sat, 11 Jul 2026 12:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783771337;
	bh=esnf8OUAn/H0q6XoO/HGfetn66mihQEMyBLbEnYuQuo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l1viY66yjJdUEaqbT2i8fIWFReP2uemHFWB9TBcK3c+en2ffmEHOtrey7LEnYaRGW
	 G/asyZoFF1TwEIMYlBsRbc/h5Lv45LtNzL3xzHpnGcOAbvNe8dFB7G0nZbwZiMUWtE
	 6hFTrhD7NN6HxXcTUg7C36On1/m2X9jcPGZArIukdbZlds+Jr/IUrCYVphC8wLYaxd
	 Z6k1fVJno6F2zkEwcUQOdjmknvbWYLz4WWtHlQWaF010QqpSSCQBPcoR7U9WnJBLC5
	 qNs1SEwRyW/xhQIJZKEWEESJ/AcDTiDo38M2SYFqIv0VDIXhF2OPq9aJblhEWHITD3
	 3rOXfPIKPb5jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] Input: applespi - fix NULL pointer dereference
 in tp_dim open
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shih-Yuan Lee" <fourdollars@debian.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260711114937.16670-3-fourdollars@debian.org>
References: <20260711055247.5412-1-fourdollars@debian.org>
 <20260711114937.16670-1-fourdollars@debian.org>
 <20260711114937.16670-3-fourdollars@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 12:02:16 +0000
Message-Id: <20260711120217.0523B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing state clearance in early return paths of `applespi_got_dat=
a` causes deadlocks on device suspend or removal.
- [High] Re-submitting an active `spi_message` on timeout causes SPI core q=
ueue list corruption.
--

--- Patch [2]: [PATCH v4 2/3] Input: applespi - fix NULL pointer dereferenc=
e in tp_dim open ---
commit 6c0dbd1a82c175c3c7ce52b489ebc6b640544832
Author: Shih-Yuan Lee <fourdollars@debian.org>

Input: applespi - fix NULL pointer dereference in tp_dim open

This commit fixes a NULL pointer dereference in applespi_tp_dim_open().
It uses smp_load_acquire() to safely load the asynchronously initialized
touchpad_input_dev and returns -ENODEV if it is not yet available.

> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/a=
pplespi.c
> index 3bdb9e7cfb8b2..4d339445e9c71 100644
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c
> @@ -963,12 +963,18 @@ static void applespi_debug_update_dimensions(struct=
 applespi_data *applespi,
>  static int applespi_tp_dim_open(struct inode *inode, struct file *file)
>  {
>  	struct applespi_data *applespi =3D inode->i_private;
> +	struct input_dev *touchpad;
> =20
>  	file->private_data =3D applespi;
> =20
> +	/* Pairs with smp_store_release in applespi_register_touchpad_device() =
*/
> +	touchpad =3D smp_load_acquire(&applespi->touchpad_input_dev);
> +	if (!touchpad)
> +		return -ENODEV;
> +
>  	snprintf(applespi->tp_dim_val, sizeof(applespi->tp_dim_val),
>  		 "0x%.4x %dx%d+%u+%u\n",
> -		 applespi->touchpad_input_dev->id.product,
> +		 touchpad->id.product,
>  		 applespi->tp_dim_min_x, applespi->tp_dim_min_y,
>  		 applespi->tp_dim_max_x - applespi->tp_dim_min_x,
>  		 applespi->tp_dim_max_y - applespi->tp_dim_min_y);

[Severity: High]
This isn't a bug introduced by this patch, but can the early return paths in
applespi_got_data() cause a deadlock on device suspend or removal?

In drivers/input/keyboard/applespi.c:applespi_got_data(), if a packet arriv=
es
with a CRC error or as a partial multi-packet receipt, the function returns
early without clearing applespi->read_active:

    if (applespi->drain) {
        applespi->read_active =3D false;
        applespi->write_active =3D false;
        wake_up_all(&applespi->drain_complete);
    }
    return;

If the device is then suspended, applespi_drain_reads() is called, which wa=
its
indefinitely:

    wait_event_lock_irq(applespi->drain_complete, !applespi->read_active,
                        applespi->cmd_msg_lock);

Since GPE interrupts are disabled during suspend and no new reads are queue=
d,
does read_active remain true forever, deadlocking the system?


[Severity: High]
This is a pre-existing issue, but does the timeout logic in
applespi_send_cmd_msg() cancel the active SPI message before resubmitting i=
t?

When a timeout occurs, the internal state is cleared:

    if (ktime_ms_delta(ktime_get(), applespi->cmd_msg_queued) < 1000)
        return 0;

    dev_warn(&applespi->spi->dev, "Command %d timed out\n",
             applespi->cmd_evt_type);

    applespi->cmd_msg_queued =3D 0;
    applespi->write_active =3D false;

But then the exact same spi_message (&applespi->wr_m) is resubmitted:

    sts =3D applespi_async(applespi, &applespi->wr_m,
                         applespi_async_write_complete);

If the original message is still actively linked in the SPI core's queue,
will passing the same spi_message to spi_async() again cause list corruption
and a kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711114937.1667=
0-1-fourdollars@debian.org?part=3D2
