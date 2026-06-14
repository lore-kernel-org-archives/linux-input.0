Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D03C1F03DE
	for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 00:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781395648; cv=none; b=N8dK/GNM42Nmwqip8t0tRYMqT+vuSScruC6Xx1P6c7CN/ZP9T86EZPgXNXqku5DLbRGR1nDjdS4Gc/wwY+FmJX45oLJ5OmWT/77MnQ+WD3qhljXF8BMHeA9EB4s2b5XCeZckR+dQalBVTPcagr0+y9wMQI7tvTg+9I+hu5OK1NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781395648; c=relaxed/simple;
	bh=1AcgHkxFwcLbm7cCzQ1BDPUklF3DxaIpMN8WlrZ9fZk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KG4kgZu2c6LJgMwmFdtY+WwEWh0jJ5tfC+mHKBDfroEodcxBCH+wLGaPttWYWnUsJVm0AHvP1BfixFmWWo2kGiiW9ItPzquWM11WThBLBoBPH5yQ4jbX6dY2PpRA1QsRrmjteeJvbhAiC7EaZ/fcm/qX6tsZvRkb8bkmkj+odks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFD7aSap; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFD7aSap"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8D11F000E9;
	Sun, 14 Jun 2026 00:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781395645;
	bh=I4LFtvDtnRPK658lLecS6ToALUfnbZIHTOlL0rvbffs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UFD7aSapxz3QBvkGZeJNHTpHVxYQkm7hPm2S9I7JfGMCNDDlG1uSDWYQDwQ2Un7hZ
	 +fw1XOop5vy+1ZX9y36YgfgbI0gTnHiRjp02ATNosc623OvYdTPlCTlN5gsQfGhLYv
	 iCwCaeI7MMSt/6eM9y99eWu+fgbzFWHjetDjQMdIAGy+cQM1G5ftN1KRRBcyLzqb+3
	 qKeKpa6eNBKtgxlkHgVrdRrkzZrJQzinwXDo/iA8GpoP+cFRSc08hkOySVeeID/JFa
	 LeCvsbHm3ir7mJI9zHqMF7lVGoKqkUeVfMdcfPYu4uFRVCecIVLpWLTFH2ArqAQFf6
	 WBkhhrOLWGMNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: apple_z2 - bound the device-reported finger
 count
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas via B4 Relay" <devnull+hexlabsecurity.proton.me@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260613-b4-disp-f0148c89-v1-1-868a48b2a187@proton.me>
References: <20260613-b4-disp-f0148c89-v1-1-868a48b2a187@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2026 00:07:24 +0000
Message-Id: <20260614000725.6B8D11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch incorrectly discards valid zero-finger reports, resultin=
g in stuck touches.

Pre-existing issues:
- [Critical] Unbounded device-reported packet length leads to a massive hea=
p buffer overflow during `spi_read()` and completely bypasses the patch's i=
ntended fix for out-of-bounds reads.
--

commit 3a1e80d03b931df0a0db172ea0ca1a4ea3349e47
Author: Bryam Vargas <hexlabsecurity@proton.me>

Input: apple_z2 - bound the device-reported finger count

This commit attempts to fix a heap out-of-bounds read by bounding the number
of reported fingers against the message length.

Link: https://lore.kernel.org/all/20260613215358.329921F000E9@smtp.kernel.o=
rg/

> diff --git a/drivers/input/touchscreen/apple_z2.c b/drivers/input/touchsc=
reen/apple_z2.c
> index 271ababf0ad55..61f353553e7c5 100644
> --- a/drivers/input/touchscreen/apple_z2.c
> +++ b/drivers/input/touchscreen/apple_z2.c
> @@ -88,10 +88,13 @@ static void apple_z2_parse_touches(struct apple_z2 *z=
2,
>  	int slot_valid;
>  	struct apple_z2_finger *fingers;
> =20
> -	if (msg_len <=3D APPLE_Z2_NUM_FINGERS_OFFSET)
> +	if (msg_len <=3D APPLE_Z2_FINGERS_OFFSET)
>  		return;

[Severity: High]
Will this new check discard valid zero-finger reports?

With SPI length rounding, an empty report indicating all fingers have been
lifted usually lacks the finger array, meaning its payload size can fall
between 17 and 24 bytes.

If a 0-finger packet is dropped here, the input subsystem won't be notified
via input_mt_sync_frame() and input_sync(). Could this result in touches
remaining stuck on the screen?

>  	nfingers =3D msg[APPLE_Z2_NUM_FINGERS_OFFSET];
>  	fingers =3D (struct apple_z2_finger *)(msg + APPLE_Z2_FINGERS_OFFSET);
> +	/* a malicious controller can claim more fingers than the packet holds =
*/
> +	nfingers =3D min_t(int, nfingers,
> +			 (msg_len - APPLE_Z2_FINGERS_OFFSET) / sizeof(*fingers));

[Severity: Critical]
This isn't a bug introduced by this patch, but does deriving msg_len from
the untrusted packet length bypass this new boundary check entirely?

In apple_z2_read_packet(), pkt_len is derived directly from an
unauthenticated SPI read:

apple_z2_read_packet() {
        ...
        pkt_len =3D (get_unaligned_le16(z2->rx_buf + 1) + 8) & 0xfffffffc;
        error =3D spi_read(z2->spidev, z2->rx_buf, pkt_len);
        ...
}

Since z2->rx_buf is a fixed 4000-byte allocation, a malicious controller
could send a large length field (up to 65540) to cause a heap buffer
overflow during spi_read().

Furthermore, because msg_len is derived directly from this untrusted
pkt_len, an artificially large pkt_len bypasses the new clamping logic
above. This allows nfingers to still evaluate to 255.

Does this render the out-of-bounds read fix ineffective against malicious
controllers?

>  	for (i =3D 0; i < nfingers; i++) {
>  		slot =3D input_mt_get_slot_by_key(z2->input_dev, fingers[i].finger);
>  		if (slot < 0) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613-b4-disp-f0=
148c89-v1-1-868a48b2a187@proton.me?part=3D1
