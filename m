Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11C12E719B
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 21:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792360106; cv=none; b=dFiWmxp6Y4wqK1gyW0FAqyU8neRk7bzo9FowfSPoBEJ5GzJh4WKOHL7T20wQ2GxUv5sCtsLkoo1wAt4qTwVcEYbX1E72HPwGWPQ9VQjZ9197stRRCI4N/5JUPvoHJlhyxuyL+gKChdeR8WARQZ2HDL0oKOY1lFkrcrXDgnS/PqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792360106; c=relaxed/simple;
	bh=JrhDUgnqoy5fPsQyTwic/9BsEru1BLJ1182dakeplUI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=RgyfTYh0Iyp3Vj55N6b9g6vjD7te4/JVpBSMQCEWhIBKB4TUNVu9dOuvmgvhNlT9O8A74mNb+BtOukBMk7YK3hhYmcB4YNpnrppVinycFvl3IyjWUV19uaBQIxOhtfIfzgq5uQhyDsdGCHbFVUH3NIhDQbS5HPzh6WP/j2ISFs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToN2EYQG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToN2EYQG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADFD81F000C4;
	Sun, 18 Oct 2026 21:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792360104;
	bh=H4VEDdoyIFuJmfgauQvqPEqNDXzm7pM7UWIxzCNiv6E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ToN2EYQGdzdWHViSW5iImjE0PNoaaWw4x7TqvThZ5iks22SuUzmNTGVhSERjYA8pw
	 wLLDZyt53k64kiVjKXH13wk2Rkn9EYwMWzgd4NO508Luggofwsd3cLilLAPDMMjZFq
	 SPttr7YzUxPLHxlGCV03MiWnoJKpSOJ8YqPKznKgT9uUgLwJ4/mGgs/RURDbwDi1PA
	 lix83lxV6NNj2FuTSUSmctENu7kw713rfsc8sCZuhtTt8mZSN7Jq3HRvymbscU5NeD
	 X53WBKs86IIeYb/4XpQz0PkTPVVa5FcbP7xDzNlco+gF12hXLp1r/+GssnJxKaFalx
	 TA5Eyc7WAdLZA==
Message-ID: <sashiko-outbox-176413@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] HID: oxp: validate report size in raw_event
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tristan Madani" <tristmd@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261018213754.1951187-7-tristmd@gmail.com>
References: <20261018213754.1951187-1-tristmd@gmail.com>
 <20261018213754.1951187-7-tristmd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 21:48:24 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] HID: oxp: unvalidated 64-byte read in oxp_hid_raw_event() dev_db=
g()
--

commit 1f763db8177cf3b395303a0f7956ff3e6b99d798
Author: Tristan Madani <tristan@talencesecurity.com>

HID: oxp: validate report size in raw_event callbacks

This commit adds report size checks to oxp_hid_raw_event_gen_1() and
oxp_hid_raw_event_gen_2() before casting the report buffer to
struct oxp_gen_1_rgb_report and struct oxp_gen_2_rgb_report.

> diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
> index 1e691ebc1199e..af9f60d45bf29 100644
> --- a/drivers/hid/hid-oxp.c
> +++ b/drivers/hid/hid-oxp.c
> @@ -318,6 +318,9 @@ static int oxp_hid_raw_event_gen_1(struct hid_device =
*hdev,
>  	struct led_classdev_mc *led_mc =3D drvdata.led_mc;
>  	struct oxp_gen_1_rgb_report *rgb_rep;
> =20
> +	if (size < sizeof(struct oxp_gen_1_rgb_report))
> +		return 0;
> +
>  	if (data[1] !=3D OXP_FID_GEN1_RGB_REPLY)
>  		return 0;
> =20
> @@ -391,6 +394,9 @@ static int oxp_hid_raw_event_gen_2(struct hid_device =
*hdev,
>  	struct led_classdev_mc *led_mc =3D drvdata.led_mc;
>  	struct oxp_gen_2_rgb_report *rgb_rep;
> =20
> +	if (size < sizeof(struct oxp_gen_2_rgb_report))
> +		return 0;
> +
>  	if (data[0] !=3D OXP_FID_GEN2_STATUS_EVENT)
>  		return 0;
> =20

[Severity: Medium]
Can a short report still trigger an out-of-bounds read in the caller
oxp_hid_raw_event() before reaching these checks?

In drivers/hid/hid-oxp.c, __hid_input_report() invokes the driver's
raw_event callback oxp_hid_raw_event(), which runs dev_dbg() with
OXP_PACKET_SIZE (64) before dispatching to oxp_hid_raw_event_gen_1() or
oxp_hid_raw_event_gen_2():

drivers/hid/hid-oxp.c:oxp_hid_raw_event() {
	u16 up =3D get_usage_page(hdev);

	dev_dbg(&hdev->dev, "raw event data: [%*ph]\n", OXP_PACKET_SIZE, data);

	switch (up) {
	case GEN1_USAGE_PAGE:
		return oxp_hid_raw_event_gen_1(hdev, report, data, size);
	case GEN2_USAGE_PAGE:
		return oxp_hid_raw_event_gen_2(hdev, report, data, size);
	...
}

When a report with size < OXP_PACKET_SIZE is delivered (for example via a
short transfer, hid_bpf_input_report(), or __hid_request() where
hid_alloc_report_buf() allocates hid_report_len(report) + 7 +
(report->id =3D=3D 0) bytes) and dynamic debugging or DEBUG is enabled, the
dev_dbg() call reads 64 bytes from data regardless of size.

Should the dev_dbg() call in oxp_hid_raw_event() pass size instead of
OXP_PACKET_SIZE (or validate size beforehand)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018213754.1951=
187-1-tristmd@gmail.com?part=3D6
