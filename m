Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794241435;
	b=peB64fo6WXRGU/FrvhOw5doRpoRvkkvfgVeNn5asuLNGzYdE7Jc5oRF8vNaYwOUWhvdQ
	 6qYPxNyYIvaV83KWx4VdTgSOA+bNvkjxYK5etAz8P0/aOe2m3W5R5dODX+CYWXgR97Mgn
	 kQnt2xL5Ti0/qRliHzN6je4mq1HKdy0H5JZiOu/XCmYu5qDbKqlQhC5pb1R1XLfsZGRxt
	 p56fHA47bvF/lDamNkGWX20wz/yWHKRmeAOBDxlYLt2Cn+qCQrWhYbiQ8FTB7ZvlchztE
	 AY+GjNkCgD3+ihiEPVutO9oFvvV6S/NWJiOfgE5+vG2jtRJMYYADUCsosJmy8V09OsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vLZwk4AFIJeTe2+OOXpWks9pg7PEHXnH7iojJi3jmvc=;
	b=QHWqlk7RlFM2d+5So9NA+bT2nQrFROI/tQztdYlEuCfmuBVrVrCUyehy7y+yeA76pEG+
	 qpPiMYU2qcVK/ZmLZNFJaKdeMLMd+xhkSt4m+daQicC7ACNGrtGNqPiLo/PYmtfq+hahH
	 tFklY1eRnzSk0MC2RpszUyTJlkCuMNQZ7ByJHAaJowbmU0UDLNkcTGSJYMH567jrdYk0O
	 Kyl+UYvl8kwcwEB2IdMC0DIbuBcQLdyqSO/w7dlZZn8w4t3bnh7jErh+Ff6KVy/dwtySv
	 cTAKHw4BJa8Ij8//JYmlZmszu/t/wlwNLX+mHdIZEfhPhZ3zjz6huiDfyDKEn/nFtQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cu8nCAFJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.45
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FE9606EE81
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 16:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68FE9606EE81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cu8nCAFJ
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7cc0ccc2fddso293316137.1
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 08:23:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794241434; cv=none;
        d=google.com; s=arc-20260327;
        b=JxAIcF1Yt3FeM/i3MB0nEQnB/GEUg7EXYs20JJUmv+Is1Sz+bv+MNhqIq2K0mGw3W0
         jr1o2BDkHaxbldGkCnRGHutmzTciN5d3ggXgZdYM0j45+ocR1UHlkoX5Vzttkepm9IHY
         RIjgAG64aMc2rNmH+U9bdKTnku/tqFm4q3R7G77irtuZwQd54Ol/On6j0JktiZr61pJn
         8cR1vu1Zd/YsTJPoBdQi0qb8geelCDgEE3EYHlCjqPdAPNKBFqbrolV4SZzguXXDG7Xa
         PTD8+t7gkZlkoPK8q8otIolTqVli22P5wrKONVkupGrnq5RkvhfNbDgH6DZDKznkILcq
         nnUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vLZwk4AFIJeTe2+OOXpWks9pg7PEHXnH7iojJi3jmvc=;
        fh=SrZFHHgnMWJ4Yi2tsc+AMvHMszNaxdirf7mI23ChQgI=;
        b=DGQW/R3agpBZaKpwBuGNB6iD4Zdv9FJSzIHFfxrWg5tE2omY8CgLBSoZk8N72s+0U3
         MrbjH5WYlm37/8njQ2n5SpHNMAMf73L+4V7cMg3knvxrRXDD3G6YnUEmCeiTl7lQ1Maq
         MyP1h3gOT9R/LECgtF99bdETML1oKElntUzz0eGIoECOrHYlKoRF39bKxT0wFSbxBZ1z
         3WPP5fNLqVyDa+Xe0+3lrteAOlkjAypGcIDAb+1dcuq/26iherhFTl08J4rVZvBIiPU/
         B1/hYOQgiyQ82Q3tQMCyDQe72IFFNeKQMuASPg0xuaOAi8WBKxFQ1umZeBQJ4ruIbPnU
         F6Kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794241434; x=1794846234; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vLZwk4AFIJeTe2+OOXpWks9pg7PEHXnH7iojJi3jmvc=;
        b=Cu8nCAFJSXX1YDSVio7oqyzvXPl9HWlcRR9i2jzOoHw4PRb6CH5HncmiohpoxKLpzX
         N/dGyR9P45dGot7ZOuleBMWx+7yxVu3EFzgz1oTFkBj19ZVZYLrJhxQqMJn2/W0pW2sj
         pfJ/aE+YoVM+n5e/13dOmSyvzPDskcDa4ZksAzmMLm+Bge9emGrPg6hc91K+wmMKjwpm
         T50SfGtlMgieqSeuREMuL8GevutwdTz575y1No5Pn0KpLsl0HOKx1/Rr6gDtUKjmDmXo
         3iPvdRDchZyejywYz3AxhKbYa5jBHp4dT/WxxKb7vfLZAi0KSOnkVlKWCldWStWhFGR0
         xCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794241434; x=1794846234;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vLZwk4AFIJeTe2+OOXpWks9pg7PEHXnH7iojJi3jmvc=;
        b=fk80SVVoKkeKSKb6RSaIGLpRsiu+cng6mcrt0vfFqYIvCE/4hMoE1sm6GH4GPWBjGZ
         /PBmvIjdECg1KRmC3jHpaTNDh6epOrhpk7V6wvrvb/4+c45ENGO9kKGCyyjyQg+zbh59
         V5zPPXMf97etduernD6FNuX3uzxq3w2bWjeHjzkAys3u1CoQKLJE/etH7zn6aEPO8ZE7
         Y8ne4kei8848tHniB+piXrr9dCcxjd2DNg5Lu3SG1CHGHh3TuNUbUfeAxOtQYLj3pPNo
         jqbNnvjbTEui+n/lCkRAft4hXUySkdRujKycop+GT00cPjx7wTOPlqYyoxBSDUFD+VDy
         4FYA==
