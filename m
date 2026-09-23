Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51F138E119;
	Wed, 23 Sep 2026 06:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790145994; cv=none; b=biqOGw8Ubz7TyWaBL4MdIyVNvpHrsCbGKGq/+lMYiZ9Sqjs28RSwYFbyHi35CVeNQhY4P9BE3PZtPD18U54KTU3PKfeAg7mj0KI4s5B7APjI328An4Urhduoj/mgT8f2E9LMQ1zi9pcedyCy23Yuhn0X8RSN/OYuICANiGaKZ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790145994; c=relaxed/simple;
	bh=2lUKTJsgYmCYEkezlWVyYMV6oMgT2UqZ+gI8uHo2QRA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=onLYGG9rEY6raJ8+Mx6OYDgDifCqx6TIT/6i6RTqq4HbVNgeFdsquSRiJWv2o3iBqwGFhzsIjsiRVYqad0S8CqZ4STFV34r0alKOvm9KPzF0Jp7Xk+/xBIouYuftSXR/rYbuh6OVxNBmo6bIchzm4GUrFxr7IHFrcUnePoui/kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqA4dXTL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqA4dXTL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D881F000FF;
	Wed, 23 Sep 2026 06:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790145982;
	bh=3V/44lydGUR/MwxwZf+ZCtl9tGXWKO1D+b30eOEJ0LE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kqA4dXTL+QSUwpVJHAyZQ/lyvDS8cJZO3cyUsMxnAAuawDkiptC1LKZyVwyUS95qN
	 J3LIPu6RvR0ZqZA5hZQZuohpVA2SdLniKXTGZdIHmQb8JLIkiY8Dt9SFWQGDjTOHTr
	 n1yvQ7v0hfVMuJUDCln22OUm3F3VkvijJy/r9qvrOIT06ER3h00UBxMR0J6zgQMQSF
	 RT284Dp7ZQgvzN6+b4yEw6q6muafLXAjAI+AkD9CyY9jvFkSlx1dpJ1u1xD+eJd2mI
	 alxKVa/yW8TZSHHLO2xTkZdi+vhrh1MXYX4OykN9K31n941MiqV3CbJOl9buFMVrtr
	 mBtw/fGBR5o9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: bpf: add __counted_by_ptr attribute to device_data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bill Wendling" <morbo@google.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260923063114.2683575-1-morbo@google.com>
References: <20260923063114.2683575-1-morbo@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 06:46:22 +0000
Message-Id: <20260923064622.90D881F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hid-bpf: false-positive bounds check panic via data race in __hid_=
bpf_allocate_data()
--

commit 4a962db9c72042e7d956ca752f9439fb64fe5e37
Author: Bill Wendling <morbo@google.com>

HID: bpf: add __counted_by_ptr attribute to device_data

The 'struct hid_bpf' contains a 'device_data' pointer field and an
'allocated_data' field that specifies the size in bytes. This commit
adds the '__counted_by_ptr' attribute to 'device_data' to enable bounds
checking sanitizers.

> diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
> index 19fffa4574a47..f45fb9cccece8 100644
> --- a/include/linux/hid_bpf.h
> +++ b/include/linux/hid_bpf.h
> @@ -185,10 +185,12 @@ struct hid_bpf_ops {
> =20
>  /* stored in each device */
>  struct hid_bpf {
> -	u8 *device_data;		/* allocated when a bpf program of type
> -					 * SEC(f.../hid_bpf_device_event) has been attached
> -					 * to this HID device
> -					 */
> +	/*
> +	 * allocated when a bpf program of type
> +	 * SEC(f.../hid_bpf_device_event) has been attached
> +	 * to this HID device
> +	 */
> +	u8 *device_data __counted_by_ptr(allocated_data);

[Severity: High]
Does this newly added attribute introduce a false-positive bounds check pan=
ic?

The commit message mentions that allocated_data is always set before any
access, but looking at __hid_bpf_allocate_data() in=20
drivers/hid/bpf/hid_bpf_dispatch.c, it appears the pointer is assigned befo=
re=20
the count without memory barriers:

	*data =3D alloc_data;
	*size =3D alloc_size;

Concurrently, if an incoming HID report triggers=20
dispatch_hid_bpf_device_event() (which holds driver_input_lock but not=20
prog_list_lock), could it observe a non-NULL device_data pointer while the=
=20
allocated_data count still evaluates to 0?

If so, would the new __counted_by_ptr() attribute cause sanitizers to evalu=
ate
the buffer size as 0 while device_data is active, triggering a false-positi=
ve
kernel panic when memcpy(ctx_kern.data, data, *size) is called?

>  	u32 allocated_data;
>  	bool destroyed;			/* prevents the assignment of any progs */
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923063114.2683=
575-1-morbo@google.com?part=3D1
