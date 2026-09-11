Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB97390C9F;
	Fri, 11 Sep 2026 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140412; cv=none; b=L61CLjyO/CHM63MZAxSLl5bRvq0Bb4fkfExH4BmtUklhwlIXpv0bRjUvl9RHII/xzyNhxKzHqUfhnDjLrywShIYbRZXWV3JaQOzRLgt0rqXi3eV2sCtmhoqXQJRk8feLSMnm+M3FNj7Z8cnmwzT7i3Vl/o8c5gPqzPhrWf7qOhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140412; c=relaxed/simple;
	bh=YDfjV29aJR2yjlIoLA/atnb+Wx4m9ycysJR0KnTq94M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dDDcMvNqpGIjuNqyHrAli5iJ4YYvUpf0oSN1z6A2Z2LV1a3klQRoaLhVRDEevaAoRY3YxmkOp9hwY1wU/BdzwoRz4hhpKIM9wYD6zpGQPgkCmhA/CkfIcrGpwRPV7mK99hYz5kYlx2e85BqIN6/dmz3as8XUO4zLhtfhgTITcH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkRw56Ni; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkRw56Ni"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6761F000FF;
	Fri, 11 Sep 2026 15:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789140407;
	bh=Kqs+tKIK4x9zxmfZl2WRfAESTvS07buUQh3qtdMKj1g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WkRw56NidMW0DXY6bAvSMlB6zt+0qsUtXWUAN50jEg6p8lIxqGTGSoQHAxftRmhst
	 4y6bT4TR9X7JC6e/uZJop/F/IGnpLsXQojPe2q+3mcp9CCd3AJHYTjyPg9HoyWs4ce
	 5ucBUqNPh0ISBcAISGeHyhV9BmLva8n20CBCxzTJVHKbqKTKPwUNM/91JeTAlHDVaf
	 gdZOgYoD42OqAeV/TORluEeKsP1GH4hqOSnTThx2Vxm6vE7A9RC/6pfgIHsZfb0LM0
	 pQy2W1a/3T+1sPvRIW8/3sMprsyd+0tGpEBelUNf7T4y5QF+6lS0VRHA/8BNoyyeat
	 yw2OWabN/3GCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] Input: Add driver for ESWIN EPH8621 touchscreen IC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Weiss" <luca.weiss@fairphone.com>
Cc: dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, robh@kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260911-eswin-eph8621-v1-2-db447ff9e445@fairphone.com>
References: <20260911-eswin-eph8621-v1-0-db447ff9e445@fairphone.com>
 <20260911-eswin-eph8621-v1-2-db447ff9e445@fairphone.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 15:26:46 +0000
Message-Id: <20260911152647.0C6761F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Double-fetch / TOCTOU vulnerability in packet length parsing allow=
s massive out-of-bounds read and an infinite loop.
- [High] Missing length validation before parsing contact events leads to h=
eap out-of-bounds reads.
- [Medium] Overlapping memory regions in memcpy() due to identical source a=
nd destination pointers.
- [Medium] Unvalidated slot ID silently corrupts input multi-touch state fo=
r valid contacts.
--

commit 6fa34851ae5b4f1c363bd77f86f1478eb5ce13e6
Author: Luca Weiss <luca.weiss@fairphone.com>

Input: Add driver for ESWIN EPH8621 touchscreen IC

Adds a driver for the ESWIN EPH8621 touchscreens connected via SPI.

