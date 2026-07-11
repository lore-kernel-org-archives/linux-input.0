Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8EE3C872B
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 13:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783776400; cv=none; b=YdXWPQ3ufkhyIRB2/BWNNWS197tpLbnYCMaJoMi87Bs72WbLwSglL84mT7IAcSoQy34/a5qU1RxK5te0j2Cep6Rs4yky4zeAtXsUhXtR8O3HkM7ygT59VpAsBsySRgZ8nn2Rq3L2SYnYvw77DdBATj9t7nVJZiSLLHbhyk8NP98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783776400; c=relaxed/simple;
	bh=dQV2fY4fIpzA6mzMe+3o+099SHm6Q9yh+EIXTxI94F8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H0ixBng+JHOuCobT12xNGf+u1UG6TDt8l2NLBmvZ7FT7V07MXdr0MN4atG0QTCbDcRPEjxCveh4Ub7MNLOyCf9gXZtXrE3P6C0w8gXDQQU3AEN5CfuBzGQMPHjKEx4vfE7CI34lScNtbLeNBfMHB8+xedNhyh+WTDkNwgWVA/Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHSZ8nFj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHSZ8nFj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EBE1F000E9;
	Sat, 11 Jul 2026 13:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783776398;
	bh=XTLZtOVRVfGxSdfj7dtFH7eEmTCrsImiQITxbjBvDQ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GHSZ8nFj3HsY1jBpJKSLwmT5vP2sOXGyPJajVdySPHcnJ69S47IarmcvUShL2IRb8
	 lSh5547lxj6OOpHh5A8UXl3Lm/Hd63mLmz0EYj5JqmIFTg+y1UN1m7PFtzKpqsYGur
	 +ux0SewQlaFSanF0+ZHGMTwujgjF6qpQWIWcCDvxsQK8O+pJ/fQ4CZsT8m1BJfqxHr
	 M4isYcYi6/Y2iChaf+INqmsKckasGYoRVvNxiBr+Y800IPKscXGS8QeACx0/xcA7pp
	 n/13YxGpi9hCSSGodOQg0by9idSdgEO1qeFPNIP7bG3Nu/KVAK8dEp34alBsU/n+r5
	 u88AR2mzGBXcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] Input: applespi - cancel pending work on driver
 remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shih-Yuan Lee" <fourdollars@debian.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260711131140.18777-2-fourdollars@debian.org>
References: <20260711055247.5412-1-fourdollars@debian.org>
 <20260711131140.18777-1-fourdollars@debian.org>
 <20260711131140.18777-2-fourdollars@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 13:26:37 +0000
Message-Id: <20260711132638.09EBE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Repeated PACKET_DEV_INFO packets lead to unbounded devm memory lea=
ks and duplicate input device registrations.
- [High] Unchecked access of asynchronously allocated applespi->touchpad_in=
put_dev in the debugfs tp_dim open handler.
- [High] Unbound wait in applespi_drain_writes() can block driver unbind an=
d suspend forever if hardware is unresponsive.
- [High] Missing async teardown in applespi_probe error path if GPE enablem=
ent fails.
- [High] Mismatched finger data reported to input subsystem due to flawed i=
teration logic.
- [Low] Redundant manual assignment of dev.parent on input devices allocate=
d with devm_input_allocate_device().
--

--- Patch [1]: [PATCH v5 1/3] Input: applespi - cancel pending work on driv=
er remove ---
commit 541134ed7dfbfee9d31126ce14257c1f72d8e7a7
Author: Shih-Yuan Lee <fourdollars@debian.org>

Input: applespi - cancel pending work on driver remove

During driver removal in applespi_remove(), the managed private data
structure is freed by devres. However, the driver does not cancel the
asynchronous work applespi->work, which registers the touchpad input
device.

> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/a=
pplespi.c
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c
> @@ -1820,8 +1820,10 @@ static void applespi_remove(struct spi_device *spi)
>  {
>  	struct applespi_data *applespi =3D spi_get_drvdata(spi);
> =20
>  	applespi_drain_writes(applespi);

[Severity: High]
This isn't a bug introduced by this patch, but can this wait indefinitely
and block driver unbind or system suspend?

applespi_drain_writes() waits for the hardware without a timeout:

drivers/input/keyboard/applespi.c:applespi_drain_writes() {
    ...
    wait_event_lock_irq(applespi->drain_complete, !applespi->write_active,
                        applespi->cmd_msg_lock);
    ...
}

If the external hardware hangs and write_active remains true, would this
task become blocked forever?

> =20
>  	acpi_disable_gpe(NULL, applespi->gpe);
>  	acpi_remove_gpe_handler(NULL, applespi->gpe, applespi_notify);
>  	device_wakeup_disable(&spi->dev);
> =20
>  	applespi_drain_reads(applespi);
> =20
> +	cancel_work_sync(&applespi->work);
> +
>  	debugfs_remove_recursive(applespi->debugfs_root);
>  }

