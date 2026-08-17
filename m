Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD513B38B0
	for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 23:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009163; cv=none; b=P7Ovy7rxoSJQKjD9szlMMtEGC+jEqWE+Ak4G3k54xbl4b2T3+5+bpdTLUaom76C2nWzwZmbcS7Oq2HVmoyfDS2UWWRinFnCNEMpkO1yAJePY9EMGcLkstj4QIZtdK39+ZpmSObAv5liMobjtlDytnAUt/buRhxyO7BR/+T4sRmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009163; c=relaxed/simple;
	bh=W9pPvJdeB6dmtsw6+vFI+IKuAgfK7XdNTo+7DfJQdVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NclqZWxq4DXkAUtdnOrjoA+SoC8xpupXSTu/siko57193OsTJp09R98pQQn60/9QZGXgdyY/rTfiPkuGL5PGlT03c3HH2I0HGyaJ7cyTUlK9PaK0/vie80Vfabj45SkRV6Z7U/GpwrihEi9+p0nLgcyzZ+F/2IU4ke+wbhWNrjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diX6qsrm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diX6qsrm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9ACB1F00A3A
	for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 23:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787009161;
	bh=qr9mAOA3VfG63Zu5zLgmSkqWB5Coj/DXmXsW17a7nko=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=diX6qsrmbgsEwslS04PSAJ0CGOyFssHOFw8GbItj4gbDFuEN+G2C1uzSV5SAegr3p
	 txp3yueJnjNJM019id2zsduwEQJgQLdLIJ5MB1s512L1QX5AhiPkqtUDPmP80mK5UU
	 POu7Aqhnl9h3YvF7Yc9JNWVX2SEFsj8zwyz4o2JC4amHSaQbYrgGbPGBuCGIk0hqAC
	 mIJPOiOuqKaz7f320lZx+a8+s2cDGWCrQJf1HYQYlQrOnXlNmrW0S9Ovh+gWkwhYHm
	 BR5G9yr+ntQ35CpJ7OJGxVIvqnsDllSdmhcV4tNM9UUe6RyHmhGhzAmSD56spIqA9X
	 BGSXP0Op0VeMw==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c167aa9500dso560706766b.3
        for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 16:26:01 -0700 (PDT)
X-Gm-Message-State: AOJu0YyeK4GDgy36QbGq9lACz6B0GGrifWG7GCT0Ksr76mzKhChd5aT8
	kY3FRFMv+N90xcxKI1IcFhS9Mc6/UhkRGxrBrpL04kMIBC+xG8pa/h/EoSsOTRU0+52CqeOosqD
	/giCe5GfrNhDxQe9i8hzHQ8bdSG4eNg==
X-Received: by 2002:a17:907:8e0f:b0:c20:1db7:f486 with SMTP id
 a640c23a62f3a-c218857a542mr206960666b.4.1787009160436; Mon, 17 Aug 2026
 16:26:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612215033.1885245-1-robh@kernel.org>
In-Reply-To: <20260612215033.1885245-1-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 17 Aug 2026 18:25:47 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJfqJ+MmBdsmhf_JsNyz2H2mnCFRMX97DZ8BBWA_U=q1g@mail.gmail.com>
X-Gm-Features: AcwNN1V6L8FxGo-wg4M3b5tgL5BURZYaxVYgyIVJwQp6UB2xp6kKL7MHKY8GBUQ
Message-ID: <CAL_JsqJfqJ+MmBdsmhf_JsNyz2H2mnCFRMX97DZ8BBWA_U=q1g@mail.gmail.com>
Subject: Re: [PATCH] Input: tsc2007 - Read "ti,poll-period" as u32
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 4:50=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
> The "ti,poll-period" property is documented as a normal uint32 cell.
> The driver used a u64 helper, which makes the helper type disagree with
> the schema even though the stored value is still small.
>
> Read "ti,poll-period" with the u32 helper matching the documented DT
> cell size.
>
> Assisted-by: Codex:gpt-5-5
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/input/touchscreen/tsc2007_core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Ping

> diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/tou=
chscreen/tsc2007_core.c
> index 524f14eb3da2..db18b712999d 100644
> --- a/drivers/input/touchscreen/tsc2007_core.c
> +++ b/drivers/input/touchscreen/tsc2007_core.c
> @@ -224,7 +224,6 @@ static int tsc2007_get_pendown_state_gpio(struct devi=
ce *dev)
>  static int tsc2007_probe_properties(struct device *dev, struct tsc2007 *=
ts)
>  {
>         u32 val32;
> -       u64 val64;
>
>         if (!device_property_read_u32(dev, "ti,max-rt", &val32))
>                 ts->max_rt =3D val32;
> @@ -240,8 +239,8 @@ static int tsc2007_probe_properties(struct device *de=
v, struct tsc2007 *ts)
>         if (!device_property_read_u32(dev, "ti,fuzzz", &val32))
>                 ts->fuzzz =3D val32;
>
> -       if (!device_property_read_u64(dev, "ti,poll-period", &val64))
> -               ts->poll_period =3D msecs_to_jiffies(val64);
> +       if (!device_property_read_u32(dev, "ti,poll-period", &val32))
> +               ts->poll_period =3D msecs_to_jiffies(val32);
>         else
>                 ts->poll_period =3D msecs_to_jiffies(1);
>
> --
> 2.53.0
>
