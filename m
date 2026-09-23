Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44353BE156
	for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 11:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790162584; cv=pass; b=m+Lysigws6nmvS/m6dnEXCrH8fHF8iCZSdC08PBxq2ib90Oro9xUr/dRgxvNtlLdhSIRwLlkIlu5D3aGmMsdBuKyp46VSn2aV2Ty8wKgiqAWqIWQlsTbFPYpuZ6JXA36JUNYHYFOvmAz25cD1cCZddpxr7EW2P0e4UMJRrDTP7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790162584; c=relaxed/simple;
	bh=0z1VCFZ2xuRyxqepe31PgaTDnQ5THZA+rjwWgzaliKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ufNt2hee/O7LMpPgCPEAN71vhEPy9sURc8uUAwK1DuJ5fjMr5VCW4CUDO9zb2mp7SEbALO0XGUJtXq1Solg/jJGdMMvQpcP94h5NWL9UvgkVctYNreV2FCHVb9a9wvuPTlGqRoFl/RkhZIloFvF8Y/IbIlVMcby9HXRkUVt6ROs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljRTHuVC; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljRTHuVC"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d45ae011aso9939417b3.0
        for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 04:23:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790162580; cv=none;
        d=google.com; s=arc-20260327;
        b=eoW0d80ynA0Un1ebS2lmSO0tkacBMryKT9nmOnL5wge5Zp2RoBUfJlPvSkkyiDdOcy
         RYdkuqdRo+Y+akg4PyM5UzJU9gXqkicikEuxaqsTkSDYeWvKqyKR/Pt/R1jhWJOcWBiv
         BlGubn7phsHUx+HRZcWIkXrgwF6jqK96Xyl+7SjRMZ7x5P1RLSLwttFx2ucpSQT00hIy
         vdGjHWXikfU0Vnvp/pg29/wYQf7Kp3UsrEYlpZ8ojXv4IGQnfi9AA8g3EPsQWKX5nNwV
         OrP7bkfVNwjojbHffrqs6EMj6cvO/KrY48bNoiRniNj2G6ENfXy0Ivt6LpWk8EAk/nyk
         Et3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gHFi7D8qOayJJzxbwOB5rCaAL3OuK0mkAkD2JKiUgRk=;
        fh=wfz6CDlxYMwnrjdEWhY4zP4moAkhWBx35wFTGfjcZ4I=;
        b=JydZeq9y12ZYjQ7wJjI/436rk3/UUMfVoGBgqVblBvaYeyQNdnXvrnG00UaydGweAs
         flpAP9rqxjBmWxMecLyR31CVmd3MUXlsMayxqig6bTefevGEbNc/kCBb3A53Al//tME0
         KChEyH8kRu+F1W8PATUwiXLgArEfwI8PmYtJ4na6pSl8w4LUaU1BlHU55I0s077bTk9a
         I0zqL+maV7O0SSPSVWDGkKA9w9IqDm7yV2M15D6lUSaTDxPK6SjEslCA2OJ2vqjL2Wme
         o2SNhG373K3N30HgtQiL+Xx6MNCCliyJDWWtatdRCgZ+QldW3kbo0vQn9QKjylRmRfXh
         GHMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790162580; x=1790767380; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gHFi7D8qOayJJzxbwOB5rCaAL3OuK0mkAkD2JKiUgRk=;
        b=ljRTHuVCrvDifCNkwU5re+mFqUBXTiZUtthBe5F0+LDz6EWaxsLqOJ70ZUNg1rLhmA
         /Pd8BCc2ygbWfhjrrwQCMCDWMjsIxRDlBA7CmvJaOyukexORZbEah1vspGK6xKEwL8pD
         5PcBi+REMyw19iu3wOrp+PlvGOG8+KYHpOIFHvTMJk+busdBGh2PU2VhXbkYNfe8gbsL
         hcGZuZxG8EqCUGlG4XUQRzQGTeNlFCWUo9Wy8oMZgSL307YuHQl0YnQHAt0ZebwgsksS
         gRBI3JSOwpSVMX1EUIraQ9cRG43QDcbdY9JHY0yLlw00JqJF+s+ngLQXm8tLnmmfK/im
         Q3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790162580; x=1790767380;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gHFi7D8qOayJJzxbwOB5rCaAL3OuK0mkAkD2JKiUgRk=;
        b=DXyAi6Xe8pVWrSH8QzCmPpjuL8VUb+hSUcxYASwaV4k4WH6I0iZHKZ6Mr/NrcAOlm7
         PDr3qmCJ3CG+uNzf5hgxi+6VHGugFMqBLSandEz3TCox/3jKZvwze7F3PmvxdS2cXhhi
         1J0wrFiYP8ZnkOQpseAIb3kS1eHeHYGhNIh3SBbb7GviwpQJjAQrA/I7uDgPBU5yVFVc
         FgLtt5cLwrJiFeWX0S4tIw1UhlRT7OQGAAevgjvWG2kXqCYWSwgiSFyKm/nxMeBolS7a
         EIoA/LAmgynoDUepEfsVSCEZxriDMSYMlzmApNg4vQXXGLq0aONb3uQsBKapEZ+wYyze
         zEjg==