X-Forwarded-Encrypted: i=1; AL+hErGzq+Qh4GLqlWUwVHCfmdnO4C1XVVQPB07WYRs+ZYlNvLANY3loDK9FnbL+OJWLbyVl4ZrDkAIfSUOPgA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+dTzsUDU6f/PziyxawEs4ngufaX7pUk+9rsgPjQ1v2l73bQDRr
	QchJ5wu9P0PylIqhck0z8p0mkrBhOAo0d5D+FYXeTVcatAaW2RsSwXWxXae8A30yZPL3a3/jRhZ
	S3k9HXh1fe4l/B47BNUEwGbOKGp31vCI=
X-Gm-Gg: AYBFou3RZZ/qyajxY7n+RLvjU1mW01IQEJXXJO2CCCXbM7aHmVCnfbugkNYy+RTA27X
	nyUfV+PUvm5K32KJ8cZcQMZz4Cx1QTX7Q8iQy7fuYCHbl1PUuUhtJVGt6d6Oo4R2zJUQFZyzGsn
	8VRNHWi8P/XWLr9m8ZX7AHbEVyGCVX0Cq3TR+EHXtf0B68M+0XOdffdsBBEPVrrGCHKTKmc8rQS
	1KAKi/9Vg3VIOpQBocHPFbudcsPGP1EeAq0huTZ1yKnh3VFc8W2ODdEjvBt1bPjSAiWYvkVPsaI
	1YStLxITVra/JcxfEI9UOt71X5iUDskglxTsbnXgx/HqXl8bU0RNX2W0KOEPDiW2/Oc1UHlGFSU
	/+Ji4mmqVPVF70ofrITM/HJ9BkuEcwqbGgkxMva8=
X-Received: by 2002:a05:6102:604a:b0:7d0:5688:f511 with SMTP id
 ada2fe7eead31-7d2db157523mr1181146137.16.1794241434153; Mon, 09 Nov 2026
 08:23:54 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108213656.13031-1-antoniovazquezblanco@gmail.com> <CAHp75VcP6AD8-vSG-QzxTCWm8RWJG2CQJ=9mrn=3nFGJd2YJXw@mail.gmail.com>
In-Reply-To: <CAHp75VcP6AD8-vSG-QzxTCWm8RWJG2CQJ=9mrn=3nFGJd2YJXw@mail.gmail.com>
From: =?UTF-8?Q?Antonio_V=C3=A1zquez_Blanco?= <antoniovazquezblanco@gmail.com>
Date: Mon, 9 Nov 2026 17:23:43 +0100
X-Gm-Features: AclHuK9_L7g6nQeJqb6GRMpf5wVh4DmYUaeFgBi1z-Yb1qLIeH2stSdKS5uAbfY
Message-ID: <CALAp9RGDV-L6icyq6nJhEA1=4DQuj-UOb-3B_NiUAi1JVTojkA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Fix MSHW0040 button driver selection on AMD
 Surface devices
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Chen Yu <yu.c.chen@intel.com>, Sachi King <nakato@nakato.io>, linux-input@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

Thanks for the review.

On the tags, agreed. In v3 the acpidumps reference moves into the tag block
as

  Link: https://github.com/linux-surface/acpidumps [1]

and I will keep the v1 thread, marked [2] and referenced from the text,
since Dmitry's review there is where the "0 is a valid revision" design
comes from.

On the documentation: if the maintainers would rather not take it with
b4 shazam -M, I am happy to put the model table in a comment next to the
check in both drivers instead.

I will wait for Dmitry and Hans before sending v3, so it can cover anything
they raise as well.

Thanks!
Ant=C3=B3n


