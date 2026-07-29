Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A09E25B0B9
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345480; cv=none; b=bW+3cq5WJbmiXs7cowQiBbiOSxAWVg9DO2zvLhGt2c6HHTZXtXGzivP7ir8LELOsXmQNe827iIZ8f8dti4Eis31Zs25A/JzJCGLUy5o9X6weuB6iZ4WAbb0ymaxUssRvTWuu1juivKCLnZlzpptKKcXlNNcurSKJi6CnAZGWOcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345480; c=relaxed/simple;
	bh=I3gX1F2m+50XQea5Py238jL/TpFl7MMqy78483LPZIk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CHY+Cm2kDbq5MzjeTtk2iClE4EdOqS3P3g6RRfiZ5/4IKE6bznMlQponpXddub0ecoDu35Pqo0o4mFE9szjzKGD1e+KPvhbMEZVUZMW2uNMe2Tx8BfCXvmL8sQ1brIYQTeyz9jeO8E/mKIhr8Kteu8v1ayU0sOvaDMjt9KW8iAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2RLGQOm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2RLGQOm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C0B1F000E9;
	Wed, 29 Jul 2026 17:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785345478;
	bh=MxS2Ykdum9HvFQwGDLoAvNYJNrUy9Qz6X5RDBC4W3DI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J2RLGQOmNdwrXzAIAbnlsnqM22DaLFFuimnZEjGPE1lK23649xyUho080V17IdTWM
	 vh9asEkAMQjPcIg734Drjp5IeqKZi88oexXFCa8rwmAQghBFwoRcVtjczYV0U9y3Pr
	 HwnCFgtILJ+NOHrz02uucbd5uS5GrNTmDujwAQ9lBQ1w4SjnMiO1l9luPhB88/Jxon
	 /U19J7VQZAbnlQ8Yv0RBENSQ+mi35fGPj/lQWxsS2d1OD8ikdyWvMxKG8UT1ONnjUj
	 8WH/fpqhB9ktnsQAV6VLvsxDAKI/r9OMCsLE+1vwXarlHmTR5HtlknQP1UtBGmLBld
	 OB6R+HBSpPEMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] Input: rmi_smbus - remove conditional return
 with no effect
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sang-Heon Jeon" <ekffu200098@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260729171001.260698-3-ekffu200098@gmail.com>
References: <20260729171001.260698-1-ekffu200098@gmail.com>
 <20260729171001.260698-3-ekffu200098@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 17:17:58 +0000
Message-Id: <20260729171758.84C0B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Buffer overflow in smb_block_read() due to ignoring the requested =
length.
- [High] Out-of-bounds read in rmi_smb_write_block() due to using the total=
 length instead of the remaining length.
--

--- Patch [2]: [PATCH v2 2/3] Input: rmi_smbus - remove conditional return =
with no effect ---
commit c43fcefd3c43ed84b5f32f45bd591ace30890382
Author: Sang-Heon Jeon <ekffu200098@gmail.com>

Input: rmi_smbus - remove conditional return with no effect
   =20
This patch simplifies the return path in smb_block_read() by removing an
unnecessary conditional check. Both branches of the check returned the same
value, so it now returns the result of i2c_smbus_read_block_data() directly.

> diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbu=
s.c
> index 6de68c602558b..3160714a514a5 100644
> --- a/drivers/input/rmi4/rmi_smbus.c
> +++ b/drivers/input/rmi4/rmi_smbus.c
> @@ -177,13 +177,8 @@ static int smb_block_read(struct rmi_transport_dev *=
xport,
>  	struct rmi_smb_xport *rmi_smb =3D
>  		container_of(xport, struct rmi_smb_xport, xport);
>  	struct i2c_client *client =3D rmi_smb->client;
> -	int retval;
> =20
> -	retval =3D i2c_smbus_read_block_data(client, commandcode, buf);
> -	if (retval < 0)
> -		return retval;
> -
> -	return retval;
> +	return i2c_smbus_read_block_data(client, commandcode, buf);
>  }

[Severity: High]
This is a pre-existing issue, but by removing the intermediate check, it dr=
aws
attention to a buffer overflow in this function.

Can this corrupt memory? The smb_block_read() function takes a len paramete=
r,
but it is completely ignored when calling i2c_smbus_read_block_data().

If a malicious or buggy I2C device returns up to 32 bytes (SMB_MAX_COUNT),
i2c_smbus_read_block_data() will copy that full amount into buf. If the
original len was less than 32 (for instance, on the final chunk of a read in
rmi_smb_read_block()), this could overflow the buffer and corrupt memory.

> =20
>  static int rmi_smb_read_block(struct rmi_transport_dev *xport, u16 rmiad=
dr,
>  			      void *databuff, size_t len)
>  {

[ ... ]

While reviewing this, I also noticed another pre-existing issue in the near=
by
rmi_smb_write_block() function:

drivers/input/rmi4/rmi_smbus.c:rmi_smb_write_block() {
    ...
	while (cur_len > 0) {
		/*
		 * break into 32 bytes chunks to write get command code
		 */
		int block_len =3D min_t(int, len, SMB_MAX_COUNT);
    ...
}

[Severity: High]
This is a pre-existing issue, but can this lead to an out-of-bounds read?

When chunking the write, the loop calculates block_len using the original t=
otal
len instead of the remaining cur_len.

If len is greater than 32, block_len will remain exactly 32 for every
iteration, even the final one where fewer than 32 bytes remain. This causes
smb_block_write() to read 32 bytes starting from the advanced databuff
pointer, potentially reading past the end of the original buffer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729171001.2606=
98-1-ekffu200098@gmail.com?part=3D2
