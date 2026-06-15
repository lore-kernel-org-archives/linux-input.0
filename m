Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCC3357CE8
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781548349; cv=none; b=IxcjGfK81WrtDroIGRMwZ3Arc2yggh2W52lzjRFzC7F9zvTYIfnsOJGBXmhtYqPmiyQZgAXPKGA81yIG7Np/yw1+S6JKDYsqZ4CdbAM9ATMfBj+9ttewumWhmShk4A+DfyMyOEULbA5CQNGzm3Zq2xdQoiEIuSC0Eqopa38s/qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781548349; c=relaxed/simple;
	bh=/4eLAYudtQSnYor1UJmVYbWnGrrXrTP5522I9/N2uk8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LxImsuy/OJabC8gWziqAu2+xauAhs01Bf4nsMKBu7eT4jy3q2O6AeZUs/boOUU80sT5VDpOtKO18I/E5ZPFVyx9nqNanLyIBtd/4emvb2OH/iSnxzRIsQeNQuZkPuWbYkuTz47JF5Q5+RG2GXS0NKL/8s9h7anfcUtSIbYFLwCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOazaukw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOazaukw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61461F000E9;
	Mon, 15 Jun 2026 18:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781548347;
	bh=3qTxGmY1VCRgFTHI3t4KeT6tMUTtD1PnHzwZlu6kIVk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eOazaukwZsEigjQWvSLm4oK6tno4PFKZoIU3nddRq2bssGhqz62h/HZSLywf0v4DB
	 GP/KE2YWc9pglNTosxc8JI2QAiEwkzIw0E6ZR6bSJDgMqLM3T0zcrsmgAVHwiXb72f
	 X8W6Ap82Cx9xgT8JRh27gt9hMddQBGa583Zn3OxahMpZQBox2vzhfg9HJqgZvZYKTE
	 YtWzN4fgF/rAOxICvCu/NUtcqlQ+p1267siGt167ub0dl/tQNum0stvrQ8dHpCJgZf
	 oaGvyYw8SKfaNBsDQTu+TMpTykyZL7FQsfyTRCtbE6DFuNZ8ZCKWJr8jrQEP2KwhVl
	 T1bfRj1Y7GXmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] Input: apple_z2 - bound the device-reported
 packet length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas via B4 Relay" <devnull+hexlabsecurity.proton.me@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260615-b4-disp-05943ee1-v3-1-bbfe1b651613@proton.me>
References: <20260615-b4-disp-05943ee1-v3-1-bbfe1b651613@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 18:32:27 +0000
Message-Id: <20260615183227.A61461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Skipping `spi_read()` on oversized packets leaves the device's buf=
fer undrained, causing an infinite interrupt storm.

Pre-existing issues:
- [High] Unprotected concurrent calls to `apple_z2_read_packet()` from both=
 the probe/resume thread and IRQ context lead to SPI buffer corruption.
--

commit 9b2ec52954ce23198e826455d8fa38261e0ca8d8
Author: Bryam Vargas <hexlabsecurity@proton.me>

Input: apple_z2 - bound the device-reported packet length

apple_z2_read_packet() takes a 16-bit length from the touch controller's
interrupt-data reply and uses it as the size of the second SPI transfer into
the fixed-size rx_buf. Reject any packet whose length exceeds the receive
buffer to prevent out-of-bounds writes.

Fixes: 471a92f8a21a ("Input: apple_z2 - add a driver for Apple Z2 touchscre=
ens")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Reviewed-by: Sasha Finkelstein <k@chaosmail.tech>

> diff --git a/drivers/input/touchscreen/apple_z2.c b/drivers/input/touchsc=
reen/apple_z2.c
> index 271ababf0ad55..ff9ff97be185a 100644
> --- a/drivers/input/touchscreen/apple_z2.c
> +++ b/drivers/input/touchscreen/apple_z2.c

[ ... ]

> @@ -147,6 +148,8 @@ static int apple_z2_read_packet(struct apple_z2 *z2)
>  		return 0;

[Severity: High]
This is a pre-existing issue, but does this function need synchronization to
prevent SPI buffer corruption?

If apple_z2_upload_firmware() sets z2->booted =3D true and synchronously ca=
lls
apple_z2_read_packet(), and a concurrent interrupt triggers apple_z2_irq(),
they can both invoke apple_z2_read_packet() at the same time.

Won't this cause simultaneous unsynchronized modifications to the shared
z2->tx_buf, z2->rx_buf, and z2->index_parity variables?

> =20
>  	pkt_len =3D (get_unaligned_le16(z2->rx_buf + 1) + 8) & 0xfffffffc;
> +	if (pkt_len > APPLE_Z2_MAX_PACKET)
> +		return -EMSGSIZE;

[Severity: High]
Will returning early here cause an interrupt storm?

By skipping spi_read(), the device's internal buffer is not drained and the
hardware interrupt line will likely remain asserted.

Since apple_z2_irq() ignores the error returned by apple_z2_read_packet() a=
nd
unilaterally returns IRQ_HANDLED:

drivers/input/touchscreen/apple_z2.c:apple_z2_irq() {
    ...
    else
        apple_z2_read_packet(z2);
       =20
    return IRQ_HANDLED;
}

Could this immediately unmask the interrupt and endlessly loop through this
same failure path?

> =20
>  	error =3D spi_read(z2->spidev, z2->rx_buf, pkt_len);
>  	if (error)

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615-b4-disp-05=
943ee1-v3-0-bbfe1b651613@proton.me?part=3D1
