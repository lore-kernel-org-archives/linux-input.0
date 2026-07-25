Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE13E27703
	for <linux-input@vger.kernel.org>; Sat, 25 Jul 2026 07:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784965722; cv=none; b=nFMr967Vp5JbmPgZebf90bZ9JvRyxYURY0jJgkx147b+Mf/l6Nry5GEfstmVMaBJnPUfMgtS14TfQOrhc7mPfL5fvdaDOcValstrB6P8FmiiIQk4imaLO+fQSGYb3vtgqJ+MPLYiZVQiTiqFHA7Z39pwnTkfS/o8yyNuGBKW/Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784965722; c=relaxed/simple;
	bh=1wy5qzBnRUt6T2D4AL3czs+FA8iku2XWBWfQCkhIKeI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e9Tz8Wlng83T5uY1JrW4dldrNCoykkz5R4Eg071IDcHyr3K/FenVIUYpOWmcrYpYTfLAXT7culrgktZvqqBnLQ7C+e04kYcDWWPpGbl68D38+HUm3DimHw4TBipVLVvloMT+5JUxHqLsTFLOAJ6TJmczrjTBjbybxDTyGXH6mIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKZXNmby; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKZXNmby"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615DA1F000E9;
	Sat, 25 Jul 2026 07:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784965720;
	bh=C3B/QYXTSv8C8UjKeNsKGxRJdC9uft+Al9MuwToyPC0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FKZXNmbyJQhQFRe9iqQG7yEoTq6d5CntnD2GW4rPz9hhi6W27Jye+xCapI2Jf4ZoE
	 hXWpcdIx60jyPmJy9He2q1XOgnpsz3QGu/db5ivV7QT8UrO2eYqtmR2VdAsxyI33WH
	 cOzUhz02lKxJL6SDrx7kaqoYoNAuyArka6B0kVBPqo5eMJbtRg6ofxLZPpkZES9OR2
	 ebq/iynbYZFJD5+ZlecHaNg9OviEwTzBOTMvRCJOHPG0B0WIok6BH+D+KfuClvM2HO
	 Bdn6SvH/HjhrHIYJLZfXKuviI8fZ0bY+pNtfLBbuyH2UaxGQVD5YesP/mVN5+FNBkw
	 HdUcvzwaVWJOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] Input: xpad - add wired Beitong BTP-KP20D support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Ma" <mapengyu@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260725072813.339112-2-mapengyu@gmail.com>
References: <20260725072813.339112-1-mapengyu@gmail.com>
 <20260725072813.339112-2-mapengyu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 07:48:39 +0000
Message-Id: <20260725074840.615DA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Probe error path after input_register_device() causes a Use-After-=
Free risk because xpad driver data is unconditionally freed while the input=
 device is visible to userspace.

Pre-existing issues:
- [Critical] The probe error path frees the output URB (irq_out) and its DM=
A buffer without killing the active URB, causing memory corruption.
--

--- Patch [2]: [PATCH 2/2] Input: xpad - add wired Beitong BTP-KP20D suppor=
t ---
commit ec428f1a8b8e609c623920e0839f0af31cf70bb0
Author: Aaron Ma <mapengyu@gmail.com>

Input: xpad - add wired Beitong BTP-KP20D support

The wired BTP-KP20D resets itself when its interrupt-IN pipe is idle
for a few seconds, causing periodic re-enumeration whenever no
userspace client holds the input device open. Add a FLAG_KEEPALIVE
quirk that keeps the input URB running from probe to disconnect,
mirroring the XTYPE_XBOX360W URB lifecycle.

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 1616047e65f5e..5369b880c6a08 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c

[ ... ]

> @@ -2227,9 +2232,22 @@ static int xpad_probe(struct usb_interface *intf, =
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
> +			if (error)
> +				goto err_deinit_input;

[Severity: High]
If xpad_start_input() fails here, we jump to err_deinit_input which=20
unregisters the input device, and eventually falls through to kfree(xpad)=20
in xpad_probe().=20

Because xpad_init_input() has already successfully called=20
input_register_device(), the device is visible to userspace.

Could a local user open the evdev node immediately after registration and=20
issue an EVIOCSFF ioctl concurrently? If so, input_ff_upload() would call=20
xpad_play_effect(), which might dereference xpad after it has been freed=20
since input_unregister_device() does not block concurrent ioctls that=20
have already passed the evdev->exist check.

> +		}
>  	}
>  	return 0;
> =20
> +err_deinit_input:
> +	xpad_deinit_input(xpad);
>  err_deinit_output:
>  	xpad_deinit_output(xpad);

[Severity: Critical]
This is a pre-existing issue, but this new fallible xpad_start_input()=20
call creates a new way to trigger it.

If we take the error path to err_deinit_output after xpad_init_input()=20
succeeds (which calls xpad_led_probe() and submits the irq_out URB for=20
Xbox 360 controllers), xpad_deinit_output() will free the irq_out URB=20
and its odata DMA buffer.

However, it does not appear to call xpad_stop_output() or usb_kill_urb().=20
Can this lead to memory corruption if the USB host controller continues=20
writing to the freed odata DMA buffer, and the URB completion handler=20
xpad_irq_out() executes and dereferences the freed xpad structure?

>  err_free_in_urb:
>  	usb_free_urb(xpad->irq_in);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725072813.3391=
12-1-mapengyu@gmail.com?part=3D2
