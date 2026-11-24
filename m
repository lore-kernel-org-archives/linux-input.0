Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795517313;
	b=siFBb1/2sR19PEiDBWm0yqbCHAah2dNjiijuAx7hGqSOcs3sQfOa0/WwSX3nCPJlybiO
	 kGKcz296H5YDEbRpKvT2Iqh/m0kXjcdCYYMLBJSzZycYietDc1TZoFpothgW+jxZShFZA
	 YBbxaPb7fRDtP01EAzPMiUlI9RgIIHN3Qzxu292KeOVEI8CaK4RJ5AJ/dM5rRbs+7KKMl
	 q+NPd6+Ex1o4batql8eTC4/oGbgrhVeoOB8NDjIsnfZPMe40IJt7FPcsEatE0IA2IgpKu
	 kIBLSU7mcBpeM7lTxJr/mvzQpRSWRW6ibZMaj2exVjM2gz6Vb7IblYNMyVd9izpEYeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795517313;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=sONtv6uuoQDqrzKy2E1x+FEJb1HP1UNQoeW1slamno4=;
	b=XRgXAiN02v4pt43o0LntmMUMrIyYQuxpxzNa9s9JK6Q5FA+2F7bG+LGA0EDIeSQA+uc0
	 ws849aw9vIxa0UzZXzSFtkNdPkVfmboFswlmBCiz44/UqUG5ByomskFA5OU6Svcts+3+j
	 ILV+lfGVYdKCkeO/XmuPEVnfqZ7/S5aJtiR12yms8lHU5WDJOnH7O0RcR/d+84S+wGVi0
	 1+vayksvB4x2BOc4TFz2Todi8YNnRRJuB3SaCILXirtsdZEQvRbHYVsognqQxzMr+4C2e
	 VwKLyOw+oTTy/bbFZ0U1DsFoSsFnBdRkvdxl9IBBDl1vW9R+1qN9Yts5/UK/xvXXHuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE58606A321
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 10:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBE58606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5ed2f163a2fso1403017e0c.1
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 02:48:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795517311; x=1796122111;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sONtv6uuoQDqrzKy2E1x+FEJb1HP1UNQoeW1slamno4=;
        b=cvQQk1QL8i3MYF+vWBzZzzFf4oiKSbyBLkYn2aMjnH//JUuWu7oq3gt2YUaAyg1P/p
         o/NYSi2SQTJBhbfxoZ9eiKjZbc/22F8yYElW5C4M7+EM7sxcK0dKZOXfj4J8XBoxkCz6
         PAyi/JkGk0iIJ2rMGrKjLGt96FM3FNqMAAqKv9SbyTCwH3tfSVptyrKWX91uCpc6o2IU
         eCt5Cl2/41/5Da6IVO0u0suvrHW3KSOv/3+jmJavjg6c+xfhpPSVoDpyNHzSjON9M3db
         TNkunZltJCXZjeeyXg/SzwR/LHmqNltPPh4ABlYPKfKSbrIk7XCdTsnK5egrxqrOWbSn
         rcoQ==
X-Forwarded-Encrypted: i=1; AL+hErFu4823pEkdJTuFdSbF8wvZKXwB++OcIKG9cFw1wnGqbgIzNRs7uNcyqcnBK05Ejtxvab0sRmSy8/HCbQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8ClNQYoa6jRoxYz5dmeCGcCku776EToeQAOVkf+Wl8wMg2pRI2
	TPSJmKRZnVZoh+tG3n+R5UXScYInApiedTfswzXT8wQdcSIduaNbh9cfr0NakXuU
X-Gm-Gg: AZFdTZeaqSgLDe24RSu/PmFyB49sL3bWvP0Dt++JRxoy162Nel7cLBy6WKsXPad4uIA
	BpW1uhnqFalhblLRqyQME2RSnMCkHN/tKftZbfLllo+VRnu59G7kQooUxbhktGo0i8rmc0nZ0os
	ylidivmTh27dK0df7Fl6S3WMRsCevNNXHw7YkjNilnXoa3SbxdrKjo8F/1ji7cy4Y5g/gKVSHbi
	7r2sSJYdZ9FTCRALIJFW/ak/YSimiAkQU72djOkS15mhllhr+yq+dNG19R1Av/szCU4dVhjppNv
	mN7QI9JEyMh7yoiJFDUx8HyAPmO3IHv/Png6a2i+O77rkznDM0Fi9tG2v+o76Ia4uUJ09FZWNAp
	exLIh0MZCgShY2xbmeBBOOfsGWb4wXcA+UnAPGQoHlIyZs1wNSB1UGJsH/gxJfFO5u+v0gvrRjl
	cxqXjZVzhr668h94RRqzr9QhHiT7Kb9Lx35Z6bgpwX4eyEbB2LPTxEaKa/iGCR2Lg06xffDQW8c
	Ng2O+qAz4uvW+GbB0lgtQ0dn8p5WMIbq28u499YjCXu7abvBBQfR06eAoKhpk3MpLOAqx7Pt7Qn
	1LEdcxg9uNcPnlN44QsL+6l5cDxCldDU+DYt5zGbcJVAydHaWRnCBvjYH5tFE7dHm6E=