X-Forwarded-Encrypted: i=1; AKwUvBxYvoRF8hlVOAWo6UXEsiAjEEdvPgVN9gdIz0zl2r+7Af5DFfd1rXjCqgTQccws2gW5dTgaN10BMNAxlQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kx/EreQau6PwBl6X8qBTJY1iqeCVlHP5oeXGkoA0YmuHEdLgqr
	C4QHyrZw0fWun81fGCR1wEHrrFT5YFUsjLIImncA8sPWxpDV6vyhq2skBOWeGJVDjTcVn/Sccej
	Vpk/8VSQ2SRAFAfS82ZlqFpbuJdLTJbs=
X-Gm-Gg: AYBFou2ur5SehpYfAVBP0rzLlRNHaj3tqI01vptZtzn9p8rTclXVr85m4Rr2AoXBGC8
	ZIyhHkX1vFq5w92G1Xj0XuH6y+wOBrjsYM1SrAKXmZDTo5ySa76GUVujID0L59Br5SbWKz3oqP6
	ex2piqk4zNXVRxy8d8zdyuJdZ6+Lhop5UQP8nEvtWFz/+5yyn0a2rAQnmCvxFGND8BRMcxzjJj1
	E01IKbJ5J9/uhwNTWiDAvPCyYgcdPqqJ2+C7xmMl2X3k4+UDjDhc3i8ZDVYqG7UQL0HfCarzcuj
	iV0UZww4S1KFkfkot7bQEiHxan2Ex/ca9/6sq7yEXSat2M0NblUdvfEQ3xunplSipF+2
X-Received: by 2002:a05:690c:c6d2:b0:854:819:64c9 with SMTP id
 00721157ae682-8a459bfa9demr8916207b3.30.1790162580359; Wed, 23 Sep 2026
 04:23:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923105215.1633-1-anykey196@gmail.com> <20260923110236.CA7FB1F000FF@smtp.kernel.org>
 <CANHPwASJBzich3-2QV3FNNdKX+GHQGe2FuFWu2CUXCYya=-1zA@mail.gmail.com>
In-Reply-To: <CANHPwASJBzich3-2QV3FNNdKX+GHQGe2FuFWu2CUXCYya=-1zA@mail.gmail.com>
From: =?UTF-8?B?0JLQu9Cw0LQg0KHQktCd?= <anykey196@gmail.com>
Date: Wed, 23 Sep 2026 16:22:47 +0500
X-Gm-Features: AclHuK-oRbR1-Bis58IfnX-iX8wBDjxwU2mU1GEVQnmP7ClH7-r_aFOAl62yTEI
Message-ID: <CANHPwARAonpfi2qCC2iVka-nLjXx6kgLvGWTtMqjKOeh5CZEYQ@mail.gmail.com>
Subject: Re: [PATCH] Input: axp20x-pek - add AXP313a support
To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks. Correct: the AXP313a register map ends at AXP313A_IRQ_STATE
(0x21), so AXP20X_PEK_KEY (0x36) is unreachable and the
startup/shutdown sysfs files would always fail with -EIO.

