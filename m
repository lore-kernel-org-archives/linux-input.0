Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3A84CA79E
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 06:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790058358; cv=pass; b=U9wwJcichHJHlSFw3J/xHj6IzVEPuKL3B8z5h+BkjiQqzBiey7DxqbcPQpXrFca53vnU/30Hv9XRF0EUn9KgC5ynKoQDSjmhsJOwK47RKuRPhhUmbRZNi2ZtT861OBPt7QuaauXGdr30HnKTr3voKOinA/HiRMuDWMfbL5I53zE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790058358; c=relaxed/simple;
	bh=0Zh6NbTCbBx+NVI+uqE5VDBeW/6Lziwppq9kVy8IRSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1NFC/5p/KR0rDcBFq7DQsQifDjYVTSV9o+SFq2eRVIh6xw1VnvLabPIJgyTiR/TQICllwYbZcZqYRVKTeEZrBIoe8zQiBtUJbdRCOY4AoQOMWBgRcr4eL5F9uYwP35JvAC0YkQKhMg2gYmGS4hzyFXz7cIcJNfim4TsSnuGbns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q2KHH4F5; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2KHH4F5"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39d654f02baso3162219a91.3
        for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 23:25:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790058350; cv=none;
        d=google.com; s=arc-20260327;
        b=plOZt7wIcAHRFXV9YuoBiZFO4kQZ6J7K9mnqjyslbvbFtr3uWko90AYh46QUOioM1E
         PvJ295+2aWGH3fRPGWj7do2bN8qWRYqqv4/hnPTGVJGP+mGHBWKpGPAWqmCHc3kJPbvl
         ty2mkUuSRYXr+9bM3ybDyakLXkuLhDyTEqxxr7lw6tC2CMpBzoXfWnh2FdY28BcWKUba
         8vy8c7DNDA93cchf/htUkmR8tbQkQfSWo47ZYobuZUZY7RURN+jIz1o0WZDBnkEoA4GB
         7VVACGoJedUGDunkVLypH1pz6YxNPcmiGjXhcrwY/Th7RqvvAI7GtHX3N8PImAmyDCbi
         DEOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xsw6RymLg8vrJTC9V4W0r3dpM0gHmJp+IdCdC5NThs8=;
        fh=LlRU1aFK/AgjlvRvWYc/NTh2QXHoDj7AgEFbM06fiK8=;
        b=XPJg5Bvfb4p83uA49W0M0e64cLcdsOR/6yV8qYchYV9givBi28KkWfytLbln9hSqbk
         5T2TAshKi2SfA4baYo/RwW5Bab/9gWDNtEA+ojnnwAb+fazP3PU1soE8313sWNOmlbms
         Iv2zoATaarU4A/q8IQWcEfNxYwoWJplc6iftnp7kC7MCrkh5PIvtEgJUSm398Y7vyx+5
         zCwy8Pi+6eSFBKjuAXyfRedTIara5khfPhhosuM062ajoxWvguDb9o3EYb7r6x9W7eBp
         JUwQ9VZv5axf3Q46Blc5mXlu8Igz3DQ5jjGERRAp09kaZ+yKQ7+90L1lVrlq1zy+WCBE
         bmvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790058350; x=1790663150; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xsw6RymLg8vrJTC9V4W0r3dpM0gHmJp+IdCdC5NThs8=;
        b=q2KHH4F5U039vDxALsjkqVgWgjevKqYBMcNpvXflitJMqXwfjAQDvWCotxoiEX/e8R
         AalpnCwa1ZtvypjESnhdOolrH0wowOBRO0dig+gPYORUBsJwec7kdYtkrdwkKDPL4gy4
         DJcCMPN2et5MclKz2cN3WhImiFDHnXckkgn2WSrQz9f9sb/oNA3j8UMKuRPm+G8BiwxZ
         MjyitoXCfFCYgcPAA3zWJ2h7gYLuqKS9B4YjCsWgaliJ1z/lsofUCpfybbqLZDW+Ao4y
         DLZ6W+HWVVlD3RMU07ggWxKO6MIXfMeZYSzU/5TEYMEkeiyaO4seS26M93eEKrT3sALY
         /0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790058350; x=1790663150;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xsw6RymLg8vrJTC9V4W0r3dpM0gHmJp+IdCdC5NThs8=;
        b=NQJpZVa3LCazf07hEkNycOj+UvEjCj3J6eciihIh5QPogR4XsJ01dPdpZf68uNIH4m
         Txar6aOwVk0Lu1SWqtPScIMbnMrYPp0EYa8GbFxoNal07yiOxZ/IluG+X4wRQ81dPf1f
         ysa/8uNi1ghGssKJwETIpqXuUuIECnh6fmNggEPSBWARvPRz1r9rO89JWcAptCAYs/85
         uNBn7VtjsPgeDj/lbFNX0td+HErVa7mFfs2CONYgY9RuMPIUiZYO9s2NwWDv6Xe6Jk6Z
         eJeQtcdavafvwrYNvhUZhBaSwMaKg+Z3Y5IcIb7Nk1Cz/2g13HkgQrGjwxoFiFCBgX8q
         SNGg==
