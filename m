Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EA83FD121
	for <linux-input@vger.kernel.org>; Mon, 10 Aug 2026 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373151; cv=none; b=k7tPsSibAYShcZsFFR8dGNL+Blzek2FAYkIRYP8DT42O4XiwX1u01vgzEh5XRrWuL3jzbsbyaiOfYvMMEkjedS/Cl+n2Lx1ZQPb9Tb12pks4A6XJe3IR9vPr55MxNiOK80+5aDauf0in0c57JcO5iEghHF2fTXp1yyKOegAL6VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373151; c=relaxed/simple;
	bh=7sknsoT8vlZIB1mU3Fk/wUfp2iZkQZixRzh4SRdCC4Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W/Q1vsiw4uBy+Nsux3lwWT+vdS+YoDSitMWIdpnkygVcrBRF3X+ZjNB/HydV/YK3noicDW8IqKV+3KQtFgxM0ne6L+AwJ43uRePVPEjLjg+UtjzeIObLwogYqNaw9FEDuz4Eu6J07QqwFq39ydN/bWf2difoIVfbxbu/cS/TIkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAEVDqqd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAEVDqqd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE281F000E9;
	Mon, 10 Aug 2026 14:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786373149;
	bh=g0QOTE8JF2UPVcXQqdkoejC7NI6C7zFk4gQk3NBDyOw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kAEVDqqdW1R/uAUcVOKAmg8iBnEh/Co+Bn1Hy1FbMuEw09XESRGW0+BPFQ+yJ2p0i
	 QcROLBRB83VIC9oAi8hmZziIlUzC6AGJCWApBQ0xKbq2a93NWNE8FX3EhybYrXM1Jf
	 1BtBCzezRfAFhXn0kLn05FgU061hI9XkFaob3hN6JrpXZd7DR39f6Fz2HKcCP2grUL
	 iC6S9+w2R1uS2VDnuvO3rl1q70hpMRVh9BDehyo+jy/U1rCzmeKAH99wZxfwsdqNiK
	 F+TWix2TSGBUClv2dv7EhWsFUU6lLtOr/6eY677HuqL7ZXgvyzsxCGJUyCW+4dTpm8
	 d4sW2jpZ5ocFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] Input: synaptics - add pass-through mode for
 TrackPoint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Evan Lawrence" <development@laserology.net>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260810142440.9060-1-development@laserology.net>
References: <20260810142440.9060-1-development@laserology.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 14:45:48 +0000
Message-Id: <20260810144549.3FE281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Type confusion leading to out-of-bounds read/write due to relying =
solely on hardware port ID for driver validation.
- [High] Unsynchronized hardware commands interleave with pass-through byte=
 stream, corrupting PS/2 communication.
- [High] Child port is leaked when parent driver probe fails, leading to a =
Use-After-Free crash.
- [Medium] Escape sequence aborts if the first byte is not ACKed, permanent=
ly locking the hardware in transparent mode.
--

--- Patch [1]: [PATCH v5] Input: synaptics - add pass-through mode for Trac=
kPoint ---
commit 0baba0d9c35febab280e4dc02e618df2555881dc
Author: Evan Lawrence <development@laserology.net>
Subject: Input: synaptics - add pass-through mode for TrackPoint

This commit introduces a transparent pass-through mode for Synaptics touchp=
ads
with a PS/2 guest port, allowing the guest (e.g., TrackPoint) to bypass the
touchpad's low poll rate by relaying raw byte streams directly. It adds a s=
ysfs
attribute to toggle the mode at runtime.

Link: https://lore.kernel.org/all/6932d599-2625-0376-d9c6-58cbb8879ff4@gmai=
l.com/

> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synapt=
ics.c
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -636,12 +650,90 @@ static void synaptics_set_rate(struct psmouse *psmo=
use, unsigned int rate)
>  /***********************************************************************=
******
>   *	Synaptics pass-through PS/2 port support
>   ***********************************************************************=
*****/

[ ... ]

> +static int synaptics_exit_transparent_mode(struct psmouse *psmouse)
> +{
> +	struct synaptics_data *priv =3D psmouse->private;
> +	int error;
> +
> +	/* Send scaling 2:1, 1:1 to exit transparent mode */
> +	error =3D ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE21);
> +	if (error)
> +		return error;
> +	error =3D ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11);
> +	if (error)
> +		return error;

[Severity: Medium]
Will a failure on the first byte permanently lock the hardware in transpare=
nt
mode?

If the guest device is missing, resetting, or unresponsive, the first
PSMOUSE_CMD_SETSCALE21 byte may time out waiting for an ACK. When ps2_comma=
nd()
returns an error, this function aborts without sending the crucial second b=
yte
(PSMOUSE_CMD_SETSCALE11).

