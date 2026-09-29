Received: from mail-vs2-f37.google.com (mail-vs2-f37.google.com [74.125.227.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBB83EEAD2
	for <linux-input@vger.kernel.org>; Tue, 29 Sep 2026 06:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665095; cv=none; b=D3XZ3WUGj75K8w+b8Yx4ouf1cVknJx2suGgLt7NtaNKfNVuBx5GhR2gJD43DHB8DYOgIHwVJqUY57f1Uc60HeKmfKPin0QF8WnFCIC7IgaXSChdraRcNfJP/3uYZxdrgGUfQDYE4UwwQhDH27M3l4vq5Mmj2Nucl4B4QDgjvyz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665095; c=relaxed/simple;
	bh=F/T7t7qSmK+GXitMSA7BLlhbCtT9VtAA7SAIzkQ/EMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X9DSt5KEv7ae7yn8l8LvaM3O0mWdJtTV1Yn47FSHlIB4h4dHxLmD9iKkCu4DqKhwGMQ4dVl7WdoWQGKmI5DUcpLKdN8ow8EWObNxVcrof+JT8nu0VeHd2gfaGNEscSS7y0/Y7UWRB6Xq0nXxjBDDSR5lDclOG/PEDfUsLMPJ5QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f37.google.com with SMTP id 71dfb90a1353d-5cfd29f1208so689664e0c.3
        for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 23:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790665092; x=1791269892;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WOMI2hvRlpBUR+jfgUNfUFOEKzipIMIZarv00xrnPTE=;
        b=ssPkXnSOpZU0d1DeqqXHPsJ4sX4qwTygi/iDHTNYco5OAzaQate8HR0iBdy3OmpvO9
         hmLgvCdvMaW6Zf+wxEKoY8Vz3doPxSiDjKhFibAzEtjmmjVNGSKiXJAN3BHTW9jbS64a
         qvGXxgGnX9V6i33Q1zUek22BSOMpkou/2Zj3vAjVXoVjsYzYbtWhALaaaKAOhRcB7s+J
         fkIjoX+XK4TEdb9RkLmz2iFI0NtRh5WlF71RUUo4C8LbP3yoMgii33s9hBqW6OhsfiHW
         egbNTOU0owkDjbkADvDSOBOv7O+F58+EBbh4d2e70P4zwRBIvhYIfcQaF1qLZ/R6FtCF
         UwvQ==
X-Forwarded-Encrypted: i=1; AKwUvBzxtj+lk5Ybz+GgIQ/yr4LAWZPaFgiqBwSqedF0ahk0ZZjkv2LPDYwCz6YwkLJ3FZqIr9i5Ta88x+4LAg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJAGi7Z7NIIGrSNQDdLkwVKj2nlcRP4E+3URkO48i9Rt0G/wvbf
	lH4xjqX+U14h2IXhHaHXr6kuQDSwcxnJ+pjcemq258qxIrvUxiOljFGlWWx8vADTHUA=
X-Gm-Gg: AYBFou2FTLKVVEHJDlnCn7Bm8UL/jw+vyMZ0EOgzuI9vJQ/Z6sjR2Arxozu7/VXNpFy
	3bLubCgSfW9ClVJ2oW0i683/9JMHIiSHEv52qyCh8Blx551bBFHm7n6LvgNhP9mEpqMoKIlzG2/
	GdMDxJlqXKqf7l4eg9g4dQgk1g0PfNGLTjVNNllHi8quQw0qmv933yZrv4ddLzh4fdIq5rafbiH
	vx80wAHIbnQgxJWAkRm7JkqEplIaNxP+BqkeVe91IeHl9QWwQW3XA6ZaHtRdFG+V8vpgjpP1X25
	O/1nYXF6FUUiFcJaaUU0TTHDuPgrQetsDji4odM+VObg8unZ3yRNAthhldmgDSCS40afQsJeTK6
	j+ihCKq8k/frhdNEwZozQEme+CYNOZFiM+SLLschqIT2DDuATHWRrhbEpBGx/066pIcnSmhn+18
	dWROxHu6USkvoGmZaSszSd0u2T9ZXziBFAqPLxyAIAf4S6vDeUlMZRo1/yBiRy+9jGM3CSD+wCO
	zsrbYG3ARb7x1p4iF5ytOHWPl01xGrq1c7qKjArj1x04nLY
X-Received: by 2002:a05:6122:6602:b0:5c9:c60e:f4b8 with SMTP id 71dfb90a1353d-5cb0bd5fa84mr6582724e0c.22.1790665092065;
        Mon, 28 Sep 2026 23:58:12 -0700 (PDT)
Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com. [74.125.226.204])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5d30b9ec2e3sm636876e0c.18.2026.09.28.23.58.11
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 23:58:11 -0700 (PDT)
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97eaa1155fdso929628241.2
        for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 23:58:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzOPyf9ZxefhVVDqGjnGtXHzjkMwP1B3+Ak+KXJzA8X1Re/VzNhkUWfMg/1DWnx6At7ly3uB95dlCUu/g==@vger.kernel.org
X-Received: by 2002:a05:6102:4422:b0:7a1:f7d2:e80f with SMTP id
 ada2fe7eead31-7af1e9f4234mr4711697137.23.1790665091194; Mon, 28 Sep 2026
 23:58:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814031745.17140-1-schmitzmic@gmail.com> <20260814031745.17140-2-schmitzmic@gmail.com>
 <CAMuHMdUDvsqT5t93-ZO413pwS3rPYPB1_uy+5iRHsii8CYTdgA@mail.gmail.com>
 <ef9e0128-6309-546a-715a-3e7eb476910e@gmail.com> <8c7863da-299f-8c77-0727-fb438467a7ba@gmail.com>
 <CAN5rfbQMTtcvmcgbDwhTQ-D9AGxP5yGqHc=JWbN7PPJXXKPGHg@mail.gmail.com> <CAN5rfbTSiRqo9V1yscb04yckJxQ2z=4VP+G__4+kbTDXeGbj-Q@mail.gmail.com>
In-Reply-To: <CAN5rfbTSiRqo9V1yscb04yckJxQ2z=4VP+G__4+kbTDXeGbj-Q@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 29 Sep 2026 08:58:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXJUmEPiJ9+Op2J=Ztu+QLJ1xhMN+w5hNRzQOEYPXkeKg@mail.gmail.com>
X-Gm-Features: AclHuK8EpOJHD-yywKe_NeGfbRXmk7lvKGhNR-kl6OXZ4KLcR_ECuskix93sSx4
Message-ID: <CAMuHMdXJUmEPiJ9+Op2J=Ztu+QLJ1xhMN+w5hNRzQOEYPXkeKg@mail.gmail.com>
Subject: Re: [PATCH 1/5] m68k: Fix atari mouse movement
To: =?UTF-8?B?TWlybyBLcm9ww6HEjWVr?= <miro.kropacek@gmail.com>
Cc: Michael Schmitz <schmitzmic@gmail.com>, linux-m68k@vger.kernel.org, 
	linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miro,

CC Dmitry

On Tue, 29 Sept 2026 at 01:45, Miro Krop=C3=A1=C4=8Dek <miro.kropacek@gmail=
.com> wrote:
> this patch still seems to be pending, i.e. I can't see it included in
> any of the trees. If there is something more you'd like to know from
> me, I'm happy to help.

I had expected v2[1] to go in through the input tree, hence I provided
my Ab.

Dmitry: if you want me to take it through the m68k tree, please ack v2.
Thanks!

[1] https://lore.kernel.org/all/20260816073752.16656-2-schmitzmic@gmail.com

> On Mon, 7 Sept 2026 at 19:39, Miro Krop=C3=A1=C4=8Dek <miro.kropacek@gmai=
l.com> wrote:
> > On Sun, 16 Aug 2026 at 15:04, Michael Schmitz <schmitzmic@gmail.com> wr=
ote:
> > > Am 15.08.2026 um 11:15 schrieb Michael Schmitz:
> > > >>> --- a/drivers/input/mouse/atarimouse.c
> > > >>> +++ b/drivers/input/mouse/atarimouse.c
> > > >>> @@ -70,9 +70,12 @@ static void atamouse_interrupt(char *buf)
> > > >>
> > > >> Alternative, you could change/restore the function's signature to =
take a
> > > >> "signed char *".
> > > >
> > > > Agreed, but without a way to test this, I'd rather wait for Miro
> > > > confirming that change also fixed the issue.
> > I have just tested it. The new version works equally well,
> >
> > I have just noticed that if I enable the pointer signedness warnings, I=
 get:
> >
> > make ARCH=3Dm68k CROSS_COMPILE=3Dm68k-linux-gnu- KCFLAGS=3D-Wpointer-si=
gn
> > arch/m68k/atari/atakeyb.o
> >
> > arch/m68k/atari/atakeyb.c: In function 'atari_keyboard_interrupt':
> > arch/m68k/atari/atakeyb.c:263:82: warning: pointer targets in
> > passing argument 1 of 'atari_input_mouse_interrupt_hook' differ in
> > signedness [-Wpointer-sign]
> >
> > atari_input_mouse_interrupt_hook(kb_state.buf);
> > arch/m68k/atari/atakeyb.c:263:82: note: expected 'signed char *' but
> > argument is of type 'unsigned char *'
> >
> > I guess this is expected but wanted to mention it just to be on the saf=
e side.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
