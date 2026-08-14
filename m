Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1853233E8
	for <linux-input@vger.kernel.org>; Fri, 14 Aug 2026 22:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786744833; cv=pass; b=Bpm6ZMCd96b7GWgT4/Rbh0wnhN4GRxNORvDaX9ewM4ChYvw3CHeHYnIUPnJw45pKeLmiPMJ6Y2xI7ktI7EQP4VAn0J3zaE5xCNhyly0CeMJwldKinqE9NCFJFDVt+1IUcmRXvDa8/H7TaJG8RGi8TpZhQJBeDI4uhWmW3SFY1bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786744833; c=relaxed/simple;
	bh=6mne82aAJHtUr30KWi7im0zCitkiQ9PmVr7Igj1yZn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSb4JoaPhI6Qrsq+EixIB69pJaP8hVo7SEbqVZTyUb6EPISo74zqG5Iaw89IXFjZwIIUbWLMbh7PHSIrKZsF+9BTc1d6KBpUAHSWgAqpS7GpqaMbju6zHQVS122JsvFnbL0XPAEFvNf2dvI3hXfVaxXei46VTL5coGboqYnjUFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WF3cKRS9; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WF3cKRS9"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8edda5d56a5so15734896d6.3
        for <linux-input@vger.kernel.org>; Fri, 14 Aug 2026 15:00:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786744831; cv=none;
        d=google.com; s=arc-20260327;
        b=VW5pXxFB1ct+byPeX60tcCivcMAEEK3oRqLQkJAkafu5DOGNZfjE1TWPtO+QMK3pzx
         4vgpMbhefaEShc5FLqBgUFw+gE7KpdmZKIZvPhwejvgYL3SY68MtmZO72N/Qd5yBhZoQ
         9yoq5NQ8x7EMIxLt2FmkGda2b5Rpj3SnZ0BSSlDANPhmiKeD87dA2bVfLWGAZN12Df7O
         0Ggc2SfTmXNt9e+QH4CjCK8LULtKegSeGG81KJSpf7vlI0ono087OxdP7E/cjY7fbj/C
         BeYY+gGlC193ewyPYg8KjYmdQvIXNHT6UoTUrVqr9a0s1+DGQUWkRcBNOtDMj5v9g2Vm
         pUhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oODB2AjBhLLjzDgKnazTq3JE4KieXBOg7eMpYzfqPKc=;
        fh=G8lQZJT+LLkHtbmOvCja0iz9l/t5artH8Dacaluxmso=;
        b=bISjLHijOCDBASmK+y9BsPvWUdSdC0gspyfyg++YxTncN0tfPFy6KnLxBeXxBcKCTs
         G+LfmfcgD7IAkBxZqlhLYbCWf5sEeqQEhoTQhc5DLAZ2Obl25uKbm5TmxJlNzr7yNBEx
         jccB+cFif2e+bzpfImllRCD/NecY0RNhaWI+6u1SmJv8f4vKYY77YPlL2J+KCV70CbQG
         UvemCM4uMf9SJ3VE8wX9JPRgvXM3LKpNn7+vs5O7xWGQuP/0NeoJvckQJPovdzRBxwPb
         Sdju0MsUpx6o+qX4mng9Pn5pZ+ZZsqovUDprvlB8ML0pdILTsbx9I9Rmo8BQn4gL7kqC
         9gEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786744831; x=1787349631; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oODB2AjBhLLjzDgKnazTq3JE4KieXBOg7eMpYzfqPKc=;
        b=WF3cKRS9CScoS4WnQ1cRBD+HZY9urIpF/Msg9sc70Nj0zfYln7Jy8doXjp8e9IPOS4
         KfezoHDq9kQ7JT7k8ruX/7nElJ0+jl8e8nrEssfwKRx7alHVbHn6EAFKG+F/pyLr7Itq
         4ljUD0ce3vpnQ8epxZrjlidYn4aW8TSUEWgLA4SKgdqbyj/LagP4hyw4Y/9RRDfEKLUO
         CVZRxcyHkth9KwdXMLW73JBrHCs+1Vn1HjY9V3PiOnFChxiyY5L7RE/4PwLJ3fSbWChA
         c/kesoi3WzSY7llFMsakqox0CxhS1pibms8BbHkNWgN41ILLJ55Gf4X4H12ih3KnEERO
         zEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786744831; x=1787349631;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oODB2AjBhLLjzDgKnazTq3JE4KieXBOg7eMpYzfqPKc=;
        b=qYEitB4XShpHhqPbyhBvdVH0bNqKRpDZ9lrINQtmUkl0rzpR4Vko9xPL5lx0E1mvqA
         u8AT0FGXjvEVxGaLH6w3mqSGPxs5DTR11L0YImW5SFhDLBbnN4lWLoQHaPADOGeJYbX1
         hx934Zhog7q5QGQA0sUmrwTRcDnA64h6lkFRqHaJfHc5vlR0MHOaTeEIRRcwpvjH47c/
         Hl20KVw6OQfL48yZDs3tJ48Lyq5Ezt9nte+LjJxBXcCtKW2sKHZpbUFa13T8rp+3uipt
         0g71j/E08hZ7FU21I3Dp/XJGTlCq1uwU2rcuRAA5PXUKyBCvl7JsbNpsdtDvAexmy5am
         2UrA==
