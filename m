Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5944AF167
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 13:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792329003; cv=none; b=DadkXHg3dVMgPWAY76+eJxw/bP9Tn6WMc0LpGFUY8FFppVzipUK4Uwy9Uij5CL/hGI1ryvCpyqpgNjpeMYlHd8EKBUXdQym8OlTB5E5Fw/NH6uO9JMRN8S4CtV92o+BTIPApxrg1bIdtRUh+kSTMB2YaBJ4mFZJdrgh5abAaR7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792329003; c=relaxed/simple;
	bh=S6lcb+IkXyE9OkIZZ64ESDBu5I3oxPxPfav6N3qIA6s=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=t1ZrKQdxiJc013IIedScMWoL3xHk95SaoiKokhYLvsPIJAQ6vL70GmlTzK5qhUe3/97EoTG/gysACRQmOGYelNCjscIhHXopwGfcqTMsmdJ308K57VXxM0OGj86fHlQqgK6oUiB97X7dLqv/nvAb4IeHVmDNf4Y2LYCnG+yOaYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRU5nx+5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRU5nx+5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DB51F000C4;
	Sun, 18 Oct 2026 13:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792329001;
	bh=5k52EYaVxmAVaMRh9tyLqeK/t50G8KWxc4cjw6bMLWc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HRU5nx+58UylItZsUl8VxI2849sIjO4LRymizaDpdX2kZnr9cN9QsPvz04wh0GMGF
	 P1urfMcrqjHtqt0oP68g4I3hUQgiEKl80TAeoaKcM53ovVv3qCPA9aYMnae7eXpBPl
	 eSg5CmSmLPq8CfW4x6r5p0kMIEJ8CzkCbSDNNQBscL8u42PchwB/T1LnxCBlDkikqY
	 SmN9nSeraBQao45LPwhRIvt3UxcJ4DN+Nuq0B4+tIqM+66WddW91mG/wKtUrMagF2X
	 O5trYSbWA2OBlIiVWYq6NYqcUQGt9HFGah53QVjscfSqIToHXdExRIg7uNQml2xsVc
	 cRi6e7ZZDdcXg==
Message-ID: <sashiko-outbox-176148@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 5/8] HID: topping: report the M62's battery level
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Gavrilov" <mikhail.v.gavrilov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261018124838.129349-6-mikhail.v.gavrilov@gmail.com>
References: <20261018124838.129349-1-mikhail.v.gavrilov@gmail.com>
 <20261018124838.129349-6-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 13:10:00 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] HID: topping: devres group race in topping_battery_work() causes U=
AF
- [Medium] HID: topping: missing runtime PM get in topping_bind() breaks se=
ssion open
--

commit 6adaaec1c5316acae80d87f07a530efd9db3ae46
Author: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

HID: topping: report the M62's battery level

This patch adds support for reporting the Topping M62's battery level via
a device-scoped power supply registered once the first battery report
arrives. It also sends a session handshake (0x11/0x01) and waits for the
device's reply at bind and resume so that the M62 announces its state in
Mobile Mode.

> diff --git a/drivers/hid/hid-topping.c b/drivers/hid/hid-topping.c
> index 7b46c4cc41745..f9e05ceafad1f 100644
> --- a/drivers/hid/hid-topping.c
> +++ b/drivers/hid/hid-topping.c

[ ... ]

> @@ -237,6 +279,25 @@ static int topping_raw_event(struct hid_device *hdev,
>  	if (get_unaligned_be16(data + 11) !=3D crc16(0xffff, data + 2, 9))
>  		return 0;
> =20
> +	if (data[5] =3D=3D TOPPING_TT_DEVICE && data[6] =3D=3D TOPPING_PP_HANDS=
HAKE)
> +		complete(&th->answered);
> +
> +	if (th->has_battery && data[5] =3D=3D TOPPING_TT_DEVICE &&
> +	    data[6] =3D=3D TOPPING_PP_BATTERY) {
> +		int charge =3D clamp_t(s32, get_unaligned_be32(data + 7), 0, 100);
> +		/* pairs with the release in topping_battery_work() */
> +		struct power_supply *psy =3D smp_load_acquire(&th->psy);
> +
> +		/* the card repeats an unchanged level now and then */
> +		if (charge !=3D th->battery) {
> +			WRITE_ONCE(th->battery, charge);
> +			if (psy)
> +				power_supply_changed(psy);
> +			else
> +				schedule_work(&th->battery_work);
> +		}
> +	}

[ ... ]

> @@ -263,6 +341,89 @@ static void topping_keepalive(struct work_struct *wo=
rk)
>  			      msecs_to_jiffies(TOPPING_KEEPALIVE_MS));
>  }
> =20
> +/* ------------------------------------------------------------------ */
> +/* battery								*/
> +/* ------------------------------------------------------------------ */

