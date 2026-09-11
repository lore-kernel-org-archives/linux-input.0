Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17A857D21C
	for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789156496; cv=pass; b=New0OZOH+hrsMMaAiFaD/U/iXudseMbyDRwu+dsG4zgY5vCBy2uweBjjlavf7KU9B7Df8d3BL2zD9niaygLkfieFKTVG2V1OrsxatFRikm61oMhOQ7piWFui0y7iUZTM8CX9tZ1DkuGarZwtrVkLtN3T6j/qEXZXJ2m9s3eheyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789156496; c=relaxed/simple;
	bh=/g5xi9VaXBeIfGF6NMxsdEGjj9+U9ivXLe4wYJ2XRc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=po8rV0iR30Nhnfy296estmhAqYthHpb46NUfv5VVV0LQKFlbwt9+rKxCP3ztI+67YKXsGjgQOhqkX3PtZSI1Z8vMcuR4ZKCVuYhlP6ETKTsR2ba7nJm9PlubcaNrUXO1bb6paRxtf983JdVtlBcNTQPXd3ooKKwb8TZg7hBDrQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oR4t8FZe; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oR4t8FZe"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c1670dad7a8so248614166b.3
        for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 12:54:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789156483; cv=none;
        d=google.com; s=arc-20260327;
        b=XAeA7hN1ChZV5dOYb+iCNyoz1QftZD0n4B5DmN/4Lx9uZZqaEoVtH9kMGwDsaWJ3b2
         /wXy2hoOnX49NvIvBd/qRfjDa68MtEtvZ5OJQVCR4PWrxKs9CzFxApKZ+tSnDQfeoB/v
         OCmozM+WK9Hl2SxOUUgeSEvcSAe6EQhowxgTBdJEwxgeOp8Z2OImGChKB52zmVnHGxnX
         /P0N9M9t+3i5IeN9JZ9bVsHDIEDgGDau1d7CEwgFxlLxA23ek5NqrQyh8fY132ToMIEX
         1RsCXHB3CNTojp2b/47UkW/iXQ9n48q6xibnBkByjbx4PkuDZpRTOvRsHVQEJhkSzny2
         LOJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jFiaBVhBz+qFc4mu8PDMa1Xlvf5B/nyWRrl2nwtY+XA=;
        fh=mje8VX30JPs+gCK87lXq3PASNR3cAin2OIxMHH2SScM=;
        b=MVOKReMSqhvwykiwEZCEggKNXIbyiQ4Gq57zFl8TwQG+/NQbWvUMUgLBGT4Z5Omm3C
         DkR7+ra+AJ9DRCwztdbkFomjZZlEU3wDrq2DD3WHonWrTDrHR3Qzz3kHVxAcFJobQxP7
         l7u/FwwWVmiz9HJDoWsoJnKIjHb2DZs3AskJuz02snWQKuasRm1G4vl5bQMJgPV9NRGU
         2C3og+MFQSh4bcli+KbPcvv5YHUPvy4QKy4OrJlHJtk1w6RiT5Tu6RFtar0/XzoPlS9S
         Boin7tyxlnoibyqbgdmD9I9BUNkP58JvrEi3v+2cfNuT89oQS5kNqgWUOZdwLGjKhaSz
         BsFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789156483; x=1789761283; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jFiaBVhBz+qFc4mu8PDMa1Xlvf5B/nyWRrl2nwtY+XA=;
        b=oR4t8FZeYWD1Th5XjoYotVBGkUTfLt7BrDwGd3gCwpgcRdr2KgbAp0ForEuWPLILAX
         00zPDagzcGGLeAJg50Ev6L2qSQNDdgIhTe93SKaxLPto8ajbNp34TR5EYSiU7o+MX1uu
         LptcrI9FDeDhrExNIejJORlFn+j8iWUe5FlAORQ6fsUnJmg+3ZJgbp2V0LnWaKLs77hV
         XIoC29FDwaQseWGdkcmhjvcD9ur3+WkdLTH2wFxirJ9QyqEZ7fzC8cDnJ5A2ydxb1t/l
         jjCGpFBsJWGV3FnoLw5G0L+Nxz+abbXLKY2OKZGYpkUUoAo2hC4bFb39AvTGmKx7B6SI
         JaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789156483; x=1789761283;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jFiaBVhBz+qFc4mu8PDMa1Xlvf5B/nyWRrl2nwtY+XA=;
        b=ftUjvDUJ+CEYNFBWA9gCKdIKfLNqAoC7QdgD0vuWKhqqMrzMefsE6VObRC+N52rDhw
         0TckCYSk6vekfhTqrzbYlEO0uMQpJbXGy/iLWREfS1qiExb5kuSj+IqlAaWCDvwt4fez
         KIU4e/8vzsFlv12u4AjCbbm2Dqx5CSL/F76+sz12nBGQwso62WdKM8rZh/f1qKsIMwm0
         dkrXUGCQ2DBNf7UUVWpDpemoanmkZvlZ0NuX6b9SZlYSwsJwmD2vJBqq5W5pxX8k2XvC
         JYckSzerxECjymC151NqVc/nVkRaFfGtQXuaoyACpJerGuG85VDap5VwInbYiUQ40DQ3
         XXeg==
