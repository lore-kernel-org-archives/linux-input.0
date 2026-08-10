Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC125464C
	for <linux-input@vger.kernel.org>; Mon, 10 Aug 2026 00:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786320632; cv=none; b=nCJtAcLNdci5zQVDx7v7qLHoD0yZwdMD4smQ3XGhwv+VnZ8SLkHmpWRmnLQVNH857ZuZRMBiA9dojFZ/pSVrULg3R7WaaWRAnLZRlmB4rf2DExFzLh3D5MaGVIORWK9n+FAduOxJdsy0AxCpwSWGIDKazHSXOBq1wCcZg+Ri/5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786320632; c=relaxed/simple;
	bh=PaGJ4/T0DVZbgpqezFKOm0TIvvYZD6SN1Nfr5g5+pLE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rSyFJFxDoRMLcNhGD5FcT9i52Ym2lcAYjExRe02LdDS7pmu15++Xb65ZxgZfIo7syLDiteukh03WfCosJMtpVpfJRWCrtG6tVw5hHWCPgGerpxYO3QvD8j1VTRBsA49iq6oEnx9R7KB56WX/k5ivwFj9H/uIujjRto+VMJpJmd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbD9b3w8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbD9b3w8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92AF1F000E9;
	Mon, 10 Aug 2026 00:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786320630;
	bh=Md0I6LeDNZNa0UwpThu5YtbbBKEFiCbVj1ZG9PHCQn0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LbD9b3w8e5WfuePtcYJ12Ps3gOq0/uWto1DIud9J+murHGoxKw/88hqfSu57lb3pp
	 9ybFAwKVwvdr8KKiCfIQxUgboe7QV0Jce0/DsQQS/fI4CE6RnBUCvl5xHSCVK24L7m
	 SYlHGr5ya9bAEVL3wZQkqrpphNii4JzFC2JLbLd/hYKTJPKceb6j0M2YwX0b0sI0fN
	 hE/FcLinHA+uzloZbWrFdRsxb3dgxpeZpId1+CsIq314NCSZkPKZxiroyZHkSMuwKe
	 KtvMOc4/37EoFpJcakh/YoPC3yx85iGJwBmOGG3bxjsPTKLTsVUB0PAifeu9o3kyVM
	 jbdlSiTEA3JJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] Input: synaptics - add transparent pass-through mode
 for TrackPoint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Laserology OSS" <development@laserology.net>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260809234611.25655-1-development@laserology.net>
References: <20260809234611.25655-1-development@laserology.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 00:10:30 +0000
Message-Id: <20260810001030.B92AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] TOCTOU races in synaptics_pt_stop and synaptics_set_transparent_mo=
de cause hardware and software state desynchronization.
- [High] synaptics_pt_write bypasses ps2_cmd_mutex in transparent mode, cor=
rupting the PS/2 bus byte stream.
- [High] synaptics_reconnect lacks pt_mutex synchronization, causing races =
with concurrent guest writes.
- [High] Delayed NULL pointer dereference (or Use-After-Free) in synaptics_=
reconnect due to a TOCTOU read of priv->pt_port.

Pre-existing issues:
- [High] Ineffective driver type check allows type confusion and out-of-bou=
nds access in pass-through port handling.
- [High] Incomplete fix for the child port leak: child port leaks if input_=
register_device fails, leading to UAF.
--

--- Patch [1]: [PATCH v4] Input: synaptics - add transparent pass-through m=
ode for TrackPoint ---
commit 7d4fbfed011585417421459058126e46e98ff9df
Author: Evan Lawrence <development@laserology.net>

Input: synaptics - add transparent pass-through mode for TrackPoint
   =20
This commit introduces a transparent pass-through mode for Synaptics touchp=
ads,
allowing a pass-through guest to operate at a higher poll rate. It adds a s=
ysfs
attribute to toggle the mode, handles hardware state switches, and adjusts =
the
protocol handler dynamically.

> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synapt=
ics.c
> index 2170bbe4c5897..2a004ae34158d 100644
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
> +	guard(mutex)(&priv->pt_mutex);
> +
> +	if (READ_ONCE(priv->transparent_mode))
> +		return parent->ps2dev.serio->write(parent->ps2dev.serio, c);

