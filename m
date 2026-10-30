Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793343914;
	b=bmyBkK6oPbGP7vNuz5JpyhcndB93YuNp0aKzoRJ41BVF9bKuqmjrPf5VeD4OyLl0FwZ1
	 i0bifdX22bhzTpsqlUxEVW7xbhW4NSn8MMZSxgoAEJTkuyT8ACSKu3u1RnVwjO8SqVywS
	 amnt5OXbcLO4uyNsLgj+SK2S9bYMUcLYYLI7iW+h9jpLKz/ZIeaM//KqyJYbar7Aj8Qmj
	 O6QQbxPwmK/g/BRCg9fM0parQtfBxhZKoYtdPJegqoE2uwcUf4d1ic4twIOZ1F9bh2bTz
	 +x/LHf9pvOIbn/1sK/O5AuWlfrKxDrkwH8BAloThPCbkzw2AdmLDfdsUESjamspQChg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793343914;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8f9U9UpZvyasXntvi3SViqFLU6aNWa7c7WLA6hTjmN0=;
	b=bR0tfPgSZANwNt63hcoCoZUoc6xTohlR2GCNkQFdvWDIfgxb4CQqAZLPF83zXjuS41HO
	 4RgnwUhqhSS7BmQA1ssPqsgWCvx6C6Mswi4j2l0qoNEb8jWMUZ8U61ylM5DPnl0EqwCD8
	 v51dzkfoy7afI9aklguekBzt9zkQNILEu0KXjln4TB1C3qrD8R0ere9icsU7xjgFvDt5D
	 kNgsFfMU2W3kjkcO0VHUj2UQHDQSQccTwtvZYtEOBKlCyOBqrXOR0GgiJOQu4uEmdVBs6
	 JRxFOyU4k1qnU+st9qWLSuT7/lwIBBWmrWw4UTRBp3aIaC8wNZkYYWGpsX3A6EwlFvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="g/rFeQhu";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3139D606A31A
	for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 07:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g/rFeQhu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6F01F000C1;
	Fri, 30 Oct 2026 07:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793343914;
	bh=8f9U9UpZvyasXntvi3SViqFLU6aNWa7c7WLA6hTjmN0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g/rFeQhu8KXcJ9EBZhtMiGsnNXmFIEQIZP8OTt0Y9cGf3pvQxhBpxjQQAxPl2iSf8
	 P9BRSJG21PTTkH1hVME9eApLvn0QKBNyHoPWvD0G3lN6m297LfaH2TvDS+lzUzBNjE
	 b1bKpaX/CBLlep26iMAXmQUs4Uiauv+vvkkmgAAyPTRPo+ihrvAl3QHglBXm+Q+PJe
	 jNVogq206z8+7LZItme7ienfFoz1utKoKzpO8NrkfD35vJEGHIySdwtkpReyXk54RR
	 ol/qXKm6VT6BDzIt3NM1BFtK1a59Dv+eG8e2XAMgQIgikI7eFnYUwa6wrS5bxiEfGL
	 wB5vGfUNmD+sw==
Message-ID: <sashiko-outbox-190626@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: synaptics - support the touchpad LED on RMI
 function $30
Reply-To: sashiko-reviews@lists.linux.dev
To: "ahmad baghereslami" <ahmad.b1995@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261030065240.1706377-1-ahmad.b1995@gmail.com>
References: <20261030065240.1706377-1-ahmad.b1995@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 07:05:13 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Input: synaptics - missing psmouse_mutex locking in synaptics_rmi_=
led_set()
- [Medium] Input: synaptics - synaptics_rmi_led_set() fails with -EBUSY on =
disconnect
- [Medium] Input: synaptics - synaptics_rmi_led_set() clears SYN_BIT_FOUR_B=
YTE_CLIENT
- [Medium] Input: synaptics - unmasked F30 pin count in synaptics_rmi_led_p=
robe()
- [Low] Input: synaptics - link failure when CONFIG_LEDS_CLASS is not reach=
able
--

