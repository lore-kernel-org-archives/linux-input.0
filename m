Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8350C49B1EF
	for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790162609; cv=pass; b=BNvLjdkLZjduN5uu6ifw6zMsi6eN+rvI8UYxvszZgU0NA/64RhmX6tZmGi/jw/X/pXFutAlGB/BZU6/+cHVppKRdfMuy5OuP6SRTBnWLN4U8rOZvlbxeyRnE2DK30pFM4yRcwhv/FVTJMX7Yv8uCrqgWE/kzSez2XNsh6yruCxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790162609; c=relaxed/simple;
	bh=XhxSI0UVdEQV9nwQDMNyEd97c+q+OPCqI1wpOJhsgB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmlCyZgjvyINzkif3h2oox3vr6jUDi1zUt4wSQItdOslhhJ1PNk1KxkDgvcq21eP6sfN4ClnfFuNOvVJ73jFlMwVBA1eACR2vPwOytFWHIlqRwIgvmFh0gXw43MT+EE8Di8IFmBLwja5k01+amO6WeiHDajViOnCdNPUZAWPeRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSFACnZv; arc=pass smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSFACnZv"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91059280d58so5996046d6.1
        for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 04:23:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790162606; cv=none;
        d=google.com; s=arc-20260327;
        b=HVw6n4MVfoSSd7HkGv4RxooaT2fC24J/orLEJ9Wxd1p0oWTVX61sfxGh2F45G4prhE
         OOJ401X7bz3FOVgBnFyZQctXXU+8/6Fw4/YT7lUWyYonLJSwDIOyIlnpXVqkySdvP1La
         dpG9YvOy1HKDU7+xl2dBrGJ2A2wph57yiqnBDRq/YA+lu1IehL+0O+edeU0jxabAYxE+
         Xv1FLdPGUNkFn7lSVOWbot+rj1AuEj0RPHBk/3qvXkevaiHyLrfBppA5IfzTQ1H+NZa/
         3k3jhXF3/SCuDrdXLml5A8VfZ71ih/vDctK4wvjdfadWsusNr3r+erHDbk5gdOtC41lm
         3FQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bN6kbYIJdb6YSfYW9P/+epswRe2d9jKi28WuqxpTfyQ=;
        fh=i0J7Vrf1Dtak+VezafgJcq22zN+YUptv8kxlFHMB4U0=;
        b=rcNx35ioQ04U1iiJ9VXf9ydeAtFSkZVy5ZkUNUS/s1FPRCnIqXfa8nO9iVEEN1IVUw
         h4amGmJWKWB4cTfw5Lp+iyP8eb8c9MAsLVGx1/pcHua7dOXywjOKz1lpIhFK518KR3b7
         K6bU5/YRd6YIeWgMc9qWHouY200lNa2WwR97bu2k7WJh79ed0ZEbwzlfq//OTZsSlIyZ
         3cH39qGs+r3XMlyHIgA4d9GM8kX91peW5YF7n8yQE23hS0cH18JJsShQHPJDN5oSWfCD
         sq7OQqHmvTxewwr9vIrfX5vvTuZh1qc+WdnrrSRDKVAYuA4beuK9qpQxuI+Z1C1gJeNC
         Gbhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790162606; x=1790767406; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bN6kbYIJdb6YSfYW9P/+epswRe2d9jKi28WuqxpTfyQ=;
        b=PSFACnZvTx1Spq0IMRsuJv9WtLOs2Fxxv5tzf2b6cxdtqbF8aoT5dBFXzDQTv+W94p
         uTiY9Up5BhIiLfy42MA571kdhmOSdgQ73sEw1/XaCtZPU34U0yFYwWbNCSoy7AfKWMbL
         ja9ER/g1bITBtmvtTTtliKb9vQrtrzZS50iwhTbp3WBlexD4fTzF3VRuIE1hLqZo4LzM
         RpKsWp4E5RVfuNznNew+uiq3N2UgyWLXetg7qSOlms8dWC+wbjFpGWzsMQihsXmNGw+5
         WdixpMW5tBrrQ14OhG6sLV2k4PMTpmbS3recKeoyXxPWfgnBmpEMJGlMR93LjrQCLq47
         QEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790162606; x=1790767406;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bN6kbYIJdb6YSfYW9P/+epswRe2d9jKi28WuqxpTfyQ=;
        b=PSECExcjlXccTSAkClSLVk22C0q05wbX8Rc3gLvMPy0YIACU7pEdMU9qAA+hYyIfgh
         kJIkZP8QpGfzfMVxJvru+xYtM3VU2je22T4irDAkGyjX8sRn991nJgr1b2tKIUSci+l6
         1bH1ytCyUwN24x3o8k0RG/NcK2ZtSGFcqy1287QkBZa1N1BMlNxwXY+wSKr3C91HPdEt
         psGqC8Fu0P4BRKH97Mt8501UFhig9KEaG73FCLm3HJKy1iPnekaweST2EHyd8uYfG75f
         Ma7Mu4wyPj7aStK4uEgrxo4fgBAzUEJBJ1yXgmpbkQwF/4FhByZ5J1sdK7RNnsandM5w
         aQyA==
