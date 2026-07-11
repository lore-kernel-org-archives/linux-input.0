Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA7035C185
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 09:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783762614; cv=none; b=g2hK48tXCMvqncs/SxdlIYSHyWjm2SGs7dEIzM+8us9ltNZsNqV+/cH1k/oDUIplz741+bAUbyTADsyLor1QjEG6ZTG9ClR3VleCB7MuH3GJjsjvo79kwVsZipBLLk7XYFF/MT7nBBERYrFGIqtJvHIP4AMN21r7qD5ao0KmNHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783762614; c=relaxed/simple;
	bh=phm5NdEASYtUS3JNA+QUyq0MHpGkW0XoCqRNVFO+sUU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mjfRzpJ8Tdhj5t+liHfY6GOIopXgrfUsd/Tux1PGAG3og6Y+OfLm0ilf13kDhgbBYwNYTC+Y/UNR4K2pOyoYfTf5Vd9U13LBqnF/v98paoBE/SpBrT9ftkWl6ySj7NwZqEoA8Yg/ixSxtzHnsMLRbBSSu9Kao46fwQ1WF5k1iIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fn1a2rwo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fn1a2rwo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F2C1F000E9;
	Sat, 11 Jul 2026 09:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783762613;
	bh=ivNpDbWkLJSUkHNMUKDuhluD8mNVObSQ0pGCTTsQTsA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fn1a2rwoZ1vDAkpurraT+Pn8JNyIowL+tn2VZW+ZZPI57OZQRwKu92vBBcTJIpTX2
	 /XEICTOzC3p3OB7u0fthSyhGN14baAfk5AzZVr1hVO3iWpd4PFtJ/ltdx6yuTlK6vA
	 y67uOF0ol0GJOdkRhJHRBy3RZTZqOu5bjhXG21dByYeGpaFl49j38MmdKKdPk/mQea
	 VM5z1eqLF0Y/BBAsttyKgyggL9iNRXmeRqWhc6k64y/IiZKB1Y4g5diOmjzBETGtQJ
	 dAgl8nvQIstW+UTfJR1RyZDOCdTKuhun+lnFSLkCGEEZiaorxoto5+PiAyil8A8n+R
	 2yPfYYcaPIfrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] Input: applespi - cancel pending work on driver
 remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shih-Yuan Lee" <fourdollars@debian.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260711092054.13818-3-fourdollars@debian.org>
References: <20260711092054.13818-1-fourdollars@debian.org>
 <20260711092054.13818-3-fourdollars@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 09:36:52 +0000
Message-Id: <20260711093653.08F2C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free of `applespi` structure in SPI async read completio=
n callback
- [High] Unbounded wait in `applespi_drain_writes` leading to deadlock on d=
river unbind or suspend
- [High] NULL pointer dereference in debugfs 'tp_dim' open handler
- [High] CRC error in SPI packet permanently leaks `read_active` flag, caus=
ing deadlock
- [High] Unsafe DMA allocation using `devm_kmalloc` leads to cacheline corr=
uption
--

--- Patch [2]: [PATCH v3 2/3] Input: applespi - cancel pending work on driv=
er remove ---
commit 600aa576cb85623de00e20bade1177db921cccac
Author: Shih-Yuan Lee <fourdollars@debian.org>

Input: applespi - cancel pending work on driver remove
   =20
During driver removal in applespi_remove(), the managed private data
structure is freed by devres. However, the driver does not cancel the
asynchronous work applespi->work, which registers the touchpad input
device.

> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/a=
pplespi.c
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c
> @@ -1861,6 +1861,8 @@ static void applespi_remove(struct spi_device *spi)
> =20
>  	applespi_drain_reads(applespi);

[Severity: High]
This is a pre-existing issue, but does applespi_drain_reads() create a race
condition with the SPI async read completion callback?

If applespi_drain_reads() waits for read_active to become false, and the
callback applespi_async_read_complete() clears this flag via
applespi_msg_complete(), it unblocks the removal thread immediately:

applespi_async_read_complete() {
    ...
    applespi_msg_complete(applespi, ...);
    ...
    acpi_finish_gpe(NULL, applespi->gpe);
}

Can the removal thread finish applespi_remove() and free the applespi
structure via devres before the completion callback finishes executing,
leading to a use-after-free when acpi_finish_gpe() is called?

[Severity: High]
This is a pre-existing issue, but can this unbind or suspend path deadlock
due to unbounded waits?

Looking at applespi_drain_writes() called earlier in this path, it waits
for write_active to become false:

applespi_drain_writes() {
    applespi->drain =3D true;
    wait_event_lock_irq(applespi->drain_complete, !applespi->write_active,
                        applespi->cmd_msg_lock);
}

If the hardware fails to respond to a command, write_active remains true.
Because drain is set to true, the lazy timeout logic in
applespi_send_cmd_msg() is unreachable. Does this wait_event block
indefinitely without a fallback timeout if a write response is never receiv=
ed?

> +	cancel_work_sync(&applespi->work);
> +
>  	if (override_dma)
>  		spi->controller->can_dma =3D applespi->original_can_dma;
> =20

[ ... ]

[Severity: High]
This is a pre-existing issue, but is there a risk of a NULL pointer
dereference when accessing the tp_dim debugfs file?

The tp_dim debugfs file is created synchronously during probe, but
applespi->touchpad_input_dev is allocated asynchronously in a workqueue.
If a user opens the debugfs file before the workqueue executes (or if it
never executes due to a hardware failure), applespi_tp_dim_open() will see
a NULL pointer:

applespi_tp_dim_open() {
    ...
    applespi->touchpad_input_dev->id.product,
    ...
}

Can this unconditionally dereference touchpad_input_dev while it is NULL?

[Severity: High]
This is a pre-existing issue, but does a CRC error permanently leak the
read_active state?

In applespi_got_data(), if a packet fails CRC validation and drain is
false, it returns early:

applespi_got_data() {
    if (!applespi_verify_crc(...)) {
        if (applespi->drain) {
            ...
        }
        return;
    }
    ...
}

This skips calling applespi_msg_complete(), leaving read_active set to
true. When the system later suspends or the driver is unbound, will
applespi_drain_reads() wait indefinitely for read_active to become
false, causing a deadlock?

[Severity: High]
This is a pre-existing issue, but are the SPI buffers safe for DMA transfer=
s?

In applespi_probe(), the buffers are allocated using devm_kmalloc():

applespi_probe() {
    ...
    applespi->tx_buffer =3D devm_kmalloc(&spi->dev, APPLESPI_PACKET_SIZE, .=
..);
    applespi->rx_buffer =3D devm_kmalloc(&spi->dev, APPLESPI_PACKET_SIZE, .=
..);
    ...
}

Since devm allocations prepend a struct devres header immediately before
the returned pointer, the devres header shares the same cacheline as the
start of the buffer.

When the SPI core maps these buffers for DMA, will DMA cache invalidation
(especially DMA_FROM_DEVICE for Rx) invalidate the CPU cacheline and
corrupt the devres linked list headers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711092054.1381=
8-1-fourdollars@debian.org?part=3D2
