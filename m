Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9964734F9
	for <linux-input@vger.kernel.org>; Fri,  2 Oct 2026 09:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932443; cv=none; b=iPOEEZh4F4hnmo+KXQI8rBsc8haxAgEg3ChqIQu16J6C4CrhDOzGeBkM4a52+kkCRVeU7lZU9TjzbUilVO2XXWhCh2hJ67SYTy5V9t8oos5ko/pjgK/YlyAWiRCMdNFuFBh6JqBkjMCvtJyH+wMMst4s4KOSlgdWg1QAp/LUioU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932443; c=relaxed/simple;
	bh=zpFrNM/hFBVHZyomc1WBPBSTD5momA0VT1i/b3eO2us=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WU9Cs8F0RifCS9BTWhNfyi6vgQmJchizNs/P3r7mpXI/b+dSQWxZJKRlshPf0zrMVEr/dLNbN2Uf0GXLA9/ZFTtBNtyXX47yDywSM4ntVJWmwqPbFOaYNidcji21SMrCaoaNYi5B36gc37zxHC5esT5qsj9YxBL9mhsn3qNym4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyEBin36; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyEBin36"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17011F00899;
	Fri,  2 Oct 2026 09:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932442;
	bh=BTg7FUS7L6jNH5DmorNu7s6Mq61rLJNvLjySgAvHXoQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VyEBin36jy7KKw+mZcFAuxBuYxJ8Pj8vDUnl6S8bwGpQ0NChqmtlRLMzBMJICDzLS
	 U9f3E96vlEGbDEygUIWQBFruNl6tZz50T7NqfmAOxJH5BxL81g20fEHmCFb9Zzn2WQ
	 JpbKIKT5ckmJlRklbthBpuSUbMtLkfUaQLwkmupcDFftxKQeKVO4roOgwnrc+R5Pz6
	 VVQC0RR3RKg0IuaRIUP9Hxhs6K/TeEJY9XmiwAF6HTBcLzUj2ix3op7Ghf82MEIXk9
	 n8gFsdxdqlph4jTSc8LsRFKlHHwRI0HQK9wh2/ziaoXR+meaKwaIQe5tDIx+XQF9vv
	 eXjWmUDMfnCtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 2/4] HID: logitech: handle HID++ thumbwheel reports
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RXJpayBIw6VrYW5zc29u?= <erikhakan@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20261002-bolt-input-rfc-v1-2-333e1f350586@gmail.com>
References: <20261002-bolt-input-rfc-v1-0-333e1f350586@gmail.com>
 <20261002-bolt-input-rfc-v1-2-333e1f350586@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:01 +0000
Message-Id: <20261002091401.C17011F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] hid: logitech-hidpp: divide-by-zero in thumbwheel scroll due to un=
protected memset
- [Medium] hid: logitech-hidpp: M560 vertical scroll dropped on init failure
--

commit 67886caf8cb1bbca1343ff56109a68fec18fa393
Author: Erik H=C3=A5kansson <erikhakan@gmail.com>

    HID: logitech: handle HID++ thumbwheel reports

This commit adds support for HID++ thumbwheel reports for devices with the
0x2150 feature and generalizes scroll handling. For Bolt devices, it defaul=
ts
to diverting thumbwheel reports to HID++ to get device index support.

> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index ff6a1095e7ba9..464685ad21bbc 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c

[ ... ]

> @@ -3323,7 +3391,8 @@ static int m560_raw_event(struct hid_device *hdev, =
u8 *data, int size)
>  		v =3D sign_extend32(data[6], 7);
>  		if (v !=3D 0)
>  			hidpp_scroll_counter_handle_scroll(hidpp->input,
> -					&hidpp->vertical_wheel_counter, v);
> +					&hidpp->vertical_wheel_counter, v,
> +					REL_WHEEL_HI_RES, REL_WHEEL);

[Severity: Medium]
When high-resolution scroll initialization fails, scale_denominator remains
zero. In this scenario, hidpp_scroll_counter_handle_scroll() will return
false. Does this code need a fallback path to ensure standard low-resolution
scroll events are still reported instead of silently dropping the vertical
scroll completely?

> =20
>  		input_sync(hidpp->input);
>  	}

[ ... ]

> @@ -4033,6 +4105,49 @@ static int hidpp_initialize_hires_scroll(struct hi=
dpp_device *hidpp)
>  	return 0;
>  }
> =20
> +static void thumbwheel_scroll_enable(struct hidpp_device *hidpp)
> +{
> +	bool divert;
> +	int ret;
> +
> +	memset(&hidpp->thumbwheel_counter, 0,
> +	       sizeof(hidpp->thumbwheel_counter));

[Severity: High]
Can this memset() race with hidpp20_thumbwheel_raw_event() in softirq conte=
xt?

If a wireless device wakes from sleep, hidpp_connect_event() could be queued
in a worker thread, calling thumbwheel_scroll_enable().

If the user scrolls concurrently, hidpp20_thumbwheel_raw_event() might
evaluate the scale_denominator check using the old counter value:

	if (!hidpp->input || !hidpp->thumbwheel_counter.scale_numerator ||
	    !hidpp->thumbwheel_counter.scale_denominator)
		return 1;

And then the worker thread zeroes the struct just before it is used in
hidpp_scroll_counter_handle_scroll():

	scaled =3D div_s64((s64)value * 120 * counter->scale_numerator,
			 counter->scale_denominator);

Could this result in a divide-by-zero kernel panic?

> +	ret =3D hidpp_thumbwheel_get_info(hidpp,
> +			&hidpp->thumbwheel_counter.scale_numerator,
> +			&hidpp->thumbwheel_counter.scale_denominator,
> +			&hidpp->thumbwheel_positive_right);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-bolt-input=
-rfc-v1-0-333e1f350586@gmail.com?part=3D2
