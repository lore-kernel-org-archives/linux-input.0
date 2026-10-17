Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7E3390224
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 02:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792203282; cv=none; b=SxRbFyXlFsc7/NRECvszgOOZVFmbr4+nRKEFR5Z2aMDQETCY+a3Z4dhkiI0iDwJoZSAMb6EtbW6KEqJcG1N7Eq7YYO0m6TKDnwWSR85EsRRFDwEmskyPXXhN/z0ye+1ilDtYf1e6lCFQJqSExcEitLKg9otlwyHyeSZUt0mh/lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792203282; c=relaxed/simple;
	bh=2pttFBnWYYpRtTmsPr+LRQncVwN4wuRysv59ETDGaB8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=dKjAJZi1lcdQGLu7sZPd90dFntwrTzScv5awrbqY23XBsYuTklmH+1DEqpJUdd7kWj1VNcKkygVkHgl4LYLvO55LhJb/ucF5OgmlalOhfUkmi+fZpxgN/l2pGcqhYGxeku9G+I9tlc4eXAAxYfKwLVuAMmzX9Yt+Ck2p8d8gBKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiWCymbf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiWCymbf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C0D1F000C4;
	Sat, 17 Oct 2026 02:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792203280;
	bh=TUvG9UvA2VZcLA1MKvp7x+1pPVACri5E/dboLg27j4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GiWCymbfry3ktBcX0KeEo3Pghy46U4RvUKMSu+nKkmyaocVL3XDgyvNXGST2Psp4h
	 mmiU0issjvIcWVcuP3AP46MDjas23yeq8hX9y8tucCs4BdCvvNHcGk+S83KxlGScN5
	 O3lXAX6f3G+u98dRECim11yYcGpq21nkXEj+dub/CgUq4Nwl1KgAn6tbJwTJ6XvHV4
	 42bt4tlxSsbdM/P6ZFHodYoyFohgQxCybVTVO3rVkjGZY01Vs7yahJuJJUGqG3FTJP
	 vR8pwFiWjSt6B/yb8tD6SDfz2ZJryldW4d4PNMWskZVAQVzhYPGxgMRkZMlhkNQ+38
	 lM7Z4o5kavMUQ==
Message-ID: <sashiko-outbox-175197@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/11] HID: hid-lenovo-go-s: Move static
 led_classdev_mc to drvdata struct
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261017013956.2440130-10-derekjohn.clark@gmail.com>
References: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
 <20261017013956.2440130-10-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 02:14:39 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] HID: hid-lenovo-go-s: sleeping in atomic context in hid_gos_bright=
ness_set()
--

commit ce257492c69717cfbc87ce4b7e8049536c911d19
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-lenovo-go-s: Move static led_classdev_mc to drvdata struct

This commit moves the static gos_cdev_rgb multicolor LED structure into
struct gos_cfg_drvdata and initializes it in hid_gos_cfg_probe() in
preparation for dynamically allocating drvdata.

> diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
> index 136372eb6e6bf..2e938dd5e77c5 100644
> --- a/drivers/hid/hid-lenovo-go-s.c
> +++ b/drivers/hid/hid-lenovo-go-s.c

[ ... ]

> @@ -1593,6 +1580,18 @@ static int hid_gos_cfg_probe(struct hid_device *hd=
ev,
>  	mutex_init(&drvdata.cfg_mutex);
>  	init_completion(&drvdata.send_cmd_complete);
> =20
> +	/* Device is hardwired and name is guaranteed to be unique */
> +	drvdata.led_mc.led_cdev.name =3D "go_s:rgb:joystick_rings";
> +	drvdata.led_mc.led_cdev.brightness =3D 0x50;
> +	drvdata.led_mc.led_cdev.max_brightness =3D 0x64;
> +	drvdata.led_mc.led_cdev.color =3D LED_COLOR_ID_RGB;
> +	drvdata.led_mc.led_cdev.brightness_set =3D hid_gos_brightness_set;
> +	drvdata.led_mc.num_colors =3D 3;
> +	drvdata.led_mc.subled_info =3D devm_kmemdup(&hdev->dev, gos_rgb_subled_=
info,
> +						  sizeof(gos_rgb_subled_info), GFP_KERNEL);
> +	if (!drvdata.led_mc.subled_info)
> +		return -ENOMEM;

[Severity: High]
Can registering hid_gos_brightness_set() as the non-blocking
brightness_set callback sleep in atomic context?

In the LED core, brightness_set is invoked directly from atomic contexts
such as software blink timers and LED triggers via:

  led_timer_function()
    -> led_set_brightness_nosleep()
      -> led_set_brightness_nopm()
        -> __led_set_brightness()
          -> led_cdev->brightness_set()

However, hid_gos_brightness_set() calls rgb_cfg_call() ->
mcu_property_out(), which sleeps:

  drivers/hid/hid-lenovo-go-s.c:mcu_property_out() {
      ...
      guard(mutex)(&drvdata.cfg_mutex);
      ...
      if (drvdata.orphan_ack_pending) {
          wait_for_completion_timeout(&drvdata.send_cmd_complete, msecs_to_=
jiffies(25));
      ...
      dmabuf =3D kzalloc(GO_S_PACKET_SIZE, GFP_KERNEL);
      ...
      ret =3D hid_hw_output_report(hdev, dmabuf, GO_S_PACKET_SIZE);
      ...
      t_remaining =3D wait_for_completion_interruptible_timeout(&drvdata.se=
nd_cmd_complete,
                                                              msecs_to_jiff=
ies(timeout));
      ...
  }

Should hid_gos_brightness_set() be wired up to brightness_set_blocking
instead of brightness_set so that the LED core defers atomic updates to
set_brightness_work?

> +
>  	/* Executing calls prior to returning from probe will lock the MCU. Sch=
edule
>  	 * initial data call after probe has completed and MCU can accept calls.
>  	 */

[ ... ]

>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017013956.2440=
130-1-derekjohn.clark@gmail.com?part=3D9
