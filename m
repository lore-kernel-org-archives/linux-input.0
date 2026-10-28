Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793187233;
	b=fQVDz3HyU4QRUBvITOIKvQD7yH5ntwPa07dC5EThZ98AgZAPWfeFv87eW5X2BZwxdNz/
	 rIOLoFel7MqJIB954sK97l5JpKlIKQTKPc6Exw4MLb4RuE95LU2mLvpNHRcaj0nTjKMtm
	 W1kbFAa7v8NiHN5zfr6qLvFTY1T+bIzmAxKNBFI8xmhPux9Oayy3UHBL8jPFWScJjtgOb
	 wqok0wJurkxXhNxUbvxyCgKkgc51umrDPC6oxZ0hcWQ8pKOj5Jh3Ni+28bfbQmq3B+y67
	 uLieba7VJn4w5t4wroQRSZNj78TEHVXxBUBNpUk/v1o/jNx7oOpZH3bL1o/BcqU/CRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793187233;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kbKkzDGI1hvtTO/vSMlmUm8rWZ5FMQsJ9+2I5LAM1QQ=;
	b=2LNa7LbqF/+iW+KY7mid+BXxawomNGqdVuS6pqHTHGMTFNyIVi8hXNJMgewS0p2WWXvw
	 6qjbwKRy5tPUhvy/XYd3MUd6BJ7/XlypOJKQ9wvV2/6DcP9hUmIb/wDLuVAAIs82GPD4t
	 tvWEInPfZwwFBGACKoD3kLbnv790oRKmACInfvhieVQPPK3I1ZiALeCjcltXuaz9fV3UW
	 4Iwij6h7v7UQCPs2ADFWQGCgFXfcWp/ZdjmrJJcB+WQCaSUsGyX0ONyOY9JV+7/hDy8Xf
	 lQrlOu2wyh8GZJl0215fn2X+d2g0Wq+Q3SGO3xJDwUr7pFbzGWWSe3kMR/yor2fED7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LYTPaBwX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08E6606A31E
	for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LYTPaBwX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5654C1F031E4;
	Wed, 28 Oct 2026 11:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793187232;
	bh=kbKkzDGI1hvtTO/vSMlmUm8rWZ5FMQsJ9+2I5LAM1QQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LYTPaBwX0aDMdsH9mvkwCsTh/38v05ctCfwVj6E82DdPNSVmnzrJ9zegN46+QhcLx
	 B/QjkHUTydGqU4MX55qjgKDi+w9W09RetszA/PVvQWNYgysOqDAHIw1hoKn/OYZmMC
	 i98U4rvYMZnwFcyk/e7f1w7kFMQ3xwZCR3LD8LMrr1NEQUUP+L/YjdRDvfDXL4DMCi
	 DnYdLT5xeGifEEw2SasQ0Lcz2h9LvLs0Rdx8WnQTyG6PShc2hPSEDnygc6L5/hTCbT
	 SgqhZtd4boPV7kf4UgtpZcbLWFd1wfi7/T/dW8cNvExCrZEtz2K4j2DbMAYD/2b1eA
	 disIuGRgy+1ug==
Message-ID: <sashiko-outbox-187824@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] HID: haptic: Replace create_singlethread_workqueue
 with alloc_ordered_workqueue
Reply-To: sashiko-reviews@lists.linux.dev
To: "George Karagounis" <taterraster@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261028111853.22429-2-mail@taterr.org>
References: <20261028111853.22429-1-mail@taterr.org>
 <20261028111853.22429-2-mail@taterr.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 11:33:51 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] HID: haptic: format string bug in hid_haptic_init() workqueue =
allocation
- [Medium] HID: haptic: misuse of WQ_MEM_RECLAIM in hid_haptic_init()
--

commit 7db50def49522def9f10d7cdd2d640a9ac167fa3
Author: George Karagounis <taterraster@gmail.com>

HID: haptic: Replace create_singlethread_workqueue with alloc_ordered_workq=
ueue

This commit replaces the deprecated create_singlethread_workqueue() call in
hid_haptic_init() with alloc_ordered_workqueue() using the WQ_MEM_RECLAIM
flag.

> diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
> index 8760eeb08b2cd..2f4fcb56aba13 100644
> --- a/drivers/hid/hid-haptic.c
> +++ b/drivers/hid/hid-haptic.c
> @@ -460,7 +460,7 @@ int hid_haptic_init(struct hid_device *hdev,
>  	name =3D kmalloc(strlen(prefix) + strlen(hdev->name) + 2, GFP_KERNEL);
>  	if (name) {
>  		sprintf(name, "%s %s", prefix, hdev->name);
> -		haptic->wq =3D create_singlethread_workqueue(name);
> +		haptic->wq =3D alloc_ordered_workqueue(name, WQ_MEM_RECLAIM);

[Severity: Critical]
Does passing name directly as the first argument to alloc_ordered_workqueue=
()
in hid_haptic_init() introduce a format string regression when hdev->name
contains % characters?

Previously, create_singlethread_workqueue(name) expanded to:

include/linux/workqueue.h:
#define create_singlethread_workqueue(name)				\
	alloc_ordered_workqueue("%s", __WQ_LEGACY | WQ_MEM_RECLAIM, name)

With alloc_ordered_workqueue(name, WQ_MEM_RECLAIM), name is passed as the
printf format string fmt to alloc_workqueue() -> __alloc_workqueue() ->
vsnprintf(wq->name, sizeof(wq->name), fmt, args) with no variadic format
arguments. Because hdev->name comes from external HID device descriptors or
userspace via uhid, any % specifiers in hdev->name will be interpreted by
vsnprintf().

Since alloc_ordered_workqueue() accepts a format string and variadic
arguments directly, could this pass "%s %s", 0, prefix, hdev->name and avoid
the intermediate kmalloc(), sprintf(), and kfree() of name altogether?

[Severity: Medium]
Also, is WQ_MEM_RECLAIM appropriate for haptic->wq in hid_haptic_init()?

The commit message notes that WQ_MEM_RECLAIM is added to ensure hardware
events can be processed under memory pressure, but WQ_MEM_RECLAIM is intend=
ed
for workqueues depended upon during memory reclaim paths and allocates a
dedicated rescuer kthread per device.

haptic->wq only runs haptic_work_handler() -> play_effect() to transmit
force-feedback output reports via hid_hw_output_report() and
hid_hw_raw_request(), which is not part of memory reclaim. Dropping
__WQ_LEGACY while keeping WQ_MEM_RECLAIM also enables check_flush_dependenc=
y()
warnings in kernel/workqueue.c if the underlying transport flushes a
non-WQ_MEM_RECLAIM workqueue. Should the flags argument be 0 instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028111853.2242=
9-1-mail@taterr.org?part=3D1
