Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58B0379C56
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 03:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863831; cv=none; b=QO95KqCrF5YJmG6ER2+8WoLosdmj5dWgzSPqCkwMwe5o6tAkLL5BLU3VlRK6MFwnc3Iu44Z/jPQ2bXaA6cKqkjFzgM5bnynVrabiNOZ3lx0X5G8ZlV0CNm+593hXpg6yDQ7IUSxd/1w2zpahLiaYLCqNEmuXmu6SHwBqPn2uuRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863831; c=relaxed/simple;
	bh=BxgSs0P1taReAKpeQDAvm7pto6zXKv5qnKOHslgxlc0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=mc96moJVQZ0aHsT0y9bMKlsQUvMTAH7mLDhfPmG0Z8Y4/jvj7Akq3DNY2RqJ/BOghEBOONJBhV9Fd6bNF34K50M8rM0yvOdrDr+vSVM5yj+giaQtbMaXzyajDEOXf4WQir0WLrvGFy+eg/zW9A0rLXyxyT4gBK5pwnyeF1SGZ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kU24/YKI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kU24/YKI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED841F000FF;
	Tue, 13 Oct 2026 03:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791863830;
	bh=fcLxbl66svv+3JYbbmWVMOC09q8Cqpy6mHlqxHxjiHE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kU24/YKIQllMeP7ip+o1ovEJg7vI7yMU7XS9tYU75nFMzs41MkFwQYEt4NRjQG0YI
	 WMAjE5p8zVo/ZRkXbmkresS/bCMGHbCcgnRgN6OB8RzLwmhG3quaHC3oxEy0sebjVA
	 nLdDoUTHCBxOKyxTwrli41wnSjJM4fxfj+P3BwUITgJWpkOOn0LS8uoJcYuTvxFrv9
	 22VdNydjr/L6eWb35o7HGBMk+rML1LWO7ZIacxc5LN8ch0F5rU4EGP/HJYs+8leUk9
	 2FidwIXq3Ao/9Jq1sI9bfdJu/v6nwtZENVWpL43MvxkueDTFl1+r7m5fOlawDJcDmm
	 PidmbyOyvK4AQ==
Message-ID: <sashiko-outbox-168940@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/9] HID: intel-thc-hid: Drop redundant report ID
 validation in quicki2c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
In-Reply-To: <20261012-hid-core-report-validation-v1-7-e0dd5cb60b2e@gmail.com>
References: <20261012-hid-core-report-validation-v1-0-e0dd5cb60b2e@gmail.com>
 <20261012-hid-core-report-validation-v1-7-e0dd5cb60b2e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 03:57:09 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] hid: intel-thc-hid: hidraw GET_REPORT fails if buffer size exceeds=
 report size
- [Medium] HID: intel-thc-hid: information leak via short DMA read
--

commit 75e0494a01241a3ea09c387003f59cc3e7199dc8
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: HID: intel-thc-hid: Drop redundant report ID validation in quicki2c

This commit removes the report ID validation from the Intel QuickI2C driver=
's
report retrieval path, as the core HID layer now handles this centrally. It
leaves the packet length validation intact.

> diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.c=
 b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.c
> index 41271301215ab..7a362a2ebe2b3 100644
> --- a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.c
> +++ b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.c
[ ... ]
> @@ -160,9 +160,9 @@ int quicki2c_get_report(struct quicki2c_device *qcdev=
, u8 report_type,
>  		return ret;
>  	}
> =20
> -	if (HIDI2C_DATA_LEN(le16_to_cpu(rpt->len)) !=3D buf_len || rpt->data[0]=
 !=3D reportnum) {
> -		dev_err_once(qcdev->dev, "Invalid packet, len (%d vs %zu) report id (%=
d vs %d)\n",
> -			     le16_to_cpu(rpt->len), buf_len, rpt->data[0], reportnum);
> +	if (HIDI2C_DATA_LEN(le16_to_cpu(rpt->len)) !=3D buf_len) {

[Severity: High]
Does requiring an exact match for buf_len break the hidraw API? If a
userspace application calls HIDIOCGFEATURE with a standard oversized buffer
(e.g., HID_MAX_BUFFER_SIZE), buf_len will be larger than the actual report
size, causing this check to fail with -EINVAL.

[Severity: Medium]
Is there a risk of leaking stale data on a short DMA read?

If thc_swdma_read() successfully performs a short read, it returns 0 and
sets read_len to a value smaller than expected, leaving the rest of the DMA
buffer stale. Because this check exclusively relies on rpt->len instead of
the updated read_len, a stale rpt->len matching buf_len will pass this
validation.

This would lead to the memcpy() further down in quicki2c_get_report()
copying stale kernel memory into the buffer.

> +		dev_err_once(qcdev->dev, "Invalid packet length (%d vs %zu)\n",
> +			     le16_to_cpu(rpt->len), buf_len);
>  		return -EINVAL;
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-hid-core-r=
eport-validation-v1-0-e0dd5cb60b2e@gmail.com?part=3D7
