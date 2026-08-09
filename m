Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E38330B53E
	for <linux-input@vger.kernel.org>; Sun,  9 Aug 2026 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786288492; cv=none; b=hbsVcZSUJJYEF4didVFpYrpQGUIgDGh9n4w9iK6gpB3D8mQeU9GvM/g+ow9EDzGESfxM4uUheRqn5GwgIB1xA7SwlYKP+qhM5xirvBKLyAv/8nRJZS7x1g22P+mTyZlYEA+hbQ9+144KT4UJBMp+6lrMvD6w1VfsLQaOOPBOZpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786288492; c=relaxed/simple;
	bh=+fprLdziHCdTTANYeHGfx4EIN+m38/RBGb16jhoTQWc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pNFjxxj8+mLf7kSwvrOgdJ/Mtj7Qh+05TihuwJPBWzsoqN7EQZU8JvJu7lroLDvsTtLR6ajdpLDyieGYlJJUGYgqVXOfOEl7fxzmr4xYH2CT0sVKFCWWVOi1kk4a1t/6ImrjvC5s9lVfd9FUmrunPajoY9a/fgYUJVwlvxUB/pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGM3XihG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGM3XihG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A39A1F000E9;
	Sun,  9 Aug 2026 15:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786288489;
	bh=KFxJ734ocYZDWJoE5MoRB65HDRLkUr12SwzFQJ7A2YU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CGM3XihGx0XzmG8T6qS2Xmq6J0VgCOhd9Qqy55tutjlN0jhFpIEB/5qCK4almmhvQ
	 o5Z93u3rrde2fSugb9c5WGltFYWGamQNPXE6LJ/XTC0/eqGjAgc1/yFecITmtJIO7X
	 T1f6keK2vuAj8IJvfAPWrqaNthUlN07Li9hCmQCUB/ygcsjpUB6BraPhcg9FnV492q
	 7ZBvwLdeAR2nbM796WQ6hpnZSGVjXoeIJp0NgW8n6dBhwH24/ATgh0Mh5cwP3SSpTI
	 NIb/vzxVMalPxZIUSm8t4YaoxHf5817yWUfZErspPHIS6GXvVd5EqyWrPKxpNBQQZO
	 skX4Y3DE18zkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Input: synaptics - add transparent pass-through mode
 for TrackPoint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Laserology OSS" <development@laserology.net>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260809143911.133983-1-development@laserology.net>