[Severity: Low]
This isn't a bug introduced by this patch, but does this code redundantly
assign the parent device?

drivers/input/keyboard/applespi.c:applespi_register_touchpad_device() {
    ...
    touchpad_input_dev =3D devm_input_allocate_device(&applespi->spi->dev);
    ...
    touchpad_input_dev->dev.parent =3D &applespi->spi->dev;
    ...
}

And similarly in applespi_probe():

drivers/input/keyboard/applespi.c:applespi_probe() {
    ...
    applespi->keyboard_input_dev->dev.parent =3D &spi->dev;
    ...
}

The input subsystem guidelines state that devm_input_allocate_device()
automatically sets the parent, making manual assignment redundant.

[Severity: High]
This isn't a bug introduced by this patch, but can a repeated
PACKET_DEV_INFO from the hardware cause an unbounded memory leak and
duplicate device registrations?

drivers/input/keyboard/applespi.c:applespi_handle_cmd_response() {
    ...
    if (packet->type =3D=3D PACKET_DEV_INFO) {
        ...
        schedule_work(&applespi->work);
    }
    ...
}

When the work runs, it executes applespi_register_touchpad_device(),
which unconditionally allocates a new managed device:

drivers/input/keyboard/applespi.c:applespi_register_touchpad_device() {
    ...
    touchpad_input_dev =3D devm_input_allocate_device(&applespi->spi->dev);
    ...
    error =3D input_register_device(touchpad_input_dev);
    ...
}

If the peripheral sends multiple PACKET_DEV_INFO packets, would this
blindly allocate and register multiple touchpad devices without checking
if one already exists?

[Severity: High]
This isn't a bug introduced by this patch, but could this dereference a
NULL pointer if the async worker hasn't completed initializing the
touchpad?

drivers/input/keyboard/applespi.c:applespi_probe() {
    ...
    debugfs_create_file("tp_dim", 0400, applespi->debugfs_root, applespi,
                        &applespi_tp_dim_fops);
    ...
}

If userspace opens this file before applespi_register_touchpad_device()
is finished by the workqueue, applespi_tp_dim_open() is called:

drivers/input/keyboard/applespi.c:applespi_tp_dim_open() {
    ...
    applespi->touchpad_input_dev->id.product,
    ...
}

Since touchpad_input_dev might still be NULL, will this crash the kernel?

[Severity: High]
This isn't a bug introduced by this patch, but does the probe error path
miss cleaning up async tasks and SPI reads?

drivers/input/keyboard/applespi.c:applespi_probe() {
    ...
    acpi_sts =3D acpi_enable_gpe(NULL, applespi->gpe);
    if (ACPI_FAILURE(acpi_sts)) {
        dev_err(&spi->dev, "failed to enable GPE\n");
        return -ENODEV;
    }
    ...
}

If acpi_install_gpe_handler() (called earlier) receives an interrupt
before acpi_enable_gpe() fails, it could queue an async SPI transfer or
work item. Returning -ENODEV immediately frees the applespi structure
without calling applespi_drain_reads() or cancel_work_sync(), which
could result in a use-after-free.

[Severity: High]
This isn't a bug introduced by this patch, but does this iteration logic
mismatch the finger data reported to the input subsystem?

drivers/input/keyboard/applespi.c:report_tp_state() {
    ...
    report_finger_data(input, applespi->slots[i], &applespi->pos[i],
                       &t->fingers[i]);
    ...
}

If earlier loops filter out fingers (e.g., touch_major =3D=3D 0) and store
their coordinates densely in applespi->pos, reusing the same sequential
index i for t->fingers[i] could pair the packed positions with the
wrong original finger data from the hardware. Could this corrupt
multitouch reporting?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711131140.1877=
7-1-fourdollars@debian.org?part=3D1
