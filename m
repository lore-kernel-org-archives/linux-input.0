Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAE6422540
	for <linux-input@vger.kernel.org>; Mon,  6 Jul 2026 09:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329908; cv=none; b=CluRYqL+oMeWz/ou7ZNyNCR0xSGkY1onZLg72wdk2M7UXrh/imLzGbk79x6We+qJO3qtROBq/XRiX1uOfVwC7KudcbG4x1bQAhDJnB+zP+k3YJM2U8eCOiaJH+44jNlO+vI2o9J7fBDgoKdOC8igLDP/PxZ8qZO5sw9vUVVyPW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329908; c=relaxed/simple;
	bh=U2/jQyoXqOReCEUpoaiwu/uubwY50Iv58sc50ThHV9s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iTbBEEHzjOtY6gAmXsSVvLhOIxbmh+QxGl9P/QTR0Btb+5gj/nByVX0PBQX3FXoBWrU5R+uskzCrUH0l+j4njxX36Yy/prmu+hIekjUuDS5u+Cdkm2FOFGb8N/cVI4eH6VDUrEmPWEy4OIBXJD4PoSRgiLwLPhG0f3JYiBIXujA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyurE/v7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyurE/v7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5911F000E9;
	Mon,  6 Jul 2026 09:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783329899;
	bh=02kds9I+irDc1IZjTWa5SLfqIKWNSYO8i2YbNTE5OAY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FyurE/v75wiIAu6vV21e/Ev8wlmZxaPohqkQzriZBixB2cJLF3Y1RUuLYRtS0gauh
	 ttxtvdfFPLEndtYIvUqL8H38fu57efkX/bGEbWVEt52wQKmFpo0BDL0dei/fFbxfML
	 YtelrveSOReiggFsSRen8C2CHCDnJe7eqvceL09fjsv27XXLogDUaEcXh9XqVLegQ5
	 f3fTvf8R/yTzrAAHscwlPHYYHLwCcfeh2kFwbnSUOGmhssNZy2u8YDpr1VchdqJRyk
	 2xqsf0xBUmgkM32owyeYxMAjMzi6tpWSxriDZISqHylily23xM5bNU5X3aVkQvVKOx
	 DSS4em1gZEvwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: atmel_mxt_ts - validate firmware frame bounds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260706091144.76132-1-pengpeng@iscas.ac.cn>
References: <20260706091144.76132-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:24:58 +0000
Message-Id: <20260706092459.6A5911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but missing serializ=
ation in the sysfs `update_fw` attribute leads to double-free and use-after=
-free vulnerabilities.
- [High] This problem wasn't introduced by this patch, but direct use of a =
vmapped firmware buffer for I2C transfers causes DMA mapping failures or me=
mory corruption.
--

commit 4f9a71983f301889709f29b76263c84f5ab07dfc
Author: Pengpeng <pengpeng@iscas.ac.cn>

Input: atmel_mxt_ts - validate firmware frame bounds

This commit adds bounds checking to the firmware update loop in
mxt_flash_fw() to ensure that the declared frame size and its CRC bytes fit
within the remaining firmware image. This prevents reading past the end of
the firmware buffer.

> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/tou=
chscreen/atmel_mxt_ts.c
> index 2c0e5a67135b6..2aa52b4e5ff50 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
[ ... ]
> @@ -2927,10 +2927,19 @@ static int mxt_flash_fw(struct mxt_data *data, co=
nst struct firmware *fw)
>  		if (error)
>  			return error;
> =20
> +		if (fw->size - pos < 2) {
> +			dev_err(dev, "Truncated frame size in firmware\n");
> +			return -EINVAL;
> +		}
> +
>  		frame_size =3D ((*(fw->data + pos) << 8) | *(fw->data + pos + 1));
> =20
>  		/* Take account of CRC bytes */
>  		frame_size +=3D 2;
> +		if (frame_size > fw->size - pos) {
> +			dev_err(dev, "Truncated frame in firmware\n");
> +			return -EINVAL;
> +		}
> =20
>  		/* Write one frame to device */
>  		error =3D mxt_bootloader_write(data, fw->data + pos, frame_size);

[Severity: High]
This isn't a bug introduced by this patch, but does this direct use of the
firmware buffer for I2C transfers risk DMA mapping failures?

The request_firmware() function can map the firmware buffer using vmap()
for files larger than PAGE_SIZE.

When mxt_bootloader_write() passes this potentially vmapped buffer directly
into i2c_transfer(), an underlying I2C adapter driver using DMA will
attempt to map a vmapped address, which yields an invalid physical address.

Should we bounce this buffer into memory allocated with kmalloc() before=20
passing it to the I2C subsystem?

[Severity: High]
This isn't a bug introduced by this patch, but does the firmware update path
lack serialization?

Concurrent writes to the sysfs update_fw attribute can execute mxt_load_fw()
in parallel:

mxt_update_fw_store() {
    ...
    error =3D mxt_load_fw(dev, MXT_FW_NAME);
}

If both threads evaluate the bootloader state as true simultaneously,
they will both execute the cleanup routines:

mxt_load_fw() {
    if (!data->in_bootloader) {
        mxt_free_input_device(data);
        mxt_free_object_table(data);
    ...
}

Could this result in a double-free on pointers like data->raw_info_block
and a double-unregister of the input device?

>  		if (error)
>  			return error;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706091144.7613=
2-1-pengpeng@iscas.ac.cn?part=3D1
