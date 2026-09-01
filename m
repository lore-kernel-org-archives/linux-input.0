Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337E447126E;
	Tue,  1 Sep 2026 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788249818; cv=none; b=i1qaAMXFADRLFAxawZPI2tFpi2BJZnXgHfvAbHI8BtH3XUnouFpQLNvAldpWkScxOhhDo+toI8An7P6JjDMxpK5iMNMZMiwY1zNCb/OrxCRfHE8a5XjhsHcDdR7inmGavbNZ48cC1X6PvOn8KW5iw08NonnX106nJI4Wbw3RvYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788249818; c=relaxed/simple;
	bh=RU6diuHJKS/aoFWyd2y6MmciRgNQLDVdpJV4o967oC0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qBj2QaIrINqhgCiRbZmU5QWhZHT3lYEPzWvNLIucheH0y8c7xgjR3vJ6AQLRDqtU4/uWC241vnqblNNRCqfNDWDMJ8aKyxf/UewLKZNUVu/d8La3uVZtH44S+gpsLXvrGTr7gwy1PUKHApbyEPW88oL5Q8kBDJl7kiD9LN7viXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFdK7c6v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFdK7c6v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665A31F000E9;
	Tue,  1 Sep 2026 08:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788249816;
	bh=BLJXOaxHqeNcfPLBq53jPT6Zj/HhLidLeWmVbD+NYl8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jFdK7c6vz24CU/CWXUOYXdMHFuTRe7HpaVU2YvDWzW2NY+90EEtyoAvczTOFvVdJf
	 1Ou3E3a7IrEIdICW4bx3Wn7vU+7od0hBbDr/CNmSULCW0utgTkAXzFcdkZX0c0pkp7
	 pG9K4OuNZuft2gu0C1QPXMzIygne6iotcyUc3LRpqDD47xtJsDRXInNyyoQ0Lz8AuN
	 e0NOwvEWpQCY/wzkp5Z6Dnt57HqJGXES/m1eJ1WVhsxeJ2Vd3OeEv3H43c9KGDZyT0
	 j0wQtrrgVYrBUdjE6O7/VMJcb6eoLZNRtamElbIIUhfY1tCussnIsRqX3/x3UVRZH2
	 C9qrCZm+Vmk4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/8] regulator: core: Add "enable and wait" functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen-Yu Tsai" <wenst@chromium.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260901074930.764550-2-wenst@chromium.org>
References: <20260901074930.764550-1-wenst@chromium.org>
 <20260901074930.764550-2-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 08:03:35 +0000
Message-Id: <20260901080336.665A31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Mismatched timebase used for `last_off` initialization, which brea=
ks `off_on_delay` semantics.
--

commit 4cf0bd57fa8e1cfa65a0e290c2b4a44f43cb23db
Author: Chen-Yu Tsai <wenst@chromium.org>

regulator: core: Add "enable and wait" functions

In device power sequencing and initialization use cases, it is common
for the driver to enable the regulator and then wait for a certain
period of time to pass before continuing. In cases where the regulator
supply is always on, or has been turned on or left on by another consumer,
the driver could shorten the delay or skip it altogether, provided that
enough time has already passed since the regulator was actually turned on.

> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 6a4008f387b5e..d7a193a3bcb28 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c

[ ... ]

> @@ -3061,6 +3108,8 @@ static int _regulator_do_enable(struct regulator_de=
v *rdev)
>  		fsleep(delay);
>  	}
> =20
> +	rdev->last_on =3D ktime_get_boottime();
> +
>  	trace_regulator_enable_complete(rdev_get_name(rdev));
> =20
>  	return 0;

[Severity: High]
This isn't a bug introduced by this patch, but since you are working with
timestamps in this function, could this timebase mismatch break off_on_delay
semantics?

In set_machine_constraints(), last_off is initialized with the monotonic cl=
ock:

	rdev->last_off =3D ktime_get();

But earlier in _regulator_do_enable(), the remaining delay is calculated us=
ing
the boottime clock:

	ktime_t end =3D ktime_add_us(rdev->last_off, rdev->desc->off_on_delay);
	s64 remaining =3D ktime_us_delta(end, ktime_get_boottime());

Because ktime_get_boottime() includes suspend time and ktime_get() does not,
the required delay is bypassed entirely if the system has accumulated suspe=
nd
time greater than the off_on_delay.

Will this lead to hardware sequence violations and incorrect functional beh=
avior
unconditionally for any regulator with an off_on_delay registered after the
system has been suspended (such as via hotplug or module load)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901074930.7645=
50-1-wenst@chromium.org?part=3D1
