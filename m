Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792567934;
	b=1YN+K72TEIEq0XJZ//6mctFUE3+0apqWxCOG0aKKNCu82JRiuslFgwqBpFNDaq0aJv5P
	 QnBgZtskn3eg6EC1IDr3vDSQ9eqsxdZUodvap99rV5YVh91UWw7Jo83NhGUJWqy4kztlx
	 LTh/TEqD1nspddGkpWIZPZMly0YAyEAXDvS3rAol8wZeAM+swln0NwWvMgfy5XYmR5vFE
	 r41cV2hXIVDbsXRfnuzP53/l+c9VLsydnhvvCFNNFhtsu20RJSTM7tO33EWdEb6Sop4Gj
	 HCjehC6cbNgiHmE8jggCMnxrMBrFgWllBfVWaYFHlepA80WzRwAuFSeLuvyU0i92zjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792567934;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=6QAiK2mo/o5kQv4IXUx/z21UDEdea17cHOw3H4USIDI=;
	b=0YvFfrSLi1XLDE+tN2NJMt62HqvBkVQAAB46t+WWBENlaaCfzS+3wK+7wE6MREoIFVB2
	 P49aAFBvgF1U4t68jNIhQ6Vm8YIhmjJGEZGOL9sjVfxjkdb9Doncc24pYhl5x1oKveJWT
	 0jvlsGO0SIMVAkTQkjnPMiib74gQzBPzGof4zLbGP3u9Iixhvg8Mub+yruyEIuh9NiqPr
	 SOXpQZNrsDKLOJ0PljHdfeJTqu8mcWXc/utVtsGvJNGhUvyYX5EoYYbCK7HaAKxSE0o+D
	 9RHXav7JPUsDh7/HVJfSfjm3UoyVMBEnDW2oW04PRuhPnQpsyLVzNQ88LeX7eQVMKQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.217.42
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ED5606A31A
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 07:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2ED5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7cc013095d4so116995137.2
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 00:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792567933; x=1793172733;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6QAiK2mo/o5kQv4IXUx/z21UDEdea17cHOw3H4USIDI=;
        b=0zbxWPP08JBC+knTk/Ea3fCZCCeCaPFcHrdvyNQqVhWECAnmOm9ySuERpcDiNs2J00
         xgKf6kUhCKg3acmRwgYai20zc28LLd8ngPn0HNUjOWLKR4pUDY4/3vLL84RlC/jcLJ0e
         W8KlA17g73MeDCj2abzRsQp04hG4faytmD0KB/1P8TdguBPfit7TMisVONEdmfLISeGF
         NK9go83SdY6FUqMFuhyw3JA2AgHHni72jKvFdsnmf6ewvXQwgu2z+6S19ZqUBFb0Wkfv
         CRgcEW7YuSkxj5sgZdSNF6WomvrT70CGIHeoxOYS61VpxU69OLTtXrAqhJbHkFZg8+CQ
         igWQ==
X-Forwarded-Encrypted: i=1; AKwUvBxj0GBc3AhgJ2AtrOKQsGdb1ULJ7/XpeV109VNqMBZyyGX8ytNarfG2H9dQdgwXDmhn1GnBeUqBpijuNQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKxu73bFwYhc0hn0jwiO04B/ANJz6gXMt1gIrisdpeXsiP3xEQo
	8BLukbDRQeE0ATEDFPRDHMmmaBQI85tvEpkrPSgT/GDC8HJzP8+YlyRU1boijPowGzs=
X-Gm-Gg: AYBFou3rrl/nx8b+H67Gq9RzBtspC9pszYwwd6nV0LRfBTjaOeR3aFwZplX0tebi2zf
	G3oWHDvETVFnWVKrUfOXXTw/usQTcx4SHNmfmD37jDnHcmEAsFnyGLwTkkJeSMctoE6ktuqIGNy
	nWmeQuAl86BTTglQ98frQCCMqBtnbZvLMFDk1jr+hGjliIXgoxea6cIsBIn8rNB2JNdVc8EEbHv
	oiGV9AhPOt+v4RqjNzGp5OVJytLvV+79QIxwUJq5WFn5JWI+Kv0ZNdwbcuxO7qbm4H8PV9LXEWh
	h9/HkvT9R/JjosVFBvDAfyM5Kw5xlo4C5xzPxrPSyVvyJgPq3vsTTyrOJMdtvJW4aLj7fSqonC8
	AcBGQjMzXHy+hiqDu1eLKcr/YtApB5W0BvkLaQnv63E6c9+Y8swvSPHdNhC2SjiTdcc4O+eacrX
	LOMGFOLXnwTmRgEqlpFrtYN3aCj8cKBb7oAd/BjjlDmDFLcxJyzpsAm/SPdiV5qtl0f3SfrQfaA
	bzHGfhnsojd3h1F7KK6d1PbGvt7bIjUpwMrFVqfSjRYLIlYTBp+JDV6KfXzAhb1WLJilSTEry4t
	TdbXOVtsP0QKMU9Tsrpcw48/kUosHu+0QU6aQwM=