[Severity: High]
Does bypassing ps2_cmd_mutex here allow raw guest bytes to interleave with =
host
commands on the PS/2 bus?

In drivers/input/mouse/synaptics.c:synaptics_pt_write():
When transparent mode is active, this fast-path directly writes to the
hardware under pt_mutex, but does not acquire ps2_cmd_mutex. If a sysfs
attribute on the parent touchpad is updated concurrently, it issues a
ps2_command(), potentially interleaving guest bytes and host commands and
corrupting communication with the touchpad.

>  	error =3D ps2_sliced_command(&parent->ps2dev, c);
[ ... ]
> @@ -669,9 +749,30 @@ static void synaptics_pt_stop(struct serio *serio)
>  {
>  	struct psmouse *parent =3D psmouse_from_serio(serio->parent);
>  	struct synaptics_data *priv =3D parent->private;
> +	bool exit_mode =3D READ_ONCE(priv->transparent_mode);
> =20
> -	guard(serio_pause_rx)(parent->ps2dev.serio);
> -	priv->pt_port =3D NULL;
> +	/*
> +	 * The guest is going away. Hold the pass-through mutex across
> +	 * the hardware exit and the software state update so a
> +	 * concurrent synaptics_pt_write() cannot observe the old
> +	 * transparent_mode after the hardware has already been
> +	 * switched back to normal operation.
> +	 */
> +	guard(mutex)(&priv->pt_mutex);
> +
> +	if (exit_mode) {
> +		if (synaptics_exit_transparent_mode(parent))

[Severity: High]
Does reading exit_mode outside of pt_mutex allow the hardware and software
state to become desynchronized?

In drivers/input/mouse/synaptics.c:synaptics_pt_stop():
If synaptics_pt_stop() is called concurrently with=20
synaptics_set_transparent_mode(), exit_mode is cached before acquiring the =
lock.
The mode switch could enable hardware transparent mode, and then
synaptics_pt_stop() acquires the lock, skips the hardware exit because the
cached exit_mode was false, but forces the software state to normal mode.

> +			psmouse_warn(parent,
> +				     "failed to exit transparent mode after pass-through port remova=
l\n");
> +	}
[ ... ]
> @@ -709,7 +822,7 @@ static void synaptics_pass_pt_packet(struct synaptics=
_data *priv, u8 *packet)
> =20
>  	serio_interrupt(ptport, packet[1], 0);
> =20
> -	if (priv->pt_port_open) {
> +	if (priv->pt_port_open && ptport->id.type =3D=3D SERIO_PS_PSTHRU) {
>  		struct psmouse *child =3D psmouse_from_serio(ptport);
> =20
>  		if (child->state =3D=3D PSMOUSE_ACTIVATED) {

[Severity: High]
This is a pre-existing issue, but does checking the hardware ID reliably
verify the bound software driver type?

In drivers/input/mouse/synaptics.c:synaptics_pass_pt_packet():
If a root user unbinds the psmouse driver from the pass-through child port
and binds a different driver like serio_raw, this check passes because it
evaluates the hardware ID. The foreign driver's private data is then
downcasted to struct psmouse, potentially allowing out-of-bounds writes to
child->state or child->oob_data_type.

> @@ -724,7 +837,14 @@ static void synaptics_pass_pt_packet(struct synaptic=
s_data *priv, u8 *packet)
[ ... ]
> +static ssize_t synaptics_set_transparent_mode(struct psmouse *psmouse,
> +					      void *data, const char *buf,
> +					      size_t len)
> +{
> +	struct synaptics_data *priv =3D psmouse->private;
> +	unsigned int value;
> +	int err;
> +
> +	err =3D kstrtouint(buf, 10, &value);
> +	if (err)
> +		return err;
> +
> +	if (value > 1)
> +		return -EINVAL;
> +
> +	if (value =3D=3D READ_ONCE(priv->transparent_mode))
> +		return len;
> +
> +	/* Transparent mode only makes sense while the guest is attached */
> +	if (value && !READ_ONCE(priv->pt_port))
> +		return -ENODEV;
> +
> +	/*
> +	 * Switch the hardware first and only commit the new mode and protocol
> +	 * handler once it succeeded, so a failing command cannot leave the
> +	 * driver with bookkeeping that does not match the device. The touchpad
> +	 * is deactivated for the duration of this write (see
> +	 * psmouse_attr_set_helper), so no live data can be misparsed in
> +	 * between.  Hold the pass-through mutex so that a concurrent
> +	 * synaptics_pt_write() cannot inject a byte onto the bus in the
> +	 * middle of the mode-switch command sequence.
> +	 */
> +	guard(mutex)(&priv->pt_mutex);

[Severity: High]
Does checking pt_port outside of pt_mutex create a race condition with
synaptics_pt_stop()?

In drivers/input/mouse/synaptics.c:synaptics_set_transparent_mode():
Since the pt_port check happens before acquiring pt_mutex,
synaptics_pt_stop() could concurrently destroy pt_port before the mode swit=
ch
executes, leading to misconfigured protocol handlers.

> +
> +	if (value) {
> +		err =3D synaptics_enter_transparent_mode(psmouse);
[ ... ]
> @@ -1478,8 +1681,35 @@ static int synaptics_reconnect(struct psmouse *psm=
ouse)
>  			 */
>  			ssleep(1);
>  		}
> -		ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_GETID);
> -		error =3D synaptics_detect(psmouse, 0);
> +		if (READ_ONCE(priv->transparent_mode) && READ_ONCE(priv->pt_port)) {
> +			/*
> +			 * psmouse_reset() above put the touchpad back into its
> +			 * power-on state, so run the full initialization before
> +			 * re-entering transparent mode. Otherwise the device
> +			 * would come back missing the configuration set up by
> +			 * synaptics_set_mode() (e.g. Advanced Gesture Mode) and
> +			 * would stay uninitialized once transparent mode is
> +			 * disabled again.
> +			 */
> +			error =3D synaptics_query_hardware(psmouse, &info);
> +			if (!error &&
> +			    (info.identity !=3D priv->info.identity ||
> +			     info.model_id !=3D priv->info.model_id ||
> +			     info.capabilities !=3D priv->info.capabilities ||
> +			     info.ext_cap !=3D priv->info.ext_cap))
> +				error =3D -ENXIO;
> +			if (!error)
> +				error =3D synaptics_set_mode(psmouse);
> +			if (!error)
> +				error =3D synaptics_enter_transparent_mode(psmouse);

[Severity: High]
Can concurrent guest writes interleave with the hardware initialization
sequence here?

In drivers/input/mouse/synaptics.c:synaptics_reconnect():
The entire re-initialization sequence runs without holding pt_mutex. If the
child port driver writes data concurrently, synaptics_pt_write() will see
transparent_mode as true, lock pt_mutex, and inject bytes directly onto the
bus between the PS/2 commands issued here.

> +			if (!error) {
> +				serio_reconnect(priv->pt_port);

[Severity: High]
Can priv->pt_port be NULL or point to freed memory by the time it is access=
ed
here?

In drivers/input/mouse/synaptics.c:synaptics_reconnect():
priv->pt_port is checked before the lengthy hardware query sequence. If the
child port is concurrently unbound during this time, synaptics_pt_stop() co=
uld
nullify and free the port structure, causing a NULL pointer dereference or
use-after-free when passed to serio_reconnect().

> +				return 0;
> +			}
[ ... ]
> @@ -1691,9 +1913,35 @@ static int synaptics_init_ps2(struct psmouse *psmo=
use,
[ ... ]
> +	/*
> +	 * Register the pass-through port only once all initialization steps
> +	 * that can fail have succeeded, so that a failure in one of the steps
> +	 * above cannot leak a registered child port whose callbacks would
> +	 * dereference the freed synaptics_data.
> +	 */
> +	if (SYN_CAP_PASS_THROUGH(info->capabilities))
> +		synaptics_pt_create(psmouse);
> +
>  	return 0;

[Severity: High]
This is a pre-existing issue, but does this still leak the child port if
the parent's input_register_device() fails later?

In drivers/input/mouse/synaptics.c:synaptics_init_ps2():
Even though synaptics_pt_create() is moved to the end of this function, if
the caller (psmouse_connect()) subsequently fails in input_register_device(=
),
it aborts and frees the psmouse instance via synaptics_disconnect(). The ch=
ild
port is never unregistered, and if it is bound later, its handlers will
dereference the freed parent private data.

> =20
>   init_fail:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809234611.2565=
5-1-development@laserology.net?part=3D1