Since synaptics_pt_stop() clears the software transparent_mode flag even if=
 the
hardware exit fails, doesn't this leave the driver fully desynchronized from
the hardware state, leaving the touchpad permanently unresponsive until a
reboot?

> +
> +	/* Re-enter the regular operating mode of the touchpad */
> +	error =3D synaptics_mode_cmd(psmouse, priv->mode & ~SYN_BIT_TRANSPARENT=
_MODE);
> +	if (error)
> +		return error;
> +
> +	priv->mode &=3D ~SYN_BIT_TRANSPARENT_MODE;
> +
> +	return 0;
> +}
> +
>  static int synaptics_pt_write(struct serio *serio, u8 c)
>  {
>  	struct psmouse *parent =3D psmouse_from_serio(serio->parent);
> +	struct synaptics_data *priv =3D parent->private;
>  	u8 rate_param =3D SYN_PS_CLIENT_CMD; /* indicates that we want pass-thr=
ough port */
>  	int error;
> =20
> +	guard(mutex)(&priv->pt_mutex);
> +
> +	if (READ_ONCE(priv->transparent_mode))
> +		return parent->ps2dev.serio->write(parent->ps2dev.serio, c);

[Severity: High]
Can this lead to corrupted PS/2 communication due to interleaved byte strea=
ms?

When transparent_mode is active, synaptics_pt_write() bypasses ps2_cmd_mute=
x to
forward raw guest bytes. However, other paths like synaptics_set_disable_ge=
sture()
or synaptics_reconnect() can send PS/2 commands while holding ps2_cmd_mutex=
 but
without checking transparent_mode or holding pt_mutex.

For example, if a user writes to the disable_gesture sysfs attribute while =
the
pass-through guest is active, won't the host command bytes and guest data
bytes interleave on the physical PS/2 bus?

> +
>  	error =3D ps2_sliced_command(&parent->ps2dev, c);
>  	if (error)
>  		return error;

[ ... ]

> @@ -681,6 +795,19 @@ static int synaptics_pt_open(struct serio *serio)
>  	guard(serio_pause_rx)(parent->ps2dev.serio);
>  	priv->pt_port_open =3D true;
> =20
> +	/*
> +	 * In transparent mode every byte on the parent serio belongs to
> +	 * the pass-through guest and is not a BAT announcement.  Skip
> +	 * BAT detection on the child as well so that guest motion data
> +	 * that happens to look like 0xAA 0x00 does not trigger a
> +	 * spurious parent reconnect.
> +	 */
> +	if (READ_ONCE(priv->transparent_mode) &&
> +	    serio->id.type =3D=3D SERIO_PS_PSTHRU) {
> +		struct psmouse *child =3D psmouse_from_serio(serio);
> +		WRITE_ONCE(child->pt_bypass_bat, true);
> +	}

[Severity: High]
Can this cause an out-of-bounds write if the child port is bound to a
different driver?

Checking serio->id.type =3D=3D SERIO_PS_PSTHRU only verifies the hardware p=
ort
type, but does not guarantee the bound driver is psmouse. If a privileged u=
ser
unbinds the psmouse driver and binds serio_raw instead, won't psmouse_from_=
serio()
cast a smaller private data structure to struct psmouse, causing
WRITE_ONCE(child->pt_bypass_bat, true) to corrupt slab memory?

This type confusion also appears to happen in synaptics_pt_close(),
synaptics_pass_pt_packet(), synaptics_pt_activate(), and
synaptics_set_transparent_mode().

> +
>  	return 0;
>  }

[ ... ]

> @@ -1447,10 +1692,20 @@ static void synaptics_disconnect(struct psmouse *=
psmouse)
>  	 */
>  	psmouse_smbus_cleanup(psmouse);
> =20
> +	if (READ_ONCE(priv->transparent_mode)) {
> +		guard(mutex)(&priv->pt_mutex);
> +		synaptics_exit_transparent_mode(psmouse);
> +		WRITE_ONCE(priv->transparent_mode, false);
> +		WRITE_ONCE(psmouse->pt_bypass_bat, false);
> +	}
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
Does this leak the pass-through child port if probe fails, leading to a
use-after-free?

If psmouse_connect() fails late in probe (for example, during
input_register_device() due to memory exhaustion), it calls the driver's
disconnect callback, which frees the priv structure here.

Since there is no call to serio_unregister_port() for the child port, it
remains registered. When the system asynchronously finishes adding the leak=
ed
port, any driver binding to it will call synaptics_pt_start(). Won't this
extract and dereference the freed parent driver data, causing a crash?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810142440.9060=
-1-development@laserology.net?part=3D1
