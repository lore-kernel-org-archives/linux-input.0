Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BC930677D
	for <linux-input@vger.kernel.org>; Fri, 22 May 2026 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435100; cv=none; b=C4dsluOFmS7UtazmRSrUZpp/pYfcw1o7Vf1/Syyp3VHQPuSLTUvgXwCf34VFvwAvDqVahQtbzW0Qs5264eKcxYwCDqvr8ZaiJ5jrOyHpOt+5m9ZEyOCmNjw3+cKmjrTG5RxGMRjbetoSzLbI6XrDggw7v0otkoajbdSA+vSKftQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435100; c=relaxed/simple;
	bh=wcNWtvmG+iyHs7YM/CFArKqODU6ijW6BI3nyEBotntk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mWGmrjErK2zx+G3+h5nbyfCn2YFuaar7nssWI45SiMP7Of849CHHcaHXfjDHApAxN4AO6oJ6LPcrxA3L8d+lm7c9O442I6rgvjb1AE/rvlFRwyIsPy01VQ0Ptu0Lw8TrTo/acA34v9RshBa9xk1BW1dqPDkMK6CPsmxk/VnV9Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ec9SS46F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ec9SS46F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96C91F000E9;
	Fri, 22 May 2026 07:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779435099;
	bh=NJiLTHVYBE3hmKp6q1PNGYVHBDH0XHCMH/jXj0Wh+go=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ec9SS46FIYmXfwlXu5RYAdQOpfBD8of6zvarN97OIikkjUrJMOly8jtaOIe+GgqfM
	 mfU4TsQGEIn53GoXQXyg8/F8pzjodbXzCCc9E0AqDVqmvUZLwXZZ2BX622ITJTBXuQ
	 NPfzP1WoSjVRKWmuJDriSAgcv90bMi9pnDcMcrDkrq2YjC3aQbFeeUlk0F7DgzWZze
	 AmGaZIOVygWUwnPBMe/YQm+PcQBdy7iqlz8z6iuXEOUW44wk9yR+EVd0jYY6NxFjw4
	 I6xrYOjrURz9Mbj+J5iYqsoAFR4NJ3aXHtulKjfnDt8VENNqNMR1utUd4RQnAFCngi
	 hdcFiDr3lH91Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: core: Fix bsize printk specifier in
 hid_report_raw_event()
Reply-To: sashiko-reviews@lists.linux.dev
To: yaolu@kylinos.cn
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260522072718.186707-1-yaolu@kylinos.cn>
References: <20260522072718.186707-1-yaolu@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 07:31:38 +0000
Message-Id: <20260522073138.A96C91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incorrect format specifier for the `size_t` variable `bsize`. The p=
atch replaces `%ld` with `%u` to fix a warning on 32-bit architectures (whe=
re `size_t` is `unsigned int`), but this introduces a new warning on 64-bit=
 architectures (where `size_t` is `unsigned long`). The correct format spec=
ifier for `size_t` is `%zu`.
--

commit d6a5fb9c76c9718771a50e1f79f29b3df496f869
Author: Lu Yao <yaolu@kylinos.cn>

HID: core: Fix bsize printk specifier in hid_report_raw_event()

This commit attempts to fix a build warning on 32-bit architectures by
changing the format specifier for a size_t variable from %ld to %u.

> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index b3596851c7191..c21c58d7bf02b 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2050,7 +2050,7 @@ int hid_report_raw_event(struct hid_device *hid, en=
um hid_report_type type, u8 *
>  		return 0;
> =20
>  	if (unlikely(bsize < csize)) {
> -		hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d v=
s %ld)\n",
> +		hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d v=
s %u)\n",

[Severity: Low]
Will this cause a new format string warning on 64-bit architectures? bsize =
is
of type size_t, which is an unsigned long on 64-bit systems. Should this use
the %zu format specifier instead to be portable across both 32-bit and 64-b=
it
architectures?

>  				     report->id, csize, bsize);
>  		return -EINVAL;
>  	}

[ ... ]

> @@ -2072,7 +2072,7 @@ int hid_report_raw_event(struct hid_device *hid, en=
um hid_report_type type, u8 *
>  		rsize =3D max_buffer_size;
> =20
>  	if (bsize < rsize) {
> -		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d =
vs %ld)\n",
> +		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d =
vs %u)\n",

[Severity: Low]
Similarly here, should this also use %zu for the size_t variable bsize?

>  				     report->id, rsize, bsize);
>  		return -EINVAL;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522072718.1867=
07-1-yaolu@kylinos.cn?part=3D1
