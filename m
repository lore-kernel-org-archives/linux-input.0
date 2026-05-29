Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116862472AF
	for <linux-input@vger.kernel.org>; Fri, 29 May 2026 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064827; cv=none; b=fuCXwlG6S3+Waemo01sngNlVxJnwQsouW5YyXvkoZProwgaerIGuk12nBJ1pUaO/5QjwsTLUdL15tNXUcPBG0NXuNrAHYiCW7j9M2DrezSXj4ZK8itY2DS58S14Hy06w7kVuK6Mgy6uyS8cz0T6VikBoKIoXHLrU6IA86tcR5ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064827; c=relaxed/simple;
	bh=RU4Rq0SG3Zhe6lGlAFHSkeYc4kSIsAudXRUVemRoaHc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FCRb6nkZI6jmlFy8uHOo1f9xp5Wk3Pbof0iVG7X4vB9X5vhHj9tnfkjNfMSWUtlvbkvEIUIcJwmm85cO43ceokAosnQSBGwXM8sB3k93AkcD0uC0WLwQEU4Vp/XOPFeamm1m8Or8uqaIoA/Mh4wlDT6Z1AyVnqjn7n+6Cz+LpLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcUj9ktz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcUj9ktz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A030B1F00893;
	Fri, 29 May 2026 14:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780064825;
	bh=mLt4XrZM77hq3TeWZnk89hXw9/wtiCUij+4l1E3RjNI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UcUj9ktzVKHFgUpnXRDI4AZlyb/Amq0zTizuLw5+UJP6e3fkWxIIJYGv4tW6t+O9j
	 97ZCe8q5Oob10tk0fjLZukZwhaCsF0loJsSDb73WdhFn6BYloB/Jp+tGaBcsNO6EVG
	 NaXDhYLXZdECWxcjWxZTmj28iSgsNh1uEBNBxx7ZMz29H4hvKpF2FnewiP6GbPcFEc
	 3WzFGMbKvSP3wqLpEV8VRyU++GbWDgUEgE1TXzAVwcrsoIc+Ku7yTdyNV3O/dxD1QN
	 yeNEQcOghQHqaAm6B3TLdgNNOgV6ZIys/KvkQgjgYTDM8Cbm7DeVvXP9QC2Vw+01EO
	 rAKh3F10rVdjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: hid-goodix-spi: validate report size to prevent
 stack buffer overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tianchu Chen" <tianchu.chen@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <f7e444a3facbe5fb2627167ab205771476e46bc8@linux.dev>
References: <f7e444a3facbe5fb2627167ab205771476e46bc8@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 14:27:05 +0000
Message-Id: <20260529142705.A030B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [Medium] The patch artificially caps SET_REPORT payload size to a 128-byt=
e stack buffer, potentially breaking legitimate large HID reports.

Pre-existing issues:
- [High] Concurrent reallocation of `ts->event_buf` in `goodix_hid_start` a=
nd access in `goodix_hid_irq` leads to a Use-After-Free.
- [Medium] Uninitialized kernel memory is transmitted over the SPI bus duri=
ng read operations.
- [Medium] The driver performs SPI reads and writes without verifying the h=
ardware suspend state.
- [Medium] In `goodix_spi_resume()`, the IRQ is enabled before the device i=
s powered on.
- [Medium] Unsafe assignment of `devm_krealloc` directly to the buffer poin=
ter causes a device-lifetime memory leak.
--

commit a3440b67c988b5226da753835060ad3d93591c74
Author: Tianchu Chen <flynnnchen@tencent.com>
Subject: HID: hid-goodix-spi: validate report size to prevent stack buffer =
overflow

This commit adds a bounds check in goodix_hid_set_raw_report() to ensure th=
at
the constructed protocol frame does not exceed the size of the 128-byte sta=
ck
buffer tmp_buf. If a caller supplies a report that exceeds this limit, the
function now returns -EINVAL to prevent a stack buffer overflow.