X-Received: by 2002:a05:6102:f9e:b0:7a6:85d6:8ae0 with SMTP id ada2fe7eead31-7cc92466125mr426939137.1.1792567933033;
        Wed, 21 Oct 2026 00:32:13 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990d10439absm2152939241.5.2026.10.21.00.32.12
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 00:32:12 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-9907a58f14dso129582241.2
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 00:32:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBypKk8CBvRWv9ElJPzHq7pNbHc1u71aECj6d7J7vhRuro0nc3kL7ajqMQElE7GoLdVDc3jkRMR875T2Mg==@vger.kernel.org
X-Received: by 2002:a05:6102:2c8d:b0:7cc:2152:4f95 with SMTP id
 ada2fe7eead31-7cc9246d45amr430597137.3.1792567932012; Wed, 21 Oct 2026
 00:32:12 -0700 (PDT)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021000338.2160223-1-miro.kropacek@gmail.com>
 <20261021022336.2232886-1-miro.kropacek@gmail.com> <c77944ee-f170-ce57-9065-d7d49fcfed6e@gmail.com>
In-Reply-To: <c77944ee-f170-ce57-9065-d7d49fcfed6e@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Oct 2026 09:32:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXWHXjbCNojoukGq4OWvLSibk-goJo4quLdbOj01neOew@mail.gmail.com>
X-Gm-Features: AclHuK-O5R44UqsZeHR5r5kV3Sh9TQiIGd4qHB-xb-ZK5hAF_St4Y5l-i_lJpFI
Message-ID: <CAMuHMdXWHXjbCNojoukGq4OWvLSibk-goJo4quLdbOj01neOew@mail.gmail.com>
Subject: Re: [PATCH v5] m68k: Fix atari mouse movement
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Miro Kropacek <miro.kropacek@gmail.com>, dmitry.torokhov@gmail.com, 
	linux-m68k@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Oct 2026 at 04:51, Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 21.10.2026 um 15:23 schrieb Miro Kropacek:
> > Kernels are built with -funsigned-char since version 6.2, resulting in
> > the signed 8-bit position deltas reported by the IKBD being
> > misinterpreted as unsigned.
> >
> > The hook is handed a raw IKBD packet, so take it as a byte stream and
> > apply the sign to the two displacement values alone.
> >
> > Fixes: 3bc753c06dd02a35 ("kbuild: treat char as always unsigned")
> > Link: https://lists.debian.org/debian-68k/2026/08/msg00000.html
> > Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Signed-off-by: Miro Kropacek <miro.kropacek@gmail.com>
> > Cc: linux-input <linux-input@vger.kernel.org>
> > ---
> >
> > Changes in v5:
> >
> > - take the packet as u8 * and cast only the two displacement values,
> >   as suggested; this drops the call-site cast v4 needed, and with it
> >   the -Wpointer-sign warning
> > - add the types include atarikb.h now relies on
> >
> > The same cast of the two displacement values was tested on an Atari
> > Falcon030 with CT60 in v1 of this patch; v5 differs from it only in the
> > type of the hook argument.
> >
> > Michael's Reviewed-by from v3 is dropped, as the approach has changed
> > twice since.
>
> Dmitry's reasoning makes sense to me, so we're back on v1 with no change
> in functionality.

If it's just a byte stream, one might not bother doing s/char/u8/, as both
are the same type anyway... and then we're really back at v1.

> Looks good to me, feel free to add my Reviewed-by if it helps get this
> merged.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
for the arch/m68k files:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
