Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6C949BD65
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055586; cv=none; b=uM+Zruqf/4jKKzI+tdcQvN87DQxaNdeohHGPOlNWV84vh6XmkOhEz8YheIlpiMCTZxPak9Ua8AJoeawt9KVUK22TcMX15g8OkaptdG17rNcYPIhwr8GKIaiul4GNgy5rXyIMTAq034yWSBqD8in5qFik9IR36vLZ4TJISE5YUc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055586; c=relaxed/simple;
	bh=F+W6hBklix8Yx3BWj2ogqWu/1RDblbqGnHtnCTrAs+c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MC6oJWE+z7OgXeiDawto9tTCecj8/k3W2NTAGrH+pCZRxCcrRxWnA4tAZbpFZSLGrCy/bZ3ODqgx3/VBSsbpk5LFH1oQVoLXY2VR2hmbmLYZHB47o246W+rA5/DjP4ze7Hdskf6e/GeQve0gwoop2Eeo23480FJ0ncYmFCOBQrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyZraarN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyZraarN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E4A1F000FF;
	Thu, 10 Sep 2026 15:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789055585;
	bh=vRIubTuwrRaQA0uCxG23rckJEaQNDkIUuxnNVUiTK5Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eyZraarNYYAYwpxJg2OKZs2KcGtjItuKc8Vk0IFhEmAenYNJ6+gNGhCUJpnWh9wjX
	 Rw60w/JrusZEL2XnsGSXxSEseGLX0Y8RQ1jwvyNeGI3bljIiHjSbrDMQNesc6QQInG
	 g3091Zn7SNafjRSJ8X0l+T88PukhwIkBxe8JOIhIAaVpRGrRnjSP2U3smvv36KgKZv
	 LQicbvRIlxE7DVBBcXzKjOXNASKwn/6lo2uFkxQEdyKVcYySeDHO1gqH9dnL8qRLK4
	 7apC4a4gqXAeXjMUDm/04XxaQQly400erCBqPeQawo2k/2HabmPFYs8xXuVdjriOt9
	 PHrv0nwHtI64Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: multitouch: use GFP_ATOMIC for
 report/application/usage allocations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nguyen Ngoc Thang" <ngocthang2710.1999@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260910153746.16222-1-ngocthang2710.1999@gmail.com>
References: <20260910153746.16222-1-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 15:53:04 +0000
Message-Id: <20260910155305.58E4A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] `mt_allocate_usage()` is incorrectly assumed to run in softirq c=
ontext, leading to an unnecessary downgrade to GFP_ATOMIC.

Pre-existing issues:
- [High] Unprotected iterations of `td->applications` can race with dynamic=
 list additions in softirq context.
--

commit 2b43dba239544b5949bf20a7a3f499c51db9632b
Author: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Subject: HID: multitouch: use GFP_ATOMIC for report/application/usage alloc=
ations

This commit changes the allocation flags for multitouch report data,
applications, and usages from GFP_KERNEL to GFP_ATOMIC to prevent lockdep
warnings about sleeping in softirq context.

Link: https://syzkaller.appspot.com/bug?extid=3D093e05755c2d99caab91

> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 451c7324e6a06..925b03619d264 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -604,7 +604,8 @@ static struct mt_usages *mt_allocate_usage(struct hid=
_device *hdev,
>  {
>  	struct mt_usages *usage;
> =20
> -	usage =3D devm_kzalloc(&hdev->dev, sizeof(*usage), GFP_KERNEL);
> +	/* may run from hid_report_raw_event() in (soft)irq context */
> +	usage =3D devm_kzalloc(&hdev->dev, sizeof(*usage), GFP_ATOMIC);

[Severity: Medium]
Is this downgrade to GFP_ATOMIC necessary?

Looking at the call chain, it appears mt_allocate_usage() is only invoked by
mt_store_field(), which is used exclusively via the MT_STORE_FIELD macro in
mt_touch_input_mapping().

Since mt_touch_input_mapping() is only called during device probe
(hid_hw_start()) and is never invoked from mt_event() or any softirq contex=
t,
using GFP_ATOMIC here might unnecessarily increase the risk of allocation
failures during device initialization under memory pressure.

>  	if (!usage)
>  		return NULL;
> =20
> @@ -633,8 +634,9 @@ static struct mt_application *mt_allocate_application=
(struct mt_device *td,
>  	unsigned int application =3D report->application;
>  	struct mt_application *mt_application;
> =20
> +	/* may run from hid_report_raw_event() in (soft)irq context */
>  	mt_application =3D devm_kzalloc(&td->hdev->dev, sizeof(*mt_application),
> -				      GFP_KERNEL);
> +				      GFP_ATOMIC);

[Severity: High]
This is a pre-existing issue, but can this allocation and subsequent list
addition race with other list iterations?

When an unknown or unmapped report ID is received, mt_event() can call
mt_allocate_application() from softirq context, which subsequently appends
the new application to td->applications:

drivers/hid/hid-multitouch.c:mt_allocate_application() {
    ...
	list_add_tail(&mt_application->list, &td->applications);
    ...
}

If this happens concurrently with mt_set_quirks() (running in sysfs process
context) or mt_release_contacts() (running in a timer callback) which both
iterate td->applications without locks:

drivers/hid/hid-multitouch.c:mt_release_contacts() {
    ...
	list_for_each_entry(application, &td->applications, list) {
    ...
}

Could this concurrent modification and unprotected iteration lead to list
corruption or infinite loops? A malicious or buggy HID device might be able
to trigger this by sending unexpected report IDs.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910153746.1622=
2-1-ngocthang2710.1999@gmail.com?part=3D1
