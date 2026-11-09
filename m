Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794208446;
	b=mUGazMAU+male5x1NPq2bCXeYHcOAVlN3a9Z5MOXOROd18Up+uleVX7QTIPhvzx9k46L
	 gnNHBNeq+gUUIHkAL6QTe3ekxsJVriXrbVys/OsQo/lFKZDDgl1tvkv3vNiTljkmJHg+X
	 /zNAa1VKPLCekr72kd73U7biZDmh6tjrCAjgI0gOYfnIH3pVhPqmW4q+v+BnRHKUbns8z
	 4E9cYgoepszFCNx5JOOBgWvQCz1/e17R7JhhOUImwsCkorSWd8X2LdpDhOACXCV6nrF5B
	 y90/9r1o03WtESfO/trzrEEOYzsY57KIl4uaM100i47T0L1G09IHkuF+/YWMUNsC6HA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=p8ohiQBg8UgGzEqawbRCebSefr/a88QyxtuULNgZzJk=;
	b=SbVjlpIKi3INtGFZUNvnCgrYNsOIEapZ5sRsBKt6ykXBbK8w2HuviZpO/TwLo5uS5SL6
	 LN/ZpWn047IAxt3k+0RY8N7wHDHICmjYQZxZpK3F2MklHwS2IAtPJ5v0sestLRMn4tKj0
	 xIp70JgvrNEqLF5ugWp3D7i22cNCZ0qJGRNl630fAUxbM2Go7QRXv8l1JqZ9nMWlWMC2n
	 ztoEXn9+XC7iYnMQxFVWS11DpLxzBRqwtu5UDtuljDQL+Y9J3QANUeq4lci4w75uergXK
	 Q+f0g10zZlt2ojkFWxhSM3YK3AxmGx46FWESk46IyNa5X9trownlF2Djx1PPTeSr4aw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Iutm2nf7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00121606A321
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 07:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00121606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Iutm2nf7
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b2d14968c9so4903947b3.0
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 23:14:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794208445; cv=none;
        d=google.com; s=arc-20260327;
        b=iCH6Vz7jAgaeSP+tVhGirLE6c7jorhJG3cltHEanCskMzy69oyDObiJbM79Sdem4uu
         /TMGZV9VYIFGwphXwWgxwN7auvQl5vkWb9FdYms8oEff71XnOgzLmoMY5O97c4uWW35N
         MlsrPSHgYHqfXOVZOVTwYIe6/FjEkB0QduiS78FCwHwcinBsE4W84wVZuaJsjWMCU9oc
         fE742qjC+4fjVtO5xYmK9zImaouVpyx19u2IvAzQ6fUnQZs/4JEIOmfZRXE9stuBjFdS
         JG0/dsaU6CEVvfXEv6zQzYM2wFLcPQuLsDLpWgbwHhUC8vPzK22zhFezgdFz3BsDJnqA
         grXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p8ohiQBg8UgGzEqawbRCebSefr/a88QyxtuULNgZzJk=;
        fh=3+AEelo/CyQRHtELOQofpb9BPrGwEJCgFKInvEl+EZ8=;
        b=HWVRIBM9tmjhu3sDmYuXLuShfpj6HgbENKLl6BBNY52VF2tmgon5QUmeGahgMFtAZY
         ZEdMeZc12hDc8RuTJ/i6QkjxsmKBhELrmoNCb9VEx0mINGb/F8G2dEOCqn9d6bgPTwHV
         EllTLgiif9oiP/1aORSIKNt07erPu9/wreQe9iha7GYBIIlgQpUcgr9RmTFblvb4CiEw
         OjJR40KXRqq0byG+nGhCIHZ6ymV7VRkrSbU2MFhoNgHyi1ANSkxTSLGBAOYHLa82K6Vr
         aFO8tALsmKR5kXRce1uczO1fgVwza6x9eMW/sX9xxKtmI5fs4+zVu3V3NJ+ow6ypcKN9
         2IKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794208445; x=1794813245; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p8ohiQBg8UgGzEqawbRCebSefr/a88QyxtuULNgZzJk=;
        b=Iutm2nf7MPuCjo82TeOmREBZHH665Hyf8H1vg8zjwCkCU9R8CUDUuGfOsoae4Q1+0a
         7TLbhra20Hwu6gbjIXPxuChjIBOX1xldHXFIQGNMcKvNz4sbPa68A9QYt7cVqzrqmn69
         gkl8PpyMylrGSzra7OYHsDtZaC5VRZM8j58aOrZ1VRjxvbvljaHSO1O7yeVcyvaEB0rC
         TIoo56EhZlkdiL5Rx7y8IrDmMIkRzDt5978PzF0F/kIUPq+l1Q44Ga8TgJbfSatCIkD/
         4YoE5tjE3HuTxyhRcNrgKEIGCujPrrwfj+EODdqiJMBFpGyieePrfWF9HovTLwtBmQv4
         0EQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794208445; x=1794813245;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p8ohiQBg8UgGzEqawbRCebSefr/a88QyxtuULNgZzJk=;
        b=SMB0UxSYVswk+tt7h3aKKTmHC//CqZmUFrrNPbuVbVqo93Thkb4eCENsXDhpq7cVFv
         Ea+7Ls8ftohzRx7Iwu0tGc2RpnsqRpm00eWVvNjzn/KbBx/knwP1eRnsC4TDeImmzs+L
         GAIxprH5cUYyDufm2l+2f/j9v41rxrHOIncw69Pi1eBis/rI+ajKK6V2FZJpcEL07C8t
         768ZfMTwcm7fL5CyjGu33WG0GAoC9Zj00em5UhVRu9RXox4fiCAY9Rl0Fpnu27Asak5j
         +y8SdwSdiC69J6/+Hotv9lVji5tCROKazusnvA/g6GQ3UhelioAOCu8rUHYkqtuauxkd
         byqw==
