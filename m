Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889E02C187
	for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 01:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781400893; cv=none; b=sShgSCQZZUeWfuPsZR2DXUZq8HxRF4/NnepQTT3JCcjiYt92z/t1lWViRH2dyHQpns1vcmLt0AJ58N6JlXpdfVPmCWCL2DZ5AhOan2slTm9TmDfvuOPDGfeufFDXMmbgiXT1oQqFE1B1rQblbWXGXwEdTPKgn2vBV/D6/hAr4SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781400893; c=relaxed/simple;
	bh=OuBh1cL0oG4TyFTXc3m8Q2O9doGlde64dvcjgnmRaOk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o2jK1IudzDCu//ag3vw3kuGQ5cCWmhUuGacA8pA1b/NkmRe5ekphcGdyrVW9psMJWaJy4UFxu/wGk41qn2cyD3mJNsV1iokBM8pe3/cpm0srIstB912Lc84oN2EUCIM4mLdLehcMcpfwjcxw0cyx6tL5jGHgd1engk/oo9vXXn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCwZkaot; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCwZkaot"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE8A1F000E9;
	Sun, 14 Jun 2026 01:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781400892;
	bh=hWn+1k5EkfncTHT1Adu/dOO7kIZju3C0l74rzPlWhh0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lCwZkaotlPiqEI9nXlxOsL0+vDmJiC1w+plBcVnSxDHKUyKhbXQuQuzUONkAH/ez7
	 xQchZa0aLPxoYHpCOmoqzY8ro4ngl8V2QujzG/lw6UwVG9tTFgTX+zv6TK/iAwWuk/
	 MPDTc2B686iaurNxFFyBbrGUk2yXLayOKpCOEf4KOYbbNPgSsJvP11B+E4yPvxnelH
	 WoZvVMVQbijJfoJjucO4XBtRF3aC7SLtvnfclj0GxjGgnejkKvg64RbRwW/q+PdAHw
	 I/3EqvDQMyoyDBzhNMfhMCv8H5zT9acdw8qyDmyIFv9SKFUESYNc9cZ4dTot5tyw7J
	 8ODsTC2EfPrkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Input: apple_z2 - bound the device-reported finger
 count
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas via B4 Relay" <devnull+hexlabsecurity.proton.me@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260613-b4-disp-4ebcbd68-v2-1-0161acfbd688@proton.me>
References: <20260613-b4-disp-4ebcbd68-v2-1-0161acfbd688@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2026 01:34:51 +0000
Message-Id: <20260614013451.DEE8A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unvalidated device-reported packet length leads to a severe he=
ap buffer overflow in `spi_read`. The patch fails to address this root caus=
e.
- [High] Using the `__free(kfree)` attribute on a variable that can hold an=
 `ERR_PTR` causes a kernel panic during error handling.
- [High] Concurrent execution of `apple_z2_read_packet` causes data races o=
n driver state, SPI buffers, and lockless input-mt helper states.
--

commit 9a7b4f864d6502dba7c8e2bed5aa7ed3358d9e4a
Author: Bryam Vargas <hexlabsecurity@proton.me>

Input: apple_z2 - bound the device-reported finger count

The commit adds bounds checking for the device-reported finger count against
the SPI packet length to prevent an out-of-bounds read in
apple_z2_parse_touches().

Closes: https://lore.kernel.org/all/20260613215358.329921F000E9@smtp.kernel=
.org/

> diff --git a/drivers/input/touchscreen/apple_z2.c b/drivers/input/touchsc=
reen/apple_z2.c
> index 271ababf0ad55..39ade83ef0de7 100644
> --- a/drivers/input/touchscreen/apple_z2.c
> +++ b/drivers/input/touchscreen/apple_z2.c
> @@ -92,6 +92,12 @@ static void apple_z2_parse_touches(struct apple_z2 *z2,
>  		return;
>  	nfingers =3D msg[APPLE_Z2_NUM_FINGERS_OFFSET];
>  	fingers =3D (struct apple_z2_finger *)(msg + APPLE_Z2_FINGERS_OFFSET);
> +	/* a malicious controller can claim more fingers than the packet holds =
*/
> +	if (msg_len < APPLE_Z2_FINGERS_OFFSET)
> +		nfingers =3D 0;
> +	else
> +		nfingers =3D min_t(int, nfingers,
> +				 (msg_len - APPLE_Z2_FINGERS_OFFSET) / sizeof(*fingers));
>  	for (i =3D 0; i < nfingers; i++) {
>  		slot =3D input_mt_get_slot_by_key(z2->input_dev, fingers[i].finger);
>  		if (slot < 0) {

[Severity: High]
This is a pre-existing issue, but does this code overflow the heap allocati=
on
for rx_buf?

In apple_z2_read_packet():

    pkt_len =3D (get_unaligned_le16(z2->rx_buf + 1) + 8) & 0xfffffffc;
    error =3D spi_read(z2->spidev, z2->rx_buf, pkt_len);

Because rx_buf is allocated with a fixed size of 4000 bytes, couldn't a
malfunctioning device supply a large packet length and cause spi_read to
write past the end of the allocation?

[Severity: High]
This isn't a bug introduced by this patch, but will this cause a kernel pan=
ic
on error?

In apple_z2_upload_firmware():

    const u8 *data __free(kfree) =3D
        apple_z2_build_cal_blob(z2, address, &size);
    if (IS_ERR(data))
        return PTR_ERR(data);

Since kfree does not check for IS_ERR, doesn't returning here cause the
compiler-inserted kfree(data) to attempt freeing an invalid virtual address?

[Severity: High]
This is a pre-existing issue, but can this sequence lead to data races?

If a hardware interrupt arrives immediately after setting z2->booted to tru=
e,
could the threaded IRQ handler execute apple_z2_read_packet concurrently?

CPU1 in apple_z2_upload_firmware():
    z2->booted =3D true;
    apple_z2_read_packet(z2);

CPU2 in apple_z2_irq():
    ...
    else
        apple_z2_read_packet(z2);

Since apple_z2_read_packet modifies shared state without a lock:

apple_z2_read_packet():
    len_cmd->counter =3D z2->index_parity + 1;
    ...
    z2->index_parity =3D !z2->index_parity;

wouldn't this concurrent execution corrupt z2->tx_buf, z2->rx_buf, and
z2->index_parity?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613-b4-disp-4e=
bcbd68-v2-1-0161acfbd688@proton.me?part=3D1
