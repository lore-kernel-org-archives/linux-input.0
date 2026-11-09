Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794208243;
	b=KzvExP2bkIETo+nUR4G+QuTFDbMupq7il+ZJCb71j+IZK8IDRW13+cHaEK9K6Yd1Wo58
	 3uKOy84twXlsspqUxRYTIwQOlPpkEVtxQO5CLI+a8cB7pFiCL0VikvWFJ/z2Sxc+1m9dQ
	 1e/t59cRe/PoP6OLSOhFA7vDy46QzxjUq8oNbXBQ9TPxi/8VgfIjQMNfbHw0QiuCJYJgr
	 EnNtydoR+rGToZMwkhxLfdkjcl/6J0VBPCWCzG6l8lGtF+65aFgCZLlxXu5fbZ7zT/Qwt
	 3LSxY4lrHqcywVm4cL0/OBfDr9Yqgcp9Wm/4RdxKPqmxiyo0UGuce54mcxJZi9QxQvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sZhN6iC/Sq69bChd4hl8Q8m5Mn1G9mu38NRvMfBDUtc=;
	b=FPj8kNiZOQjXk2OOoNNkqPpP6EFrWzq1KDjyKVF2MQpgcn/3v2d1AgxVtdxD+IRzLW56
	 hZKXqKTyeGX32p+g9VBO6nb5Macy6VA2JuwTh9HyZUNNbyDZ9dwIqiAmJ2Z6zCD5igClP
	 JBXUeH642+mrDy2edY5uFMOMPShmGQmNzvZWg+cnz/K/m5VMaVDx3y3m0I+QE/jrX+BAF
	 tVal7vbiTxBGc5eIq3dUASRJiQxw5zg70UeMAL2Brk4tXo/toYHaFoTai1Yb1yWgs8fqB
	 fve5KH5bFhP+4xvIGlTmycCo7WZbvYOXuP0SEKAgSIl7KoYYXBzkAdiiIYmTJKlDzfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qoK31i3p;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42C2606A334
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 07:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E42C2606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qoK31i3p
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b32daac9d7so3305387b3.0
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 23:10:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794208242; cv=none;
        d=google.com; s=arc-20260327;
        b=Xu3x4MzDwTEYDdC7n4rSDyi+o2quArUG6Nbd2b9dlctPzEmfiQx2DT8LXfFruH3izD
         FYkPI1he5J/dBQaIcFYliQJeanC5mrsV7LAlMdU5m7s7WyvUoOmm/bZWrB1arDY3VDPU
         IDP6xyReUltVINKVFwet7Aj14Y5hRJnlQ4YWhXHmItgJdFtYIrGKq5C4UuELd0++Q2Qw
         EjI6HPR3GNbv8iJpH5r9rsIAVFwh8IM24U8bqXa6V5fCXL6ljDpX4q5f402cASXI87vh
         EnAKaotMHo7nyn172zaTLIJMpfgUAuhHIIf9O56vn+B6GAdRU4IlDyyrkIzXO1fv8m4L
         jfBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sZhN6iC/Sq69bChd4hl8Q8m5Mn1G9mu38NRvMfBDUtc=;
        fh=cxGUN1ht1abGhmUNpixqEUiPLYSF3UmcqvbP30LJjMA=;
        b=NlUABUeW5L6GDfXbX8FPdqHTorZtYHObJAumV1xpiVpQ9vYeBq8xkD3nFIU7jjcW/r
         dR0gK+XrPFo/DrLVQjW9s0LvgLWX6AlQwmvkKLXAra2v5X1//K9Gc6I5ad8Rj2lTvdPn
         zb9I5AQ66K+rgpZHCQcSLd5/9P2GBXrQ6UNItCLdmuQGhXUDE8AAQTqmbyPaVrfPwp8p
         5kCwxAsSK1FYCw9O4e4j8wEUciFBhfDZ5Vla85jKhiMxLQvv5/tmv8cJjYxbW2VItcg1
         Xt4uOs2eBFNjxJyfIBASBgPreJoP3MWFRhmy+hiCJrLtlmVVnHICdOw0zdxd5CDEbuhE
         TVNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794208242; x=1794813042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sZhN6iC/Sq69bChd4hl8Q8m5Mn1G9mu38NRvMfBDUtc=;
        b=qoK31i3pV63aikaG2dHW3gw0V/bLxJgV0EQGKPdaCgbTdWoQAzcJC4ysHmJqxeXeQK
         9+FvOk5a8y7fVOX5soRaEWtz8ChW1XT27z0JEYxdmNX6r7G9906B+52XOoEONJugQwIp
         tXQ4GwV5SzU6agWZyZp7wr+2m7fo4Xjq64AMmF3wrnZbdag+yf3/b6AzEtjzT1L8BUJp
         ahvAmln9ikWXqUlTfrKGT2Pd1baNNMNsahWoYeqJO1cQk6bdfnyEaBy/n9OjKD2b5SQ0
         GpkrmIsYSF6ljDK6D6rYeAcAGPnJMHL5WmvE7quZq210Cp2DYaD3UdPD/NU0Z4Wwna1k
         vdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794208242; x=1794813042;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sZhN6iC/Sq69bChd4hl8Q8m5Mn1G9mu38NRvMfBDUtc=;
        b=1g4FZHYGozlzqDQr4DM3YRSOtfpIOUen3KIlTkL0kN3diRHM7TiVvaMmTF2bQuVFSO
         mFdpzoqgu3WLQ5b6HvzIEtDuXxxBul9OSwYP//OU+bNz4MVgYJLSPmhRJDBpc6w+/VWX
         SZacz26ltzmbigPTJ/hMRhbjSNNrNoAcBRz0DIoGMfCoSRKB82J25vcIpkgKDLi95T5K
         bt8JSIjSOvvt1IhG+WhiKmIalydwFUpNSM1jsX8agixThyjsDxllNMpH1buMkD13SdPu
         jOKIGJsNQwZb3LNLxx3pYDFqLcvHjcxV2006yQmbgQjTr48CVvXVS7eeHwYbpk0wKm7r
         uI6w==
