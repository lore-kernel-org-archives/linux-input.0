Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC927283C82
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 21:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781387639; cv=none; b=EG1yWQk2l/BvPBzVl2RW8cD6k67SbLSTJFFozB1/jT4q1/HxB6kR1jAG3kMKwruGwATZnlOI/7dJM2fHC+GDdkMDUtsM3VIheWHr9TpRm8TBFd4yq6XH5bPSUQ+oqjTR9uxjdksF32xtTysOnMhc9FFqmeVOiurMOOErSU+Xwto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781387639; c=relaxed/simple;
	bh=sXrRuQLRRax14pZrvKdxflJR15Q+dJk2qJ5JkZ0ZsHY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FS50COMXM7QauE3H72iyd3jSTC7va+u4MO2GtfEHqxGIXdYB1P94C2PvbM2U0wVEhoR/L2H7X1golm3J83JcjoFY25uzlj7zopTAlwT3ppvyebdfd3C6ZACUaYXTNe2tIWH58cBlFBi6M4brNH4fe6I9VJlNWsR2QF5xA3bw0lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVpMiYyJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVpMiYyJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329921F000E9;
	Sat, 13 Jun 2026 21:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781387638;
	bh=JKmQNhR0MNqiMaf9u5dumPbqGzkzd4DL0yf9zvn7yic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QVpMiYyJa2pRPVtmtDhlMjC/jLZFEDW7lxZzvtFQonNQa9Ib8m+xtdnc3vV5wuB1x
	 mRmz2CFaLeUMWwHIfZQpRME5j9jSOVJfPYPgwRd3gfneQuqyVHIubBxlAoe96lSFUh
	 3SLXagdO4iJhMAyMFA3vZKw9NOPaq1IDD2C3Jnl/jfb3dTxSDPfTvhW6LVBcGFiP61
	 P4ggZ9BgNcfzeuA36TikTgwcPgyODatAxzeniRGcmG0A43mIntCfm22iEL+b7rX1GM
	 CutfHweMeGrE+HDwzeEU6+yN3ptw6IIK/MpMG40NerbIoU7I69LvARaFbGWnUiL0qt
	 30xYejG/644Yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: apple_z2 - bound the device-reported packet
 length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas via B4 Relay" <devnull+hexlabsecurity.proton.me@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260613-b4-disp-b1926f1a-v1-1-3a277b7c0cfa@proton.me>
References: <20260613-b4-disp-b1926f1a-v1-1-3a277b7c0cfa@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 21:53:57 +0000
Message-Id: <20260613215358.329921F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds check on the number of fingers (`nfingers`) reporte=
d by the device in `apple_z2_parse_touches` leads to a kernel heap out-of-b=
ounds read and potential information leak.
- [High] Concurrent execution of `apple_z2_read_packet()` from the probe/re=
sume thread and the IRQ handler causes a data race and shared SPI buffer co=
rruption.
- [Medium] If `apple_z2_boot()` times out waiting for the boot IRQ, it retu=
rns directly without disabling the IRQ or reverting the hardware reset stat=
e, leading to state inconsistencies.
- [Low] The input device is registered and exposed to userspace before the =
hardware is initialized and firmware is uploaded, violating input subsystem=
 readiness rules.
--

commit 0ef574cc6b6df1efb30f7e523d3cf505e551ae3c
Author: Bryam Vargas <hexlabsecurity@proton.me>

Input: apple_z2 - bound the device-reported packet length

apple_z2_read_packet() takes a 16-bit length from the touch controller's
interrupt-data reply and uses it as the size of the second SPI transfer into
the fixed-size rx_buf. This bounds the device-reported packet length to rej=
ect
any packet whose length exceeds the receive buffer.

> diff --git a/drivers/input/touchscreen/apple_z2.c b/drivers/input/touchsc=
reen/apple_z2.c
> index 271ababf0ad55..ff9ff97be185a 100644
> --- a/drivers/input/touchscreen/apple_z2.c
> +++ b/drivers/input/touchscreen/apple_z2.c

[ ... ]

