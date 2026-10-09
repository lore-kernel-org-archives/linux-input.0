Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EA8238150
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 02:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791513889; cv=none; b=ToJbuysqpY0QE3bzDSyJHUG9SQgVKnH06BhbsLzvCmPxQzpUvS8qxmXC6mGqtzLkw5Ksv+21VjDEfhJlQXSZxYDtB5ZWh0QPX2Ugqbgplp/9BmWzT4jkDEa4/uMpTAhycCVRBqbHzAG73Fkfr3T5UQgBDnf4YG6xfJ+DcCCs6Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791513889; c=relaxed/simple;
	bh=Ewb8lLmm3+62lpheXuHI+fuPzonVBVNOz4y0N7/9Xcs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=WbGFggSivCBb0KmsyQwmfY3V1VIT26Ftr+hjz1cxCGwwkLZBfxizJ1cJ/0zdYvO3ZA53iF+w0mcMqF31GRUtararIqNeenUclk552HiYLg6zdizhvdAlfjN/FsVCS6rGTW9ZRfRcvYriKo8kJC8RrU4Zp6Df9Fli41LINAM9zg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oItMbmJg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oItMbmJg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BF91F000FF;
	Fri,  9 Oct 2026 02:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791513888;
	bh=KCvXC48tSHNWY0N2vXkXYYK0CbxRYWEyc6ubwuzsdAo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oItMbmJgD+Nh3EDfIpjH3XG2v67+zvJDZSYj2ov63Y/7OAoGKE2XYFXS2sZf350LA
	 0rfUl3d4oPa+fV9mF6NHGjWapqQcRD2FMHxrZAmAbgK33X510DpvSkejoUY6CAMU3Q
	 MGfyjJbMqxp8yWPWN6dnJTBbCrkC5PDMqytL0L+yKz9IBFC87x64Nv7UqiwoYJFR8u
	 xW/0xlf2wrJmT+UBU9Tr41qbbVj/xElFLNvMLSD8y9L0sMi8lYEV/NAUCuGvlD8v7C
	 VMcG9w065SMQbp6F18+jMUScaQN7yd4I28ElWx/xnvYMZMlKQRgpWFwaoCF/Tki7Y4
	 arEIehUupavow==
Message-ID: <sashiko-outbox-164734@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] HID: wiimote: turn on the LEDs indicating the
 controller id
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael Passos" <rafael@rcpassos.me>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20261009022844.2790778-2-rafael@rcpassos.me>
References: <20261009022844.2790778-1-rafael@rcpassos.me>
 <20261009022844.2790778-2-rafael@rcpassos.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 02:44:47 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] hid: wiimote: UAF on probe error path due to early sysfs exposure
- [Medium] hid: wiimote: premature ida_free() races with running workers
--

commit a053e1ef17e333e649ad6046f972b3ed52cf7844
Author: Rafael Passos <rafael@rcpassos.me>

HID: wiimote: turn on the LEDs indicating the controller id

The behavior in a Wii/Wii U console is to have each controller turn on
a different LED indicating the controller id. This commit implements the
same behavior using the ida struct. Unlike switch controllers, each ID
only turns one LED (from 1 to 4).

> diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-cor=
e.c
> --- a/drivers/hid/hid-wiimote-core.c
> +++ b/drivers/hid/hid-wiimote-core.c
> @@ -670,7 +677,10 @@ static void wiimote_modules_load(struct wiimote_data=
 *wdata,
> =20
>  	spin_lock_irq(&wdata->state.lock);
>  	wdata->state.devtype =3D devtype;
> +	/* after loading modules, set the Player ID LED cycling the available L=
EDs*/
> +	wiiproto_req_leds(wdata, player_leds[(wdata->player_id - 1U) % ARRAY_SI=
ZE(player_leds)]);
>  	spin_unlock_irq(&wdata->state.lock);
> +
>  	return;

[Severity: High]
Could wdata->player_id be 0 here if the initialization worker runs before
probe finishes allocating the ID?

If a sysfs write to dev_attr_extension triggers the initialization worker
before wiimote_hid_probe() has assigned player_id via ida_alloc_range(),
wdata->player_id will still be 0. This would cause an underflow in the
calculation (0 - 1U) % 4, incorrectly indexing player_leds[3].

[ ... ]

> @@ -1759,12 +1770,18 @@ static struct wiimote_data *wiimote_create(struct=
 hid_device *hdev)
>  	return wdata;
>  }
> =20
> +/* Global id allocator for wii remotes */
> +static DEFINE_IDA(wiimote_ida);
> +
>  static void wiimote_destroy(struct wiimote_data *wdata)
>  {
>  	unsigned long flags;
> =20
>  	wiidebug_deinit(wdata);
> =20
> +	if (wdata->player_id > 0)
> +		ida_free(&wiimote_ida, wdata->player_id);
> +
>  	/* prevent init_worker from being scheduled again */
>  	spin_lock_irqsave(&wdata->state.lock, flags);
>  	wdata->state.flags |=3D WIIPROTO_FLAG_EXITING;
>  	spin_unlock_irqrestore(&wdata->state.lock, flags);
> =20
>  	cancel_work_sync(&wdata->init_worker);

[Severity: Medium]
Is it safe to free the player ID here before synchronously cancelling
wdata->init_worker?

If the asynchronous initialization worker or timer is actively executing (f=
or
example, performing a periodic hotplug scan or LED setup), releasing the ID
early could allow a concurrently probing wiimote to claim the same player I=
D.

This would result in the still-executing worker of the tearing-down device
continuing to use the old wdata->player_id, which could potentially conflict
with the newly registered device. Should the ida_free() be moved to run
after cancel_work_sync() and timer_shutdown_sync()?

[ ... ]

> @@ -1834,7 +1851,14 @@ static int wiimote_hid_probe(struct hid_device *hd=
ev,
>  	if (ret)
>  		goto err_free;
> =20
> -	hid_info(hdev, "New device registered\n");
> +	ret =3D ida_alloc_range(&wiimote_ida, 1, 255, GFP_KERNEL);
> +	if (ret < 1) {
> +		hid_err(hdev, "cannot allocate controller id\n");
> +		goto err_free;
> +	}
> +
> +	wdata->player_id =3D ret;

[Severity: High]
Does this sequence create a use-after-free window if probe fails?

Prior to this point in wiimote_hid_probe(), device_create_file() exposes
sysfs nodes like dev_attr_extension. If userspace writes to "extension",
it can queue wdata->init_worker.

If a subsequent step fails (like device_create_file for dev_attr_devtype
failing before ida_alloc_range), the error path jumps to err_ext. The
err_ext path removes the file and eventually calls kfree(wdata) without
calling cancel_work_sync(&wdata->init_worker). If the init_worker was
already queued by userspace, it will execute and dereference the freed
wdata.

Could the sysfs nodes be created only after player_id is allocated and
all probe setup is complete, or should the err_ext path be updated to
cancel pending work?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009022844.2790=
778-1-rafael@rcpassos.me?part=3D1