X-Forwarded-Encrypted: i=1; AL+hErHfWqD68JxrOohr7CC5CUTOBl3uGt8RZTVhqWwSHVmuaenzjfnCym/iul3CKvTf/S/lb6b5Pjm7HhEkRg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/IQY+ZWVb8HZsf6MUesQdLRGedvJ+Plw8FftlqI1n5fMvjRzse
	WqKIC2NnaMsqJY9OZ/muwb8C9WlbK3pX0SnOLeX8dR2SGdL46aLwytIvjkSjb/YYTJ0SmFT6VFe
	q4EKq5YImmSsq59V/6K8NSrRCajOhtuc=
X-Gm-Gg: AYBFou2X2xcyTpWf4I24zDevn03UO/+kLjNFk/pXiKbuq9FZvhha3b87ck56Cac1DDw
	SrSPwcfhBIWCf8/RowEH/yH36Vyp4ycKLSbTAD4hb8cDWuvf2u70TxQxNsqSneAbga8FZ4h5TIA
	MCP/9FTPcVSEe/LHugodybMwk13zSjhUNXflslp0iMQHskspjXXfsXJhHuUabM1vE5RM3YdLi/B
	oD8yOlfxzUFA8r/tBs8aED75G5M5p0KmtC9rCG2G1g9z3aTB2RqtwMG+MncC1tSIKt2d/AEEXCH
	XiGF3pTyd7cqOHaCL5EH29rCmq+TAOobDEacR2wHXl7VXF3q6h1ciWVIg58O5eoV/V4CEzruVyh
	JN02/bwtwwDZO2qQHpG/RVkO4RcpDiM1kPWeeZUtz69LsCi5zIPc+Zjfjcs/ueNZ/DNLExxz/wL
	v0fYFyOUNRdlDTVXID6TYEL50PddsppQZoRsIhnGrVXhKsDJy3rZx37jukLtFeBK808vOK6vsG+
	PbjQX4Fw3np1tjGrtyq2jJ+O75nIKAmn5J8gdUpP82fv8kWLk2Q8UJM/7XT0w==
X-Received: by 2002:a05:690c:9213:b0:8b0:dadd:e578 with SMTP id
 00721157ae682-8b36cab7460mr16553447b3.30.1794208241914; Sun, 08 Nov 2026
 23:10:41 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108213656.13031-1-antoniovazquezblanco@gmail.com>
