Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F8235201F
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 08:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782809970; cv=none; b=bW7rsJ5kiwqZzx33u55dTwPAKVF19UVen/pBdXYw7utZ4XFdNN7pmV0ZiTr+P5lGrvNhWZOTgBzcQluLVkg6ZFPsBI3vFQJ7h86XkSJxwJC/hqxLiucqfMPeh5U8WU67hjdtT4y+vmcaHVcjn8GhurN8jF5yKQOhZ9lUjusAqmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782809970; c=relaxed/simple;
	bh=feW7nCdwUZHAMQuM937KY0ak6HLIJYqSVv1JR4TjFtg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GZJQATnJdn7Il2KrvI+pASBswjnmm/fD1dWvklnEHDRvuHU0bls7ixe3jk1Unyehjvs9DPT3oxwclcJJNZFs4PI5Q+ygZcQ3KuqZVA8IOIYRH5r7EpB8fuYD6V/GzAn6cLJLTSBeVnLj5tI28zpjxWYKct6ZLkkM1N4tUZVfdlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0mYSfnR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0mYSfnR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBC41F000E9;
	Tue, 30 Jun 2026 08:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782809969;
	bh=mExjFa6Nt6xaNe7xZhBtHSqb90iPEZh08yWln7slkEs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K0mYSfnRFPtSYXb4d5cFzHdrVk63+VPEfLqqq11Qq8xIx1Pu3CvF28f53d+Lm0FYg
	 OhJAUE2KIZmz2NyYcDChay7+5pRizXs5tRhZ1qsMEXYhs/3etC7e+CVuFUAOxzQyRq
	 0bjpSP0TkywY8whcnFxxDQaXLEXgrRAKG250f4aL4ajshP+DZpymUX/eraPhIGTN/Y
	 2FVzLJEtspcklG9NoRV1B8MMli7kmRBhXAPi5AebYtMdivbgEeYp4xJGvIz410nO95
	 VV/W8lQqqXgpctsVvwLnZ2VNXhJ6kruQd8/GgMENkKWyRTIPUJziby+BAIP0E4pyPa
	 yDEMQ7BoySkdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/3] HID: nintendo: Add unified report format support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260630084838.2313379-4-vi@endrift.com>
References: <20260630084838.2313379-1-vi@endrift.com>
 <20260630084838.2313379-4-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 08:59:28 +0000
Message-Id: <20260630085929.2CBC41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The global HID report size check was incorrectly tightened to 17 b=
ytes, silently dropping valid input reports for non-unified controllers.
--

commit 2414bf53574e3d2b6aee6b978aeb58f941052e21
Author: Vicki Pfau <vi@endrift.com>

HID: nintendo: Add unified report format support

This commit adds support for the unified report format for various Nintendo
controllers. It maps their respective buttons and axes to the new unified
formats.

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index a53c554a54ae3..4920c9691b08a 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c

[ ... ]

> @@ -3765,7 +3866,7 @@ static int switch2_event(struct hid_device *hdev, s=
truct hid_report *report, uin
>  	if (report->type !=3D HID_INPUT_REPORT)
>  		return 0;
> =20
> -	if (size < 15)
> +	if (size < 17)
>  		return -EINVAL;

[Severity: High]
Does tightening this global size check to 17 bytes silently drop valid input
reports for non-unified controllers?

Looking at the other cases in switch2_event(), such as NS2_REPORT_GC, the
driver previously validated against a 15-byte minimum because it only
accesses up to raw_data[14]. By unconditionally checking if the size is
less than 17 before evaluating the report ID, any 15-byte or 16-byte report
will hit this early return and be rejected with -EINVAL.

Should this size requirement be localized strictly to the NS2_REPORT_UNIFIED
branch to avoid breaking functionality for legacy controllers?

>  	guard(rcu)();
> @@ -3776,11 +3877,51 @@ static int switch2_event(struct hid_device *hdev,=
 struct hid_report *report, uin
> =20
>  	switch (report->id) {
>  	case NS2_REPORT_UNIFIED:

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630084838.2313=
379-1-vi@endrift.com?part=3D3
