Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF9246AEF5
	for <linux-input@vger.kernel.org>; Tue, 19 May 2026 09:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183831; cv=none; b=lBugNoWBv0hwhgjoDl/elnA6YrM7ASg9yu7HBMx6yORbH9iBhyJSd+0e0yi4IW2/qA2HjBXLJUTaCFCNXCIDTizAD78LjIUcakJFM998HJsplZGff9IhCTHJ+pkZ1OU9adHsaiJpS8NjD/YGIxJmziQnn/1SkdsaJQcXmkvoQpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183831; c=relaxed/simple;
	bh=0INAwGT8fLvknS2YIWK1zRXAZ0x1HB3qJKNf+7nEtXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3rmQ2+eSJfN6zEprDwERQoTNmW7HV/1Lyc9TXo5BDguU4DxJkYrOhEkfVhOYlUUTvwwmCzzeJSErWi3akRsgekHjgb3fx1fK9rhBeQtaSXPOeIna9CMdWgp7rFBzc9EPR5iBOyzw5JWpKgH5pZZRTIZ2ONEQDaKKZiBHX2h8Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=DEUbr+42; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="DEUbr+42"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=qwHt
	/k/M9wDvjOKDF5wywv6g/VitFR+hRN8iRxYXca8=; b=DEUbr+423Zmp7QzKjVei
	FBJe2aYeRTHW8/m1BIdIHoBdDRHtEG7lqynGa7m0WLjNpovsbg9srPB6NWQXFFuI
	cwEMEdiaF1VhG8zWWWn4dox0SmhMSr4fP9UwQYmH2cHtBgtR+n7gy80SKNjUYvf8
	2gqtlBrI55d4AOJpGbeuSdbfBEkcDlzHlOD3OwDMRhnC/4/doDKUR0Fnw96wG9Be
	PZWdx13MvwfFJylShDbYlZ/8gI5ihWv2wv4jjAkEXoUp0bdi4Ae2uVtNgTYVpjiR
	hSBPg4oHnx5M1nfmbjzOLuPQSi1tabtOlx4bD03IkZxtJndaiQPg2VDUXAYbJKuR
	lQ==
Received: (qmail 209164 invoked from network); 19 May 2026 11:43:46 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 May 2026 11:43:46 +0200
X-UD-Smtp-Session: l3s3148p1@wO34gyhSvtNUszca
Date: Tue, 19 May 2026 11:43:46 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+64ca69977b37604cd6d9@syzkaller.appspotmail.com,
	bentiss@kernel.org, jikos@kernel.org, linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	michael.zaidman@gmail.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] i2c: add sanity check for input SMBus data length
Message-ID: <agww0q1p3VZ5h9iv@shikoro>
References: <696eedec.a00a0220.203946.0001.GAE@google.com>
 <tencent_9443A8C45A37693763A6D7D3658367896405@qq.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4DEtacso/rj3ZKrm"
Content-Disposition: inline
In-Reply-To: <tencent_9443A8C45A37693763A6D7D3658367896405@qq.com>


--4DEtacso/rj3ZKrm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

thanks for your patch!

On Tue, Jan 20, 2026 at 09:47:02PM +0800, Edward Adam Davis wrote:
> The value passed to block[0] in the user-constructed data is too large,
> exceeding the length that data for SMBus messages can accommodate. This
> triggered the out-of-bounds access reported by syzbot [1].
>=20
> Adding relevant data size checks in the smbus ioctl can prevent this
> out-of-bounds access.
>=20
> [1]
> BUG: KASAN: stack-out-of-bounds in ft260_smbus_write+0x19b/0x2f0 drivers/=
hid/hid-ft260.c:486
> Read of size 42 at addr ffffc90003427d81 by task syz.2.65/6119
> Call Trace:
>  ft260_smbus_write+0x19b/0x2f0 drivers/hid/hid-ft260.c:486
>  ft260_smbus_xfer+0x22c/0x640 drivers/hid/hid-ft260.c:736
>=20

Did you look for a suitable Fixes tag?

> Reported-by: syzbot+64ca69977b37604cd6d9@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D64ca69977b37604cd6d9
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  drivers/i2c/i2c-dev.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
> index e9577f920286..6725a49d6921 100644
> --- a/drivers/i2c/i2c-dev.c
> +++ b/drivers/i2c/i2c-dev.c
> @@ -378,6 +378,14 @@ static noinline int i2cdev_ioctl_smbus(struct i2c_cl=
ient *client,
>  	    (read_write =3D=3D I2C_SMBUS_WRITE)) {
>  		if (copy_from_user(&temp, data, datasize))
>  			return -EFAULT;
> +
> +		if (temp.block[0] > datasize) {
> +			dev_dbg(&client->adapter->dev,
> +				"user input data size (%u) is too big "
> +				"in ioctl I2C_SMBUS.\n",

Strings stay in one line, please, even if they break the line length.

> +				temp.block[0]);
> +			return -EINVAL;
> +		}
>  	}
>  	if (size =3D=3D I2C_SMBUS_I2C_BLOCK_BROKEN) {
>  		/* Convert old I2C block commands to the new

Happy hacking,

   Wolfram


--4DEtacso/rj3ZKrm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoMMNIACgkQFA3kzBSg
KbaUMg/+J7HCylAZwxM3wXeuGt5P6vf/vpg/pl7VO5nPrusIeNKD4cwZ+kR5gMtQ
xr4rmrnnXftu/8f7Ivwh4LYOO/bPscbZGgyU4SgiqbCo7kzxLZuR2J8JygRzE67J
76qfhpX0kSNwLFpVpiLdPA8GOyzCSiOMgEXJoWVYKoM0Gj21L23szXQWyvkCjbkT
vYt0JIlcOjgsRLYkxmwhbS92b6FTEDfrW4v8mm9H8sxOJgF1NsHlz7HvybsuXCd+
yU2mpYUfjay6QAzQURg9/Rv89WcZ1sS1NJchPUSRMXfyD2+HS1XKhejV0+BpzFir
nuc9TH8W+3Od/+dW3gTw0BBQUURwPG6/E8XGUkVVzDW3mIaG4Ylh/aY1ACAidXtJ
++4zqBkusFjrn4aNCDxFgtQkSLw5xJ0neXyuIZ2Fvurq3iRURHsCzQRn8tsdxvXT
Cm4abQSdZ/s2ky/mtyMAe/wcnhkJYFFJBIdmTHEP8RR0qgyS3e+g6bwzlAyCgXmz
COgb8eNXw1Kw63DLcxK1pdEn0K5GbLRj53uamWdw1y8afpyC66xZODXagrXZ4n3d
5XSKo18mJN8TY06ndVsdw5+NkGRCmKShuur8bkHRWdn/yZf5Q4reXEmE7grNRtid
qsSyuRseGZ1hfSogmp6BUu/rJR3+2etWRZZ+iw9Xijd3UyfxuFA=
=7ok1
-----END PGP SIGNATURE-----

--4DEtacso/rj3ZKrm--
