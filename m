Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C750B37186A
	for <linux-input@vger.kernel.org>; Wed, 20 May 2026 11:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779278210; cv=none; b=JdWacRb3pRiG4slv1A2BocUOAcb0Z0z2ihfo8ht6ABo/zlO7mj/eacxa6PRx0aZiqGY0YZp5/exM8qWs61QP7OwgFRBuSAdPVLDizelBOfEl27UNLCEf+y6MsJ/aFpEUiQj8L3/iXXFzRIuR9GYzavAjiazqXiaxMu8242tJhRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779278210; c=relaxed/simple;
	bh=i8jSDBGS95vi5q2Aj7ErzELk5HdzHgx8P0qfO2Ia6do=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rur94YYYQ5erQ2bDccBF5uT5NoyMxp435naZLZOU+qOo9iSwn6E+MBZxFGFJt1yFWqjIkbm0ogwoa2UlASXb9gxx9rB8qZb7IvrY1VL6mONlrzTix0uJi3DeU0x6g5XlROvV6pXx0mUPai9wRtFhDeGxTslTHr61S0UBhZ12Vgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLw00lSJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLw00lSJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B7A1F000E9;
	Wed, 20 May 2026 11:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779278209;
	bh=ZvOjeDRkcl14EsfUXf+deH7iaUWG0Zv+KxCgXXiI6KU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oLw00lSJEDA8Wryt23gn1hz2G9a1PxOcee+M+CZ9yoRMeFaxHOw1kq422kranl8mU
	 z/Jum9qfj03cgeql8AU6wNVO3Q9VK7dbeviGAfVDEN916eHROoJkf21FLnJVYikgtY
	 l2DC4QxfzQcCygKVehIP25XPF7k1rt0kJDqFXyIkcxBsSj7Bn8A8bDZZzuoDs4M+9u
	 qdt2wju3YqqdHMBHRWlZITHBZzilzghOyLyauGrHLNdyif3yonuACbP7wiv9egyjkP
	 8EPb2vfkByhyIT/PV6pkG3LG+TVGXatBGEe3WpxZm8eoEdDfQzoy/dxbwmW9i0rjbz
	 MSM9WZIlMYdPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 7.0-5.10] HID: mcp2221: fix OOB write in
 mcp2221_raw_event()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260520111944.3424570-25-sashal@kernel.org>
References: <20260520111944.3424570-25-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 11:56:48 +0000
Message-Id: <20260520115649.49B7A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The patch introduces `mcp->rxbuf_size` to prevent Out-of-Bounds (O=
OB) writes but fails to initialize it in `mcp_smbus_xfer()` for block opera=
tions.

Pre-existing issues:
- [High] The `mcp->rxbuf` pointer is never cleared after an I2C/SMBus trans=
fer completes or times out, leaving a dangling pointer that can be exploite=
d.
- [High] The `mcp2221_raw_event()` handler ignores the `size` parameter pro=
vided by the HID subsystem, leading to out-of-bounds reads on the kernel he=
ap.
- [High] A data race exists between the I2C transfer context and the HID ra=
w event context, which accesses `rxbuf` state variables without synchroniza=
tion.
--

commit 161d8d13687380796daedd1f35b98269619cd589
Author: Florian Pradines <florian.pradines@gmail.com>

HID: mcp2221: fix OOB write in mcp2221_raw_event()

mcp2221_raw_event() copies device-supplied data into mcp->rxbuf at offset
rxbuf_idx without verifying that the copy fits within the destination buffe=
r.
A device responding with up to 60 bytes to a small I2C/SMBus read can overf=
low
this buffer. This patch adds an rxbuf_size field to struct mcp2221 and chec=
ks
rxbuf_idx + data[3] <=3D rxbuf_size before performing the copy.

> diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
> index ef3b5c77c38e3..badd4958bc12c 100644
> --- a/drivers/hid/hid-mcp2221.c
> +++ b/drivers/hid/hid-mcp2221.c
[ ... ]
> @@ -323,12 +324,14 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
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

[Severity: High]
Does this overlook updating mcp->rxbuf_size for block operations in
mcp_smbus_xfer()?

In mcp_smbus_xfer(), mcp->rxbuf is manually assigned for block reads without
updating mcp->rxbuf_size:

drivers/hid/hid-mcp2221.c:mcp_smbus_xfer() {
...
	case I2C_SMBUS_BLOCK_DATA:
		if (read_write =3D=3D I2C_SMBUS_READ) {
...
			mcp->rxbuf_idx =3D 0;
			mcp->rxbuf =3D data->block;
...
}

If rxbuf_size is 0, the new bounds check in mcp2221_raw_event() will always
fail, breaking legitimate SMBus block reads. If rxbuf_size holds a large st=
ale
value from a prior transfer, the check might pass and still allow an overfl=
ow
on the data->block stack buffer.

>  	}
> =20
>  	ret =3D mcp_send_data_req_status(mcp, mcp->txbuf, 4);
[ ... ]
> @@ -912,6 +915,10 @@ static int mcp2221_raw_event(struct hid_device *hdev,
>  					mcp->status =3D -EINVAL;
>  					break;
>  				}
> +				if (mcp->rxbuf_idx + data[3] > mcp->rxbuf_size) {
> +					mcp->status =3D -EINVAL;
> +					break;
> +				}

[Severity: High]
This is a pre-existing issue, but does mcp2221_raw_event() ignore the size
parameter provided by the HID subsystem?

The driver unconditionally accesses data bytes like data[3], and later copi=
es
data[3] bytes starting from &data[4], without verifying the actual length of
the received HID report buffer. If a malicious device provides a small repo=
rt
size, could reading or copying these bytes result in out-of-bounds reads on
the kernel heap?


[Severity: High]
This isn't a bug introduced by this patch, but is there a data race between
the I2C transfer context and the HID raw event context?

While mcp_i2c_smbus_read() and mcp_smbus_xfer() update mcp->rxbuf,
mcp->rxbuf_size, and mcp->rxbuf_idx while holding mcp->lock,
mcp2221_raw_event() runs asynchronously in the HID input report context and
accesses these variables without acquiring the lock.

If a stray or malicious USB report arrives concurrently with a new I2C read
request, could the state become desynchronized and lead to an out-of-bounds
write?

>  				buf =3D mcp->rxbuf;

[Severity: High]
This is a pre-existing issue, but is the mcp->rxbuf pointer left dangling
after a transfer completes or times out?

During transfers, mcp->rxbuf points to a caller-provided buffer which is of=
ten
allocated on the kernel stack. When a transfer times out, the stack frame is
popped, but mcp->rxbuf still points to the now-invalid stack address.

If a delayed or spurious USB report arrives later, could mcp2221_raw_event()
copy device-controlled data into this stale pointer and corrupt the kernel
stack?

>  				memcpy(&buf[mcp->rxbuf_idx], &data[4], data[3]);
>  				mcp->rxbuf_idx =3D mcp->rxbuf_idx + data[3];
>  				mcp->status =3D 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520111944.3424=
570-25-sashal@kernel.org?part=3D1
