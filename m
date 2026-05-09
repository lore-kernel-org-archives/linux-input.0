Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A602F8E8A
	for <linux-input@vger.kernel.org>; Sat,  9 May 2026 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778322988; cv=none; b=oX5YUqQnKPSDG59ITDgO5c72x4+Qi4DOXxRGpKNetAmPLtGjTl9/48hNBjj++cr6FwcBbIbAgYb6utJYZDHWo+wpZGdVNvF51t83UP+48d3twHNfOhcj3V/CL5GXoCyaoxNtPulrr9uBv0ncnebLwPh3qw4Y6kt78KgWr2Utn9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778322988; c=relaxed/simple;
	bh=IGCLS6xpr+/8KUB9mGkyP/zPyaYg5p/dfxzTCklEaDM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jPEvgK9onK4ryyGWtDlrJJ6SBG4MaDvxmSvQJr03C6rObiyrr0C3jY8nZ65AkJh6vgLJdDQafcnLMVbtYNa33OA6hZG3tJPSKnjqsJ6ToKOzm16IhwTuUNBObAuBChrEBpxA9UUMDts4VvnA3men0xt91PQgTLO+5zd3ILzj3aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLKDpEQx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLKDpEQx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC90C2BCB2;
	Sat,  9 May 2026 10:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778322987;
	bh=IGCLS6xpr+/8KUB9mGkyP/zPyaYg5p/dfxzTCklEaDM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cLKDpEQxXF6f/00pQUD+hkRvi9MW619yKJGjZy3cS1nwlU+Ru/VYwut93v6ZZNhvw
	 NJFfHolQmjSwe2aPaLQnqubAZv2Ryo0omDAy6tT0EQ3nr9eSvsF+GN/2Mv6B3YAlfc
	 ln/9yXtZp29Tf38LkaUfVhZ1hBbU7MRNBIuJjaD7NYaHCVa7VCPmV3VEV1mb9Sp42a
	 TOC8o+kvpK8dEXtAhleWUlt5bosRVxtfAPLCkFti5SyA8+6JKdxj1Rg6GxG39ufBgs
	 Wus3kvM67teQiJdNyCHeJKeFCN2XCBDD92EMflAncWCdisora0RbPpJ4IelC+J75pM
	 hzSXjP0lmHzVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: mcp2221: fix OOB write in mcp2221_raw_event()
Reply-To: sashiko@lists.linux.dev
To: "Florian Pradines" <florian.pradines@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260509094517.2691246-1-florian.pradines@gmail.com>
References: <20260509094517.2691246-1-florian.pradines@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 10:36:26 +0000
Message-Id: <20260509103627.8AC90C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] The patch adds a size bound but leaves a dangling pointer in `=
mcp->rxbuf` when a read times out, resulting in a Use-After-Free.
- [High] Unsynchronized updates to `mcp->rxbuf` and `mcp->rxbuf_size` allow=
 an attacker to bypass the new bounds check completely, causing an Out-Of-B=
ounds (OOB) write.
- [High] The patch fails to prevent stack buffer overflows for `I2C_SMBUS_B=
LOCK_DATA` reads because it bases `mcp->rxbuf_size` on uninitialized stack =
memory.
- [High] The raw event handler blindly accesses payload data without valida=
ting against the actual received HID report size, leading to out-of-bounds =
kernel heap reads.
--

commit 2cea5cadcf6c54079354cc3c519d5621e3b06d74
Author: Florian Pradines <florian.pradines@gmail.com>

HID: mcp2221: fix OOB write in mcp2221_raw_event()

This commit attempts to fix an out-of-bounds write in mcp2221_raw_event()
by adding a rxbuf_size field. It sets this field alongside rxbuf in
mcp_i2c_smbus_read() and validates the incoming data length against it
before copying.

> diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
> index be80970ab48e2..e4ddd8e9293b6 100644
> --- a/drivers/hid/hid-mcp2221.c
> +++ b/drivers/hid/hid-mcp2221.c
[ ... ]
> @@ -330,12 +331,14 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
>  		mcp->txbuf[3] =3D (u8)(msg->addr << 1);
>  		total_len =3D msg->len;
>  		mcp->rxbuf =3D msg->buf;
> +		mcp->rxbuf_size =3D msg->len;
>  	} else {
>  		mcp->txbuf[1] =3D smbus_len;
>  		mcp->txbuf[2] =3D 0;
>  		mcp->txbuf[3] =3D (u8)(smbus_addr << 1);
>  		total_len =3D smbus_len;
>  		mcp->rxbuf =3D smbus_buf;
> +		mcp->rxbuf_size =3D smbus_len;

Does this code fail to prevent stack buffer overflows for
I2C_SMBUS_BLOCK_DATA reads?

In i2c_smbus_read_block_data(), the i2c_smbus_data union is allocated
on the stack but its first byte (data.block[0]) is not initialized before
the read. In mcp_smbus_xfer(), the driver uses data->block[0] + 1 to
determine the read length, which is then assigned here to mcp->rxbuf_size.

If this uninitialized stack memory contains a large value (e.g., 255), the
new bounds check will pass for large responses, and memcpy can write past
the 34-byte data->block array, overflowing the stack.

Also, are these updates to mcp->rxbuf and mcp->rxbuf_size safe from
concurrent access?

These are updated non-atomically in process context, while
mcp2221_raw_event() runs asynchronously.

If a previous read timed out leaving rxbuf_idx =3D 0 and rxbuf_size =3D 60,
could a late 60-byte response arrive just after mcp->rxbuf is assigned a new
2-byte buffer but before mcp->rxbuf_size is updated to 2?

This would cause the event handler to read the old rxbuf_size (60), pass the
check, and copy 60 bytes into the 2-byte buffer, bypassing the protection.

>  	}
> =20
>  	ret =3D mcp_send_data_req_status(mcp, mcp->txbuf, 4);

If mcp_send_data_req_status() times out, it returns -ETIMEDOUT without
setting mcp->rxbuf to NULL.

If the caller then frees or pops the buffer, and a delayed or malicious
MCP2221_I2C_GET_DATA report is processed by mcp2221_raw_event(), could this
result in a use-after-free?

Since rxbuf is not NULL and rxbuf_idx < rxbuf_size, the new check passes,
and memcpy would write data directly into the freed memory.

[ ... ]
> @@ -919,6 +922,10 @@ static int mcp2221_raw_event(struct hid_device *hdev,
>  					mcp->status =3D -EINVAL;
>  					break;
>  				}
> +				if (mcp->rxbuf_idx + data[3] > mcp->rxbuf_size) {
> +					mcp->status =3D -EINVAL;
> +					break;
> +				}
>  				buf =3D mcp->rxbuf;
>  				memcpy(&buf[mcp->rxbuf_idx], &data[4], data[3]);

This isn't a regression from this patch, but does the raw event handler
blindly access payload data without validating against the actual received
HID report size?

The mcp2221_raw_event() function receives a size parameter representing the
length of the HID report but ignores it.

If a malicious USB device presents a HID report descriptor with a small
maximum report size (e.g., 4 bytes), the HID core will allocate a 4-byte
buffer.

If the device then sends data[3] =3D 60, this memcpy will read 60 bytes past
the end of the 4-byte kernel heap buffer, potentially leaking adjacent
kernel memory to user-space.

>  				mcp->rxbuf_idx =3D mcp->rxbuf_idx + data[3];

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260509094517.2691=
246-1-florian.pradines@gmail.com?part=3D1
