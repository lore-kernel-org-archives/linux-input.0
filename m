Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A27361974;
	Wed, 23 Sep 2026 07:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147567; cv=none; b=NuTBcnO3JBDugTcjI1RZ8M7QpTxfvGWgDaAJXkxjJ7jNj6MznOmZkx3q85KRgV8fTp/IAjc71M88PwWbk7I8uAMqQiDtL1LM+3A6sUdUayyO0bthZD4uX1/VOtgeZcMPpycia8/I4ZatQm5PYeHMOlfSiCeS3g1uwzSP9bIJ6tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147567; c=relaxed/simple;
	bh=L36iXjmgeLF9QB4QbihxTNoFK3jgnto30OAu5YXot88=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fLhawsO9yJ/B4iQOSFRmjOo9JTz6IDUBSy/hWyUNki30Syt9WEj2gYZIelYxovUvScdQ8bQh24VHnDQq1uBUPsZ2TcxFg17N6i4G/xk5bK1uwLWUG+u9qDxNQdadLKK0vM6hfi9zRST+6fgfThW6eGTulot5FYbYRvhyvkbkuiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApXfAf2M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApXfAf2M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161FE1F000FF;
	Wed, 23 Sep 2026 07:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790147566;
	bh=K5jrxZI/CMJF7j8AIaM1EPKSYzwwFdDhFbqtLb87WN8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ApXfAf2MRsoKM8IKa9WL2hIGzuzWcN+jST+bsOkIDxtqVH9OOxZCBylFAoz0NK/no
	 +o1xTc/EKq9O2BuLoels44DemBeZvRNKjM88jkbGLIDfwDSeiTA8OYeeSaGQX9YSnG
	 vA9v4NaeEhRaknkUUexvf0dNuh5sT/UnXAH/S4pxtceNjjXVdLNgFl5873Ff8Os7BC
	 G28TypZO1/bidQs5Ecr71/9ZOMCfA0qS8N8sShMxfXJDtv6tFseoyPBBhOhPb0DYZE
	 7dmBmupxFiyFy0bLTSFNLHw/53DT30+SJ3RZpFvTwYu1XcC7q1xTJZ70JN8MJ28q1f
	 +vlNSZzEtaS9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: bpf: add __counted_by_ptr attribute to
 device_data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bill Wendling" <morbo@google.com>
Cc: dmitry.torokhov@gmail.com, bpf@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260923065612.2707049-1-morbo@google.com>
References: <20260923063114.2683575-1-morbo@google.com>
 <20260923065612.2707049-1-morbo@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:12:45 +0000
Message-Id: <20260923071246.161FE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hid-bpf: kernel panic in FORTIFY memcpy due to lockless allocation=
 race
--

commit 146c59142d1d9271032a5ce18e55e70b22ecb2ec
Author: Bill Wendling <morbo@google.com>

HID: bpf: add __counted_by_ptr attribute to device_data

This commit adds the __counted_by_ptr attribute to the device_data field in
struct hid_bpf, pointing to allocated_data. It also swaps the assignment or=
der
of size and data in __hid_bpf_allocate_data() to ensure the buffer size is =
set
before the pointer.

> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf=
_dispatch.c
> index d46779b63660b..fb302d0b97970 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> @@ -255,8 +255,8 @@ static int __hid_bpf_allocate_data(struct hid_device =
*hdev, u8 **data, u32 *size
>  	if (!alloc_data)
>  		return -ENOMEM;
> =20
> -	*data =3D alloc_data;
>  	*size =3D alloc_size;
> +	*data =3D alloc_data;

[Severity: High]
Does this lockless assignment guarantee that the reader will observe
allocated_data being set before device_data?

Without memory barriers like smp_store_release(), the CPU can reorder these
stores. Concurrently, an incoming HID report triggering
dispatch_hid_bpf_device_event() can read these fields locklessly without
smp_load_acquire().

If the reader observes device_data !=3D NULL but allocated_data =3D=3D 0, c=
an it
lead to a fatal FORTIFY bounds check panic here:

drivers/hid/bpf/hid_bpf_dispatch.c:dispatch_hid_bpf_device_event() {
    ...
    memcpy(ctx_kern.data, data, *size);
    ...
}

Because the __counted_by_ptr annotation statically ties the bounds of
device_data to allocated_data, if allocated_data is 0, ctx_kern.data would
inherit a 0 bound. Calling memcpy() to write into it would then trigger a
kernel panic.

> =20
>  	return 0;
>  }
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
>  	u32 allocated_data;
>  	bool destroyed;			/* prevents the assignment of any progs */
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923065612.2707=
049-1-morbo@google.com?part=3D1