[ ... ]

> +static void topping_battery_work(struct work_struct *work)
> +{
> +	struct topping_hid *th =3D container_of(work, struct topping_hid,
> +					      battery_work);
> +	struct hid_device *hdev =3D th->hdev;
> +	struct power_supply_config cfg =3D { .drv_data =3D th };
> +	struct power_supply *psy;
> +	int err;
> +
> +	if (th->psy)
> +		return;
> +
> +	th->psy_desc.name =3D devm_kasprintf(&hdev->dev, GFP_KERNEL,
> +					   "hid-%s-battery",
> +					   dev_name(&hdev->dev));
> +	if (!th->psy_desc.name)
> +		return;
> +	th->psy_desc.type =3D POWER_SUPPLY_TYPE_BATTERY;
> +	th->psy_desc.properties =3D topping_battery_props;
> +	th->psy_desc.num_properties =3D ARRAY_SIZE(topping_battery_props);
> +	th->psy_desc.get_property =3D topping_battery_get;
> +
> +	/*
> +	 * devm on the HID device: released after .remove(), which has
> +	 * stopped .raw_event() and this work by then.
> +	 */
> +	psy =3D devm_power_supply_register(&hdev->dev, &th->psy_desc, &cfg);
> +	if (IS_ERR(psy)) {
> +		hid_err(hdev, "battery: %ld\n", PTR_ERR(psy));
> +		return;
> +	}
> +	err =3D power_supply_powers(psy, &hdev->dev);
> +	if (err)
> +		hid_warn(hdev, "battery: powers link: %d\n", err);
> +
> +	/* a supply seen by .raw_event() is a registered one */
> +	smp_store_release(&th->psy, psy);
> +}

[Severity: High]
Can calling devm_kasprintf() and devm_power_supply_register() on &hdev->dev
from topping_battery_work() race with component_bind() and cause a
use-after-free on th->psy or th->psy_desc.name?

When the aggregate device binds, component_bind() wraps the call to
topping_bind() in a devres group on component->dev (&hdev->dev):

drivers/base/component.c:component_bind() {
	if (!devres_open_group(component->dev, component, GFP_KERNEL)) {
		...
	}
	ret =3D component->ops->bind(component->dev, adev->parent, data);
	if (!ret) {
		component->bound =3D true;
		devres_close_group(component->dev, NULL);
		...
	}
}

Inside topping_bind(), topping_open_session() sends TOPPING_PP_HANDSHAKE,
waits up to 3.5 seconds, and then sends TOPPING_PP_SUBSCRIBE and
TOPPING_PP_ANNOUNCE while incoming reports are already enabled via
hid_device_io_start().

If a battery report (0x11/0x18) arrives in topping_raw_event() before
component_bind() reaches devres_close_group(&hdev->dev, NULL) (either
after TOPPING_PP_SUBSCRIBE while TOPPING_PP_ANNOUNCE is still in flight, or
during wait_for_completion_timeout() if the card's 2-second subscription
was still active from a prior bind), topping_raw_event() schedules
th->battery_work.

If topping_battery_work() executes while the component's devres group is
still open on &hdev->dev, devm_kasprintf() and devm_power_supply_register()
are captured into the component's devres group instead of the HID driver's
probe group.

Doesn't that cause two problems on unbind or removal?