X-Received: by 2002:a05:6122:3d10:b0:5ea:c11b:432c with SMTP id 71dfb90a1353d-5ee8af2e7bamr7576794e0c.15.1795517310755;
        Tue, 24 Nov 2026 02:48:30 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b609bc7sm14005747e0c.12.2026.11.24.02.48.30
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 02:48:30 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-745497ac8fcso1546908137.0
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 02:48:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErElL/HtABxGeVi1iGmsxsaJKnsz+REwtA/+Hn28w4DKDxelJiMcbVErpET7vlsR9UJ0f8UqyldqYDVwOg==@vger.kernel.org
X-Received: by 2002:a05:6102:6890:b0:7c3:fc96:fbdc with SMTP id
 ada2fe7eead31-7d7396b5a8amr5632287137.37.1795517310321; Tue, 24 Nov 2026
 02:48:30 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124100604.2380938-1-daniel@0x0f.com>
In-Reply-To: <20261124100604.2380938-1-daniel@0x0f.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Nov 2026 11:48:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW1e8_fNpciRaJxxJDUvCsV8bgkOBoPjpzUp=uPNWaM8A@mail.gmail.com>
X-Gm-Features: Aa3M54qB1yt6lqgJnmZUZ9UYgPzwgC5-7_fQiU7RevBgj6A490deRL9llFJVxM4
Message-ID: <CAMuHMdW1e8_fNpciRaJxxJDUvCsV8bgkOBoPjpzUp=uPNWaM8A@mail.gmail.com>
Subject: Re: [PATCH] Input: amimouse - Fix the buttons
To: Daniel Palmer <daniel@0x0f.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

On Tue, 24 Nov 2026 at 11:06, Daniel Palmer <daniel@0x0f.com> wrote:
> On the Amiga the left button is connected to CIAAPRA bit 6 (/FIR0)
> and the middle and right ones are POTINP (called potgor in the code)
> bits 8 (DATLX) and 10 (DATLY), all of these are active low according
> to the "Amiga Hardware Reference Manual (3rd edition)":
>
> In chapter 8, "Interface Hardware": under "Mouse Buttons" a 0 in CIAAPRA
> bit 6 means "switch closed", and under "Digital I/O on the Controller
> Port" reading POTINP "will produce a 0 if the button is pressed, a 1 if
> it is not".
>
> Invert the bits from the registers so the state of the buttons is
> correct.
>
> Tested with Quake on a real Amiga 4000.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>

Thanks for your patch!

> --- a/drivers/input/mouse/amimouse.c
> +++ b/drivers/input/mouse/amimouse.c
> @@ -58,9 +58,10 @@ static irqreturn_t amimouse_interrupt(int irq, void *data)
>         input_report_rel(dev, REL_X, dx);
>         input_report_rel(dev, REL_Y, dy);
>
> -       input_report_key(dev, BTN_LEFT,   ciaa.pra & 0x40);
> -       input_report_key(dev, BTN_MIDDLE, potgor & 0x0100);
> -       input_report_key(dev, BTN_RIGHT,  potgor & 0x0400);
> +       /* the buttons are active low */
> +       input_report_key(dev, BTN_LEFT,   !(ciaa.pra & 0x40));
> +       input_report_key(dev, BTN_MIDDLE, !(potgor & 0x0100));
> +       input_report_key(dev, BTN_RIGHT,  !(potgor & 0x0400));
>
>         input_sync(dev);

Nice catch!

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

That bug was introduced in in full-history-linux commit 7c40d075b02b3ddd
("Add keyboard, mouse and touchscreen drivers. Add tsdev, power and
evbug event handlers.") when converting drivers/char/amigamouse.c.

How come we never noticed before? I did use the mouse after that, cfr.
https://lists.x.org/archives/xorg-devel/2013-March/035831.html

Comparing drivers/input/mouse/inport.c to the old drivers/char/atixlmouse.c,
I am wondering if the same bug is present there, too?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
