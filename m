Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F4530D3FF
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 04:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787285994; cv=none; b=BXm9FLRWoCHt59Gv2Fq/3mrk9AjJTp1G2PYu67dcbpqrd8uniwos7v6vQUemCMjjCxDZJ5PjzegeW3NAvHIMf1/EKp++4k+Gtqs5Z8QadtjG4iWzBnAkyDj/6Uneul8V9E1UYXCwr35ePtrYvHvM+QTg9RRGS6Ss5ZscHfOvrZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787285994; c=relaxed/simple;
	bh=tc9kW0WvJCOJKZ7hKBawPZlI8Xu/+B1v6OBjiTzEoV4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G2QOO/Hwk7rDLAj6ky/aSShw8zIeYx+DKD8kjWcIQ4irCNhROXrgvz5aDBv2esRf8vMi7Fbu4+EXj7xK1uWXGq04qktEL/OveQ11FwegaPNj8JhRzw9JONwZpHtOiPfHF1p/bV8pUZYmPtSJg6g7pyTaVxbwyb6UpPn8aY/0DwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhvFC0LJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhvFC0LJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE131F000E9;
	Fri, 21 Aug 2026 04:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787285991;
	bh=XxqO66hl1i647MIO+saZaU2HNDgZpLiSocBbDaAZJnQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RhvFC0LJ1bREDNB11fCecPlwSJ7YRO3Vz/6/xDgbvbDeeI0Mf5II8TRSYyVMI0Cxm
	 Q4iCnbFbiKHit0otGyLCJLpwbTh38YFIPx14Q7z0RBYOxwV7ZqSwb9Jvx85EAYborz
	 g4SJKk7tkBSKRF3gKYqM5LD8aOVq+443R/9vB+tqMrPHcqrU8F3YxtITWPsqQcoWmb
	 IE366HScI/woIVY7EM1Lm9H3DdrDeciyoX1Ebt66qtnn4BMyPB01D3Cp7sndcekSD0
	 TM//iu21cdRqxFuO3qQv4pGcs2DsFCbZkHoibKp1v7v3KzRHC39k40HmZQ36XtodFD
	 Z7Z8ONXlbWmQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] input: touchscreen: Convert to
 DEFINE_SIMPLE_DEV_PM_OPS()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Triet Hoang" <triet.hoang.dev@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260821040905.104590-1-triet.hoang.dev@gmail.com>
References: <20260821025514.31AE01F000E9@smtp.kernel.org>
 <20260821040905.104590-1-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 04:19:51 +0000
Message-Id: <20260821041951.7DE131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The logic in `ad7879_toggle()` is completely inverted, causing the=
 sysfs `disable` attribute to malfunction and desynchronize the hardware st=
ate from software tracking.
--

--- Patch [1]: [PATCH v2] input: touchscreen: Convert to DEFINE_SIMPLE_DEV_=
PM_OPS() ---
commit b2cacedba4aaf53cb97b0b4bbb302d78a3a37daf
Author: Triet Hoang <triet.hoang.dev@gmail.com>

input: touchscreen: Convert to DEFINE_SIMPLE_DEV_PM_OPS()

This commit converts the deprecated SIMPLE_DEV_PM_OPS to
DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr() across several touchscreen
drivers. This allows dropping the __maybe_unused annotations and reduces
kernel size when PM features are disabled.

> diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscre=
en/ad7879.c
> index 31d2a3029d5f6..10f8574f478e2 100644
> --- a/drivers/input/touchscreen/ad7879.c
> +++ b/drivers/input/touchscreen/ad7879.c

[ ... ]

> @@ -329,8 +329,7 @@ static int __maybe_unused ad7879_resume(struct device=
 *dev)
>  	return 0;
>  }
> =20
> -SIMPLE_DEV_PM_OPS(ad7879_pm_ops, ad7879_suspend, ad7879_resume);
> -EXPORT_SYMBOL(ad7879_pm_ops);
> +EXPORT_SIMPLE_DEV_PM_OPS(ad7879_pm_ops, ad7879_suspend, ad7879_resume);
> =20
>  static void ad7879_toggle(struct ad7879 *ts, bool disable)
>  {

[Severity: High]
This is a pre-existing issue, but the logic in this function appears to be
completely inverted.

Looking at the full ad7879_toggle() function in
drivers/input/touchscreen/ad7879.c:

static void ad7879_toggle(struct ad7879 *ts, bool disable)
{
        guard(mutex)(&ts->input->mutex);

        if (!ts->suspended && input_device_enabled(ts->input)) {

                if (disable) {
                        if (ts->disabled)
                                __ad7879_enable(ts);
                } else {
                        if (!ts->disabled)
                                __ad7879_disable(ts);
                }
        }

        ts->disabled =3D disable;
}

If a user writes 1 to the disable sysfs attribute (disable =3D=3D true), an=
d the
device is already marked disabled (ts->disabled =3D=3D true), won't this lo=
gic
actually enable the hardware by calling __ad7879_enable(ts)?

Conversely, if the user writes 0 to enable the device (disable =3D=3D false)
while the device is currently enabled (ts->disabled =3D=3D false), won't th=
is
unexpectedly disable the hardware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821040905.1045=
90-1-triet.hoang.dev@gmail.com?part=3D1
