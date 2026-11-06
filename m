Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793960048;
	b=pwblWUSI7gwvEOPgASiZDVDbPKsdyz8k1xbi8Hq+9JvGAeprCUwDnz3iU0NGP+Pst+yp
	 Crc5oo879Ld6ldYbT56XFi+HmmFJsKrCz12GhwRDWxAL9Y0YqVG+bq0ag5t3Ge8sh6FA5
	 cc/W0GDCu7hx7SFALrvGky5f5fXibBv5vJBI7SvGnJihAYkqGVWf6r0D1jWWuaiPGS1ci
	 1+wu+Jd+9KcNdRTGJFErqsHC1SAuhlvygl5fBIlm5jV8QGSnH00fc4bFDlK9It4a2ZCHp
	 SMb/1/kpN0pQhMulO+q2SqUBtXLY9+dZI/7kcEscjykdkRFGAGhMzDx1fWw1NggDufg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793960048;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QwT2GBVFfcMrIfyvMSPkOFGRB6E2tIfb2WaH7+Q5onE=;
	b=iLmUBe0UkYtPH+dqPLPIGSfBgtpuxRQrUT+WOru4FxAVB1lTEEKLHPoYKujs1NPyhk/i
	 tE0ehmiRFxl4pgGXEIs4mV+sH96cHQuecB1Bfyilz7242uxScRHujj8+mjrOqCVt8JL2J
	 qkkc3m9UVF1V2ME7X3UEnh/kMKtAJf3uaiGkVxtnssSSLU+7Aj84kq0EBtt3j0otuB3SO
	 cxs+LViWpKi5F0XxoFX9qJhPFWQ892WOnMRR87b/6Up1APky+vcvfp76CI9puf6nnytqm
	 7QPLS5ZENqZC9QSUbUhdlsVZGuowYh4T8X1IwqCmzlu+ELGVcUg2TMvp3ZA32tjjT1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LYnAqDk6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821DD606A32E
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 10:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LYnAqDk6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC62E1F0089F;
	Fri,  6 Nov 2026 10:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793960048;
	bh=QwT2GBVFfcMrIfyvMSPkOFGRB6E2tIfb2WaH7+Q5onE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LYnAqDk6NbByAWUZ+LT2OSZCaAPCyUUNwQfmrn+8UejSDIW7rsGSKCLGuXaM56ct2
	 U0YJKBpu2w5HPN4nkpkAqzwC2YIDS3hfAVjH2uXdEEffWBcRZOtopKZWXrWn3oRj6g
	 A5lpPiPz8xofwXBtk/FkJzY1LrirrIZbfz1H+TstOFN4wq3o6dpQJIBdo6T+cUNQ2K
	 8ziWtcaai1GvevXVy3748Ny84qKUxjVRDF3+ofC9oZ1hL21a6z/u/x1z79KmZe7gTu
	 LnpUGsgwIyZuZFP6M1GMdgZ42mvEMi9sJd5/yThfWSqcXfpsTmvRlRTC88df6Hv7Mz
	 I2IvZb8H+yxNg==
Message-ID: <sashiko-outbox-201190@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Input: synaptics - support the touchpad LED on RMI
 function $30
Reply-To: sashiko-reviews@lists.linux.dev
To: "ahmad baghereslami" <ahmad.b1995@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261106095658.44166-1-ahmad.b1995@gmail.com>
References: <20261030070821.1716595-1-ahmad.b1995@gmail.com>
 <20261106095658.44166-1-ahmad.b1995@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 10:14:07 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] Input: synaptics - touchpad LED left on after
  synaptics_disconnect()
- [Medium] Input: synaptics - synaptics_rmi_led_set() ignores brightness
  value
- [Low] Input: synaptics - deprecated system_wq used in
  synaptics_rmi_led_set()
- [Low] Input: synaptics - non-standard error return style in RMI LED
  helpers
--

commit 8709ca284d49e5eecf9c3bb3b076159f75f00824
Author: ahmad baghereslami <ahmad.b1995@gmail.com>

Input: synaptics - support the touchpad LED on RMI function $30

This commit adds support for the touchpad LED wired to RMI function $30
over PS/2 on HP laptops such as the HP ZBook 17 G3.

> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synapt=
ics.c
> index b007e642ea765..4186e4f5373ab 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -589,6 +589,278 @@ static int synaptics_set_advanced_gesture_mode(stru=
ct psmouse *psmouse)

[ ... ]