References: <20260809143911.133983-1-development@laserology.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 15:14:48 +0000
Message-Id: <20260809151449.3A39A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Calling `psmouse_set_state()` while holding the parent device's `s=
erio_pause_rx` guard unconditionally re-enables local interrupts while the =
parent lock is still held, leading to a self-deadlock.
- [High] Resetting the pass-through port in `synaptics_set_transparent_mode=
` blindly casts the child driver data to `struct psmouse`, leading to memor=
y corruption if a different driver is bound.
- [Medium] Software protocol handler is updated before the hardware exits t=
ransparent mode, causing guest data to be misparsed as host data.

Pre-existing issues:
- [High] The pass-through child port is leaked when the parent psmouse driv=
er is explicitly unbound or fails late initialization, leading to a Use-Aft=
er-Free.
--

--- Patch [1]: [PATCH v2] Input: synaptics - add transparent pass-through m=
ode for TrackPoint ---
commit 947ac1aeba1f54176e154131535b9d172e064815
Author: laserology oss <development@laserology.net>

Input: synaptics - add transparent pass-through mode for TrackPoint

This reworks an earlier implementation by Miroslav Bend=C3=ADk from 2022
that was never merged. It keeps the same hardware-mode approach but
commits the mode flag only after a successful mode command, moves the
reconnect handling into a generic psmouse hook instead of protocol-
specific checks in psmouse-interrupt, and documents the interface.

Link: https://lore.kernel.org/all/6932d599-2625-0376-d9c6-58cbb8879ff4@gmai=
l.com/

> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synapt=
ics.c
> index 2170bbe4c5897..9a09417775043 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c

[ ... ]

> @@ -669,9 +747,28 @@ static void synaptics_pt_stop(struct serio *serio)
>  {
>  	struct psmouse *parent =3D psmouse_from_serio(serio->parent);
>  	struct synaptics_data *priv =3D parent->private;
> +	bool exit_mode;
> =20
> -	guard(serio_pause_rx)(parent->ps2dev.serio);
> -	priv->pt_port =3D NULL;
> +	{
> +		guard(serio_pause_rx)(parent->ps2dev.serio);
> +
> +		priv->pt_port =3D NULL;
> +		exit_mode =3D READ_ONCE(priv->transparent_mode);
> +		WRITE_ONCE(priv->transparent_mode, false);
> +		synaptics_update_protocol_handler(parent);
> +	}
> +

[Severity: Medium]
Will this cause guest data to be misparsed as host data?

In synaptics_pt_stop(), the software state is preemptively switched to host
mode before dropping the rx lock.

Then it calls synaptics_exit_transparent_mode() which sends slow PS/2 comma=
nds
to switch the hardware.

During this window, the hardware is still in transparent mode sending raw g=
uest
bytes, but the software will interpret them as Synaptics absolute mode pack=
ets.
This can lead to PSMOUSE_BAD_DATA, dropping packets, or triggering spurious
host resets.

> +	/*
> +	 * The guest is going away. If the touchpad was left in transparent
> +	 * mode it would keep relaying the guest's byte stream with nobody to
> +	 * consume it, leaving hardware and software permanently out of sync,
> +	 * so take it out of transparent mode and back to normal operation.
> +	 */
> +	if (exit_mode) {
> +		if (synaptics_exit_transparent_mode(parent))
> +			psmouse_warn(parent,
> +				     "failed to exit transparent mode after pass-through port remova=
l\n");
> +	}
>  }

[ ... ]

> @@ -1438,6 +1552,98 @@ PSMOUSE_DEFINE_ATTR(disable_gesture, S_IWUSR | S_I=
RUGO, NULL,
>  		    synaptics_show_disable_gesture,
>  		    synaptics_set_disable_gesture);

[ ... ]

> +static ssize_t synaptics_set_transparent_mode(struct psmouse *psmouse,
> +					      void *data, const char *buf,
> +					      size_t len)
> +{

[ ... ]

> +	/*
> +	 * Commit the software state with RX paused so the interrupt handler
> +	 * never observes a torn (protocol_handler, pktsize) pair while the
> +	 * pass-through guest keeps streaming.
> +	 */
> +	guard(serio_pause_rx)(psmouse->ps2dev.serio);
> +
> +	WRITE_ONCE(priv->transparent_mode, value);
> +
> +	synaptics_update_protocol_handler(psmouse);
> +
> +	/*
> +	 * The touchpad is stopped for the duration of the mode switch, but the
> +	 * pass-through guest keeps streaming. It may therefore be left with a
> +	 * partially assembled packet from the previous mode. Drop it so the
> +	 * stream restarts cleanly in the new mode and no stale bytes are
> +	 * misparsed as pointer motion or spurious button clicks.
> +	 */
> +	if (READ_ONCE(priv->pt_port)) {
> +		struct serio *pt_port =3D priv->pt_port;
> +
> +		/*
> +		 * The pass-through port may be registered without a bound
> +		 * driver (e.g. no TrackPoint attached), in which case its
> +		 * drvdata is NULL and psmouse_from_serio() would produce a
> +		 * bogus pointer; only reset the child if there is a real
> +		 * psmouse bound to it.
> +		 */
> +		if (serio_get_drvdata(pt_port)) {
> +			struct psmouse *child =3D psmouse_from_serio(pt_port);

[Severity: High]
Is it safe to unconditionally cast the child drvdata to struct psmouse here?

If a user unbinds the psmouse driver from the child port and binds a differ=
ent
serio driver (like serio_raw), serio_get_drvdata() would return a pointer to
that driver's private structure.

The container_of() macro in psmouse_from_serio() would then produce a bogus
pointer, leading to invalid memory accesses when checking child->state.

> +
> +			if (child->state =3D=3D PSMOUSE_ACTIVATED)
> +				psmouse_set_state(child, PSMOUSE_ACTIVATED);

[Severity: High]
Can calling psmouse_set_state() here lead to a deadlock?

The earlier code in synaptics_set_transparent_mode() takes the parent devic=
e's
rx guard:

	guard(serio_pause_rx)(psmouse->ps2dev.serio);

This disables interrupts and takes the parent spinlock.

When psmouse_set_state() is called on the child, it internally takes and
releases its own rx guard:

drivers/input/mouse/psmouse-base.c:psmouse_set_state() {
	guard(serio_pause_rx)(psmouse->ps2dev.serio);
	__psmouse_set_state(psmouse, new_state);
}

When this child guard is released, it calls spin_unlock_irq(), which
unconditionally re-enables local interrupts while the parent lock is still
held. If a hardware interrupt arrives on the same CPU, serio_interrupt()
will attempt to acquire the parent lock again, causing a self-deadlock.

> +		}
> +	}
> +
> +	return len;
> +}

[ ... ]

>  static void synaptics_disconnect(struct psmouse *psmouse)
>  {
>  	struct synaptics_data *priv =3D psmouse->private;
> @@ -1448,10 +1654,16 @@ static void synaptics_disconnect(struct psmouse *=
psmouse)
>  	 */
>  	psmouse_smbus_cleanup(psmouse);
> =20
> +	if (READ_ONCE(priv->transparent_mode))
> +		synaptics_exit_transparent_mode(psmouse);
> +
>  	if (!priv->absolute_mode &&
>  			SYN_ID_DISGEST_SUPPORTED(priv->info.identity))
>  		device_remove_file(&psmouse->ps2dev.serio->dev,
>  				   &psmouse_attr_disable_gesture.dattr);
> +	if (SYN_CAP_PASS_THROUGH(priv->info.capabilities))
> +		device_remove_file(&psmouse->ps2dev.serio->dev,
> +				   &psmouse_attr_transparent_mode.dattr);
> =20
>  	synaptics_reset(psmouse);
>  	kfree(priv);

[Severity: High]
This isn't a bug introduced by this patch, but does this code leak the child
pass-through port?

When the host psmouse driver is unbound, synaptics_disconnect() frees the
driver private data via kfree(priv).

However, the pass-through child port created earlier in synaptics_pt_create=
()
is never unregistered via serio_unregister_child_port().

Any subsequent interaction with the leaked child port (like binding a new
driver to it) will call callbacks that dereference the freed parent structu=
res,
leading to a use-after-free.

> @@ -1478,8 +1690,35 @@ static int synaptics_reconnect(struct psmouse *psm=
ouse)
>  			 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809143911.1339=
83-1-development@laserology.net?part=3D1
