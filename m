Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E47145D1AA
	for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 15:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821172; cv=none; b=d4kKEd2ExO7eeQE6rz5mDWHzrDhvZjNA+5pMJTsSoS3mW6jqlmJDlGJD082KhzXvw0Z8DXYvvR7X0v88ZiH80WUOeiAm32wXj6Zq1FYUOSmET8nIcR4iY3eEvAwp0V2PKE7zI9TcJNYR0rFAym8uOstFBaQSgDq0V71jYsb+OAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821172; c=relaxed/simple;
	bh=Hh0Uw2l0bpw3R+potB9CniXW5SjHBPAN2xYew6RM2Xs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OwN38eLHkGcNOTZ0mO0UUn29Wq7aJKpg76862p2LQOcRemim2Sma85OGlN6F6eeJ7Aj3OIynFDo/B5xo0bOQH5HjjLlzpZfza7mwnFftq/udJrWfL6jvM5FPPLNJC+kebNyebO+4PlVzzWfafKG7CBWUR1Ql+3F8+WVkVGrjNks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ef8p+za/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ef8p+za/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F8E1F000E9;
	Thu, 23 Jul 2026 15:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784821170;
	bh=jkhM/5Yqed/MCBRcRWCl2Tw/BshcWne0a9drmwQFJOE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ef8p+za/pWnWUA93k2LDSXhevXNH7GzrwCaYYZvKtu8fVki33e4d7j5g7ZRV7h1HQ
	 OtwtoAKMDc4mruka1loX0psdh4JJ/krvHBhiFmsefieXzXOiDaYEaaysIpMxmEkLQY
	 12hYXFA3xGzqRMpXHHWz4PsITlONvxcxCILdizAHUs7Bid9KmXddpTTZVeqSYHbQ7p
	 NCWAwLF3NJyMgQsLzDzYc6hLLUZmvnAJEA7+QIWae6OoeXRwZhvKk25eTxavW/z9ID
	 /MC0w8i5J01GFaQrNWuCNnWG+dPubmTHRibHHQ8ztS57pH3JG/VWkPtgrOHfI+gjCI
	 wPF61RzE5pMZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] Input: ilitek_ts: handle short I2C transfers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kristian Mide" <kristian@mide.dk>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260723152244.11252-3-kristian@mide.dk>
References: <20260709182602.7308-1-kristian@mide.dk>
 <20260723152244.11252-1-kristian@mide.dk>
 <20260723152244.11252-3-kristian@mide.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 15:39:28 +0000
Message-Id: <20260723153930.12F8E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing IRQ re-enable on error paths in suspend/resume handlers.
- [High] Unsafe DMA Buffer Allocation for I2C transfers (stack variables pa=
ssed to i2c_transfer).
- [High] Data parsing error for multi-touch reporting when more than 10 con=
tacts are present.
--

--- Patch [2]: [PATCH v3 2/3] Input: ilitek_ts: handle short I2C transfers =
---
commit 642c55e3cb3ec68f3ba0fdc9a106d372a6e3c257
Author: Kristian Mide <kristian@mide.dk>

Input: ilitek_ts: handle short I2C transfers

Check that i2c_transfer() returns the expected number of messages in
ilitek_i2c_write_and_read(). Short transfers were previously treated as
success, allowing callers to continue with partially filled buffers.

> diff --git a/drivers/input/touchscreen/ilitek_ts_i2c.c b/drivers/input/to=
uchscreen/ilitek_ts_i2c.c
> index 86975fa9a0940..a184d024d6c4f 100644
> --- a/drivers/input/touchscreen/ilitek_ts_i2c.c
> +++ b/drivers/input/touchscreen/ilitek_ts_i2c.c
> @@ -131,11 +131,15 @@ static int ilitek_i2c_write_and_read(struct ilitek_=
ts_data *ts,
>  		error =3D i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));

[Severity: High]
This isn't a bug introduced by this patch, but will passing stack buffers to
i2c_transfer() cause memory corruption or kernel panics if the I2C adapter
driver uses DMA?

For example, ilitek_process_and_report_v6() allocates a 512-byte buffer on =
the
stack and passes it down the call chain:

ilitek_process_and_report_v6()
  u8 buf[512];
  ...
  error =3D ilitek_i2c_write_and_read(ts, NULL, 0, 0, buf, 64);

And api_protocol_get_mcu_ver() does something similar:

api_protocol_get_mcu_ver()
  u8 buf[64];
  ...
  error =3D ilitek_i2c_write_and_read(ts, buf, 1, 5, outbuf, 32);

On systems with CONFIG_VMAP_STACK=3Dy, stack pages are not physically
contiguous. Is there a risk of dma_map_single() silently failing or
corrupting memory when mapping these buffers?

>  		if (error < 0)
>  			return error;
> +		if (error !=3D ARRAY_SIZE(msgs))
> +			return -EIO;

[Severity: High]
This is a pre-existing issue, but returning explicitly on short transfers
makes error paths more likely to be triggered. Are we leaking IRQ states in
the suspend and resume routines?

If api_protocol_set_cmd() fails due to this new -EIO return during
ilitek_suspend(), we return early:

ilitek_suspend()
  ...
  if (error)
      return error;

The function returns without re-enabling the interrupt that was disabled at
the start of the function. The PM core aborts the suspend transition and
won't call the resume callback, leaving the device interrupt permanently
disabled.

A similar situation happens in ilitek_resume():

ilitek_resume()
  ...
  if (error)
      return error;

This skips the enable_irq(client->irq) call at the end of the function.
Could this leave the touchscreen permanently unresponsive?

>  	} else {
>  		if (write_len > 0) {
>  			error =3D i2c_transfer(client->adapter, msgs, 1);
>  			if (error < 0)
>  				return error;
> +			if (error !=3D 1)
> +				return -EIO;
>  		}

[ ... ]

> @@ -144,6 +148,8 @@ static int ilitek_i2c_write_and_read(struct ilitek_ts=
_data *ts,
>  			error =3D i2c_transfer(client->adapter, msgs + 1, 1);
>  			if (error < 0)
>  				return error;
> +			if (error !=3D 1)
> +				return -EIO;

[Severity: High]
This is also a pre-existing issue, but does the data parsing loop in
ilitek_process_and_report_v6() calculate offsets correctly when there are
more than 10 contacts?

When report_max_point > 10, the driver fetches subsequent data in 64-byte
chunks. However, the parsing loop calculates offsets linearly assuming a
continuous array:

ilitek_process_and_report_v6()
  for (i =3D 0; i < report_max_point; i++) {
      status =3D buf[i * packet_len + 1] & 0x40;
  ...

For the 11th point (where i =3D 10 and packet_len =3D 5), the offset is 51,=
 which
falls inside the 14-byte padding at the end of the first 64-byte chunk. The
actual data for this point was written to the second chunk starting at
index 64.

Will this cause garbage touch events to be sent to userspace for the 11th
and subsequent fingers?

>  		}
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723152244.1125=
2-1-kristian@mide.dk?part=3D2