> +static int synaptics_rmi_write(struct psmouse *psmouse, u8 reg, u8 val)
> +{
> +	struct ps2dev *ps2dev =3D &psmouse->ps2dev;
> +	int error;
> +
> +	error =3D ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE21);
> +	if (error)
> +		return error;
> +
> +	error =3D ps2_command(ps2dev, &reg, PSMOUSE_CMD_SETRATE);
> +	if (error)
> +		return error;
> +
> +	return ps2_command(ps2dev, &val, PSMOUSE_CMD_SETRATE);
> +}

[ ... ]

> +/* Sets the LED. Leaves the touchpad in RMI mode. */
> +static int __synaptics_rmi_led_set(struct psmouse *psmouse, bool on)
> +{
> +	struct synaptics_data *priv =3D psmouse->private;
> +	u8 val;
> +	int error;
> +
> +	error =3D synaptics_mode_cmd(psmouse, SYN_RMI_MODE);
> +	if (error)
> +		return error;
> +
> +	error =3D synaptics_rmi_write(psmouse, SYN_RMI_PAGE_SELECT, priv->rmi_l=
ed_page);
> +	if (error)
> +		return error;
> +
> +	if (on) {
> +		error =3D synaptics_rmi_write(psmouse, priv->rmi_led_brightness,
> +					    SYN_RMI_LED_BRIGHTNESS);
> +		if (error)
> +			return error;
> +	}
> +
> +	error =3D synaptics_rmi_read(psmouse, priv->rmi_led_ctrl, &val);
> +	if (error)
> +		return error;
> +
> +	val =3D on ? val | priv->rmi_led_mask : val & ~priv->rmi_led_mask;
> +	return synaptics_rmi_write(psmouse, priv->rmi_led_ctrl, val);
> +}

[Severity: Low]
This isn't a bug, but in input subsystem functions that have multiple
failure points using an error variable, the preferred style for the final
call is to assign to error, check if (error) return error, and explicitly
return 0 on the success path in both synaptics_rmi_write() and
__synaptics_rmi_led_set().

> +
> +/*
> + * Runs with psmouse_mutex held, like the protected psmouse attributes, =
so
> + * that it does not race with reconnect, resync or attribute changes.
> + * synaptics_disconnect() cancels it with psmouse_mutex held, so it must=
 not
> + * wait for the mutex: when it is busy, try again a little later.
> + */
> +static void synaptics_rmi_led_work(struct work_struct *work)
> +{
> +	struct synaptics_data *priv =3D container_of(to_delayed_work(work),
> +						   struct synaptics_data,
> +						   rmi_led_work);
> +	struct psmouse *psmouse =3D priv->psmouse;
> +	int error;
> +
> +	if (!mutex_trylock(&psmouse_mutex)) {
> +		schedule_delayed_work(&priv->rmi_led_work,
> +				      msecs_to_jiffies(SYN_RMI_LED_RETRY_MS));
> +		return;
> +	}
> +
> +	if (psmouse->state =3D=3D PSMOUSE_RESYNCING) {
> +		schedule_delayed_work(&priv->rmi_led_work,
> +				      msecs_to_jiffies(SYN_RMI_LED_RETRY_MS));
> +	} else if (psmouse->state =3D=3D PSMOUSE_ACTIVATED) {
> +		/* Otherwise the LED is restored on reconnect */
> +		psmouse_deactivate(psmouse);
> +
> +		error =3D __synaptics_rmi_led_set(psmouse,
> +						priv->rmi_led.brightness !=3D LED_OFF);
> +		if (error)
> +			psmouse_warn(psmouse,
> +				     "failed to set touchpad LED: %d\n", error);
> +
> +		/* Setting the mode byte again leaves RMI access */
> +		if (synaptics_mode_cmd(psmouse, priv->mode))
> +			psmouse_warn(psmouse, "failed to restore mode\n");
> +
> +		psmouse_activate(psmouse);
> +	}
> +
> +	mutex_unlock(&psmouse_mutex);
> +}
> +
> +static void synaptics_rmi_led_set(struct led_classdev *led,
> +				  enum led_brightness value)
> +{
> +	struct synaptics_data *priv =3D container_of(led, struct synaptics_data=
, rmi_led);
> +
> +	mod_delayed_work(system_wq, &priv->rmi_led_work, 0);
> +}

[Severity: Medium]
Can ignoring the value argument in synaptics_rmi_led_set() leave the LED
stuck on when software blinking is disabled?

