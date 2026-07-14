Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE124156C1
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 18:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053523; cv=none; b=GAte68+ddVRRspuqpqLH9GuxTD/cz0q7tspXI+JT+TrkDfGsdfVNRk+wtjWGMVD5cRX5ATho/glC+orquGiXC0h3jLrb8ffE5CB1YJPkXrCxY9JotWyphjhJF+TOFL2rs6MsF3Lj4ecvf/Taj8QWUIuAff/jEjovzU2g0PRDyOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053523; c=relaxed/simple;
	bh=WgCH+opq6Xq25nY+URV4io6g+UFhdXQCEponUt9Ywio=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R8g57tzT9rAdH8/bHfZ1+ER8XVbxORRq9TDHiO9TqVwLMDZ4IsNWx9S6p52Te5BuADLA9DcxJU7WMhoLYyLaQHiGbVsM5CVgF2cZC7J5Hp5A0DQ+QxjgN/RTosj1uMjOWXrkuIMW7cdu5HmMah4PRWSbLdgZ7Qg5KLxKu4Z1zeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMgXfWvV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMgXfWvV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD8F1F000E9;
	Tue, 14 Jul 2026 18:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784053519;
	bh=U5CsPLZpoxZG1okmID2k977BS5J1IAmVUx2vASeT9AM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NMgXfWvV4VTY1mnvTDJ08hWQlq2qgRqCReEZsTL5uJ5mDAWFkmM/X2xqXqGWg/HAS
	 fXfNuBaorbw9cMicnPiRkuwoMVdUgUyLXbn60G2191g08T8rbjkB/BHm+D7YP+6djF
	 HGf3vf/nfwhNUsexReqhsd4EaC3+REHsOZGflbs0R9RBDcghXN/oNWpzEx/Hp4+yyG
	 DybTDnk247f60OzP63RgBcEh94MNS/cdT/V1xoIvnpSSWxlbvxzAUA2Pu5l85uhpUM
	 tPtZ483LbcoX4b6XAHHJETyUNbyZFImCZ0GlhFmTpZEp2Smgl4Swt12LvKNfm6VxxJ
	 mD0DM7Vy/ft2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: playstation: Support DualSense player LED
 brightness control
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S2F0ZcWZaW5hIE1lZHbEm2RvdsOh?= <k8ie@mcld.eu>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260714180424.70662-1-k8ie@mcld.eu>
References: <20260714180424.70662-1-k8ie@mcld.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 18:25:18 +0000
Message-Id: <20260714182519.4CD8F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Multi-variable data race on `ds->player_leds_state` and `ds->pla=
yer_leds_brightness` in `dualsense_player_led_get_brightness()`.

Pre-existing issues:
- [High] Missing workqueue cancellation in the `dualsense_create()` and `du=
alshock4_create()` error paths causes a use-after-free if probe fails.
--

--- Patch [1]: [PATCH] HID: playstation: Support DualSense player LED brigh=
tness control ---
commit 9dd8a497081a6ac6ae8e211e738b3ef23a0669be
Author: Kate=C5=99ina Medv=C4=9Bdov=C3=A1 <k8ie@mcld.eu>

    HID: playstation: Support DualSense player LED brightness control

This patch wires up the controls for the brightness byte, allowing
the player indicator brightness to be adjusted. It increases the
max_brightness of each player's LED classdev from 1 to 3, and correctly
updates the firmware encoding.

> diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
> index f9dc9378cf777..78e43a176248a 100644
> --- a/drivers/hid/hid-playstation.c
> +++ b/drivers/hid/hid-playstation.c
[ ... ]
> @@ -1219,12 +1229,22 @@ static int dualsense_lightbar_set_brightness(stru=
ct led_classdev *cdev,
>  	return 0;
>  }
> =20
> +/*
> + * The DualSense's player LEDs only support a single, shared brightness =
level
> + * for all lit LEDs -- there is no per-LED brightness control. We still =
expose
> + * per-LED on/off state plus 3 brightness levels through each LED classd=
ev's
> + * max_brightness of 3; the last value written by any player LED classde=
v sets
> + * the shared level for all of them.
> + */
>  static enum led_brightness dualsense_player_led_get_brightness(struct le=
d_classdev *led)
>  {
>  	struct hid_device *hdev =3D to_hid_device(led->dev->parent);
>  	struct dualsense *ds =3D hid_get_drvdata(hdev);
> =20
> -	return !!(ds->player_leds_state & BIT(led - ds->player_leds));
> +	if (!(ds->player_leds_state & BIT(led - ds->player_leds)))
> +		return LED_OFF;
> +
> +	return DS_OUTPUT_PLAYER_LED_BRIGHTNESS_LOW + 1 - ds->player_leds_bright=
ness;

[Severity: Medium]
Could this lockless read result in a multi-variable data race?

In dualsense_player_led_set_brightness(), ds->player_leds_state and
ds->player_leds_brightness are updated together under ds->base.lock.
If dualsense_player_led_get_brightness() reads them without the lock,
a concurrent read could observe the updated state but the old
brightness (or vice-versa due to compiler or CPU reordering), returning
an inconsistent value to userspace.

>  }
> =20
>  static int dualsense_player_led_set_brightness(struct led_classdev *led,=
 enum led_brightness value)
[ ... ]
> @@ -1742,15 +1774,15 @@ static struct ps_device *dualsense_create(struct =
hid_device *hdev)
>  	int i, ret;
> =20
>  	static const struct ps_led_info player_leds_info[] =3D {
> -		{ LED_FUNCTION_PLAYER1, "white", 1, dualsense_player_led_get_brightnes=
s,
> +		{ LED_FUNCTION_PLAYER1, "white", 3, dualsense_player_led_get_brightnes=
s,
>  				dualsense_player_led_set_brightness },
[ ... ]
> -		{ LED_FUNCTION_PLAYER5, "white", 1, dualsense_player_led_get_brightnes=
s,
> +		{ LED_FUNCTION_PLAYER5, "white", 3, dualsense_player_led_get_brightnes=
s,
>  				dualsense_player_led_set_brightness }
>  	};
> =20

[Severity: High]
This is a pre-existing issue, but missing workqueue cancellation in the
dualsense_create() and dualshock4_create() error paths could cause a
use-after-free if probe fails.

During probe, dualsense_set_lightbar() is called to set the initial lightbar
color, which implicitly schedules ds->output_worker:

drivers/hid/hid-playstation.c:dualsense_create() {
    ...
	dualsense_set_lightbar(ds, 0, 0, 128); /* blue */

	for (i =3D 0; i < ARRAY_SIZE(player_leds_info); i++) {
		const struct ps_led_info *led_info =3D &player_leds_info[i];

		ret =3D ps_led_register(ps_dev, &ds->player_leds[i], led_info);
		if (ret < 0)
			goto err;
	}
    ...
}

If a subsequent initialization step fails, the error path returns and allows
devres to free the allocated ds struct:

err:
	ps_devices_list_remove(ps_dev);
	return ERR_PTR(ret);
}

Because the worker is not cancelled, it remains in the system workqueue and
will dereference the freed ds pointer when it executes. Does the error path
need an explicit cancel_work_sync(&ds->output_worker) to prevent this? The
exact same vulnerability exists in dualshock4_create() due to
dualshock4_set_bt_poll_interval().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714180424.7066=
2-1-k8ie@mcld.eu?part=3D1
