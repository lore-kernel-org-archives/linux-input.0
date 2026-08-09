Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC9312B94
	for <linux-input@vger.kernel.org>; Sun,  9 Aug 2026 16:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786291951; cv=none; b=ENgnVMEZOnvnAKSma9o15woR0uB+wfcLBZ64MGBBPhaOwHlYr8j0KmQGiyV+wqsO20DqkvUUafcWjAJf+GBr4loz06xnb7VBSMVS1aU1rKTej7O9+baXJJ5rb/17RUQS56/g1TpTJNAk925mbnc5uXvPCd8dA86JuPFRYwFUdPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786291951; c=relaxed/simple;
	bh=qNNg+zvr+pdrXFyyVHXDW8RSTeDu5NaaVPMaeX79s4Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k9aPrldC2pzeoXPG5dFIFXtWlXMD5lSVB9helKj25Sf7GfLIJ+gWvxps7qi9WfmY5GPO54pQmxme8O3rzl79OzkoSw2PDT5NVSTofZr9J9C6DYIPS2RDRUsf12xhMUjyoAk39VaIoU89MgzUy/pGZEd/gqjvN8mW6FPn+K41OKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBjY3wvf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBjY3wvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510D71F000E9;
	Sun,  9 Aug 2026 16:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786291949;
	bh=0Qk8jyHu793Ry+g9DEg265tD2JfnGcqGKS8p4KQKSjQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CBjY3wvfWJNKIlq6kSIr38bX1b4En+HquZH29TDhYIVeLfCA7xIyYctVJmYwE0xD7
	 eVGsxr2/IaMz3heYdywh2b5rqgZpcIL/KEPQfTunpujmjY0AH8mrufkVsmw2QtKPSN
	 AKRm3mTDnYphkgD0D/2vFyGmwMW0dhfnq6NoqnIn+cY/CqhvGpruV0EuCesZ9lvu0A
	 1IAtZLYx38ueRBhEgXyK/p52Go8yLQw5ETgCxWpGq6XvByxVCMx0vX27BQsLg0BRkY
	 C/KgVmRwSaP1EdawnPjsn8nw/fDyfcMCysY8lp8xJGCA3up5iYQedbR3uzRg4JDsPf
	 hMML8Z9i2yeLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: synaptics - add transparent pass-through mode
 for TrackPoint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Laserology OSS" <development@laserology.net>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260809154420.369073-1-development@laserology.net>
References: <20260809154420.369073-1-development@laserology.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 16:12:28 +0000
Message-Id: <20260809161229.510D71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Self-deadlock and Use-After-Free/Double-Free of the pass-throu=
gh serio port during parent driver unbind or port unregistration.
- [Critical] Type confusion in synaptics_pt_open() leads to arbitrary memor=
y corruption when toggling transparent mode.
- [High] Bypassed mutex synchronization in synaptics_pt_write() causes conc=
urrent hardware command injection and data races.
--

--- Patch [1]: [PATCH] Input: synaptics - add transparent pass-through mode=
 for TrackPoint ---
commit 1a99c1461a4c3bd59a184b3551c27088c1845e41
Author: laserology oss <development@laserology.net>

Input: synaptics - add transparent pass-through mode for TrackPoint

This patch reworks an earlier implementation to add a transparent pass-thro=
ugh
mode for Synaptics touchpads with a TrackPoint. It documents the interface =
and
modifies the protocol handling to support relaying the raw byte stream of t=
he
pass-through guest.

> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synapt=
ics.c
> index 2170bbe4c5897..29e9a0c24dc23 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c

[ ... ]

