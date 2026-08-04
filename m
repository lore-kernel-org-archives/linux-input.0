Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6976F3F8898
	for <linux-input@vger.kernel.org>; Tue,  4 Aug 2026 02:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785809849; cv=none; b=AS5PfhHfInDszGwOnhmyUYAfqe9Qa3SrNF/jQhVN/sd9dzSqsR0ZtKpHCcgNiGlkosKnUVdVl9oFl9tbTfxGdYk97WBdchqLW+kDuyJOxITwg4Gg2oYbD/F3Nc79GEKAkgjcIjWGZQKmAae6mpNJ7YoAGtaQalYlNerJKyVcr5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785809849; c=relaxed/simple;
	bh=K47S4gvRtpFRkuVPN5mtNUh3v5CqVJObpjzb1inZA1w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mdV6q1gUnR1amzsItoVezaYINTDDfIgWFPkWmni5q05P/i3jZHl/DjPP1IPVpFWP9Hl2+4IxjDVpCnzhMiS5BcPAoSWinz80oDeEjIPZ3u2W55mcYg8VbPYWXV1ImhPpldNNPPmR5uWo0PTu15AAXAQYgF07ky3dRNfXaXGgQNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIxRZzfE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIxRZzfE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37D31F000E9;
	Tue,  4 Aug 2026 02:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785809848;
	bh=ThUBIpCxZNllafNIGvlgfMGaZwpwYQhm9SQsE8kr1FM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XIxRZzfE5jn98xmwjbM5tJALu0vLX6etJIJMYXqUsjc61W8aXKnfgkEbKSfRP7PFq
	 9T9g//igZrl7CtEL04NXPcUnGoOkyqdEznSg2iDD7IOzx6wGwtMiD74670zXoUlc88
	 61nL4sjSB3zVY4sOy1Wwrzc5nkPuajrlisdYQio/m53370GmqxiEvxKYNc87NCE1KZ
	 ykR2gkDLXtCfDTJultWrehbIbwrsUP/HR9cfl39wwkfgZC1N6B5ljwcZlosPktKI2T
	 a6fp6/tlK554ORWjTekalkl+BLUsUdxanpDFGC7lXKvu04lAVx3mVnqNga60d48Oax
	 6PkNjhmRESjvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: hynitron_cstxxx: reject out-of-range finger IDs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jianing Li" <m13940358460@163.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260804020314.2082-1-m13940358460@163.com>
References: <20260804020314.2082-1-m13940358460@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 02:17:26 +0000
Message-Id: <20260804021727.D37D31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds check on `touch_cnt` leads to out-of-bounds stack m=
emory reads.
--

--- Patch [1]: [PATCH] Input: hynitron_cstxxx: reject out-of-range finger I=
Ds ---
commit 91e0c941ddcc6d0f4ff8d05bd12420502e2416a4
Author: Jianing Li <m13940358460@163.com>

Input: hynitron_cstxxx: reject out-of-range finger IDs

The driver allocates max_touch_num input slots, which are indexed from
zero through max_touch_num - 1. This commit fixes an out-of-bounds access
by rejecting finger IDs that are greater than or equal to max_touch_num
before using them as slot indexes.

> diff --git a/drivers/input/touchscreen/hynitron_cstxxx.c b/drivers/input/=
touchscreen/hynitron_cstxxx.c
> index f6139b1a86811..05e877b0d8776 100644
> --- a/drivers/input/touchscreen/hynitron_cstxxx.c
> +++ b/drivers/input/touchscreen/hynitron_cstxxx.c
> @@ -334,7 +334,7 @@ static void cst3xx_touch_report(struct i2c_client *cl=
ient)
>  		finger_id =3D (buf[idx] >> 4) & 0x0f;
> =20
>  		/* Sanity check we don't have more fingers than we expect */
> -		if (ts_data->chip->max_touch_num < finger_id) {
> +		if (finger_id >=3D ts_data->chip->max_touch_num) {

[Severity: High]
This is a pre-existing issue, but while we are checking for out-of-range
values in cst3xx_touch_report(), is there a missing bounds check on
touch_cnt earlier in this function?

The touch_cnt is extracted from the 28-byte fixed-size buf array:

    touch_cnt =3D buf[5] & CST3XX_TOUCH_COUNT_MASK;

If the device returns a touch_cnt greater than 5, wouldn't the end_byte
calculation result in an out-of-bounds stack memory read when checking the
last touch slot?

    if (touch_cnt > 1) {
            end_byte =3D touch_cnt * 5 + 2;
            if (buf[end_byte] !=3D CST3XX_TOUCH_DATA_CHK_VAL) {

For example, a touch_cnt of 6 or more would evaluate to an end_byte of 32
or greater, reading past the end of the 28-byte buf array. Similarly, the
subsequent coordinate extraction loop would also sequentially read past the
end of buf.

Can this out-of-bounds read occur if the device firmware malfunctions or
returns an unexpectedly large touch count?

>  			dev_err(&client->dev, "cst3xx touch read failure\n");
>  			break;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804020314.2082=
-1-m13940358460@163.com?part=3D1
