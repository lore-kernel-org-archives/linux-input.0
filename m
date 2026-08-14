Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46837415F07
	for <linux-input@vger.kernel.org>; Fri, 14 Aug 2026 07:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694015; cv=none; b=iQAOiMHSttKva0Fg0dqj+huDRVnSTMpLhIN8kNRKErOG+exfHqNBH4XXUDpntmEjV+5NLWVXYNFP4oFx/DPGn7D+rEY9kriihdcQe5cFZkRkG6/6UPx9oCD/Y1+7r3XKLXUHcSE7tgZZfs1Cl67wwKupR1rKvD/PnNpERf/Peyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694015; c=relaxed/simple;
	bh=7BkQnfAIktusRlNjZWX17il+4/DC7tS0dUmvo6uz8uA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFHxE4QEoEmh30IYzd8ngDjFIFdlIWZ6y9vzE/RlLVFi/pIVxtuQ5xtLQqb/IUnP5X+ulmzIajXjHSDH2dEVsQTa7dZ+b9h6HyuUo6MnKCYakTuOPk6El7+3iagOoRNPKuMBmQMVGTQeRUo57z8Lx/q7MflwUiHDZXCDpCN5zzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5c56dbc3a51so187763e0c.0
        for <linux-input@vger.kernel.org>; Fri, 14 Aug 2026 00:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786694012; x=1787298812;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0qHVfNxtQY2Rdqk6vqe/0GBLwii5v18vOQzYi9aKNQI=;
        b=VGAPqb0ChGvL+riWlGgZhBxrIRGfAHVL+XlKO8mRyxUUKLCdmpTTuYcbFc88epHVt/
         weGlIYM2AJ0ukgFkPs8WkQHJCXbLmAeLUyAVuS8vEyUVb9RBvPEk8BJFCgNF6lLJwTzm
         jlEkB9Se5SpgMA6BsUxDU2rUENvh4PBPF4z9tBpDl6Xag1N0sEO2Ruy02nMWGm7p35UE
         KaYkB3VFsxEed5UBdsZhDh2Ep7lmwEGxDjJ4wQaoMTms64DLljHUGLzbM/YaiqkqCFhh
         gaD/D6bmUjEoOJ/wr3SP6/GaqlgcY3v+Qkr7Dz0dv/WKeHzf3xRLF+a1pW8btl6s4eWu
         RzAw==
X-Forwarded-Encrypted: i=1; AHgh+RrYwWH40iCdXxmvuDYb8FUJpV0TN5UfCZ3ESF96syzq7DrQR5NtWhkfFpSYPojmQCg91cBnEK4mHuPwlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwceVXS9orr8pyNzKQX2KkEPJsiOFLXMaTefsyJ3cwUpzUKPXB2
	mH08E2Hx2vHsEbEyi6f3BAHQOatXPNnboqf8dD3Nz6r15icZaoVaBgw0JbvSU7IQeLM=
X-Gm-Gg: AR+sD114UnoAqluZd3juEEg/saB/OYv8PGbv8BsZjn6rihLYrPh+aMr7FtCmVpPaVhz
	yfPLQBeWW99zGwXuFGlWKjUpLQCFMyYOmn+NZ8ES61joDFx2s90FsctN4sNp+1sWrGzvKmYNKsN
	L5G9UFBDPBvFMoC/0lI18m1rA7AN4QNkJUEuRS9lEZ7OKx2GSz/xhBJblT7yzQvUsqECKtDUrZ5
	mtizzHikVkISilFzmBwr1NSdfr7CPTx/amkITQIujUUCQo7YfyR2JfbOZFoNASWP1liiwYD2+J6
	0VIp2MxgTbyrJjQfpMtwpZ7IusAbQLhv25Uljp11bxObbjhy876Ffd0nSsizaPZVoRqFDJGWcoU
	oBmGXfwju43dh2ea08JyMpzmyQVWbCYhtHixC1+4yuP1ImDivBHJDhtY5bNKJ6rv0JPrlPGhDti
	RAIU5efCE0c6AYWGknaeDdGAn2xrDSbpW1vlMhv7MGsgOfqfCKv3scdTDUsxT9NrdQIQ0Khjdcq
	ssrv1h3MBcQ9yPzFWiJpeECxW3y6g==
X-Received: by 2002:a05:6122:1815:b0:5bd:ddab:59a7 with SMTP id 71dfb90a1353d-5c591f369c7mr665058e0c.10.1786694012121;
        Fri, 14 Aug 2026 00:53:32 -0700 (PDT)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c597c1d3c2sm385429e0c.18.2026.08.14.00.53.31
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 00:53:31 -0700 (PDT)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5bf9466867cso176788e0c.2
        for <linux-input@vger.kernel.org>; Fri, 14 Aug 2026 00:53:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RofO07r0vb10d74UysJVPu5sfeJH2Qm9ORFOLXX+P2Zo8Z1KIilzw/yCzXK+ThXHoOkp4+0WT/GLBuEUw==@vger.kernel.org
X-Received: by 2002:a05:6122:caa:b0:5bd:cb34:1b70 with SMTP id
 71dfb90a1353d-5c591c98081mr656206e0c.1.1786694011698; Fri, 14 Aug 2026
 00:53:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814031745.17140-1-schmitzmic@gmail.com> <20260814031745.17140-2-schmitzmic@gmail.com>
In-Reply-To: <20260814031745.17140-2-schmitzmic@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Aug 2026 09:53:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUDvsqT5t93-ZO413pwS3rPYPB1_uy+5iRHsii8CYTdgA@mail.gmail.com>
X-Gm-Features: AcwNN1WMoINhecOvnhDTMgQZHz3bOdVXUcdM9Pmp4imwGjdsj-hjuib00geilxQ
Message-ID: <CAMuHMdUDvsqT5t93-ZO413pwS3rPYPB1_uy+5iRHsii8CYTdgA@mail.gmail.com>
Subject: Re: [PATCH 1/5] m68k: Fix atari mouse movement
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: linux-m68k@vger.kernel.org, Miro Kropacek <miro.kropacek@gmail.com>, 
	linux-input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Michael,

CC linux-input

On Fri, 14 Aug 2026 at 05:17, Michael Schmitz <schmitzmic@gmail.com> wrote:
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

Since you're now in the path to upstream, you should add your SoB here
(applies to all patches).

> --- a/drivers/input/mouse/atarimouse.c
> +++ b/drivers/input/mouse/atarimouse.c
> @@ -70,9 +70,12 @@ static void atamouse_interrupt(char *buf)

Alternative, you could change/restore the function's signature to take a
"signed char *".

>         atari_mouse_buttons = buttons;
>  #endif
>
> -       /* only relative events get here */
> -       dx = buf[1];
> -       dy = buf[2];
> +       /* only relative events get here; the IKBD sends signed 8-bit
> +        * deltas, and the kernel builds with -funsigned-char since 6.2,
> +        * so an explicit signed cast is required
> +        */
> +       dx = (s8)buf[1];
> +       dy = (s8)buf[2];
>
>         input_report_rel(atamouse_dev, REL_X, dx);
>         input_report_rel(atamouse_dev, REL_Y, dy);

Regardless:
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
