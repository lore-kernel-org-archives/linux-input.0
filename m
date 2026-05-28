Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09012D46C0
	for <linux-input@vger.kernel.org>; Thu, 28 May 2026 18:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993752; cv=none; b=VPx9hlRVQz3Xr6Xh2L+KZOJtrHebjeZJtZvCJolHhgVI3iQjPHMinEjysgK2qtnve1KgB9MTh52X6Au/t+Pf9HlN+JU9ptr92Xba+UK/ykIGrc90AuaVFWlhvLop06Oz42+1vwEVgNqSaMkX5h01xnxtnDzFbTEWhypaX+RlyqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993752; c=relaxed/simple;
	bh=LpggWhpKE9UOFiESfs9BTgkp7I1fZYujxCMEAjb/O8Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MsMY+PQdq6JjEH5Z7ulwvNFc5DSTV0uZyTPuVL+QmRcp42kAmyAT9uTVb4BSwKNnig+WAzIJou4mdOmPZcItCFHpuF4Lvme8Xzh9WdlzsDlPtSsmU76UrU/vXtvGNxSqmZ3IK/cfxnioSj0TO7QGvumfJJVU8U82Y4qLNaltSEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZqTzGuX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZqTzGuX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0581F000E9;
	Thu, 28 May 2026 18:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779993751;
	bh=LzOsSdwgpPyhqB//xxHf2bWBBQ70JhytubH0P8Rpl4I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BZqTzGuXsRX9WNqpCCPgCJDS6z6KbMALkaxQhR37kJiFZz3XNOmExwEbxUnTfT6xP
	 VXbwdnsxvnxPpXFduCCdRDFx5G+jbsF4J/mi1IiS44i0ax3d7qTMcF/u5e+Tlm3KnR
	 cEb9Cgnn6u6JqnZDvzMc1SniipXR2kEh4KZNSrPI2VT6lnKt4eEcK+15Cgnw9tBWWw
	 x75ut/ppmYSKCzBZIg0qR8AqXt516WH+HkSJaqewtTUIzj+JMbGHxygPAFJCu95gLm
	 IlXsjh5rrMIc+MXse3j54u93t/4UTYNCYg4GnOM3LvLOQVp38hb1YqeZ5MJz+PlShx
	 w45K/6yimxoyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: wacom: fix slab-out-of-bounds write in
 wacom_wac_queue_insert
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinmo Yang" <jinmo44.yang@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260528175945.2987781-1-jinmo44.yang@gmail.com>
References: <20260528175945.2987781-1-jinmo44.yang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 18:42:29 +0000
Message-Id: <20260528184231.1F0581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] wacom_wac_queue_flush() allocates memory with GFP_KERNEL while exe=
cuting in an atomic context, leading to a 'scheduling while atomic' panic.
--

commit 70e9615b93de485ba1816f95e27e25b054df4b6a
Author: Jinmo Yang <jinmo44.yang@gmail.com>

HID: wacom: fix slab-out-of-bounds write in wacom_wac_queue_insert

This commit fixes a slab-out-of-bounds write in wacom_wac_queue_insert().
It prevents kfifo_skip() from operating on an empty fifo and validates
the return value of kfifo_in().

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index a32320b351e3e..489ca68f1560f 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c

[ ... ]

> @@ -62,7 +62,9 @@ static void wacom_wac_queue_insert(struct hid_device *h=
dev,
>  		kfifo_skip(fifo);
>  	}
> =20
> -	kfifo_in(fifo, raw_data, size);
> +	if (!kfifo_in(fifo, raw_data, size))
> +		hid_warn_ratelimited(hdev, "%s: report is too large (%d)\n",
> +				     __func__, size);
>  }
> =20
>  static void wacom_wac_queue_flush(struct hid_device *hdev,
>  				  struct kfifo_rec_ptr_2 *fifo)
>  {
>  	while (!kfifo_is_empty(fifo)) {
>  		int size =3D kfifo_peek_len(fifo);
>  		u8 *buf;
>  		unsigned int count;
>  		int err;
> =20
>  		buf =3D kzalloc(size, GFP_KERNEL);

[Severity: High]
This is a pre-existing issue, but is it safe to use GFP_KERNEL here?

Looking at the call chain, wacom_wac_queue_flush() is invoked via
wacom_wac_pen_serial_enforce() from the driver's .raw_event callback,
wacom_raw_event().

For USB HID devices, this callback is typically triggered by hid_irq_in(),
which is an URB completion handler that runs in an atomic context.

Since using GFP_KERNEL allows the allocator to sleep, could this lead to a
scheduling while atomic panic? Would it be better to use GFP_ATOMIC instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528175945.2987=
781-1-jinmo44.yang@gmail.com?part=3D1