X-Gm-Message-State: AFuF++nTjgz1Z6X2/0gdVxcWnlYQLmipP0Zlr1olyVzYgP+UHSosURMm
	Eg//m+XpEObCdu8xdXjXvez2qmMSaAEux2KGOByP5LKEWhZpQCNPL1bpr6wFGK5e5RasQ6f9m4/
	wrgwaGQYU5E1paSKQ2bYMUFE1bI6GQsz6Mp4WPJ4Glaqy
X-Gm-Gg: AYBFou0wvOY7OtcTNlmK1ZkJ8VEyFQEOeRjxY4tTKatcGeupfMu4tNEmW0jBvhCiag7
	LJ2AlLkfnjOvyzgozg12WZyMphcYcCwqVpGwOjlQJoXgCBbfHbdHh+PKrfy99rUUmpMqIsZYqPZ
	mg3+kFbCkMUjR4Ln3WAdI1M6SY85f/D6RhO4PBM4GOSZ1jDurIv/djETiWJi7BjB0sYl8EFXMix
	ah8pjFyeW2PdJfZWTzGEGmQW7EmXsqEWCdA+qFiQAv0iqv4wrts5qYjWIBhenX/0oZkKCY0WZ1K
	6OY9sdmiMNjDupHgBUL3kAP9cx8sZfDwtqV1EBfRxjk2b7M6oTUcQgePug==
X-Received: by 2002:ad4:4eaf:0:b0:912:517b:7bcd with SMTP id
 6a1803df08f44-9140c45e16amr36513256d6.44.1790162606203; Wed, 23 Sep 2026
 04:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923105757.260-1-anykey196@gmail.com> <20260923110700.C331F1F00898@smtp.kernel.org>
In-Reply-To: <20260923110700.C331F1F00898@smtp.kernel.org>
From: =?UTF-8?B?0JLQu9Cw0LQg0KHQktCd?= <anykey196@gmail.com>
Date: Wed, 23 Sep 2026 16:23:13 +0500
X-Gm-Features: AclHuK80bwmJZdOYxmF8iAKdw-NUD9G5_eoeZNJ35MH2NPLmCB-oxTRJeWQWiiA
Message-ID: <CANHPwAQOPvcQvDLNpKLNL+jQg23sJMbhVSvNWqswFDm7iH6TEg@mail.gmail.com>
Subject: Re: [PATCH] Input: axp20x-pek - add AXP313a support
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, 
	linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is already addressed in v2 [1]: the AXP313a no longer reuses
axp20x_info. It has its own axp313a_info without start-up/shutdown
times, and the startup/shutdown attributes are hidden through
is_visible(), so they are not created and no out-of-range access to
AXP20X_PEK_KEY happens.

=D1=81=D1=80, 23 =D1=81=D0=B5=D0=BD=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 16:0=
7, <sashiko-bot@kernel.org>:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] input: broken AXP313a sysfs attributes due to out-of-bounds re=
gmap access
> --
>
> commit fbaeccab4996537ab99d0c8423e2cf36610e4b34
> Author: Vladimir <anykey196@gmail.com>
>
> Input: axp20x-pek - add AXP313a support
>
> This commit adds the AXP313a PMIC platform ID to the axp20x-pek driver to
> enable the power button. It uses the axp20x_info generic register layout.
>
> > diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20=
x-pek.c
> > index 24f9e9d893de3..d4e2fc9a937ff 100644
> > --- a/drivers/input/misc/axp20x-pek.c
> > +++ b/drivers/input/misc/axp20x-pek.c
> > @@ -393,6 +393,10 @@ static const struct platform_device_id axp_pek_id_=
match[] =3D {
> >               .name =3D "axp221-pek",
> >               .driver_data =3D (kernel_ulong_t)&axp221_info,
> >       },
> > +     {
> > +             .name =3D "axp313a-pek",
> > +             .driver_data =3D (kernel_ulong_t)&axp20x_info,
> [Severity: Medium]
> Will reusing axp20x_info break the sysfs attributes startup and shutdown =
for
> the AXP313a?
>
> When these sysfs attributes are accessed, the driver calls:
>
> axp20x_show_attr()
>   regmap_read(axp20x_pek->axp20x->regmap, AXP20X_PEK_KEY, &val);
>
> axp20x_store_attr()
>   regmap_update_bits(axp20x_pek->axp20x->regmap, AXP20X_PEK_KEY, mask, id=
x);
>
> Since AXP20X_PEK_KEY is 0x36, but the AXP313a regmap defines max_register
> as 0x21, won't the regmap core block this out-of-bounds access and return
> an error?
>
> > +     },
> >       { /* sentinel */ }
> >  };
> MODULE_DEVICE_TABLE(platform, axp_pek_id_match);
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923105757.26=
0-1-anykey196@gmail.com?part=3D1