In-Reply-To: <20261108213656.13031-1-antoniovazquezblanco@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 9 Nov 2026 09:10:05 +0200
X-Gm-Features: AclHuK-FhW3Y6XmNHzP6haZP4G5X-CZNURWWPI-z5sCpXmwCxD-yiO7h25l1YMQ
Message-ID: <CAHp75VcP6AD8-vSG-QzxTCWm8RWJG2CQJ=9mrn=3nFGJd2YJXw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Fix MSHW0040 button driver selection on AMD
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
> This is a rebase and rework of Sachi King's series from November 2021 [1]=
.
> It was reviewed then, the review was never acted on, and the thread went
> quiet in March 2022. Sachi has confirmed they are happy for it to be
> carried and no longer have the hardware. Both patches keep their original
> authorship and sign-offs.
>
> The problem, restated, because Hans asked for this in [1] and never got a
> clear answer:
>
> The AMD variants of the Surface Laptop 3 and 4 use the same MSHW0040 ACPI
> device ID as the Intel Surface devices from the 5th generation on. Both
> soc_button_array and surfacepro3_button match that ID and tell the groups
> apart inside probe, by evaluating function 2 of the MSHW0040 _DSM, the OE=
M
> Platform Revision, and treating a returned 0 as proof that the method is
> absent. The AMD variants implement that function and legitimately return =
0,
> so both drivers draw the wrong conclusion, and surfacepro3_button binds
> where soc_button_array should.
>
> The sound test is whether the device implements that function at all, whi=
ch
> function 0 of the same _DSM advertises and acpi_check_dsm() reports.
>
> To answer the question of which models are affected, every ACPI dump in
> linux-surface/acpidumps [2] carrying MSHW0040 was surveyed, 32 models, fo=
r
> UUID 6fd05c69-cde3-49f4-95ed-ab1665498035 revision 1:
>
>   Model                        fn 0 mask fn 2 advertised
>   Surface Book 1               0x03      no
>   Surface Book 2               0x0d      yes
>   Surface Book 3               0x0f      yes
>   Surface Laptop 1             0x05      yes
>   Surface Laptop 2             0x05      yes
>   Surface Laptop 3 AMD         0x0f      yes
>   Surface Laptop 3 Intel       0x0f      yes
>   Surface Laptop 4 AMD         0x0f      yes
>   Surface Laptop 4 Intel       0x0f      yes
>   Surface Laptop 5             0x0f      yes
>   Surface Laptop 6             0x0f      yes
>   Surface Laptop 7 Qualcomm    0x0f      yes
>   Surface Laptop Go 1          0x0f      yes
>   Surface Laptop Go 2          0x0f      yes
>   Surface Laptop Go 3          0x0f      yes
>   Surface Laptop SE            0x0d      yes
>   Surface Laptop Studio 1      0x0f      yes
>   Surface Laptop Studio 2      0x0f      yes
>   Surface Pro 10 Business      0x0f      yes
>   Surface Pro 11 Qualcomm      0x0f      yes
>   Surface Pro 4                no _DSM   no
>   Surface Pro 5                0x0f      yes
>   Surface Pro 6                0x0f      yes
>   Surface Pro 7                0x0f      yes
>   Surface Pro 7 Plus           0x0f      yes
>   Surface Pro 8                0x0f      yes
>   Surface Pro 9 5G             0x0f      yes
>   Surface Pro 9 Intel          0x0f      yes
>   Surface Pro X SQ1            0x0f      yes
>   Surface Pro X SQ2            0x0f      yes
>   Surface Studio 2             0x0d      yes
>   Windows Dev Kit 2023         0x0f      yes
> Exactly two do not advertise function 2, and they are exactly the two tha=
t
> need surfacepro3_button:
>
>   - Surface Pro 4: its MSHW0040 device carries no _DSM at all, only _HID
>     and _STA.
>   - Surface Book 1: it does carry the _DSM with this UUID, but function 0
>     returns {0x03,0,0,0}, advertising functions 0 and 1 only. Function 1
>     there is dGPU base attach and detach handling.
>
> Worth noting that v1 said the devices needing surfacepro3_button "do not
> have the _DSM". That is not true of the Surface Book 1, and the inaccurac=
y
> is probably why the problem was hard to follow. The commit messages now
> describe what is actually tested.

...

> On merging: please do not separate the two patches. Both drivers match
> MSHW0040 and discriminate only in probe, so with only one of them applied=
,
> which driver claims the device on the AMD variants depends on module load
> order. Hans asked for the same arrangement for his own two patch series i=
n
> 2022, so either tree with an ack from the other would work.

If we go with this series close to its current shape, I really ask
maintainers to use `b4 shazam -M` for it to make a cover letter
(without list of files and changelogs) be present in the Git history
(as a "merge" commit message) as it supplies nice piece of
documentation (see the part above ...). Alternatively we might want to
see this be listed somewhere in the code as a comment, or in some file
under Documentation. The rationale is that it is always hard to find
people who may test something on a variety of the HW and having a
technical background provide a valuable summary.

--=20
With Best Regards,
Andy Shevchenko