X-Forwarded-Encrypted: i=1; AL+hErFRMuMm3+gzMa+pE/XeshjG8z/CqYiXqRhcszIOGGadh9qYB3Unc/T3OywS6pQCuq/jdeJtB6cTORZbbA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9vg4zStXwls7x3cAVhoC/tsJHYtDSQsGSmIqgzaCRmjUbw6CBI
	Kv0mZAzjHNlpWbdwBrPJ1JpCgIKl5DUvfsvSp4hHva2PHk70IxqqsbuLnYdgjTz26bWAuAjLKS8
	NCm7/hv+t7KMi+vzU7YiWnjz95LA87VI=
X-Gm-Gg: AYBFou2VEjaNCBtkpTLMA5thOvps1y2aTM0tsLc/2S0RJGEmUuLesnuqyPKM73TIYs7
	mn5MUgmJ7Z+UlPQxtaM82CdfacrPPd4bd1lFUuvinvBTIObwVEtmZflZckHde0Wcg1gnMEn2nlP
	NfOwLx/To/txRt8X1ionTijlBznpjfFwBk8IXL2/AZBJA5sTTsOU0PDYOrKFFI7/aBLszxPX7/b
	1Q1PoIHpPqT8bsvYxqq91K0wG7GjkJeABgU0ZuLZwprIY5/qPsSFkXWUQKDQzGvzVjYVfmx3pLJ
	f78QEHq1IsjBmH2nzqLdqzgx6k3vLXNFUiw0+aQAtVxtr29QB2RTYT9V3LBcaftQvTHz+OoOrsl
	Wo0itd73MDTURFTwBqBRMc8lzf7nT3wr6i4wXbjrjDl4G/p3fM5Vw5TUrmj5JdsktiLLOv+nlLB
	0b87rclQ2hncyQ9FqB1T9Hh35ydxJadhEFRvW4OwV6Mz7picnZhwsTfGrFQUN2X4SD7mB7W/vic
	1jdnIAHYureMetT0Q8GfFIzDcBgdGKudSPoGCjwVEJxzgkojcizhL0fXuAL5A==
X-Received: by 2002:a05:690c:e3ee:b0:8b0:6866:c5b6 with SMTP id
 00721157ae682-8b36c906f40mr15532137b3.9.1794208444824; Sun, 08 Nov 2026
 23:14:04 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108213656.13031-1-antoniovazquezblanco@gmail.com> <20261108213656.13031-2-antoniovazquezblanco@gmail.com>
In-Reply-To: <20261108213656.13031-2-antoniovazquezblanco@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 9 Nov 2026 09:13:28 +0200
X-Gm-Features: AclHuK8MaFKzfCmypbKM_T55grhYANqfvZn7avQ_UIhgQgnEJ2s3PDOHcaKYoRo
Message-ID: <CAHp75VcOOwr37SyOgyYnRu2Gc_FoyAzmmt+qk5cnN=9LF2Xvqw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Input: soc_button_array - support AMD variant
 Surface devices
To: =?UTF-8?Q?Antonio_V=C3=A1zquez_Blanco?= <antoniovazquezblanco@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Chen Yu <yu.c.chen@intel.com>, Sachi King <nakato@nakato.io>, linux-input@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 11:37=E2=80=AFPM Antonio V=C3=A1zquez Blanco
<antoniovazquezblanco@gmail.com> wrote:
>
> From: Sachi King <nakato@nakato.io>
>
> The power button on the AMD variants of the Surface Laptop 3 and 4 uses
> the same MSHW0040 device ID as the 5th and later generations of Surface
> devices, so soc_button_array matches it. The device check then rejects
> it, and surfacepro3_button binds instead, which is the wrong driver.
>
> soc_device_check_MSHW0040() evaluates function 2 of the MSHW0040 _DSM,
> the OEM Platform Revision, and treats a returned 0 as proof that the
> _DSM is not there. That is wrong: 0 is a valid revision. The AMD
> variants implement the function and return 0, so the check rejects
> exactly the devices it is meant to accept.
>
> What separates the two groups is whether the device implements that
> function at all, which function 0 of the same _DSM advertises. Of the 32
> Surface models carrying MSHW0040 in the ACPI dumps at [1]:
>
>   fn 0 mask   fn 2 advertised   models
>   no _DSM     no                Surface Pro 4
>   0x03        no                Surface Book 1
>   0x05        yes               Surface Laptop 1, 2
>   0x0d        yes               Surface Book 2, Laptop SE, Studio 2
>   0x0f        yes               the remaining 25
>
> Only two models do not advertise it, and they are exactly the two that
> need surfacepro3_button: the Surface Pro 4, whose MSHW0040 device
> carries no _DSM at all, and the Surface Book 1, whose _DSM advertises
> functions 0 and 1 only, function 1 there being dGPU base attach
> handling.
>
> Use acpi_check_dsm() to make the decision, and keep evaluating the
> revision afterwards so that it remains available through dev_dbg().

> [1] https://github.com/linux-surface/acpidumps

Make it a Link tag in a form of
Link: $URL [1]


> Fixes: c394159310d0 ("Input: soc_button_array - add support for newer sur=
face devices")
> Link: https://lore.kernel.org/all/20211109081125.41410-1-nakato@nakato.io=
/

This tag is not referred in the text, make sure you have somewhere the
reference to [2] and mark it so here
Link: $URL [2]
(or drop completely)

> Co-developed-by: Maximilian Luz <luzmaximilian@gmail.com>
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> Signed-off-by: Sachi King <nakato@nakato.io>

--=20
With Best Regards,
Andy Shevchenko