X-Forwarded-Encrypted: i=1; AHgh+RqLfKQsaPjXcAmYuQSwtm2T59rEI/NQceFG0P8oq2jjOPhkBi6oT8YLlIo6pN1G3SpDemuYp85qblVhdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjUw3qr9F3Hiy7n1lLu+XxLPBOfFNa5ePaXgTNHf+uYS0hwvkz
	0jhY0BxZEQIHWeGonOLfEG8jCVO0ymjLK/3N6O9X2LZbgOUnz0yMEKtBTxycvw4+XYM/8OfBn/v
	H5/sqo+5IHTqNQNkGLkbraTY1HRh8Des=
X-Gm-Gg: AR+sD11gwsSNMft0Z6oyG4Mf3XdVlMVSZPTB76bmRBc4BvipgMxLqFLyNQ3f6BpBZu/
	epG1+NfhcN09kanjI1vDkmKB583PnKKAJmydLAJptThOjw7Z8daRqgtCA+Mcc1XOSTrbpsVKt7X
	TNd7smno36Fl9Araxr2MfB/YsqKzXMKrS1pjbRk/MZK2Qtf4NPKOpqGkqei4l4iqnmCl9ifZ3RZ
	Al59Vm5eS8im/OOoBOs6M059lkBt1VE+wJyejoej+JKM6LVL9C3hBy9XvQhXjc/FYkzRk++UU/k
	W/v7A/7/FwrevHU6S3R15q48TorErH0dY/f1bIblB5Q2
X-Received: by 2002:a05:6214:2c08:b0:8f2:940e:2423 with SMTP id
 6a1803df08f44-90a91d1a557mr123266366d6.11.1786744830628; Fri, 14 Aug 2026
 15:00:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713075110.92469-1-security@auditcode.ai> <20260713093414.94337-1-security@auditcode.ai>
 <36s07n6o-3n6p-p438-6qq7-921r98171q40@xreary.bet>
In-Reply-To: <36s07n6o-3n6p-p438-6qq7-921r98171q40@xreary.bet>
From: Jason Gerecke <killertofu@gmail.com>
Date: Fri, 14 Aug 2026 15:00:18 -0700
X-Gm-Features: AcwNN1VyQkANU9yxbEMoFSqZ9QhxR0gDHgX6WoklB1oekCay5Qss2SGog6-7A10
Message-ID: <CANRwn3SJawDyXOgvWg69mLZspQemMnFNxSDa3OdpTOzzf89ddQ@mail.gmail.com>
Subject: Re: [PATCH v2] HID: wacom: validate report length in wacom_intuos_pro2_bt_irq
To: Jiri Kosina <jikos@kernel.org>
Cc: Ibrahim Hashimov <security@auditcode.ai>, ping.cheng@wacom.com, jason.gerecke@wacom.com, 
	bentiss@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 5:24=E2=80=AFAM Jiri Kosina <jikos@kernel.org> wrot=
e:
>
> Ping, Jason, could you please Ack this one? Looks good to me, but I alway=
s
> prefer to have an Ack from one of you on the Wacom HID driver.
>

LGTM. I suspect there are plenty more similar cases that need
cleaning, but this is a straightforward improvement.