When led_set_brightness(led_cdev, LED_OFF) is called while software
blinking (LED_BLINK_SW) is active, set_brightness_delayed() stops blinking
and invokes brightness_set(led_cdev, LED_OFF) without updating
led_cdev->brightness:

drivers/leds/led-core.c:set_brightness_delayed() {
	if (test_and_clear_bit(LED_BLINK_DISABLE, &led_cdev->work_flags)) {
		led_stop_software_blink(led_cdev);
		set_bit(LED_SET_BRIGHTNESS_OFF, &led_cdev->work_flags);
	}
	...
	if (test_and_clear_bit(LED_SET_BRIGHTNESS_OFF, &led_cdev->work_flags))
		set_brightness_delayed_set_brightness(led_cdev, LED_OFF);
}

If the blink timer last left priv->rmi_led.brightness at 1,
synaptics_rmi_led_work() (and synaptics_reconnect()) will read that stale
value instead of LED_OFF and keep the LED lit.

[Severity: Low]
Also in synaptics_rmi_led_set(), system_wq is deprecated and scheduled for
removal; please use system_percpu_wq in mod_delayed_work() instead.

[ ... ]

> +static void synaptics_rmi_led_register(struct psmouse *psmouse)
> +{
> +	struct synaptics_data *priv =3D psmouse->private;
> +	int error;
> +
> +	if (!IS_REACHABLE(CONFIG_LEDS_CLASS) || !priv->has_rmi_led)
> +		return;
> +
> +	priv->psmouse =3D psmouse;
> +	INIT_DELAYED_WORK(&priv->rmi_led_work, synaptics_rmi_led_work);
> +	priv->rmi_led.name =3D "synaptics::touchpad_disabled";
> +	priv->rmi_led.max_brightness =3D 1;
> +	priv->rmi_led.brightness_set =3D synaptics_rmi_led_set;
> +	/* synaptics_disconnect() resets the touchpad, which turns the LED off =
*/
> +	priv->rmi_led.flags =3D LED_RETAIN_AT_SHUTDOWN;
> +	error =3D led_classdev_register(&psmouse->ps2dev.serio->dev, &priv->rmi=
_led);
> +	if (error) {
> +		psmouse_warn(psmouse, "failed to register touchpad LED: %d\n", error);
> +		priv->has_rmi_led =3D false;
> +	}
> +}
> +
> +static void synaptics_rmi_led_unregister(struct psmouse *psmouse)
> +{
> +	struct synaptics_data *priv =3D psmouse->private;
> +
> +	if (!IS_REACHABLE(CONFIG_LEDS_CLASS) || !priv->has_rmi_led)
> +		return;
> +
> +	led_classdev_unregister(&priv->rmi_led);
> +	cancel_delayed_work_sync(&priv->rmi_led_work);
> +}
> +
>  static int synaptics_set_mode(struct psmouse *psmouse)
>  {
>  	struct synaptics_data *priv =3D psmouse->private;
> @@ -1444,6 +1716,8 @@ static void synaptics_disconnect(struct psmouse *ps=
mouse)
>  {
>  	struct synaptics_data *priv =3D psmouse->private;
> =20
> +	synaptics_rmi_led_unregister(psmouse);
> +
>  	/*
>  	 * We might have left a breadcrumb when trying to
>  	 * set up SMbus companion.

[Severity: Medium]
Does synaptics_disconnect() leave the touchpad LED lit in hardware if it
was on when the driver disconnects?

Because LED_RETAIN_AT_SHUTDOWN is set, led_classdev_unregister() does not
turn the LED off, and any pending rmi_led_work is canceled before it can
acquire psmouse_mutex.  Unlike synaptics_reconnect(), which calls
psmouse_reset(), synaptics_disconnect() only calls synaptics_reset():

drivers/input/mouse/synaptics.c:synaptics_reset() {
	/* reset touchpad back to relative mode, gestures enabled */
	synaptics_mode_cmd(psmouse, 0);
}

Writing mode byte 0 only leaves RMI register access mode without clearing
the F30 LED control register, so the LED stays on after driver unbind,
module unload, or a protocol switch.  Calling __synaptics_rmi_led_set(psmou=
se,
false) in synaptics_rmi_led_unregister() after cancel_delayed_work_sync()
(before synaptics_reset() writes mode byte 0) would turn it off.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106095658.4416=
6-1-ahmad.b1995@gmail.com?part=3D1