> diff --git a/drivers/input/touchscreen/eswin_eph8621.c b/drivers/input/to=
uchscreen/eswin_eph8621.c
> new file mode 100644
> index 0000000000000..12b90cc89052e
> --- /dev/null
> +++ b/drivers/input/touchscreen/eswin_eph8621.c
[ ... ]
> static int eswin_spi_read(struct eswin_touch *ts, u16 len, u8 *buf)
> {
> 	struct spi_device *spi =3D to_spi_device(ts->dev);
> 	struct spi_transfer xfer =3D {
> 		.tx_buf =3D ts->tx_buf,
> 		.rx_buf =3D ts->rx_buf,
> 		.len =3D len,
> 	};
> 	int error;
>=20
> 	if (len > ESWIN_COMMS_BUF_SIZE)
> 		return -EINVAL;
>=20
> 	/* ESWIN requires 0xFF dummy bytes clocked out to read data */
> 	memset(ts->tx_buf, 0xFF, len);
> 	error =3D spi_sync_transfer(spi, &xfer, 1);
> 	if (error)
> 		return error;
>=20
> 	memcpy(buf, ts->rx_buf, len);

[Severity: Medium]
Is this memcpy() safe from overlapping memory regions?

Looking at eswin_interrupt(), it passes ts->rx_buf as the buf argument to
eswin_comms_two_stage_read(), which subsequently passes it to this function:

eswin_interrupt() {
        error =3D eswin_comms_two_stage_read(ts, ts->rx_buf);
...

This means buf and ts->rx_buf point to the exact same memory address. Since
the SPI transfer writes data directly into ts->rx_buf, does this memcpy()
trigger undefined behavior due to the identical source and destination
pointers?

[ ... ]
> static void eswin_report_contact(struct eswin_touch *ts, u8 *payload)
> {
> 	u8 touch_type =3D (payload[0] & EVENT_REPORT_TYPE_MASK) >> EVENT_REPORT_=
TYPE_OFFSET;
> 	u8 slot =3D payload[1];

[Severity: Medium]
Is the slot ID extracted from the device payload validated anywhere before
use?

If the hardware reports an invalid slot index (e.g., slot >=3D
ESWIN_MAX_TOUCHES), input_mt_slot() safely ignores it, leaving the active
mt->slot unchanged. However, the subsequent code unconditionally proceeds
to report X/Y coordinates and touch properties.

Could this cause the driver to apply malformed event data to the
previously active, valid slot, corrupting the multi-touch state?

[ ... ]
> static void eswin_process_report(struct eswin_touch *ts, u8 *buf)
> {
> 	u16 total_len =3D buf[TLV_LENGTH_FIELD] | (buf[TLV_LENGTH_FIELD + 1] << =
8);

[Severity: High]
Does this recalculation introduce a double-fetch vulnerability?

The SPI controller initially reads the 3-byte header into ts->rx_buf and
safely validates payload_len. However, the second SPI transfer in
eswin_comms_two_stage_read() overwrites ts->rx_buf with the full packet.

Here, total_len is blindly recalculated from this newly fetched, unvalidated
header data. If a glitchy or malicious device provides a valid length for
the first read and a huge length (e.g., 0xFFFF) for the second, total_len
is set to an unchecked value.

> 	u16 offset =3D TLV_HEADER_SIZE;
>=20
> 	if (buf[TLV_TYPE_FIELD] !=3D TLV_REPORT_DATA)
> 		return;
>=20
> 	while (offset < total_len + TLV_HEADER_SIZE) {

[Severity: High]
Can this loop condition result in an infinite loop and out-of-bounds reads?

If total_len was manipulated by the double-fetch issue above to be 0xFFFF,
total_len + TLV_HEADER_SIZE becomes 65538. Since offset is a u16, it can
never reach 65538, causing the condition to evaluate to true forever.

> 		u8 ev_len =3D buf[offset] & EVENT_REPORT_LENGTH_MASK;
>=20
> 		eswin_report_contact(ts, &buf[offset]);

[Severity: High]
Can this function call trigger an out-of-bounds heap read?

The loop verifies that offset is less than the packet end, but does not
check if at least 8 bytes remain to safely parse a full contact event.

If offset is near the end of the 3072-byte buffer (e.g., offset =3D 3070),
eswin_report_contact() unconditionally reads up to payload[7] for the
height, which reads past the end of the heap allocation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-eswin-eph8=
621-v1-0-db447ff9e445@fairphone.com?part=3D2