X-Forwarded-Encrypted: i=1; AKwUvBx7WO9Ir1Tm56Wl/TABlyNIvKeTDywsYub0kDN3daBsDbnWQrJP5kbrbfdbYzhA21b7eu2ozrMag2+Mww==@vger.kernel.org
X-Gm-Message-State: AFuF++kN0fydmicU9+hXRQYp5eMFLiMFL5G13jkXz14+lUagGQgzr15r
	xh69CbJvp5tN9ol+A3vIB/t6WpzHMTNBBLi4+hK2ffepEi+6vTYBrT9ESZR65gi34UILXB7Px/C
	OfOkkmpc72ALERgmtUeobnq8YIvxwKCY=
X-Gm-Gg: AYBFou2ntRLnPjME7tmRVZUAo13sYEm1bE/enw5SjT9weHjqBUOMmFSA3HqtosOFTuc
	wur3lhToT5sBzVWNK3E+PoopJ7oK0fWGN+wijvhMAGY34oECjIffHlyV1bdh7nKCR109xp72gsL
	DByhNh9h2iuoqe5InDSXPglYSajsnha/kFXHb10nuli2d72nhmV4GxxcLwNUj88/4tpa1pv+RS6
	jDj+ODeacjDTOrnu96xYX6pU+5fCoQKzngzaM2jWOtYjGIxxOUHorFBi9rX8x4DjOikIuI99AVH
	FS+asQu4/y5yA+hfLHn9D14sXMreOpRS0TlrQ+aQgDxR/p50NBL0i7UncVokRU2SU4YO2Dl5Pr/
	MA0L+FDxXzrDO
X-Received: by 2002:a17:90b:3bcb:b0:39e:6c69:34d8 with SMTP id
 98e67ed59e1d1-3a07331ae7amr134090a91.60.1790058350508; Mon, 21 Sep 2026
 23:25:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721095233.420823-1-clamor95@gmail.com> <20260921175234.3137985-3-florian.krischer@fkr.dev>
In-Reply-To: <20260921175234.3137985-3-florian.krischer@fkr.dev>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 22 Sep 2026 09:25:38 +0300
X-Gm-Features: AcwNN1XCYQcpoYAJO_F2KOCSSGkPDz9AobuhsjJh05fJE4KGKFrobaYysqnjTV8
Message-ID: <CAPVz0n1HHP_D4jGNHHqO4AGZHAms5tCLK0Sftb9gn9ywSb8qcw@mail.gmail.com>
Subject: Re: [PATCH v10 fixup 2/2] input: serio: asus-transformer-ec: fix
 keyboard response framing
To: Florian Krischer <florian.krischer@fkr.dev>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Lee Jones <lee@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 21 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 20:52 Flor=
ian Krischer <florian.krischer@fkr.dev> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Real SL101 hardware exposes two issues in the v10 keyboard response
> handling.
>
> First, keyboard command responses may carry OBF without KEY or KBC.
> The downstream ASUS driver treats valid non-AUX OBF responses as
> keyboard data. Dropping these packets prevents PS/2 ACK responses from
> reaching atkbd.
>
> Second, the EC count byte is the number of bytes following the count
> byte, not the total packet size. For example, the SL101 returns the
> keyboard reset response:
>
>   03 09 fa aa
>
> where 03 counts status 09, ACK fa and BAT-success aa.
>
> v9 used data[0] - 1 after skipping the count and status bytes. v10
> changed this to data[0] - 2 while tightening the packet bound, which
> drops the final payload byte. Keep the v10 bound but restore the
> correct payload count.
>
> Tested on an ASUS Eee Pad Slider SL101 with EC firmware SL101-0202.
> Together with the SL101 8-byte event-read fixup, the physical sliding
> keyboard completes atkbd initialization and works.
>
> Signed-off-by: Florian Krischer <florian.krischer@fkr.dev>
> ---
>  drivers/input/serio/asus-transformer-ec-kbc.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> --- a/drivers/input/serio/asus-transformer-ec-kbc.c
> +++ b/drivers/input/serio/asus-transformer-ec-kbc.c
> @@ -26,20 +26,26 @@
>                 return NOTIFY_DONE;
>         else if (action & ASUSEC_AUX_MASK)
>                 port_idx =3D 1;
> -       else if (action & (ASUSEC_KBC_MASK | ASUSEC_KEY_MASK))
> +       else if (action & ASUSEC_OBF_MASK)
> +               /*
> +                * Keyboard command responses can carry only OBF, without=
 KEY or
> +                * KBC set. The original SL101 driver treated every valid=
 non-AUX,
> +                * non-SMI/SCI OBF packet as keyboard data, including PS/=
2 ACKs.
> +                */

I have to test this on my ASUS Transformer Prime TF201 to be sure it
does not break other devices. But before that happens I would like to
get Dmitry's feedback regarding input patches.

>                 port_idx =3D 0;
>         else
>                 return NOTIFY_DONE;
>
>         /*
> -        * The data[0] is the length of the packet including itself. The =
data[]
> -        * buffer has to be at least 3 bytes (length + ctrl + 1 data byte=
) and
> -        * must not exceed the EC entry size.
> +        * data[0] is the number of bytes following the count byte: one s=
tatus
> +        * byte plus the payload. The SL101 EC, for example, reports keyb=
oard
> +        * reset as 03 09 fa aa (status 09, ACK fa, BAT aa). Skip the cou=
nt and
> +        * status bytes and forward every payload byte to serio.
>          */
>         if (data[0] < 2 || data[0] > ASUSEC_ENTRY_SIZE)
>                 return NOTIFY_BAD;
>
> -       n =3D data[0] - 2;
> +       n =3D data[0] - 1;

This is legit, I will adjust in v11.

>         data +=3D 2;
>
>         if (port_idx =3D=3D 0) {
> --
