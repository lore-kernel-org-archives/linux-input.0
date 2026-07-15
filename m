Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3D13A0E8D
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 21:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784151731; cv=none; b=Kf1RfT/4NT626014OonvETmQJ7Nh47wfDu1DhkZFzc4e21VHUHTEVE5XRGcAV+TkEdjNmz8CwD8KMAk+Drna6lxMepcAutmIfGiQlNxKg6/f1YG7drMUw/krZmPoqezS/tN84dgTh+IqLKLYMBhbVcu68d4rtjGfFfOAFUKqh+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784151731; c=relaxed/simple;
	bh=e7DJJx7rLQYzwx0TG+4SSRgdACHFeIU57/q2oHtdonM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CC8tRsdDIhNld2VJzcTdTATljLtOEzX53tz9KZSi22H2MfmA3uEqtqzHyE1f7tPk3LhQLqBaE6yYslQFjvOqpYEqacHsz1i9HIKlgd33pyxqs0eesgL+WqmkbgCJ3OvhC6FAb+fyZU0PKj2Q8CwtLgKJGvHkqwrP7LQc9h/8d88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZLH/IOG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZLH/IOG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6051F000E9;
	Wed, 15 Jul 2026 21:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784151729;
	bh=hCUX0C4a5frC3Q8gi0hpwxRBfZxCTMs3S47fcFhkY64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mZLH/IOGtWfv3y2bi5yFtFm666dPTe9B+epio/w+A+B3H2241uD69I+WPN/VRsSK/
	 vQu7s/4+K63U1VYGFiNm8/h8KDPdvnnWoNWZMLbbuFxapYh8QR0pYThjRhj3npUwAw
	 35S9rZOiZSj7xIVkZSBFuQV5EY2iEtMmlV0kLQNzGZuLsPaoTO16S3npsQHtPM31AD
	 zNUkmNCniZPAuRhPYveReIv+I5K3yzpfLq2PbZ9FHxlRjiwmS02cD2dvtiLPz09xMT
	 W+A6Fuf61PA5WcD2MRh79+8/Jk8WISdmMYppNQ3PIiyPODzkYtY+JDz0CPsgOEXZu+
	 3TbTVrlSRv+Ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] HID: wiimote: use scoped cleanup in wiimote and
 led probes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael Passos" <rafael@rcpassos.me>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260715212501.3920033-4-rafael@rcpassos.me>
References: <20260715212501.3920033-1-rafael@rcpassos.me>
 <20260715212501.3920033-4-rafael@rcpassos.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 21:42:08 +0000
Message-Id: <20260715214209.3F6051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The new scoped cleanup function `__wiimote_probe_cleanup()` fails =
to cancel async workers, timers, and loaded modules on error, leading to a =
Use-After-Free and dangling registered devices.
- [Medium] Truncation of `player_id` from `int` to `__u8` causes IDA double=
 frees, leaked IDs, and an out-of-bounds array access.
--

--- Patch [3]: [PATCH v2 3/4] HID: wiimote: use scoped cleanup in wiimote a=
nd led probes ---
commit 29027bf7f674068d4630217f5005fa7c42f22f18
Author: Rafael Passos <rafael@rcpassos.me>
Subject: HID: wiimote: use scoped cleanup in wiimote and led probes

This patch refactors the cleanup paths in the wiimote and led probe functio=
ns
to use scoped cleanup macros. It also introduces a state mask to track the
hardware probing progress.

> diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-cor=
e.c
> index d37d740a7162f..b549a7d58d512 100644
> --- a/drivers/hid/hid-wiimote-core.c
> +++ b/drivers/hid/hid-wiimote-core.c
> @@ -1774,16 +1774,40 @@ static void wiimote_destroy(struct wiimote_data *=
wdata)
>  /* Global id allocator for wii remotes */
>  static DEFINE_IDA(wiimote_ida);
> =20
> +#define WIIMOTE_PROBE_HW_STARTED  BIT(0)  // hid_hw_start succeeded
> +#define WIIMOTE_PROBE_HW_OPENED   BIT(1)  // hid_hw_open succeeded
> +
> +static void __wiimote_probe_cleanup(struct wiimote_data *wdata)
> +{
> +	if (!wdata)
> +		return;
> +
> +	if (wdata->player_id)
> +		ida_free(&wiimote_ida, wdata->player_id);
> +
> +	// safe, debugfs checks IS_ERR_OR_NULL
> +	wiidebug_deinit(wdata);
> +	// safe, checks dev for NULL
> +	device_remove_file(&wdata->hdev->dev, &dev_attr_devtype);
> +	device_remove_file(&wdata->hdev->dev, &dev_attr_extension);
> +	if (wdata->probe_state & WIIMOTE_PROBE_HW_OPENED)
> +		hid_hw_close(wdata->hdev);
> +	if (wdata->probe_state & WIIMOTE_PROBE_HW_STARTED)
> +		hid_hw_stop(wdata->hdev);
> +	kfree(wdata);
> +}

[Severity: High]
Does this new cleanup function safely handle asynchronous teardown?

In the original code, failures later in the probe function would route to
the err_free label which called wiimote_destroy(). That function cleanly
cancelled wdata->init_worker and unloaded any registered modules.

If a hardware event occurs during probe:

wiimote_hid_event()
   queues wdata->init_worker

And then an allocation fails (e.g. in wiidebug_init or ida_alloc_min):

__wiimote_probe_cleanup()
   hid_hw_stop(wdata->hdev)
   kfree(wdata)

Will the queued worker execute after wdata has been freed?

[ ... ]

> @@ -1792,68 +1816,54 @@ static int wiimote_hid_probe(struct hid_device *h=
dev,
>  	ret =3D wiidebug_init(wdata);
>  	if (ret)
> -		goto err_free;
> +		return ret;
> =20
> -	player_id =3D ida_alloc_min(&wiimote_ida, 1, GFP_KERNEL);
> +	int player_id =3D ida_alloc_min(&wiimote_ida, 1, GFP_KERNEL);
>  	if (player_id < 1) {
>  		hid_err(hdev, "cannot allocate controller id\n");
>  		ret =3D player_id;
> -		goto err_free;
> +		return ret;
>  	}
> -
>  	wdata->player_id =3D player_id;

[Severity: Medium]
Could this assignment result in truncation if the allocated ID is larger
than 255?

ida_alloc_min() returns an int, but wdata->player_id is defined as a __u8.
If an ID exceeds 255, the truncation could result in 0.

If player_id becomes 0, could it cause an out-of-bounds read later?
Looking at wiimote_modules_load():

wiiproto_req_leds(wdata, player_leds[(wdata->player_id - 1) % 4]);

This might evaluate to player_leds[-1].

Additionally, truncation could lead to multiple devices sharing the same
truncated ID, which might cause IDA double frees when devices are removed.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715212501.3920=
033-1-rafael@rcpassos.me?part=3D3
