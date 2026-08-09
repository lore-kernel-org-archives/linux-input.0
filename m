Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F705282F01
	for <linux-input@vger.kernel.org>; Sun,  9 Aug 2026 06:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786255771; cv=none; b=BUOFtDCx9YhVROhXO4GpdD6AmX4Foky1owOeuvEZoinuTCBfE7eAUOEBetc4NjMmdFlpFd+34L8tlb+7NXGVzzE3jW8t6guAHwafKkks23vscystFDqMn8F6QQwFRy6X7attThSVXDPDgO5xz2Phq1kkpTHp0MNntcFLTbgFxz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786255771; c=relaxed/simple;
	bh=23QSatMPFS8J/oJOlYCFq3cMwhM3fPVZb15sQiS5rG0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cXGftv9dvUi0BvYiaG8YQKoX6Tz835dImJ+M/uuih+elPiOICCqyVCPleGvW+YRuX2DTbGi7g6mhxzGYPPkOPFRbq6HMUvkrwmk2XVOBEbiLb7V7upcAj14TqNe7bC/h9/lXxOtf2xTjiUw2tmaGK7VxqD6XAY059hmmEc3vfC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsY7JhT4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsY7JhT4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3491F000E9;
	Sun,  9 Aug 2026 06:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786255770;
	bh=car6KNJaB1lgUzX6umkUFylo5a9+6WvjkxKXtR0Ajbw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KsY7JhT4r2MLKZ52iHWBZai7j5V75AaMMZHDBXIvmiPDXprj+zQ6pVHjOK6j7MUJ8
	 UP2Vv3FixObJhuu2qvZSJSFOCi1W+T0I79nmH9pydfeBzlQduBObbniQAjUtNEBrw6
	 6Vx6cRlcOxpR5ko13sLiZXtUCUqCQiMQPlIAbKl2xJMbgZehea1Ydo1vuPk/EV0Aeb
	 lzUYTA8uMvbmP/nqKAHjf1fV4r4UUsiDJ9ITz1Oh5keza8rwqiuELUFYnQgYXrBqtW
	 SwEd5uxpQs7zv1QsK32tyn4smGElr2WY8Rj5PWgfWiWlPz6X0WUttigtLEh4Cf0plz
	 +YIkRtZ2O/uUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: synaptics - add transparent pass-through mode
 for TrackPoint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Laserology OSS" <development@laserology.net>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260809053322.25430-1-development@laserology.net>
References: <20260809053322.25430-1-development@laserology.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 06:09:29 +0000
Message-Id: <20260809060929.CF3491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [Critical] Missing pass-through port check in psmouse_receive_byte causes=
 type confusion and control flow hijacking for non-psmouse parent ports.
- [High] Blind cast of pass-through port's drvdata in synaptics_set_transpa=
rent_mode leads to type confusion and NULL pointer dereferences.
- [Medium] Hardware and software states become permanently desynchronized i=
f the guest port is stopped while transparent mode is active.
- [Medium] Unprotected updates to protocol_handler and pktsize in synaptics=
_set_transparent_mode() cause a data race with the RX interrupt.
- [Medium] Skipping synaptics_set_mode() during reconnect in transparent mo=
de leaves the hardware uninitialized when transparent mode is later disable=
d.

Pre-existing issues:
- [High] Failing to create sysfs attributes leaks the pass-through port and=
 causes a use-after-free on its access.
--

--- Patch [1]: [PATCH] Input: synaptics - add transparent pass-through mode=
 for TrackPoint ---
commit 1fc824e1e4a325dcff29e0fb66487d7ede60f009
Author: Laserology OSS <development@laserology.net>
Subject: Input: synaptics - add transparent pass-through mode for TrackPoint

This patch adds a transparent pass-through mode for Synaptics touchpads
with a pass-through port. It allows the guest device to run at its full
poll rate while temporarily disabling the touchpad.

Link: https://lore.kernel.org/all/6932d599-2625-0376-d9c6-58cbb8879ff4@gmai=
l.com/

> diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psm=
ouse-base.c
> --- a/drivers/input/mouse/psmouse-base.c
> +++ b/drivers/input/mouse/psmouse-base.c
[ ... ]
> @@ -392,8 +392,18 @@ static void psmouse_receive_byte(struct ps2dev *ps2d=
ev, u8 data)
>  		}
> =20
>  		if (psmouse->packet[1] =3D=3D PSMOUSE_RET_ID) {
> +			struct serio *serio =3D ps2dev->serio;
> +			struct psmouse *parent_psmouse =3D NULL;
> +
>  			__psmouse_set_state(psmouse, PSMOUSE_IGNORE);
> -			serio_reconnect(ps2dev->serio);
> +			/* Some devices need parent to be reconnected instead */
> +			if (serio->parent)
> +				parent_psmouse =3D psmouse_from_serio(serio->parent);
> +			if (parent_psmouse && parent_psmouse->pt_reconnect_parent &&
> +			    parent_psmouse->pt_reconnect_parent(parent_psmouse))

[Severity: Critical]
Is it safe to unconditionally cast serio->parent's driver data to a psmouse
struct here?

If the parent port is a multiplexer driven by ps2mult, its driver data
would be a different struct. Accessing parent_psmouse->pt_reconnect_parent
could then lead to type confusion and read a bogus function pointer,
potentially causing a crash or arbitrary execution when called.

> +				serio_reconnect(serio->parent);
> +			else
> +				serio_reconnect(serio);
>  			return;
>  		}
> =20
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synapt=
ics.c
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
[ ... ]
> @@ -672,6 +750,8 @@ static void synaptics_pt_stop(struct serio *serio)
> =20
>  	guard(serio_pause_rx)(parent->ps2dev.serio);
>  	priv->pt_port =3D NULL;
> +
> +	synaptics_update_protocol_handler(parent);