> diff --git a/drivers/hid/hid-goodix-spi.c b/drivers/hid/hid-goodix-spi.c
> index 80c0288a3a38b..288cb827e9d6d 100644
> --- a/drivers/hid/hid-goodix-spi.c
> +++ b/drivers/hid/hid-goodix-spi.c
> @@ -520,6 +520,9 @@ static int goodix_hid_set_raw_report(struct hid_devic=
e *hid,
>  	memcpy(tmp_buf + tx_len, args, args_len);
>  	tx_len +=3D args_len;
> =20
> +	if (tx_len + len > sizeof(tmp_buf))
> +		return -EINVAL;

[Severity: Medium]
Does returning `-EINVAL` here artificially cap the SET_REPORT payload size?
If the device's HID report descriptor defines larger output or feature repo=
rts
(e.g., for firmware updates or configuration), would this fix block them?
Could we dynamically allocate a buffer of adequate size or use the already
available 2KB `ts->xfer_buf` instead of relying on a hardcoded stack limit?

> +
>  	memcpy(tmp_buf + tx_len, buf, len);
>  	tx_len +=3D len;
> =20

[Severity: High]
This is a pre-existing issue, but is there a use-after-free risk with
`ts->event_buf` between `goodix_hid_irq()` and `goodix_hid_start()`?

If the HID driver is unbound and rebound, `goodix_hid_start()` will execute
`devm_krealloc()`, freeing the old `ts->event_buf`:

drivers/hid/hid-goodix-spi.c:goodix_hid_start() {
    ...
	ts->event_buf =3D devm_krealloc(ts->dev, ts->event_buf,
                                  report_size, GFP_KERNEL);
    ...
}

Meanwhile, if `goodix_hid_close()` clears the `GOODIX_HID_STARTED` flag but
does not synchronize with the threaded IRQ, a preempted IRQ handler can pass
the flag check and then use the now-freed `ts->event_buf`:

drivers/hid/hid-goodix-spi.c:goodix_hid_irq() {
    ...
	if (!test_bit(GOODIX_HID_STARTED, &ts->flags))
		return IRQ_HANDLED;
    ...
	event =3D goodix_get_event_report(ts, ts->hid_report_addr, ts->event_buf,
					GOODIX_HID_ACK_HEADER_SIZE +
					GOODIX_HID_COOR_PKG_LEN);
    ...
}


[Severity: Medium]
This is a pre-existing issue, but does assigning the result of
`devm_krealloc()` directly to `ts->event_buf` cause a memory leak if it fai=
ls?

drivers/hid/hid-goodix-spi.c:goodix_hid_start() {
    ...
	ts->event_buf =3D devm_krealloc(ts->dev, ts->event_buf,
                                  report_size, GFP_KERNEL);
    ...
}

If `devm_krealloc()` returns `NULL`, the original memory chunk remains in t=
he
`devres` list, but the pointer in `ts->event_buf` is overwritten. Subsequent
re-binds would allocate a new devres chunk instead of reusing the old one,
accumulating leaked chunks until the SPI device is unbound.


[Severity: Medium]
This is a pre-existing issue, but does this transmit uninitialized kernel
memory over the SPI MOSI line during read operations?

In `goodix_get_event_report()`, `ts->event_buf` is used as the transaction
buffer, and it is allocated with `devm_kmalloc()` (which doesn't zero memor=
y).
The first 5 bytes are initialized, but the dummy bytes and read payload
section are left uninitialized:

drivers/hid/hid-goodix-spi.c:goodix_get_event_report() {
    ...
	data[0] =3D GOODIX_SPI_READ_FLAG;
	put_unaligned_be32(addr, data + GOODIX_SPI_TRANS_PREFIX_LEN);

	spi_message_init(&spi_msg);
	memset(&xfers, 0, sizeof(xfers));
	xfers.tx_buf =3D data;
	xfers.rx_buf =3D data;
	xfers.len =3D GOODIX_SPI_READ_PREFIX_LEN + len;
    ...
}

Because `xfers.tx_buf` is provided for the entire transfer length, is the
uninitialized memory sent to the hardware during the dummy and read phases,
resulting in an information leak?


[Severity: Medium]
This is a pre-existing issue, but does `goodix_hid_raw_request()` perform S=
PI
operations without verifying the hardware suspend state?

drivers/hid/hid-goodix-spi.c:goodix_hid_raw_request() {
    ...
	guard(mutex)(&ts->hid_request_lock);
	switch (reqtype) {
	case HID_REQ_GET_REPORT:
		error =3D goodix_hid_get_raw_report(hid, reportnum, buf,
						  len, rtype);
		break;
	case HID_REQ_SET_REPORT:
		if (buf[0] =3D=3D reportnum)
			error =3D goodix_hid_set_raw_report(hid, reportnum,
							  buf, len, rtype);
		break;
    ...
}

If a request is issued while the device is in the `GOODIX_SPI_POWER_SLEEP`
state, the driver will directly perform SPI read/write operations on the
powered-down hardware. Could this cause timeouts or undefined hardware stat=
es?


[Severity: Medium]
This is a pre-existing issue, but should the IRQ be enabled before the devi=
ce
is powered on during resume?

drivers/hid/hid-goodix-spi.c:goodix_spi_resume() {
    ...
	enable_irq(ts->spi->irq);
	return goodix_spi_set_power(ts, GOODIX_SPI_POWER_ON);
}

If a spurious interrupt or power-on glitch asserts the IRQ line while the
device is still in the sleep state, the interrupt handler will execute and
attempt to perform SPI reads on the waking hardware. Would it be safer to
bring the device to an active power state before unmasking its interrupts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/f7e444a3facbe5fb262=
7167ab205771476e46bc8@linux.dev?part=3D1
