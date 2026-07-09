Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90574DC54B
	for <linux-input@vger.kernel.org>; Thu,  9 Jul 2026 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622257; cv=none; b=iqhQ3kzDVC0ZTIORjyw/eVxudPkhniK16WxzrImj7gFrtaL6AWRB3vONSjOSo/e63szYmpLrscHeDHo6X+173yLOnXdiUe+XWlG57GOpK/TC9YVK5Pl50wSAocGkj7tKNThnxnBVH1XKGEiyqvgyRsx58QquM3xuDlEnFZ4RUM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622257; c=relaxed/simple;
	bh=vtB0SE7N6Lu+f19iMQQjgyWDZwg7/FkmOZsIoMbF7d0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rhepVPi/xObhq6ZK4oq8+LXavH4meboh0jEHFHI8Z98ourMKVmKL8z8EalhkTCZnJWjEVm+lmuCtz4/mmhYwwKlC5/o+rLAUqUxgprkPiSy3a/xtpJ2WaXAysRC2VFXOvvqd79XEDahX9XmdwbTbxLxBkUD+AfBq+579ehES6jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieySe2Xb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieySe2Xb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084DA1F000E9;
	Thu,  9 Jul 2026 18:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783622254;
	bh=Je0wjKnyBqDaJhnxBXjcXVm1F4+S1QU8D9Y3LOpf3u0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ieySe2XbW2jfBlsnY4t0kh5+aUh8l7OWWMRwF14aRU+wbeWfL5tayhgAy43nZlTBY
	 iuFX9Ll0NbGxP31rWdE69CGQirj9Ss4JYUjMbvGt/OwMc1aKT+xhm1D1TNf1THJdqM
	 G7Jf7zO+o8vwSaIs7s5eNyqn75aC38kyHrnPF+iRZJghcB/Fdjg5UsoG0KaRWJu712
	 onPDbpOnMXT+AAZIIsGH/AHh/T0sHyxA++0Zg+tHe+R1An62nOIrMYNRP55HWNnlli
	 hzgh57RVq9B3m4em8wZ8LmMg49dtCrvajJYQp62K2ZGAK2PXPFbOpbuxf9RaqTwlXS
	 CXtEezQ0KqdlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] Input: ilitek_ts: handle short I2C transfers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kristian Mide" <kristian@mide.dk>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260709182602.7308-3-kristian@mide.dk>
References: <20260626214248.5563-1-kristian@mide.dk>
 <20260709182602.7308-1-kristian@mide.dk>
 <20260709182602.7308-3-kristian@mide.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 18:37:33 +0000
Message-Id: <20260709183734.084DA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `enable_irq()` on error paths in suspend and resume functi=
ons.
- [High] Incorrect touch packet parsing offset across 64-byte chunks for po=
ints > 10.
--

--- Patch [2]: [PATCH v2 2/3] Input: ilitek_ts: handle short I2C transfers =
---
commit fea6e8240af99ced183b54d3a3d2c69a63ac6791
Author: Kristian Mide <kristian@mide.dk>

Input: ilitek_ts: handle short I2C transfers

Check that i2c_transfer() returns the expected number of
messages in ilitek_i2c_write_and_read().

> diff --git a/drivers/input/touchscreen/ilitek_ts_i2c.c b/drivers/input/to=
uchscreen/ilitek_ts_i2c.c
> index 54e39721f2473..6146baa2b6062 100644
> --- a/drivers/input/touchscreen/ilitek_ts_i2c.c
> +++ b/drivers/input/touchscreen/ilitek_ts_i2c.c
> @@ -131,11 +131,15 @@ static int ilitek_i2c_write_and_read(struct ilitek_=
ts_data *ts,
>  		error =3D i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
>  		if (error < 0)
>  			return error;
> +		if (error !=3D ARRAY_SIZE(msgs))
> +			return -EIO;
>  	} else {
>  		if (write_len > 0) {
>  			error =3D i2c_transfer(client->adapter, msgs, 1);
>  			if (error < 0)
>  				return error;
> +			if (error !=3D 1)
> +				return -EIO;
>  		}
>  		if (delay > 0)
>  			fsleep(delay * 1000);
> @@ -144,6 +148,8 @@ static int ilitek_i2c_write_and_read(struct ilitek_ts=
_data *ts,
>  			error =3D i2c_transfer(client->adapter, msgs + 1, 1);
>  			if (error < 0)
>  				return error;
> +			if (error !=3D 1)
> +				return -EIO;
>  		}
>  	}

drivers/input/touchscreen/ilitek_ts_i2c.c:ilitek_suspend() {
    ...
    error =3D api_protocol_set_cmd(ts, SET_IC_SLEEP, NULL, NULL);
    if (error)
        return error;
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but does this error path return
early without re-enabling the IRQ that was disabled at the start of the
function?

If api_protocol_set_cmd() fails during system suspend or resume, the PM core
will abort the suspend process. Because enable_irq() is skipped, won't
ilitek_resume() not be called for this device, leaving the IRQ permanently
disabled and the device unresponsive?

drivers/input/touchscreen/ilitek_ts_i2c.c:ilitek_resume() {
    ...
    error =3D api_protocol_set_cmd(ts, SET_IC_WAKE, NULL, NULL);
    if (error)
        return error;
    ...
}

[Severity: High]
This is a pre-existing issue, but does this error path also return early
before the enable_irq() call is reached?

drivers/input/touchscreen/ilitek_ts_i2c.c:ilitek_process_and_report_v6() {
    ...
    status =3D buf[i * packet_len + 1] & 0x40;
    if (!status)
        continue;
       =20
    id =3D buf[i * packet_len + 1] & 0x3F;
   =20
    x =3D get_unaligned_le16(buf + i * packet_len + 2);
    y =3D get_unaligned_le16(buf + i * packet_len + 4);
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but does this purely linear
index calculation i * packet_len cause out-of-bounds offsets into padding
areas and conflict with metadata offsets for indices >=3D 10?

The driver reads touch points into buf in 64-byte chunks, each holding up
to 10 touch points, and advances the buffer pointer by 64 bytes for each
chunk.

Because each chunk only uses 50 bytes of data (leaving 14 bytes of padding),
won't the linear formula fail to account for the 64-byte chunk boundaries
instead of correctly tracking them?

For example, for the 11th point (i =3D 10), the driver should read from
buf[64], but it incorrectly reads from buf[50] (which is inside the first
chunk's padding). For i =3D 12, the offset buf[12 * 5 + 1] resolves to 61,
colliding exactly with REPORT_COUNT_ADDRESS, resulting in corrupted
coordinates and statuses for points > 10.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709182602.7308=
-1-kristian@mide.dk?part=3D2
