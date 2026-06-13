Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CC43845A2
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 05:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781329881; cv=none; b=fB3EpIbDTrPHeI7P68fb/NXoIO+qRe/jrAOXkVGCpn3w3eZ7N75slulgrdLwjxa+lZ0uWr+LmfUrYYv5DgO3YtscFSrY7UJpfDiI+2fQ9cITJ6A2RSWMjvUHYKT7QlSxWUA8vILwMY8/RH++hSMsEJio4p7DbKSVTetUCDNVh8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781329881; c=relaxed/simple;
	bh=2pI0gWYA7aFQO86op2la1IbLk1CVjGGScnd0Unam9ys=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k16HP/ik4oy1DWC6rdGawxw+fV1SgbxnE38P45WN5fJdaegh5hYZpl7cXgGJGeSyKlct1tILLZjEBaRDiPR+MVL1l4DkFLbG8kC4DZw4isunTEkdw9tDmdKnBsVlmri8oOCcHdytNREJwcSMVjqNwvjj2rLH2YbEzJEivNvDjoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvIusyp7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvIusyp7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0571F000E9;
	Sat, 13 Jun 2026 05:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781329879;
	bh=SpsH9tky4gLmkBcfUyd+ICplEuIXVHqfdFI/RiSl8xQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PvIusyp7W7B6gUEmxc/NWmBwb1gHBzp7PODBdCx9ls9BAjUkwDsXAy64hLrtE119+
	 7U0JqhcaW9JiZIE0NmO3fEp7dRGbJisgCAqUP9UHrKqTkGfu4BEXatQbdjhfwX/xkX
	 5xFXXHXvuzYzlnHUVqjAbsj1wX1scPURAFjmOj2gZcON3g6hWv6nZytFI//OhD+6ms
	 9i1bLoLIm+n422ZdzZfvl3pLsHdURFhi9w6eb0/w7q07f4mnuLz4MTqvEGqcZQfSDj
	 m9NEBvH13ycT/exiTuFkplHOIdJYnK7US8toRra1+YAOwRPaJXXJ0BL6H6qJtn4hPT
	 E0PlJ3ZBKBYYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: synaptics-rmi4 - bound the SMBus block read to
 the caller buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas via B4 Relay" <devnull+hexlabsecurity.proton.me@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260613-b4-disp-2e033955-v1-1-43ab7281667a@proton.me>
References: <20260613-b4-disp-2e033955-v1-1-43ab7281667a@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 05:51:18 +0000
Message-Id: <20260613055119.3B0571F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds read and information leak in `rmi_smb_write_block`.
--

commit d7c26cbb5c7a78f15621da67eb9707ffe6750b59
Author: Bryam Vargas <hexlabsecurity@proton.me>

Input: synaptics-rmi4 - bound the SMBus block read to the caller buffer

This commit fixes a stack overflow in smb_block_read by reading into a local
buffer first. It then copies back at most len bytes to ensure the device
never writes past the caller's buffer.

> diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbu=
s.c
> index f3d0b40721df0..ea957aba28f17 100644
> --- a/drivers/input/rmi4/rmi_smbus.c
> +++ b/drivers/input/rmi4/rmi_smbus.c
> @@ -177,12 +177,20 @@ static int smb_block_read(struct rmi_transport_dev =
*xport,
>  	struct rmi_smb_xport *rmi_smb =3D
>  		container_of(xport, struct rmi_smb_xport, xport);
>  	struct i2c_client *client =3D rmi_smb->client;
> +	u8 data[I2C_SMBUS_BLOCK_MAX];
>  	int retval;
> =20
> -	retval =3D i2c_smbus_read_block_data(client, commandcode, buf);
> +	/*
> +	 * i2c_smbus_read_block_data() copies the device-reported block count
> +	 * (up to I2C_SMBUS_BLOCK_MAX) into the destination and has no way to
> +	 * know its size, so read into a local buffer and copy back at most
> +	 * len bytes - never past the caller's buffer.
> +	 */
> +	retval =3D i2c_smbus_read_block_data(client, commandcode, data);
>  	if (retval < 0)
>  		return retval;
> =20
> +	memcpy(buf, data, min_t(size_t, retval, len));
>  	return retval;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but while looking at this file,
I noticed a similar size calculation issue in rmi_smb_write_block().

Does this code overflow databuff on the final chunk if len is not a
multiple of 32?

drivers/input/rmi4/rmi_smbus.c:rmi_smb_write_block() {
    ...
	while (cur_len > 0) {
		/*
		 * break into 32 bytes chunks to write get command code
		 */
		int block_len =3D min_t(int, len, SMB_MAX_COUNT);
    ...
		retval =3D smb_block_write(xport, commandcode,
					 databuff, block_len);
    ...
		cur_len -=3D SMB_MAX_COUNT;
		databuff +=3D SMB_MAX_COUNT;
	}
    ...
}

It appears block_len is calculated using the invariant len parameter instead
of cur_len. If len is greater than 32 but not a multiple of 32 (e.g., 40),
the second iteration will evaluate min(40, 32) =3D 32 instead of the
remaining 8 bytes.

This would cause smb_block_write() to read 32 bytes from databuff when
only 8 valid bytes remain, leading to an out-of-bounds read.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613-b4-disp-2e=
033955-v1-1-43ab7281667a@proton.me?part=3D1