>  static int synaptics_pt_write(struct serio *serio, u8 c)
>  {
>  	struct psmouse *parent =3D psmouse_from_serio(serio->parent);
> +	struct synaptics_data *priv =3D parent->private;
>  	u8 rate_param =3D SYN_PS_CLIENT_CMD; /* indicates that we want pass-thr=
ough port */
>  	int error;
> =20
> +	if (READ_ONCE(priv->transparent_mode))
> +		return parent->ps2dev.serio->write(parent->ps2dev.serio, c);
> +

[Severity: High]
Does this bypass the parent's ps2_cmd_mutex? Since the child port uses its
own isolated ps2_cmd_mutex, returning parent->ps2dev.serio->write(...)
directly could allow concurrent hardware commands. This could interleave raw
PS/2 bytes if userspace triggers a command on the parent device (like
changing transparent_mode) while the child is writing.

>  	error =3D ps2_sliced_command(&parent->ps2dev, c);
>  	if (error)
>  		return error;

[ ... ]

> @@ -669,9 +747,30 @@ static void synaptics_pt_stop(struct serio *serio)
>  {
>  	struct psmouse *parent =3D psmouse_from_serio(serio->parent);
>  	struct synaptics_data *priv =3D parent->private;
> +	bool exit_mode;
> =20
> -	guard(serio_pause_rx)(parent->ps2dev.serio);
> -	priv->pt_port =3D NULL;
> +	exit_mode =3D READ_ONCE(priv->transparent_mode);
> +
> +	/*
> +	 * The guest is going away. Take the hardware out of transparent
> +	 * mode first so the device stops relaying the guest's byte stream
> +	 * and resumes producing host packets, then update the software state
> +	 * with RX paused so the interrupt handler never observes a torn
> +	 * configuration.
> +	 */
> +	if (exit_mode) {
> +		if (synaptics_exit_transparent_mode(parent))
> +			psmouse_warn(parent,
> +				     "failed to exit transparent mode after pass-through port remova=
l\n");
> +	}

[Severity: High]
Does this create a data race if a driver like serio_raw is bound to the chi=
ld
port? Unbinding serio_raw invokes synaptics_pt_stop() without holding the
global psmouse_mutex. Modifying hardware state and priv->transparent_mode
here could race with synaptics_set_transparent_mode() running concurrently
on the parent device.

> +
> +	{
> +		guard(serio_pause_rx)(parent->ps2dev.serio);
> +
> +		priv->pt_port =3D NULL;
> +		WRITE_ONCE(priv->transparent_mode, false);
> +		synaptics_update_protocol_handler(parent);
> +	}
>  }
> =20
>  static int synaptics_pt_open(struct serio *serio)
> @@ -681,6 +780,7 @@ static int synaptics_pt_open(struct serio *serio)
> =20
>  	guard(serio_pause_rx)(parent->ps2dev.serio);
>  	priv->pt_port_open =3D true;
> +	priv->pt_psmouse =3D psmouse_from_serio(serio);

[Severity: Critical]
Can this cast cause memory corruption? If userspace binds a non-psmouse
driver (like serio_raw) to the pass-through port, the driver data points to=
 a
different structure (e.g., struct serio_raw). This caches a bogus pointer in
priv->pt_psmouse, which is later dereferenced in
synaptics_set_transparent_mode().

> =20
>  	return 0;
>  }

[ ... ]

> +	/*
> +	 * The touchpad is stopped for the duration of the mode switch, but the
> +	 * pass-through guest keeps streaming. It may therefore be left with a
> +	 * partially assembled packet from the previous mode. Drop it so the
> +	 * stream restarts cleanly in the new mode and no stale bytes are
> +	 * misparsed as pointer motion or spurious button clicks.
> +	 */
> +	if (READ_ONCE(priv->pt_port)) {
> +		struct psmouse *child =3D READ_ONCE(priv->pt_psmouse);
> +
> +		if (child && child->state =3D=3D PSMOUSE_ACTIVATED)
> +			psmouse_set_state(child, PSMOUSE_ACTIVATED);

[Severity: Critical]
If a different driver (like serio_raw) is bound, this could interpret
arbitrary memory as a struct psmouse. By manipulating the serio_raw queue
buffer to match PSMOUSE_ACTIVATED and injecting a pointer, could this result
in psmouse_set_state() dereferencing an attacker-controlled pointer to
acquire a spinlock?

> +	}
> +
> +	return len;
> +}

[ ... ]

>  static void synaptics_disconnect(struct psmouse *psmouse)
>  {
>  	struct synaptics_data *priv =3D psmouse->private;
> @@ -1448,10 +1649,24 @@ static void synaptics_disconnect(struct psmouse *=
psmouse)
>  	 */
>  	psmouse_smbus_cleanup(psmouse);
> =20
> +	if (READ_ONCE(priv->transparent_mode)) {
> +		synaptics_exit_transparent_mode(psmouse);
> +		WRITE_ONCE(priv->transparent_mode, false);
> +	}
> +
>  	if (!priv->absolute_mode &&
>  			SYN_ID_DISGEST_SUPPORTED(priv->info.identity))
>  		device_remove_file(&psmouse->ps2dev.serio->dev,
>  				   &psmouse_attr_disable_gesture.dattr);
> +	if (SYN_CAP_PASS_THROUGH(priv->info.capabilities))
> +		device_remove_file(&psmouse->ps2dev.serio->dev,
> +				   &psmouse_attr_transparent_mode.dattr);
> +
> +	if (priv->pt_serio) {
> +		serio_unregister_port(priv->pt_serio);
> +		kfree(priv->pt_serio);
> +		priv->pt_serio =3D NULL;
> +	}

[Severity: Critical]
Can this cause a use-after-free, double-free, and self-deadlock?

If the parent port is unregistered (e.g. physical removal), the serio core
traverses the tree depth-first and synchronously destroys the child
pass-through port, freeing its memory. When synaptics_disconnect() is then
called for the parent, calling serio_unregister_port() and kfree() on the
dangling priv->pt_serio pointer could use freed memory and deadlock on
serio_mutex, which is already held by the core's unregistration path.

Alternatively, if userspace manually unbinds the parent driver via sysfs:

psmouse_disconnect() (acquires psmouse_mutex)
  synaptics_disconnect()
    serio_unregister_port()
      (unbinds child driver)
      psmouse_disconnect() for child
        (tries to acquire psmouse_mutex)

Could this sequence lead to a permanent self-deadlock on psmouse_mutex?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809154420.3690=
73-1-development@laserology.net?part=3D1