Acked-by: Jason Gerecke <jason.gerecke@wacom.com>

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>
> On Mon, 13 Jul 2026, Ibrahim Hashimov wrote:
>
> > wacom_intuos_pro2_bt_irq() receives the wire report length in `len`
> > but never consults it before parsing. After the report-id gate it
> > unconditionally calls wacom_intuos_pro2_bt_pen() and then, selected by
> > features.type, a fixed chain of sub-parsers, none of which receive
> > `len`:
> >
> >       wacom_intuos_pro2_bt_pen(wacom);
> >       if (type =3D=3D INTUOSP2_BT || type =3D=3D INTUOSP2S_BT) {
> >               wacom_intuos_pro2_bt_touch(wacom);
> >               wacom_intuos_pro2_bt_pad(wacom);
> >               wacom_intuos_pro2_bt_battery(wacom);
> >       } else {
> >               wacom_intuos_gen3_bt_pad(wacom);
> >               wacom_intuos_gen3_bt_battery(wacom);
> >       }
> >
> > Each sub-parser dereferences wacom->data at fixed offsets. The furthest
> > byte touched on each branch is:
> >
> >   INTUOSP2_BT / INTUOSP2S_BT: wacom_intuos_pro2_bt_pad() reads data[285=
]
> >       (the touchring byte), so the report must be at least 286 bytes;
> >   INTUOSHT3_BT ("gen3"): wacom_intuos_gen3_bt_battery() reads data[45],
> >       so the report must be at least 46 bytes.
> >
> > features.type is selected from the VID/PID id_table entry and
> > wacom_setup_device_quirks() force-registers the pen/pad/touch inputs
> > for that type independent of the report descriptor, so a malicious or
> > malfunctioning paired/spoofed Bluetooth peripheral can advertise that
> > VID/PID and send an undersized report that still satisfies the
> > data[0] =3D=3D 0x80/0x81 gate. The driver then reads past the received
> > report and forwards the bytes to userspace via evdev (MSC_SERIAL /
> > ABS_MISC / ABS_WHEEL on the pen and pad input nodes), an out-of-bounds
> > read with a concrete userspace read-back channel, and a true
> > out-of-bounds read on transports whose backing buffer is sized to the
> > (small) report descriptor rather than a fixed-size staging buffer.
> >
> > This is the same class of bug commit 2f1763f62909 ("HID: wacom: fix
> > out-of-bounds read in wacom_intuos_bt_irq") already hardened in the
> > sibling wacom_intuos_bt_irq(), which guards each report id against its
> > minimum length before parsing.
> >
> > Guard wacom_intuos_pro2_bt_irq() the same way: before parsing, reject
> > reports shorter than the furthest offset the selected branch actually
> > dereferences, warn, and bail out. Because the whole pen/touch/pad/
> > battery chain runs unconditionally per branch, a single up-front check
> > against the maximum offset (286 bytes for INTUOSP2_BT/INTUOSP2S_BT,
> > 46 bytes for the gen3 branch) bounds every sub-parser. Returning 0 on
> > a short report also skips those calls for the same malformed report,
> > which is the safe, conservative behavior.
> >
> > Fixes: 4922cd26f03c ("HID: wacom: Support 2nd-gen Intuos Pro's Bluetoot=
h classic interface")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
> > Assisted-by: AuditCode-AI:2026.07
> > ---
> > v2: the v1 check (len < 109 / len < 43) only bounded
> >     wacom_intuos_pro2_bt_pen(). As sashiko-bot pointed out, the
> >     unconditional touch/pad/battery calls read much further --
> >     wacom_intuos_pro2_bt_pad() up to data[285] and
> >     wacom_intuos_gen3_bt_battery() up to data[45] -- so a report in the
> >     gap (109..285 / 43..45) passed the guard yet still over-read. Raise
> >     the minimums to the furthest offset each branch dereferences
> >     (286 / 46) so the guard actually bounds the whole call chain.
> >
> >  drivers/hid/wacom_wac.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> > index da1f0ea85625..89a191cf1924 100644
> > --- a/drivers/hid/wacom_wac.c
> > +++ b/drivers/hid/wacom_wac.c
> > @@ -1548,6 +1548,19 @@ static int wacom_intuos_pro2_bt_irq(struct wacom=
_wac *wacom, size_t len)
> >               return 0;
> >       }
> >
> > +     if (wacom->features.type =3D=3D INTUOSP2_BT ||
> > +         wacom->features.type =3D=3D INTUOSP2S_BT) {
> > +             if (len < 286) {
> > +                     dev_warn(wacom->pen_input->dev.parent,
> > +                              "Pro2 BT report too short: %zu bytes\n",=
 len);
> > +                     return 0;
> > +             }
> > +     } else if (len < 46) {
> > +             dev_warn(wacom->pen_input->dev.parent,
> > +                      "Pro2 BT report too short: %zu bytes\n", len);
> > +             return 0;
> > +     }
> > +
> >       wacom_intuos_pro2_bt_pen(wacom);
> >       if (wacom->features.type =3D=3D INTUOSP2_BT ||
> >           wacom->features.type =3D=3D INTUOSP2S_BT) {
> > --
> > 2.50.1 (Apple Git-155)
> >
>