> @@ -147,6 +148,8 @@ static int apple_z2_read_packet(struct apple_z2 *z2)
>  		return 0;
> =20
>  	pkt_len =3D (get_unaligned_le16(z2->rx_buf + 1) + 8) & 0xfffffffc;
> +	if (pkt_len > APPLE_Z2_MAX_PACKET)
> +		return -EMSGSIZE;
> =20
>  	error =3D spi_read(z2->spidev, z2->rx_buf, pkt_len);
>  	if (error)

[Severity: High]
This isn't a bug introduced by this patch, but does apple_z2_parse_touches()
lack a bounds check on the number of fingers?

It appears that apple_z2_parse_touches() reads the unvalidated nfingers cou=
nt
from msg[APPLE_Z2_NUM_FINGERS_OFFSET] and blindly iterates over it:

drivers/input/touchscreen/apple_z2.c:apple_z2_parse_touches() {
    ...
	nfingers =3D msg[APPLE_Z2_NUM_FINGERS_OFFSET];
	fingers =3D (struct apple_z2_finger *)(msg + APPLE_Z2_FINGERS_OFFSET);
	for (i =3D 0; i < nfingers; i++) {
    ...
}

Could a spoofed device set nfingers to 255, causing the loop to read
out-of-bounds past the rx_buf allocation, and potentially leading to an
information leak when those bytes are parsed as touch coordinates?

[Severity: High]
This is a pre-existing issue, but is there a data race when
apple_z2_read_packet() is executed concurrently?

In apple_z2_boot(), the device interrupt is unmasked via enable_irq() before
firmware is uploaded. Then in apple_z2_upload_firmware(), the driver sets
z2->booted =3D true and manually calls apple_z2_read_packet().

If the device asserts the interrupt concurrently, the threaded IRQ handler
apple_z2_irq() will wake up, observe z2->booted =3D=3D true, and also invoke
apple_z2_read_packet().

Since there is no lock protecting apple_z2_read_packet(), could this
concurrently overwrite z2->tx_buf, mutate z2->index_parity, and corrupt the
shared SPI buffers?

[ ... ]

> @@ -363,7 +366,7 @@ static int apple_z2_probe(struct spi_device *spi)
>  	if (!z2->tx_buf)
>  		return -ENOMEM;
>  	/* 4096 will end up being rounded up to 8192 due to devres header */
> -	z2->rx_buf =3D devm_kzalloc(dev, 4000, GFP_KERNEL);
> +	z2->rx_buf =3D devm_kzalloc(dev, APPLE_Z2_MAX_PACKET, GFP_KERNEL);
>  	if (!z2->rx_buf)
>  		return -ENOMEM;

[Severity: Medium]
This is a pre-existing issue, but does apple_z2_boot() miss cleanup when
wait_for_completion_timeout() fails?

In apple_z2_boot(), the IRQ enable depth is incremented and the device is
taken out of reset. If it times out waiting for the boot_irq completion, it
directly returns -ETIMEDOUT:

drivers/input/touchscreen/apple_z2.c:apple_z2_boot() {
    ...
	if (!wait_for_completion_timeout(&z2->boot_irq, msecs_to_jiffies(20)))
		return -ETIMEDOUT;
    ...
}

If this happens during apple_z2_resume(), devm teardown does not occur. Does
this leave the IRQ permanently enabled and the reset GPIO active, leading to
state inconsistency?

[Severity: Low]
This is a pre-existing issue, but is the input device registered before the
hardware is fully initialized?

In apple_z2_probe(), input_register_device() is called before apple_z2_boot=
()
has completed:

drivers/input/touchscreen/apple_z2.c:apple_z2_probe() {
    ...
	error =3D input_register_device(z2->input_dev);
	if (error)
		return dev_err_probe(dev, error, "unable to register input device\n");

	/* Wait for device reset to finish */
	usleep_range(5000, 10000);
	error =3D apple_z2_boot(z2);
    ...
}

If apple_z2_boot() fails, the momentarily registered device is removed. Does
this expose an uninitialized device to userspace prematurely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613-b4-disp-b1=
926f1a-v1-1-3a277b7c0cfa@proton.me?part=3D1
