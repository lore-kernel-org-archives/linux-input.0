Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD92637207D
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 07:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783753683; cv=none; b=TZkpjDdu060nJebGyAkxiLankhWCeZ91Lt+csTR0WRIr54UcLE4PWVM6ZgMYQ5qp8WzYnIGUItSWE0t7O7CozX60+CuJR9MZnG0kImON2m9bd0FSttFHSgXQTHbDx39xKiuR7YBeHmAO074k4PO8Wwo0YwTFFGSIEf9pjAO9Ejw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783753683; c=relaxed/simple;
	bh=p3HdZPbG/HomP0ngwA3mOVi2HcpVqEe9xepNdO1xUKs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IDfP6O+v41jqKbYolRVeWTQbygp4pOHYfi8GV+keapQGOL9i8VtALOBDpKegFaFK5zgqK2ohmpE1t/NlH98fXjW2ywlN0XMhcibm/rwVyELOxHhuFhD/TeXZgbjh1ur6dVlCOLoahl8oDnmQBLxye+SaRQTr7cnZIEOzn2Es3YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0vBWGEq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0vBWGEq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386591F000E9;
	Sat, 11 Jul 2026 07:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783753682;
	bh=g+jLFdPk4og1yBdL6I5mBGsjWbYlNjKHyoAR9fpy/+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G0vBWGEq/vk1Zxv6iO//blNIIfjfsrCcYwn4F8PrTIX1OVnDKorkO2Rgv6buj8Ycr
	 zAHQGd3tTS3sLAekBlVx4Cmdn5LVilY21FNNvefuURVgSYCYhPgDrQS/wvme4iSu1G
	 Ed7hU8vjoPFBCgiVMqTEnYjFWf3lNSOfDirpEnykrIOBEx8PapAK83dIa65BoTEM7y
	 nXOdKznrq7bQnCA+yLPvYZm4oD4MJxDSad2xZzPV083zhECCb44eOTSVeCGNFXvUOD
	 cBZ69xKuqxtZhjeMh4ooZZ8EbyOF6OOYPJ0mti9RTavMVUNhYn9EQgWGKGPVJuXJ8N
	 2ogHFlJslrLXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] Input: applespi - fix NULL pointer dereference
 in tp_dim open
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shih-Yuan Lee" <fourdollars@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260711065415.7396-4-fourdollars@debian.org>
References: <20260711055247.5412-1-fourdollars@debian.org>
 <20260711065415.7396-1-fourdollars@debian.org>
 <20260711065415.7396-4-fourdollars@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 07:08:01 +0000
Message-Id: <20260711070802.386591F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbounded allocations of touchpad input devices triggered by repea=
ted PACKET_DEV_INFO SPI messages.
- [High] Deadlock in `applespi_drain_reads` during module unload or system =
suspend after a CRC error.
--

--- Patch [3]: [PATCH v2 3/3] Input: applespi - fix NULL pointer dereferenc=
e in tp_dim open ---
commit 54174cce6bfb0203a63026dc8e54eb65b7ee620c
Author: Shih-Yuan Lee <fourdollars@debian.org>

Input: applespi - fix NULL pointer dereference in tp_dim open

The tp_dim debugfs file is registered synchronously during driver probe
in applespi_probe(). However, the applespi->touchpad_input_dev is
initialized and registered asynchronously in the driver's worker thread.
If a userspace process opens the debugfs file before the worker thread
has completed initialization, it will dereference the NULL pointer.
This commit uses smp_load_acquire to safely load the pointer and returns
-ENODEV if not initialized.

> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/a=
pplespi.c
> index b6b4d258d0dd5..1f8e4ae902855 100644
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c
> @@ -968,12 +968,18 @@ static void applespi_debug_update_dimensions(struct=
 applespi_data *applespi,
>  static int applespi_tp_dim_open(struct inode *inode, struct file *file)
>  {
>  	struct applespi_data *applespi =3D inode->i_private;
> +	struct input_dev *touchpad;
> =20
>  	file->private_data =3D applespi;
> =20
> +	/* Pairs with smp_store_release in applespi_register_touchpad_device() =
*/
> +	touchpad =3D smp_load_acquire(&applespi->touchpad_input_dev);
> +	if (!touchpad)
> +		return -ENODEV;
> +
>  	snprintf(applespi->tp_dim_val, sizeof(applespi->tp_dim_val),
>  		 "0x%.4x %dx%d+%u+%u\n",
> -		 applespi->touchpad_input_dev->id.product,
> +		 touchpad->id.product,
>  		 applespi->tp_dim_min_x, applespi->tp_dim_min_y,
>  		 applespi->tp_dim_max_x - applespi->tp_dim_min_x,
>  		 applespi->tp_dim_max_y - applespi->tp_dim_min_y);

[Severity: High]
This isn't a bug introduced by this patch, but could this lead to an unboun=
ded
allocation of touchpad input devices?

When the SPI device sends a PACKET_DEV_INFO message,
applespi_handle_cmd_response() unconditionally queues applespi->work:

	applespi->rcvd_tp_info =3D message->tp_info;
	schedule_work(&applespi->work);
	return;

The worker function applespi_worker() then calls
applespi_register_touchpad_device(), which unconditionally allocates and
registers a new touchpad device:

	/* create touchpad input device */
	touchpad_input_dev =3D devm_input_allocate_device(&applespi->spi->dev);
	...
	/* register input device */
	sts =3D input_register_device(touchpad_input_dev);

This appears to overwrite the applespi->touchpad_input_dev pointer without
freeing or unregistering the previous one.=20

If the hardware sends multiple info packets, does this cause a resource lea=
k=20
of devm-managed memory and input devices?

[Severity: High]
This is a pre-existing issue, but is there a potential deadlock during modu=
le
unload or system suspend after a CRC error?

In applespi_got_data(), if a SPI packet fails the CRC check and the driver
is not currently draining, the function returns early without clearing
applespi->read_active:

	if (!applespi_verify_crc(applespi, applespi->rx_buffer,
				 APPLESPI_PACKET_SIZE)) {
		guard(spinlock_irqsave)(&applespi->cmd_msg_lock);

		if (applespi->drain) {
			applespi->read_active =3D false;
			applespi->write_active =3D false;
			wake_up_all(&applespi->drain_complete);
		}
		return;
	}

If no further SPI interrupts arrive before a system suspend or rmmod,
applespi_remove() and applespi_suspend() disable GPE interrupts and then ca=
ll
applespi_drain_reads():

	/* disable GPE interrupt */
	acpi_disable_gpe(NULL, applespi->gpe);
	applespi_drain_reads(applespi);

applespi_drain_reads() will then wait for !applespi->read_active:

	wait_event_lock_irq(applespi->drain_complete, !applespi->read_active,
			    applespi->cmd_msg_lock);

Since interrupts are disabled, no new read can arrive to clear the flag.=20

Can this result in an unrecoverable deadlock waiting for read_active to cle=
ar?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711065415.7396=
-1-fourdollars@debian.org?part=3D3