commit ba11d4207158064745617f3cd241e591354af8aa
Author: ahmad baghereslami <ahmad.b1995@gmail.com>

Input: synaptics - support the touchpad LED on RMI function $30

This commit adds support for the touchpad disabled LED wired to RMI function
$30 over PS/2 on HP laptops matching rmi_led_pnp_ids, probing the F30
registers during setup and registering a synaptics::touchpad_disabled LED
class device.

> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synapt=
ics.c
> index b007e642ea765..bf1c6c738295c 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c

[ ... ]

> +/* Finds the LED of RMI function $30. Leaves the touchpad in RMI mode. */
> +static int synaptics_rmi_led_probe(struct psmouse *psmouse)
> +{
> +	struct synaptics_data *priv =3D psmouse->private;
> +	u8 fn, query, ctrl, caps, count, gpios;
> +	unsigned int page, zeros, i;
> +	int addr, error;
> +
> +	error =3D synaptics_mode_cmd(psmouse, SYN_RMI_MODE);
> +	if (error)
> +		return error;
> +
> +	for (page =3D 0; page < SYN_RMI_NUM_PAGES; page++) {
> +		error =3D synaptics_rmi_write(psmouse, SYN_RMI_PAGE_SELECT, page);
> +		if (error)
> +			return error;
> +
> +		for (addr =3D SYN_RMI_PDT_START; addr >=3D SYN_RMI_PDT_END;
> +		     addr -=3D SYN_RMI_PDT_ENTRY_SIZE) {
> +			error =3D synaptics_rmi_read(psmouse, addr, &fn);
> +			if (error)
> +				return error;
> +			if (!fn)
> +				break;
> +			if (fn !=3D SYN_RMI_F30)
> +				continue;
> +
> +			error =3D synaptics_rmi_read(psmouse, addr - 5, &query);
> +			if (!error)
> +				error =3D synaptics_rmi_read(psmouse, addr - 3, &ctrl);
> +			if (!error)
> +				error =3D synaptics_rmi_read(psmouse, query, &caps);
> +			if (!error)
> +				error =3D synaptics_rmi_read(psmouse, query + 1, &count);
> +			if (error)
> +				return error;
> +
> +			if (!(caps & SYN_RMI_F30_HAS_LED))
> +				return -ENODEV;
> +
> +			priv->rmi_led_page =3D page;
> +			if (!(caps & SYN_RMI_F30_HAS_GPIO)) {
> +				priv->rmi_led_mask =3D BIT(0);
> +				priv->rmi_led_ctrl =3D ctrl + 1;
> +				priv->rmi_led_brightness =3D ctrl + 4;
> +				return 0;
> +			}
> +
> +			/* GPIO/LED select: the LED is the first set bit */
> +			error =3D synaptics_rmi_read(psmouse, ctrl, &gpios);
> +			if (error)
> +				return error;
> +
> +			priv->rmi_led_mask =3D 0;
> +			for (i =3D 0, zeros =3D 0; i < min(count, 8); i++) {
> +				if (!(gpios & BIT(i)))
> +					zeros++;
> +				else if (!priv->rmi_led_mask)
> +					priv->rmi_led_mask =3D BIT(i);
> +			}
> +			if (!priv->rmi_led_mask)
> +				return -ENODEV;
> +
> +			priv->rmi_led_ctrl =3D ctrl + 4;
> +			priv->rmi_led_brightness =3D ctrl + 7 + zeros;

[Severity: Medium]
In RMI4 Function $30, Query 1 encodes the GPIO/LED pin count in bits 4:0,
which rmi_f30_initialize() in drivers/input/rmi4/rmi_f30.c extracts using
RMI_F30_GPIO_LED_COUNT (0x1f):

    f30->gpioled_count =3D buf[1] & RMI_F30_GPIO_LED_COUNT;

Here in synaptics_rmi_led_probe(), count is read from query + 1 without
masking with 0x1f, and the loop continues incrementing zeros for clear bits
in gpios even after latching the first set bit into priv->rmi_led_mask.

If any of bits 7:5 in Query 1 are set when the 5-bit pin count is less than
8, or if a GPIO pin is present at a bit index above the first LED bit, could
zeros include extra clear bits and offset priv->rmi_led_brightness to the
wrong F30 control register?

[ ... ]

> +static int synaptics_rmi_led_set(struct led_classdev *led,
> +				 enum led_brightness value)
> +{
> +	struct synaptics_data *priv =3D container_of(led, struct synaptics_data=
, rmi_led);
> +	struct psmouse *psmouse =3D priv->psmouse;
> +	int error, ret;
> +
> +	guard(mutex)(&priv->rmi_led_lock);
> +
> +	if (psmouse->state !=3D PSMOUSE_ACTIVATED)
> +		return -EBUSY;
> +
> +	error =3D psmouse_deactivate(psmouse);
> +	if (error)
> +		return error;
> +
> +	ret =3D __synaptics_rmi_led_set(psmouse, value !=3D LED_OFF);

[Severity: High]
When brightness is updated via sysfs, the LED core queues set_brightness_wo=
rk
to invoke synaptics_rmi_led_set() asynchronously. In psmouse-base.c,
psmouse_mutex serializes operations that inspect or change psmouse->state,
modify priv->mode, or run multi-command sequences on the PS/2 device and its
pass-through port, such as psmouse_reconnect(), psmouse_resync(),
psmouse_disconnect(), psmouse_cleanup(), and psmouse_attr_set_helper().

Here, synaptics_rmi_led_set() only takes priv->rmi_led_lock, which is not
acquired anywhere else (including in synaptics_reconnect() when reading
priv->rmi_led.brightness and calling __synaptics_rmi_led_set()).

Without holding psmouse_mutex, can synaptics_rmi_led_set() race with a
concurrent reconnect, resync, sysfs attribute write, or pass-through port
operation after checking psmouse->state !=3D PSMOUSE_ACTIVATED, interleaving
PS/2 commands while the touchpad is in SYN_RMI_MODE (0x7f) and prematurely
setting psmouse->state back to PSMOUSE_ACTIVATED?

> +
> +	/* Setting the mode byte again leaves RMI access */
> +	error =3D synaptics_set_mode(psmouse);

[Severity: Medium]
When a 4-byte protocol child device is attached to the pass-through port,
synaptics_pt_activate() sets SYN_BIT_FOUR_BYTE_CLIENT in priv->mode:

    if (child) {
        if (child->pktsize =3D=3D 4)
            priv->mode |=3D SYN_BIT_FOUR_BYTE_CLIENT;
        else
            priv->mode &=3D ~SYN_BIT_FOUR_BYTE_CLIENT;

        if (synaptics_mode_cmd(psmouse, priv->mode))
            psmouse_warn(psmouse,
                         "failed to switch guest protocol\n");
    }

Unlike synaptics_set_rate() and synaptics_set_disable_gesture(), which upda=
te
their respective bit in priv->mode and call synaptics_mode_cmd(psmouse,
priv->mode), calling synaptics_set_mode() here resets priv->mode =3D 0 and
rebuilds it without SYN_BIT_FOUR_BYTE_CLIENT.

Will toggling the LED at runtime clear SYN_BIT_FOUR_BYTE_CLIENT in both
priv->mode and the hardware mode register when a 4-byte pass-through child =
is
active?

> +	if (!ret)
> +		ret =3D error;
> +
> +	error =3D psmouse_activate(psmouse);
> +	return ret ?: error;
> +}
> +
> +static void synaptics_rmi_led_init(struct psmouse *psmouse)
> +{
> +	struct synaptics_data *priv =3D psmouse->private;
> +
> +	if (!IS_REACHABLE(CONFIG_LEDS_CLASS) ||
> +	    !psmouse_matches_pnp_id(psmouse, rmi_led_pnp_ids))
> +		return;
> +
> +	if (synaptics_rmi_led_probe(psmouse))
> +		return;
> +
> +	psmouse_info(psmouse, "touchpad LED on RMI F30 (page %u, ctrl %#x, mask=
 %#x)\n",
> +		     priv->rmi_led_page, priv->rmi_led_ctrl, priv->rmi_led_mask);
> +	__synaptics_rmi_led_set(psmouse, false);
> +	priv->has_rmi_led =3D true;
> +}
> +
> +static void synaptics_rmi_led_register(struct psmouse *psmouse)
> +{
> +	struct synaptics_data *priv =3D psmouse->private;
> +	int error;
> +
> +	if (!priv->has_rmi_led)
> +		return;
> +
> +	mutex_init(&priv->rmi_led_lock);
> +	priv->psmouse =3D psmouse;
> +	priv->rmi_led.name =3D "synaptics::touchpad_disabled";
> +	priv->rmi_led.max_brightness =3D 1;
> +	priv->rmi_led.brightness_set_blocking =3D synaptics_rmi_led_set;
> +	error =3D led_classdev_register(&psmouse->ps2dev.serio->dev, &priv->rmi=
_led);
> +	if (error) {
> +		psmouse_warn(psmouse, "failed to register touchpad LED: %d\n", error);
> +		priv->has_rmi_led =3D false;
> +	}
> +}

[Severity: Low]
In drivers/input/mouse/Kconfig, MOUSE_PS2 and MOUSE_PS2_SYNAPTICS do not
depend on or select LEDS_CLASS, and include/linux/leds.h declares
led_classdev_register_ext() and led_classdev_unregister() without inline
stubs when CONFIG_LEDS_CLASS is disabled.

While synaptics_rmi_led_init() checks IS_REACHABLE(CONFIG_LEDS_CLASS),
synaptics_rmi_led_register() and synaptics_disconnect() only guard the calls
to led_classdev_register() and led_classdev_unregister() with the runtime
field priv->has_rmi_led. Because priv escapes through psmouse->private acro=
ss
external calls before synaptics_rmi_led_register() and synaptics_disconnect=
()
is an address-taken callback, the compiler cannot eliminate those calls.

Will building with CONFIG_MOUSE_PS2=3Dy and CONFIG_LEDS_CLASS=3Dn (or
CONFIG_LEDS_CLASS=3Dm) fail at link time with undefined references to
led_classdev_register_ext() and led_classdev_unregister()?

[ ... ]

> @@ -1444,6 +1674,9 @@ static void synaptics_disconnect(struct psmouse *ps=
mouse)
>  {
>  	struct synaptics_data *priv =3D psmouse->private;
> =20
> +	if (priv->has_rmi_led)
> +		led_classdev_unregister(&priv->rmi_led);

[Severity: Medium]
Every caller of psmouse->disconnect() in drivers/input/mouse/psmouse-base.c
(psmouse_disconnect(), psmouse_connect(), and psmouse_attr_set_helper() ->
psmouse_attr_set_protocol()) transitions psmouse->state to PSMOUSE_CMD_MODE
before invoking synaptics_disconnect():

    psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
    ...
    if (psmouse->disconnect)
        psmouse->disconnect(psmouse);

When synaptics_disconnect() calls led_classdev_unregister(&priv->rmi_led),
led_classdev_unregister() sets the brightness to LED_OFF and flushes
set_brightness_work, which calls synaptics_rmi_led_set(). Because
psmouse->state is already PSMOUSE_CMD_MODE rather than PSMOUSE_ACTIVATED,
synaptics_rmi_led_set() returns -EBUSY, causing the LED core to log an error
("Setting an LED's brightness failed (-16)") and leaving the hardware LED o=
n.

Similarly, synaptics_init_ps2() calls synaptics_rmi_led_register() while
psmouse->state is still PSMOUSE_INITIALIZING (before psmouse_connect()
activates the device or while the pass-through serio child port probes and
deactivates the parent), so any brightness write in that window also fails
with -EBUSY and leaves priv->rmi_led.brightness out of sync with the
hardware.

Should synaptics_rmi_led_set() handle being called when the touchpad is not
in PSMOUSE_ACTIVATED, or how should LED updates during init and disconnect =
be
handled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030065240.1706=
377-1-ahmad.b1995@gmail.com?part=3D1