El lun, 9 nov 2026 a las 8:10, Andy Shevchenko
(<andy.shevchenko@gmail.com>) escribi=C3=B3:
>
> On Sun, Nov 8, 2026 at 11:37=E2=80=AFPM Antonio V=C3=A1zquez Blanco
> <antoniovazquezblanco@gmail.com> wrote:
> >
> > This is a rebase and rework of Sachi King's series from November 2021 [=
1].
> > It was reviewed then, the review was never acted on, and the thread wen=
t
> > quiet in March 2022. Sachi has confirmed they are happy for it to be
> > carried and no longer have the hardware. Both patches keep their origin=
al
> > authorship and sign-offs.
> >
> > The problem, restated, because Hans asked for this in [1] and never got=
 a
> > clear answer:
> >
> > The AMD variants of the Surface Laptop 3 and 4 use the same MSHW0040 AC=
PI
> > device ID as the Intel Surface devices from the 5th generation on. Both
> > soc_button_array and surfacepro3_button match that ID and tell the grou=
ps
> > apart inside probe, by evaluating function 2 of the MSHW0040 _DSM, the =
OEM
> > Platform Revision, and treating a returned 0 as proof that the method i=
s
> > absent. The AMD variants implement that function and legitimately retur=
n 0,
> > so both drivers draw the wrong conclusion, and surfacepro3_button binds
> > where soc_button_array should.
> >
> > The sound test is whether the device implements that function at all, w=
hich
> > function 0 of the same _DSM advertises and acpi_check_dsm() reports.
> >
> > To answer the question of which models are affected, every ACPI dump in
> > linux-surface/acpidumps [2] carrying MSHW0040 was surveyed, 32 models, =
for
> > UUID 6fd05c69-cde3-49f4-95ed-ab1665498035 revision 1:
> >
> >   Model                        fn 0 mask fn 2 advertised
> >   Surface Book 1               0x03      no
> >   Surface Book 2               0x0d      yes
> >   Surface Book 3               0x0f      yes
> >   Surface Laptop 1             0x05      yes
> >   Surface Laptop 2             0x05      yes
> >   Surface Laptop 3 AMD         0x0f      yes
> >   Surface Laptop 3 Intel       0x0f      yes
> >   Surface Laptop 4 AMD         0x0f      yes
> >   Surface Laptop 4 Intel       0x0f      yes
> >   Surface Laptop 5             0x0f      yes
> >   Surface Laptop 6             0x0f      yes
> >   Surface Laptop 7 Qualcomm    0x0f      yes
> >   Surface Laptop Go 1          0x0f      yes
> >   Surface Laptop Go 2          0x0f      yes
> >   Surface Laptop Go 3          0x0f      yes
> >   Surface Laptop SE            0x0d      yes
> >   Surface Laptop Studio 1      0x0f      yes
> >   Surface Laptop Studio 2      0x0f      yes
> >   Surface Pro 10 Business      0x0f      yes
> >   Surface Pro 11 Qualcomm      0x0f      yes
> >   Surface Pro 4                no _DSM   no
> >   Surface Pro 5                0x0f      yes
> >   Surface Pro 6                0x0f      yes
> >   Surface Pro 7                0x0f      yes
> >   Surface Pro 7 Plus           0x0f      yes
> >   Surface Pro 8                0x0f      yes
> >   Surface Pro 9 5G             0x0f      yes
> >   Surface Pro 9 Intel          0x0f      yes
> >   Surface Pro X SQ1            0x0f      yes
> >   Surface Pro X SQ2            0x0f      yes
> >   Surface Studio 2             0x0d      yes
> >   Windows Dev Kit 2023         0x0f      yes
> > Exactly two do not advertise function 2, and they are exactly the two t=
hat
> > need surfacepro3_button:
> >
> >   - Surface Pro 4: its MSHW0040 device carries no _DSM at all, only _HI=
D
> >     and _STA.
> >   - Surface Book 1: it does carry the _DSM with this UUID, but function=
 0
> >     returns {0x03,0,0,0}, advertising functions 0 and 1 only. Function =
1
> >     there is dGPU base attach and detach handling.
> >
> > Worth noting that v1 said the devices needing surfacepro3_button "do no=
t
> > have the _DSM". That is not true of the Surface Book 1, and the inaccur=
acy
> > is probably why the problem was hard to follow. The commit messages now
> > describe what is actually tested.
>
> ...
>
> > On merging: please do not separate the two patches. Both drivers match
> > MSHW0040 and discriminate only in probe, so with only one of them appli=
ed,
> > which driver claims the device on the AMD variants depends on module lo=
ad
> > order. Hans asked for the same arrangement for his own two patch series=
 in
> > 2022, so either tree with an ack from the other would work.
>
> If we go with this series close to its current shape, I really ask
> maintainers to use `b4 shazam -M` for it to make a cover letter
> (without list of files and changelogs) be present in the Git history
> (as a "merge" commit message) as it supplies nice piece of
> documentation (see the part above ...). Alternatively we might want to
> see this be listed somewhere in the code as a comment, or in some file
> under Documentation. The rationale is that it is always hard to find
> people who may test something on a variety of the HW and having a
> technical background provide a valuable summary.
>
> --
> With Best Regards,
> Andy Shevchenko
