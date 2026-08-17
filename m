Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741623BBFB1
	for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 08:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786953658; cv=none; b=XLWkApzzO8s/0c5GqYiZkbQvPo309yo3qTVswyqCrvjOwmrXqAmMIo0nFDEb6sQ9uUj92XjUwRdx7bIO/vkuPZgj46ZSgssWVrNc7X5wKfOXbHAfIMM3i72tccAbDXTVIXBiRsrRy+PAG5xxLDqkOIv98S7R6ZAsLVSIjY5qpvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786953658; c=relaxed/simple;
	bh=o4GCnT9Q7KKtMGlSItfIkAisf6gdkc9OYv2RNknuqSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRi5SSSvlCn3pnyfbiNVkZoKlCvhO4iAedrBRhkwOpoqBVBO4gmYixFvF8OaH549fuV4ClXsDCZ1P9bHfQUqD3npFU8V6Lf9OkkZoVuY7Xc94BYuTQyrubKyuOOoXmuLakiuDpJkkbA24H+eYktqD2Wolm9L/0NBLvSmwmyagEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-97bf8f94cb3so490920241.0
        for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 01:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786953656; x=1787558456;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u/+yV80fX1YIAnHqERFUO5SmbBJag9Ryono5118GOFQ=;
        b=dfYsXC5k5WX2xoPRkh26NCTxHP084Mlb6wFNhUPIRjcCRfLpLR13XvK05X69iu34Td
         +3hRnEidjUwu57s2DpQ2du2qeUkQHkCP7bHjVUaXkSI+wcQnSAGSltzDTO1aJrtLWxXU
         1QvORq2gPCHSxTk5vwwXF/Fd3QYXTmwRCrWoXlDhssEC0jgs3x5NwjD3PAqRIS7JOj0P
         S3Z3LIa0uDit75aGGbmQ5kgVOgj2KcObOfbWvJBtX73/R7WEfmt1Vz+m4WlYpp/oVX4a
         aHJdtZSeHeZYDjap1Bz3Ay4RRFn4dO8o0hfm2FeOp4/SoF4r7BDOWiGMDmBlFCMf4CJJ
         U9Sw==
X-Forwarded-Encrypted: i=1; AHgh+Ro68ImUjeqMbDJOEuAUANy88N8SPiOs2/epogPu7AydfaGd1cxojSQdmvyGzqXgnydC6iRYJm10j9iucA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYvWnLN258xrr+zwwaHMKMfHN7EtBmPXmi/R18MTIWcnMFJKOh
	Ak0cQK/GjsR8PK8+vAo4zf1ptr1i5yPOcU8/Q4j7e/stNX/Uxqlyuet9+/9yxdf1
X-Gm-Gg: AR+sD105nhS/FWgkSJ7mnifslLiidpT4D2mpiBazdEaqWviLnSX8YmzPWkp36NYfWs8
	D1Qb3ui+HGGrMRtFoVijdgBJnTQ7aKXBzT0PGUkmrivJv9FNUOwJjVDvECsFHgGiD4mob2fTvzg
	fuugFiAvuPh0JGEfkbN3bp0OZAobrQ2AP8ZeTq3NDIlJ28H6hyDkuYTvjQTPIGEm/W4Uh0MHYTK
	e68J0BxP7uuf9v+dynWaZbQ5IMxObU1ze2ejh2QcFvZttgIyaIQ1M0DB4/kgyR8B9nIeF1O0rAX
	GoOCD1BiSVc6RZSsLKsE7hzLqOVgWdCbq//zHyPb72l7fk2pOKbC1nvyi+OPfP+z240wiUlFBqU
	MtoQW2CkH8wrd09WwaZpojivdnV8Y3xeG/Q4Xc3kzAQc+sNXwbeVcBMWPCgA2dz0g1/nEoxIUha
	dXFxCttsZZZJjVyvkXr2uW734TY6SEjwLgDMbmyg/aST6CRMI2lMoyv8TTK737iMjlS7Bt1mkKy
	yht3s49DiGcW8LWDZsNJ6sexkcekA==
X-Received: by 2002:a05:6102:26cb:b0:631:4cd8:b6aa with SMTP id ada2fe7eead31-76f2cc50ae6mr3289969137.13.1786953656235;
        Mon, 17 Aug 2026 01:00:56 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97c2c409c99sm613349241.12.2026.08.17.01.00.55
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 01:00:55 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5c2dbaf828eso1098329e0c.0
        for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 01:00:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqhbWblfGGcX1pW/UFZ4iSfA+4DYWWWwUbkoF7DrIz8Js+57mLvOLM1S7pOOKep3quZZ6vFqxvJrLDeXg==@vger.kernel.org
X-Received: by 2002:a05:6122:f05:b0:5c2:c0de:f06a with SMTP id
 71dfb90a1353d-5c591f9f1b0mr3909422e0c.14.1786953655176; Mon, 17 Aug 2026
 01:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816073752.16656-1-schmitzmic@gmail.com> <20260816073752.16656-2-schmitzmic@gmail.com>
In-Reply-To: <20260816073752.16656-2-schmitzmic@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Aug 2026 10:00:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXyOSOahXjXbJksXgrNY8WOjwf-cqx_HrtcLy9s_Yfz2w@mail.gmail.com>
X-Gm-Features: AcwNN1VGXZC1fvEFifX8RzfaBRusZdOtGYs2dpCK1ZiPNulbOW5iHL_5W02SOOQ
Message-ID: <CAMuHMdXyOSOahXjXbJksXgrNY8WOjwf-cqx_HrtcLy9s_Yfz2w@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] m68k: Fix atari mouse movement
To: Michael Schmitz <schmitzmic@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-m68k@vger.kernel.org, Miro Kropacek <miro.kropacek@gmail.com>, 
	linux-input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 16 Aug 2026 at 09:38, Michael Schmitz <schmitzmic@gmail.com> wrote:
> From: Miro Kropacek <miro.kropacek@gmail.com>
>
> Kernels are built with -funsigned-char since version 6.2, resulting
> in signed mouse position deltas getting misinterpreted as unsigned.
>
> Cast deltas passed in (unsigned) scancode buffer to correctly
> interpret sign.
>
> Fixes: 3bc753c06dd02a35 ("kbuild: treat char as always unsigned")
> Link: https://lists.debian.org/debian-68k/2026/08/msg00000.html
> Signed-off-by: Miro Kropacek <miro.kropacek@gmail.com>
> Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> Cc: linux-input <linux-input@vger.kernel.org>
>
> ---
> Changes in  v2:
>
> - change atamouse_interrupt function signature to signed char *,
>   drop signed casts (Geert)

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