1. If the audio master unbinds (for example, snd-usb-audio is unbound or
   topping_master_bind() fails), component_unbind() calls
   devres_release_group(&hdev->dev, component), which unregisters and frees
   th->psy (and/or th->psy_desc.name) while hid-topping remains bound and
   th->psy remains non-NULL. Subsequent battery frames in
   topping_raw_event() will then pass the freed th->psy pointer to
   power_supply_changed(psy).

2. In topping_remove(), component_del() runs before hid_hw_close(),
   hid_hw_stop(), and cancel_work_sync(&th->battery_work), which would
   release the captured power supply while topping_raw_event() or
   topping_battery_work() can still be running.

> @@ -286,15 +447,16 @@ static int topping_bind(struct device *dev, struct =
device *master,
>  		th->comp =3D comp;
> =20
>  	/*
> -	 * Subscribe and ask for the state HERE rather than at probe:
> -	 * before this point there is nobody to pass the answer to.  The
> -	 * card answers in two waves -- the jacks at once, the gain of a
> -	 * connected input about 5 s later -- so nothing here waits for
> -	 * them: each value arrives through .raw_event() on its own.
> +	 * Open the session and ask for the state HERE rather than at
> +	 * probe: before this point there is nobody to pass the answer to.
> +	 * The card answers in two waves -- the jacks at once, the gain of
> +	 * a connected input about 5 s later -- so nothing here waits for
> +	 * them: each value arrives through .raw_event() on its own.  Only
> +	 * the answer to the handshake is waited for, inside
> +	 * topping_open_session(), before the audio side writes anything.
>  	 */
>  	if (th->subscribe) {
> -		topping_send(th, TOPPING_TT_DEVICE, TOPPING_PP_SUBSCRIBE, 1);
> -		topping_send(th, TOPPING_TT_DEVICE, TOPPING_PP_ANNOUNCE, 1);
> +		topping_open_session(th);
>  		schedule_delayed_work(&th->keepalive,
>  				      msecs_to_jiffies(TOPPING_KEEPALIVE_MS));
>  	}

[Severity: Medium]
Should topping_bind() hold a runtime PM reference via
usb_autopm_get_interface(th->intf) across topping_open_session()?

In topping_probe(), hid_hw_open() calls usbhid_open(), which starts the IN
URB and drops its autopm reference before returning, leaving th->intf's
runtime PM usage count at 0. As noted in the comment above topping_send(),
waking the interface is the caller's responsibility (which topping_write()
does with usb_autopm_get_interface(th->intf)).

Because topping_bind() does not call usb_autopm_get_interface(th->intf):

1. If th->intf has already runtime-suspended before topping_bind() runs
   (for instance, if hid-topping probed before snd-usb-audio and
   autosuspended because no reports arrive before subscription, or if the
   audio driver is unbound and rebound), usbhid->urbin has been stopped by
   hid_suspend(). When topping_open_session() sends TOPPING_PP_HANDSHAKE
   and waits in wait_for_completion_timeout(&th->answered, ...), the reply
   cannot be received on the stopped IN URB, causing a 3.5-second timeout
   and dropped session frames.

2. Even if th->intf is active when topping_bind() starts, waiting up to
   3500 ms in topping_open_session() exceeds the default 2000 ms USB
   autosuspend delay. If th->intf runtime-suspends during the wait,
   topping_suspend() runs before topping_bind() calls
   schedule_delayed_work(&th->keepalive, ...), leaving th->keepalive
   scheduled on a suspended interface; if th->intf then resumes before
   topping_open_session() finishes, topping_resume() sees th->comp !=3D NULL
   and calls topping_open_session() concurrently on the shared
   th->answered completion.

[ ... ]

> @@ -466,8 +636,7 @@ static int topping_resume(struct hid_device *hdev)
>  	 */
>  	if (th->subscribe) {
>  		noio =3D memalloc_noio_save();
> -		topping_send(th, TOPPING_TT_DEVICE, TOPPING_PP_SUBSCRIBE, 1);
> -		topping_send(th, TOPPING_TT_DEVICE, TOPPING_PP_ANNOUNCE, 1);
> +		topping_open_session(th);
>  		memalloc_noio_restore(noio);
>  	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018124838.1293=
49-1-mikhail.v.gavrilov@gmail.com?part=3D5