[Severity: Medium]
If the guest port is unbound while transparent mode is active, priv->pt_port
becomes NULL and synaptics_update_protocol_handler() will revert the softwa=
re
handler to synaptics_process_byte. Will this cause the hardware and software
states to become permanently desynchronized?

The hardware would still be in transparent mode sending 3-byte packets, but
the software would expect 6-byte absolute packets, which could lead to
erratic pointer behavior.

>  }
[ ... ]
> @@ -1438,6 +1535,80 @@ PSMOUSE_DEFINE_ATTR(disable_gesture, S_IWUSR | S_I=
RUGO, NULL,
[ ... ]
> +	WRITE_ONCE(priv->transparent_mode, value);
> +
> +	synaptics_update_protocol_handler(psmouse);

[Severity: Medium]
Should this call to synaptics_update_protocol_handler() be protected by
guard(serio_pause_rx)? It updates psmouse->protocol_handler and
psmouse->pktsize outside of the lock.

If an interrupt arrives concurrently, psmouse_receive_byte() might read the
new pktsize but the old protocol_handler, leading to incorrect packet
processing.

> +
> +	/*
> +	 * The touchpad is stopped for the duration of the mode switch, but the
> +	 * pass-through guest keeps streaming. It may therefore be left with a
> +	 * partially assembled packet from the previous mode. Drop it so the
> +	 * stream restarts cleanly in the new mode and no stale bytes are
> +	 * misparsed as pointer motion or spurious button clicks.
> +	 */
> +	if (READ_ONCE(priv->pt_port)) {
> +		struct psmouse *child =3D psmouse_from_serio(priv->pt_port);
> +
> +		if (child && child->state =3D=3D PSMOUSE_ACTIVATED)
> +			psmouse_set_state(child, PSMOUSE_ACTIVATED);
> +	}

[Severity: High]
Does this cast safely handle the case where the guest port is unbound or
bound to a different driver?

If the port is unbound, the drvdata is NULL and psmouse_from_serio()
evaluates to a negative offset, causing a panic when child->state is checke=
d.

If it is bound to another driver like serio_raw, this causes type confusion
and psmouse_set_state() could dereference an invalid pointer, leading to
memory corruption.

> +
> +	return len;
> +}
[ ... ]
> @@ -1478,8 +1655,16 @@ static int synaptics_reconnect(struct psmouse *psm=
ouse)
>  			 */
>  			ssleep(1);
>  		}
> -		ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_GETID);
> -		error =3D synaptics_detect(psmouse, 0);
> +		if (READ_ONCE(priv->transparent_mode) && READ_ONCE(priv->pt_port)) {
> +			error =3D synaptics_enter_transparent_mode(psmouse);
> +			if (!error) {
> +				serio_reconnect(priv->pt_port);
> +				return 0;
> +			}

[Severity: Medium]
Returning early here bypasses the normal synaptics_set_mode() initialization
during reconnect. If the user later disables transparent mode via sysfs,
synaptics_exit_transparent_mode() only restores the previous mode byte but
won't re-enable Advanced Gesture Mode or other configurations set up by
synaptics_set_mode().

Could this leave the touchpad uninitialized after a suspend/resume cycle?

> +		} else {
> +			ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_GETID);
> +			error =3D synaptics_detect(psmouse, 0);
> +		}
>  	} while (error && ++retry < 3);
[ ... ]
> @@ -1691,9 +1869,26 @@ static int synaptics_init_ps2(struct psmouse *psmo=
use,
[ ... ]
>   init_fail:
> +	if (!priv->absolute_mode && SYN_ID_DISGEST_SUPPORTED(priv->info.identit=
y))
> +		device_remove_file(&psmouse->ps2dev.serio->dev,
> +				   &psmouse_attr_disable_gesture.dattr);
> +	if (SYN_CAP_PASS_THROUGH(priv->info.capabilities))
> +		device_remove_file(&psmouse->ps2dev.serio->dev,
> +				   &psmouse_attr_transparent_mode.dattr);
>  	kfree(priv);
>  	return err;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but if device_create_file() fails
in synaptics_init_ps2(), the code jumps to init_fail, frees the priv struct=
ure,
and returns an error without unregistering the pass-through serio child por=
t.

The child port remains active, and any subsequent interaction with it could
trigger callbacks that dereference the freed parent->private pointer,
resulting in a use-after-free. Should the port be unregistered during
cleanup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809053322.2543=
0-1-development@laserology.net?part=3D1