v2 no longer reuses axp20x_info. The AXP313a gets its own axp313a_info
with no start-up/shutdown times, and those two attributes are hidden
via an is_visible() callback, so they are simply not created for this
variant.

Tested on: OrangePi Zero 2W (Allwinner H618 + AXP313a).

=D1=81=D1=80, 23 =D1=81=D0=B5=D0=BD=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 16:1=
4, =D0=92=D0=BB=D0=B0=D0=B4 =D0=A1=D0=92=D0=9D <anykey196@gmail.com>:
>
> Thanks. Correct: the AXP313a register map ends at AXP313A_IRQ_STATE (0x21=
), so AXP20X_PEK_KEY (0x36) is unreachable and the startup/shutdown sysfs f=
iles would always fail with -EIO.
>
> v2 no longer reuses axp20x_info. The AXP313a gets its own axp313a_info wi=
th no start-up/shutdown times, and those two attributes are hidden via an i=
s_visible() callback, so they are simply not created for this variant.
>
> Tested on: OrangePi Zero 2W (Allwinner H618 + AXP313a).
>
> =D1=81=D1=80, 23 =D1=81=D0=B5=D0=BD=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 16=
:02, <sashiko-bot@kernel.org>:
>>
>> Thank you for your contribution! Sashiko AI review found 1 potential iss=
ue(s) to consider:
>> - [Medium] sysfs: broken startup/shutdown attributes for axp313a
>> --
>>
>> commit 2573be3a312f98b032ff9523708d368661f8e004
>> Author: Vladnwx <vladnwx@users.noreply.github.com>
>>
>> Input: axp20x-pek - add AXP313a support
>>
>> The AXP313a MFD driver registers its power button cell as "axp313a-pek",
>> but the axp20x-pek platform id table only matches "axp20x-pek" and
>> "axp221-pek". The power button therefore never probes on boards using th=
e
>> AXP313a PMIC (e.g. the OrangePi Zero 2W).
>>
>> > diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp2=
0x-pek.c
>> > index 24f9e9d893de3..d4e2fc9a937ff 100644
>> > --- a/drivers/input/misc/axp20x-pek.c
>> > +++ b/drivers/input/misc/axp20x-pek.c
>> > @@ -393,6 +393,10 @@ static const struct platform_device_id axp_pek_id=
_match[] =3D {
>> >               .name =3D "axp221-pek",
>> >               .driver_data =3D (kernel_ulong_t)&axp221_info,
>> >       },
>> > +     {
>> > +             .name =3D "axp313a-pek",
>> > +             .driver_data =3D (kernel_ulong_t)&axp20x_info,
>> > +     },
>>
>> [Severity: Medium]
>> Will using axp20x_info result in broken sysfs attributes for AXP313a?
>>
>> The AXP313a platform binding unconditionally exposes startup and shutdow=
n
>> sysfs files because they are hardcoded in axp20x_groups. Reading or writ=
ing
>> these files attempts to access the AXP20X_PEK_KEY register (0x36) in
>> axp20x_show_attr() and axp20x_store_attr():
>>
>> drivers/input/misc/axp20x-pek.c:axp20x_show_attr() {
>>         ...
>>         ret =3D regmap_read(axp20x_pek->axp20x->regmap, AXP20X_PEK_KEY, =
&val);
>>         ...
>> }
>>
>> drivers/input/misc/axp20x-pek.c:axp20x_store_attr() {
>>         ...
>>         ret =3D regmap_update_bits(axp20x_pek->axp20x->regmap, AXP20X_PE=
K_KEY,
>>                                  mask, idx);
>>         ...
>> }
>>
>> However, the AXP313a regmap configuration restricts max_register to
>> AXP313A_IRQ_STATE (0x21). The regmap core blocks accesses to registers b=
eyond
>> max_register, meaning these sysfs accesses will definitively fail with -=
EIO.
>>
>> Could the axp313a-pek driver be updated to avoid exposing these broken s=
ysfs
>> attributes?
>>
>> >       { /* sentinel */ }
>> >  };
>> >  MODULE_DEVICE_TABLE(platform, axp_pek_id_match);
>>
>> --
>> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923105215.1=
633-1-anykey196@gmail.com?part=3D1