X-Forwarded-Encrypted: i=1; AKwUvBy+zlHAuGI7EJr8wlsdPtX8PnpJjAf/XjHpcKeU/SSfmiW7B/bvFhJjirnxxt+x9Geo4HRdKlYlvbzk0g==@vger.kernel.org
X-Gm-Message-State: AFuF++lPa/yumgnsWl1iIcbQZU4MXPIGgPznYAvRkOknSmbO0Bn7H0gv
	wGPgpdBH271e3lLLrgtJZO4sPOfwtPkj0qodSBUt0Nhj9knGwkNvw9LikSiTYkAAaNlh3R1NlM1
	+jiJU45y8g93a6jEyors++N2ENzkvFqw=
X-Gm-Gg: AYBFou2Fj8QgGCoxfDCBQ+J9khytkP4QdfxG6W7nbjgyoXyF7RGg4hUj8e9ewA0FL17
	xPENYdmWTvMUq6jLkzWQu+7xF743Wmbo+qTQ0QUkgvUOLNBy2trZqtUIUSBI/E7Wt75GBFOGwZ6
	BR15uVWi0RxA0FTi6DEHs5DOVjX6i6IxCRWtYd3T9aN54vokLylzjV5km8XLdHIjqvlGNFh+w+C
	wLsGC2U2eDVVqafI5YLZlf+eNWoHa0uvRUA7NbC/6IZjTcysmeb0OHyLrUgJvbmXxkUDX3bErWy
	dh2rmvaE/4p++qqfMvXcWjPepzhan44RPpMp8IW+AS7QhBCL84zmkiJJjIUx4Wt1Z/W6LCNZONj
	/xpRrjsXr1jynugc=
X-Received: by 2002:a17:906:f591:b0:c26:19de:912a with SMTP id
 a640c23a62f3a-c29666bdc3fmr241276266b.29.1789156482793; Fri, 11 Sep 2026
 12:54:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c8efa35aeff7b6ee4f66f1d48d4392976dbde128.1783329551.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <c8efa35aeff7b6ee4f66f1d48d4392976dbde128.1783329551.git.u.kleine-koenig@baylibre.com>
From: Ping Cheng <pinglinux@gmail.com>
Date: Fri, 11 Sep 2026 12:53:29 -0700
X-Gm-Features: AcwNN1XrgStnWGmxuNQqXKK7nNRse8tmJ4sopCfbZbYwU2VNndHMxH7Co3dO-8k
Message-ID: <CAF8JNhJa3hOqt06XYNvhRa-QYz1LyzczPCdWbzs0Oin5DN+euw@mail.gmail.com>
Subject: Re: [PATCH v1] HID: wacom: #include <linux/device-id/hid.h> instead
 of <linux/mod_devicetable.h>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 4:39=E2=80=AFAM Uwe Kleine-K=C3=B6nig (The Capable H=
ub)
<u.kleine-koenig@baylibre.com> wrote:
>
> The single device-id structure that is used by drivers/hid/wacom.h and
> its users (drivers/hid/wacom_sys.c + drivers/hid/wacom_wac.c) is struct
> hid_device_id. So #include the much more lightweight
> <linux/device-id/hid.h> instead the full <linux/mod_devicetable.h>.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
> ---
> Hello,
>
> there is no coordination needed, just make sure to apply it to v7.2-rc2 o=
r
> later. So please take it via the hid tree for the next merge window.

What's the status of this patch? I don't see it merged into 7.2 or 7.3-rc.

The patch works,
Ping

> Best regards
> Uwe
>
>  drivers/hid/wacom.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
> index 1deacb4568cb..d2398b1cdbb2 100644
> --- a/drivers/hid/wacom.h
> +++ b/drivers/hid/wacom.h
> @@ -82,7 +82,7 @@
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> -#include <linux/mod_devicetable.h>
> +#include <linux/device-id/hid.h>
>  #include <linux/hid.h>
>  #include <linux/kfifo.h>
>  #include <linux/leds.h>
>
> base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
> --
> 2.55.0.11.g153666a7d9bb
>
>
