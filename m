Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF093242D8
	for <linux-input@vger.kernel.org>; Sat,  1 Aug 2026 08:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785571898; cv=none; b=Bav/FRtFrUnnc/nLN92gPI/OYKnkjlIRwUz7r1drafwf2D4dCJRPFvJpfJoT2NccX7+Fej2ow5bkd3mkNWRT/waEQltTdiuoNylzus35ztoAvQAZ6y9eb/zaqbrPZ/ylOQIdXhz+U6vtZ6eQ1SQbOwTUiW4ygxtvP8Cb2vT6+AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785571898; c=relaxed/simple;
	bh=vKaL4AxRjaph/TF7sHrK67+hdjJNWc47zxZTzgbWthU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DsnSBTk3NPDD3DMF0awEzKa5k8JeFsRyKXgD5loRSmBboW7f4qbjg0lDFLN1KOeAA+B1HBVTF55CeZyzlbbA7C5yHWuCUI32/7UVlUE0V3BP1Cs29PXqA6W7YztZsyIxBPFbU4MAG7ngop7sltw+oQ4Ol0Snsng1+Q79ge7Ogjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VL5cEb2C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VL5cEb2C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053CD1F00AC4;
	Sat,  1 Aug 2026 08:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785571897;
	bh=9dW7THjAYYyJCZA+oD5rnqa2sMBDkj8n/6jfyV0tqf4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VL5cEb2CaeW26uuF/LczwXcphQGwzUWYhNuMtVNot630whw7N3gvJePe4ntSzFpNM
	 QEV9v4hJxdoJAhWW9wheCGRBGTY/O+a2ZlcYiljDFU77cOlbZOXp0HiXNqoMBkCL5y
	 LUv/gEQCrBTTrHfUgH9MwAtHyqBuM0DmpPxBl+ouAuhmLBbGO2kPkZwTlMAWp7amyv
	 dDavwioVKDyngMxBjB77QhKsQxiv8VZF/zdiAY9k7Wxo3O2aI8aaVUSvmYneqolxi4
	 r9OeOecaPuWfIvNlCy32cZzBHl3Kb9iR0eGiHEvevGsEDMs5PzzUwV0O4prWzDl7VE
	 fPAlnXDL/XKYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] Input: xpad - add wired Beitong BTP-KP20D
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Ma" <mapengyu@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260801075623.2769601-2-mapengyu@gmail.com>
References: <20260801075623.2769601-1-mapengyu@gmail.com>
 <20260801075623.2769601-2-mapengyu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 08:11:36 +0000
Message-Id: <20260801081137.053CD1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing workqueue cancellation in xpad_probe error path leads to U=
se-After-Free.
- [High] Sleeping in atomic context when processing GIP_CMD_ANNOUNCE from t=
he URB completion handler.
--

--- Patch [2]: [PATCH v2 2/2] Input: xpad - add wired Beitong BTP-KP20D sup=
port ---
commit 600bda7a2ef7ea6aabd37796bfb7164b015f813b
Author: Aaron Ma <mapengyu@gmail.com>

Input: xpad - add wired Beitong BTP-KP20D support

This patch adds support for the wired Beitong BTP-KP20D controller and
introduces a FLAG_KEEPALIVE quirk. The quirk keeps the input URB running
from probe to disconnect to prevent the device from resetting itself when i=
dle.

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 1616047e65f5e..9adc419066353 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c

[ ... ]

> @@ -2227,10 +2232,24 @@ static int xpad_probe(struct usb_interface *intf,=
 const struct usb_device_id *id
>  		error =3D xpad_init_input(xpad);
>  		if (error)
>  			goto err_deinit_output;
> +
> +		if (xpad->keepalive) {
> +			/*
> +			 * The device resets itself when the interrupt-IN pipe
> +			 * is idle for a few seconds, so keep the URB running
> +			 * from probe until disconnect.
> +			 */
> +			error =3D xpad_start_input(xpad);

[Severity: High]
This is a pre-existing issue, but does xpad_start_input() sleep in atomic
context when called from the URB completion handler?

For XTYPE_XBOXONE devices with FLAG_DELAY_INIT, a GIP_CMD_ANNOUNCE packet
triggers xpadone_process_packet() from the URB completion handler xpad_irq_=
in(),
which executes in an atomic context (softirq).

xpadone_process_packet() then invokes xpad_start_input():

	if (xpad->delay_init && !xpad->delayed_init_done) {
		xpad->delayed_init_done =3D true;
		error =3D xpad_start_input(xpad);

xpad_start_input() calls usb_submit_urb() with GFP_KERNEL, which can sleep:

	if (usb_submit_urb(xpad->irq_in, GFP_KERNEL))
		return -EIO;

It also calls xpad_start_xbox_one(), which invokes usb_set_interface() to
disable the audio interface using synchronous USB control messages that can=
 wait
and sleep.

Can this trigger a kernel bug or panic if a malicious USB device sends a
GIP_CMD_ANNOUNCE packet?

> +			if (error)
> +				goto err_deinit_input;
> +		}
>  	}
>  	return 0;
> =20
> +err_deinit_input:
> +	xpad_deinit_input(xpad);
>  err_deinit_output:
> +	xpad_stop_output(xpad);
>  	xpad_deinit_output(xpad);
>  err_free_in_urb:

[Severity: High]
This is a pre-existing issue, but is it possible for xpad_probe() to free t=
he
xpad structure without canceling the workqueue on the error path?

For XTYPE_XBOX360W devices, xpad_probe() calls xpad360w_start_input(), which
submits the irq_in URB and then calls xpad_inquiry_pad_presence():

	error =3D xpad_inquiry_pad_presence(xpad);
	if (error) {
		usb_kill_urb(xpad->irq_in);
		return error;
	}

If a malicious or buggy device responds immediately via the IN endpoint,
xpad_irq_in() will run and xpad360w_process_packet() may schedule xpad->wor=
k.

If xpad_inquiry_pad_presence() fails, xpad360w_start_input() kills the URB =
and
returns an error without canceling the scheduled work.

xpad_probe() then takes the err_deinit_output path:

	if (xpad->xtype =3D=3D XTYPE_XBOX360W) {
		...
		error =3D xpad360w_start_input(xpad);
		if (error)
			goto err_deinit_output;

This eventually frees the xpad structure via kfree(xpad).

Can the workqueue execute xpad_presence_work() later, causing a Use-After-F=
ree
when accessing the freed xpad structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801075623.2769=
601-1-mapengyu@gmail.com?part=3D2
