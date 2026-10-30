Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793345055;
	b=Shn+7WykyjsxTlb5QfgbA6gpOjsgVnWQp1N2F6/BScGXhW4d3qJkHIgepWxmu2UqEpdb
	 mIKNRjVIndHBXqMmM/AMGO7L3WkRuI1v9MA0TJ9IbSKR2t6sfpR2pa+tNIqHYDTTGK9sM
	 6gtFjf/HtzjISZn9ce04BdVJhjPlitCQgWyV8TY6Zfgi7TdjldSW7lAFjC6khvY1+krS7
	 x9zhdDhPuiFwoo1gvB1xDAk3AbJiMZ2Dorz6O+TeqScX+5TqbPKIes1944Phtat8rrPKt
	 vZoRN73QAHucAeeKMp/QGBvLZAaRYdBGNOS4OpcBDBYWhRi7ax8fVpUy00eO/PYHMNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793345055;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FOlOEH6lcaLyAyCHL97CFFUL6Imr3VtVGlnu9puCQ7c=;
	b=XkdWlGL98o5PK/lD3VOlvdeHd0h2uqlJ4vNjZzINKavE0HEIsqfaLIpFitlx8O7dvwbh
	 1eAwZ+G6FbPqRUs82akfcKWbsQR073F0iZq4oxWwiJsHtCUqw7B9bva3EUsXqnWlYS06S
	 utwP8nVScCq1pF7py9Oi0z4v6PlFXWIJwI71OWZHG2iFGE4N2Lqmyeq6BREYtp4riHzVZ
	 jV+x8k2/vri27syXSf+R3ZH7B98fxu3XLvWR2xid7I68fMs4Ryz8ei2upfXIhaPVt8qT9
	 2j4Ro6a1sLSmkpnKQuqUIOoXFTixd3aEJjxW3aWwtt3DDpHwHZJW28Jc7JPjOvek/ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oc4yYqTY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6B0606A31C
	for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 07:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oc4yYqTY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDDF1F000C1;
	Fri, 30 Oct 2026 07:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793345054;
	bh=FOlOEH6lcaLyAyCHL97CFFUL6Imr3VtVGlnu9puCQ7c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Oc4yYqTY6YZEBdpDIXvK8gMuT0CSUBH+OOzf6QoNRIJ+FYDMYXwwrrC1Q6jjpWrG+
	 j1RvwHEPu57kBXLjW+u3cEH59+Uxau7P74gGNymMP7qyKktMJrLEBXwrzfILZjhgmN
	 zq15dm5L52VO0jELjxY9MO7cie8BX1bIZVMzVA3k8xN5kj9Gk+as0e9cOGBc6ITiIh
	 qKvZTe4awM7ESV1w5bi52KqcvSzMtMhm7xZ6nBnwVQBpR6xEZDjN868KGUr0MvcGY9
	 70XYLJyanL7TlQlUqE6idB74SAprj20uDQ8gfLcu/a3r82o419K6bOgmgfkvbFnCyu
	 MtPjCKpJwaK6A==
Message-ID: <sashiko-outbox-190638@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: synaptics - support the touchpad LED on RMI
 function $30
Reply-To: sashiko-reviews@lists.linux.dev
To: "ahmad baghereslami" <ahmad.b1995@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261030070821.1716595-1-ahmad.b1995@gmail.com>
References: <20261030070821.1716595-1-ahmad.b1995@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 07:24:13 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] Input: synaptics: LED unregister in synaptics_disconnect() fails=
 with -EBUSY
- [Medium] Input: synaptics: missing psmouse_mutex locking in synaptics_rmi=
_led_set()
- [Medium] Input: synaptics: synaptics_rmi_led_set() clears SYN_BIT_FOUR_BY=
TE_CLIENT
- [Low] Input: synaptics: link failure when CONFIG_LEDS_CLASS is not reacha=
ble
--

commit 2ccb85e9eccb48086da73fe8acd02267ab779ff1
Author: ahmad baghereslami <ahmad.b1995@gmail.com>

Input: synaptics - support the touchpad LED on RMI function $30

This commit adds support for the touchpad disabled LED wired to RMI function
$30 on certain HP laptops (such as the HP ZBook 17 G3) by accessing RMI
registers over PS/2 using mode byte 0x7f. It probes F30 during PS/2
initialization, registers an LED class device, and restores the LED state on
reconnect.

> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synapt=
ics.c
> index b007e642ea765..bf1c6c738295c 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c

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

[Severity: Medium]
Should synaptics_rmi_led_set() synchronize with psmouse_mutex rather than a
private rmi_led_lock?

In drivers/input/mouse/psmouse-base.c, psmouse_mutex serializes all paths
that inspect or transition psmouse->state, activate or deactivate a device =
or
pass-through parent port, or run multi-command PS/2 sequences (such as
psmouse_reconnect(), psmouse_resync(), psmouse_cleanup(),
psmouse_disconnect(), and psmouse_attr_set_helper()). Meanwhile,
ps2_command() only holds ps2dev->cmd_mutex for one PS/2 command at a time,
and nothing else in synaptics.c (including synaptics_reconnect()) or
psmouse-base.c takes priv->rmi_led_lock.

When synaptics_rmi_led_set() runs asynchronously from set_brightness_work
without holding psmouse_mutex:

1. While __synaptics_rmi_led_set() has the touchpad in mode 0x7f across
   multiple SetScale 2:1, SetRate, and GetInfo commands, concurrent PS/2
   commands from reconnect, resync, sysfs attribute writes (such as
   synaptics_set_rate() or synaptics_set_disable_gesture()), or pass-through
   port operations can interleave and corrupt both the RMI register sequence
   and the concurrent operation.

2. At the end of synaptics_rmi_led_set(), psmouse_activate(psmouse)
   unconditionally sends the enable command and sets psmouse->state to
   activated, even if a concurrent thread holding psmouse_mutex (such as
   pass-through child probing, reconnect, cleanup, or disconnect) has
   deactivated the touchpad and expects it to stay in command or
   initializing mode.

3. If set_brightness_work runs while a sysfs write or pass-through operation
   temporarily places psmouse->state into command mode, or right after
   synaptics_rmi_led_register() before psmouse_connect() activates the
   device, synaptics_rmi_led_set() immediately returns -EBUSY instead of
   waiting for the state transition to finish.

> +
> +	/* Setting the mode byte again leaves RMI access */
> +	error =3D synaptics_set_mode(psmouse);
> +	if (!ret)
> +		ret =3D error;
> +
> +	error =3D psmouse_activate(psmouse);
> +	return ret ?: error;
> +}

[Severity: Medium]
Will calling synaptics_set_mode() here clobber the 4-byte client bit in
priv->mode when a pass-through guest device is attached?

When a 4-byte protocol child is activated on the pass-through port,
synaptics_pt_activate() updates priv->mode:

drivers/input/mouse/synaptics.c:synaptics_pt_activate() {
	...
	if (child) {
		if (child->pktsize =3D=3D 4)
			priv->mode |=3D SYN_BIT_FOUR_BYTE_CLIENT;
		else
			priv->mode &=3D ~SYN_BIT_FOUR_BYTE_CLIENT;

		if (synaptics_mode_cmd(psmouse, priv->mode))
			psmouse_warn(psmouse,
				     "failed to switch guest protocol\n");
	}
}

Other runtime mode updates such as synaptics_set_rate() and
synaptics_set_disable_gesture() modify priv->mode in place and call
synaptics_mode_cmd(psmouse, priv->mode). By contrast, synaptics_set_mode()
resets priv->mode =3D 0 and rebuilds it without SYN_BIT_FOUR_BYTE_CLIENT,
which will clear that bit in hardware whenever the LED brightness is change=
d.

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
Can this cause a link failure when CONFIG_LEDS_CLASS is disabled, or when
psmouse is built-in and CONFIG_LEDS_CLASS=3Dm?

In drivers/input/mouse/Kconfig, MOUSE_PS2_SYNAPTICS does not depend on or
select LEDS_CLASS, and include/linux/leds.h declares
led_classdev_register_ext() and led_classdev_unregister() unconditionally
without inline stubs when CONFIG_LEDS_CLASS is not enabled.

Because synaptics_rmi_led_init() checks IS_REACHABLE(CONFIG_LEDS_CLASS),
whereas synaptics_rmi_led_register() and synaptics_disconnect() only check
the runtime struct field priv->has_rmi_led after priv is loaded from
psmouse->private across function calls, the compiler cannot fold
priv->has_rmi_led to a compile-time constant false and eliminate the calls
to led_classdev_register() and led_classdev_unregister().

> +
>  static int synaptics_set_mode(struct psmouse *psmouse)
>  {
>  	struct synaptics_data *priv =3D psmouse->private;
> @@ -1444,6 +1674,9 @@ static void synaptics_disconnect(struct psmouse *ps=
mouse)
>  {
>  	struct synaptics_data *priv =3D psmouse->private;
> =20
> +	if (priv->has_rmi_led)
> +		led_classdev_unregister(&priv->rmi_led);

[Severity: Medium]
When synaptics_disconnect() calls led_classdev_unregister(&priv->rmi_led),
will the shutdown brightness update always fail with -EBUSY?

Every caller of psmouse->disconnect(psmouse) in
drivers/input/mouse/psmouse-base.c transitions psmouse->state to command mo=
de
before invoking the disconnect callback:

drivers/input/mouse/psmouse-base.c:psmouse_disconnect() {
	...
	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
	...
	if (psmouse->disconnect)
		psmouse->disconnect(psmouse);
}

Because LED_RETAIN_AT_SHUTDOWN is not set on priv->rmi_led.flags,
led_classdev_unregister() calls led_set_brightness(&priv->rmi_led, LED_OFF)
and flushes set_brightness_work:

led_classdev_unregister()
  -> led_set_brightness(&priv->rmi_led, LED_OFF)
  -> flush_work(&priv->rmi_led.set_brightness_work)
       -> set_brightness_delayed()
            -> synaptics_rmi_led_set()

Inside synaptics_rmi_led_set(), the check:

	if (psmouse->state !=3D PSMOUSE_ACTIVATED)
		return -EBUSY;

sees PSMOUSE_CMD_MODE and returns -EBUSY, causing
set_brightness_delayed_set_brightness() to log a kernel error and leaving t=
he
hardware LED lit if it was on before disconnect.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030070821.1716=
595-1-ahmad.b1995@gmail.com?part=3D1
