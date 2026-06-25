Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027242BE7CD
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 05:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782364417; cv=none; b=SQGgjOVVsIbYl3gAryQsFZ7b1ni7I/y9AH5oTNS9Q097h313dj9YhJNJUCazClQg/v0E1oT0Wr1X6HBcNyx+3+IjEuiJJ/9mRAP7hjWG+kPf9ulh7sEsXg7u2fMxuPxB3Ucr4Ei7STpf8IpulvIoP7HCL/zoq4hQC3xHPvWEgnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782364417; c=relaxed/simple;
	bh=qe8Fuzi0/5hcUKnb4jfjqrP1UNej3vqruqS2G3wxGAs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f+hX8nFdnGgZjcW1CHt/9FNX2nM3kbcOhpEHVloVz6eM+aQyporYNJ2z6SMoams3w62T9dyrGJ2vf263bXORuUp+SH0LbadMOEvn5ZQJ8szqkr1YrqDQunB8HieONaa6icG6Wyrs1Q5CnaFNQrzPZjV31Q70wKsBc9+0OToHl74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2+fNTh5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2+fNTh5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F41E1F000E9;
	Thu, 25 Jun 2026 05:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782364415;
	bh=mTlOkrZTxswa4R0gzuzYosb7i3oLtihgfhQAOHRzxhg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n2+fNTh5QzET8BWLLHum2Agq3Xr73UB6ftxDu1jjyNIJ9rXgCU2r4BapZipLbW0v8
	 vYe+RJc8GE8x92QrcMHhbCLelOZp/zSJS/P3Olr/AKomldNLoEYoLOgFGVO4fMW1HX
	 +ko88t+P8L8Glqq7I9TJ3ho4usJRbINtAE2dZ1LQbRYrxGbXxLrraOe64dOJrdHD+p
	 //YatojGwMTnQczlUuVOmUOe6y3uox9BI5R4rHbhFrSbnacR93ggMNCrcl3x2ZLsMO
	 JJfnSG/zDklPNlUeYMH7xw6IoT2VMm+1HcbBaSudV8xkn0EJ5hLTAZamxRzYwrgek/
	 Gf2B5c9MdbkRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/3] HID: nintendo: Add unified report format support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260625045948.2343168-4-vi@endrift.com>
References: <20260625045948.2343168-1-vi@endrift.com>
 <20260625045948.2343168-4-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 05:13:34 +0000
Message-Id: <20260625051335.6F41E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Global minimum report size check incorrectly rejects valid legacy,=
 non-unified reports.
--

commit ebbc8f2a738bc80390ec8c8785093f44578537e8
Author: Vicki Pfau <vi@endrift.com>

HID: nintendo: Add unified report format support

This commit adds support for the unified report format that all controllers
also support. It includes overlapping fields for like buttons and axes betw=
een
them.

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index ae360f4d15d1a..9cb4a503fe2d3 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c

[ ... ]

> @@ -3732,7 +3833,7 @@ static int switch2_event(struct hid_device *hdev, s=
truct hid_report *report, uin
>  	if (report->type !=3D HID_INPUT_REPORT)
>  		return 0;
> =20
> -	if (size < 15)
> +	if (size < 17)
>  		return -EINVAL;
> =20

[Severity: High]
Does this global size check incorrectly reject valid non-unified reports?

Since non-unified reports like NS2_REPORT_GC only access up to raw_data[14]
and can legitimately have a size of exactly 15 bytes, it seems this check w=
ill
cause those legitimate 15-byte or 16-byte reports to be dropped with -EINVAL
in switch2_event().

Should this 17-byte requirement be scoped inside the case NS2_REPORT_UNIFIE=
D:
block instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625045948.2343=
168-1-vi@endrift.com?part=3D3
