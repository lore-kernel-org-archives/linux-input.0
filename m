Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AD82E413
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 00:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778544295; cv=none; b=FN9POR8EyBAbquoZ+eVu4wYm4lgsPTRqOg8Vhp8BsnjxJep7F4Y1MYpXv57UFQNeKeFtBUusSCyiDYmA8dNhroeIxzrp6H/f0vrFb1+jyfLvN8zUDrqJ6x7vTW0OmGUqxpRhkeA6s6pEwMtBDtBrxPMWFNxSZOhHNnoz98GiZUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778544295; c=relaxed/simple;
	bh=syDMp2Xmca3gvRoU20qXKQKz1mHtPNSYB9h64pPtsxY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fznys/dchG8Yh8apPi4IRLOJDyUe1q2pLlSUXMJlhocC7xF+6gyk2oOJgiAQEYoP6ldsBFUwcnmKq7EXL1r8vbJ9/ToUjX7pPYclYqZUCdP+aiANWKdHud2aQW3kBnvhPBvb+rS7FGkG+wb+mMmYxybKnj0+r0UJs/PKfbZbYR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/DbpET8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/DbpET8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AB2C2BCB0;
	Tue, 12 May 2026 00:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778544295;
	bh=syDMp2Xmca3gvRoU20qXKQKz1mHtPNSYB9h64pPtsxY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=m/DbpET8aj0HkfRh0PQa7t0I9+7gdX0MvREVk2nyGqU9iKc4BKPbme/SsSOUHiB1g
	 yE3VVYKSycOQ2EVFCWa1wsLgcmq4RRRx8CGEnQEnInYr/OuuVRerJMssTOCfPeXOb5
	 1BuZ4a/cg7h1xVkUqWrOGynXepRtWiIrDwlozjVS7ULPh8bFYavPuIBz/6cWsnx7J3
	 qA8bfnOyebOCQ9BHTtSU7/wvR712JrgNQu0iF1Yd3DjcpcvubRT1RR2V2Vn/k8ZuV+
	 8s73vp1H7+4scfOAgPbDAxh1nFcUVd3AMuspC4Q+s6zp/Fm+PUWGF55cjPSx+KK+P1
	 3y8g6XPjtq+aA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: tsc2007 - fix resistance calculation when A/D
 value is saturated
Reply-To: sashiko@lists.linux.dev
To: "Yuki Horii" <yuuki198708@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260511054003.1205-1-horiiyuk@ishida.co.jp>
References: <20260511054003.1205-1-horiiyuk@ishida.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 00:04:51 +0000
Message-Id: <20260512000455.44AB2C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Uninitialized stack variable read in the IIO raw read path.
- [High] Returning 0 to invalidate saturated A/D values causes phantom touc=
hes with maximum pressure or premature pen-up events.
--

commit 8a6bcc1904d4e8b8d9d219e6c086925c53bfc4cb
Author: Yuki Horii <yuuki198708@gmail.com>

Input: tsc2007 - fix resistance calculation when A/D value is saturated

This patch modifies the touch resistance calculation to return 0 when either
the X or Y A/D value is saturated. This is intended to indicate that the
touch resistance calculation is invalid.

> diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/tou=
chscreen/tsc2007_core.c
> index f9b3d2598933c..7d3bc0c396113 100644
> --- a/drivers/input/touchscreen/tsc2007_core.c
> +++ b/drivers/input/touchscreen/tsc2007_core.c
> @@ -69,9 +69,9 @@ u32 tsc2007_calculate_resistance(struct tsc2007 *tsc, s=
truct ts_event *tc)
>  {
>  	u64 rt =3D 0;
> =20
> -	/* range filtering */
> -	if (tc->x =3D=3D MAX_12BIT)
> -		tc->x =3D 0;
> +	/* invalidate touch resistance if X or Y coordinate is saturated */
> +	if (tc->x =3D=3D MAX_12BIT || tc->y =3D=3D MAX_12BIT)

Does this code read uninitialized stack memory? The IIO path initializes
tc.x, tc.z1, and tc.z2, but it does not initialize tc.y before passing the
struct to tsc2007_calculate_resistance():

drivers/input/touchscreen/tsc2007_iio.c:tsc2007_read_raw() {
	...
	case 5: {
		struct ts_event tc;

		tc.x =3D tsc2007_xfer(tsc, READ_X);
		tc.z1 =3D tsc2007_xfer(tsc, READ_Z1);
		tc.z2 =3D tsc2007_xfer(tsc, READ_Z2);
		*val =3D tsc2007_calculate_resistance(tsc, &tc);
		break;
	}
	...
}

> +		return 0;

Is it safe to return 0 to invalidate the sample?

In tsc2007_soft_irq(), if there is no pendown GPIO, !rt evaluates to true
and prematurely breaks the polling loop, causing an early pen-up event.

If there is a pendown GPIO, rt <=3D ts->max_rt evaluates to true. Then the
driver calculates pressure as ts->max_rt - rt, which maps rt =3D 0 to the
maximum possible pressure. This results in a valid touch being reported at
the saturated coordinates with maximum pressure, rather than ignoring the
sample.

Should this instead return a value strictly greater than ts->max_rt (such as
U32_MAX) so the debouncing logic safely ignores the invalid sample?

> =20
>  	if (likely(tc->x && tc->z1)) {
>  		/* compute touch resistance using equation #1 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511054003.1205=
-1-horiiyuk@ishida.co.jp?part=3D1
