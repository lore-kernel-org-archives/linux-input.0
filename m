Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD7E23AE62
	for <linux-input@vger.kernel.org>; Wed,  5 Aug 2026 05:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785907242; cv=none; b=fECRKz1P3wB5Of5om2dJ6kqHARa4Lj3FDcaJ1n5luFQb49nwvu40Mgtv4Xka/1vtnVdRWBPVhrHaFzqVGPwEZVxdzBrk10SwgHVZnZq0JrDjcjJTcLVreoeD7yFlgNwfczgt+Atm3l9Zs62drV0dFxJYRRY59SiDAAQqoA3O8ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785907242; c=relaxed/simple;
	bh=wbeuJ4qycU2XurcKhJfwNSrzleoobV0aFJp3AXIrEMM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pHFuIBqXjyUWLNQhNJOBu5P93qJrCFBffzsgYrYSzNGIDKQziTsBhy71DFyaP02tT0E4M0AcT2wxdDFzMSVLI4ZZ35EcDGTPzGzCCZt/yrfBiJsGlod0Z5sq2JdQOvzy1j3bATlsR8NnraHDaQgFkm0FQhZ85UkYwaMemp+lXTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nu+Ib8aH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nu+Ib8aH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CA21F000E9;
	Wed,  5 Aug 2026 05:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785907240;
	bh=XbvKZDC5rkp7+B0WsE8XIiyxjWuVb5sbns3A0aiP1kw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nu+Ib8aHeYwJ/soIZudRHYa87qUlyNmAQhT1gTXxSh3qgnAfd7BC19C946wPjV5gI
	 Q+JfWFQbbOgfIEg+BTckPKdLtbTzg5naZZMlckp0lT5pSxfaC8ebhNq9CzkUxCAWUu
	 DsI5kYonTLhxrxrXJT+vABnxIowWlSuUW3kvXVD8iiLXagclOZrycHX14tOK4BFpb+
	 z1EOdqOl75wFU4+qD6M3ltJGvkDyJiwml3NqD/UmV97DYbpOspY61Bx9grXK2bRnbG
	 LYhB6Fw7bmEX4Y1k68nOOYgWGmtwOz5hznjENVWfoLtxfvvDfpNPDH3vKj23tQf+aB
	 iVFdayPito/CA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: rmi_smbus - fix out-of-bounds read in
 rmi_smb_write_block()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <anLFSMKSoKyyZ272@google.com>
References: <anLFSMKSoKyyZ272@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 05:20:39 +0000
Message-Id: <20260805052039.C1CA21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing stack/heap buffer overflow in `rmi_smb_read_block()` =
due to unsafe use of `i2c_smbus_read_block_data()` without a bounce buffer.
--

--- Patch [1]: [PATCH] Input: rmi_smbus - fix out-of-bounds read in rmi_smb=
_write_block() ---
commit 530e4667b6144c7e030412bbc818f1de86a5a09e
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: rmi_smbus - fix out-of-bounds read in rmi_smb_write_block()

This commit fixes an out-of-bounds read in rmi_smb_write_block() by ensuring
block_len is calculated using the remaining length (cur_len) rather than the
original total length.

> diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbu=
s.c
> --- a/drivers/input/rmi4/rmi_smbus.c
> +++ b/drivers/input/rmi4/rmi_smbus.c
[ ... ]
> @@ -148,7 +148,7 @@ static int rmi_smb_write_block(struct rmi_transport_d=
ev *xport, u16 rmiaddr,
>  		/*
>  		 * break into 32 bytes chunks to write get command code
>  		 */
> -		int block_len =3D min_t(int, len, SMB_MAX_COUNT);
> +		int block_len =3D min_t(size_t, cur_len, SMB_MAX_COUNT);
> =20
>  		retval =3D rmi_smb_get_command_code(xport, rmiaddr, block_len,
>  						  false, &commandcode);
[ ... ]

[Severity: High]
This is a pre-existing issue, but since the chunking logic in=20
rmi_smb_write_block() is being corrected here, does a similar buffer overfl=
ow=20
exist in the read path?

Looking at smb_block_read(), it ignores the len argument and passes the=20
buffer directly to i2c_smbus_read_block_data():

drivers/input/rmi4/rmi_smbus.c:smb_block_read() {
    ...
    retval =3D i2c_smbus_read_block_data(client, commandcode, buf);
    ...
}

If a caller requests a small read, or if the final partial chunk in=20
rmi_smb_read_block() has less than 32 bytes of capacity remaining:

drivers/input/rmi4/rmi_smbus.c:rmi_smb_read_block() {
    ...
    retval =3D smb_block_read(xport, commandcode, databuff, block_len);
    ...
}

Could a malfunctioning I2C device returning a length greater than block_len=
=20
cause the I2C core to unconditionally copy up to 32 bytes, overflowing=20
the databuff allocation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/anLFSMKSoKyyZ272@go=
ogle.com?part=3D1
