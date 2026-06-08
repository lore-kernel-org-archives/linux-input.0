Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083FB38C2C6
	for <linux-input@vger.kernel.org>; Mon,  8 Jun 2026 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780950051; cv=pass; b=ZsF15dXfTh9qO3KO8u4WeIXokbowex9eIv4MjqAC0BTF9rVB4LAt6zdu3/Pr7TWWLoKieRJGncf4a+pGTZyE3gomem5McQFKaJZd9LzG7tKbsbnRPZX50H4G+v9y0yYm4/NRozQDekejtU25QW9Oa5iVsmBCWQO0dU32MuM1gFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780950051; c=relaxed/simple;
	bh=vV3Cys6b1uPIizdYBnb6UdHneJnd3MHnFo8LjuTeFww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=REEfrKDe5dbexM/jEm5TgujnVRl54wa7vzPWxYRkEra38EOoyiWlO+BGgeGqgYhcpXLHR6mMHuyBmQ3FNQXuzmZqBn7uENFj6cfb33yUU+y1AabUL69UoqLXswACcl0oYAlBaKygEtB2AQjMSE2uIq4ASiTN0H50mUwRH7Ur2hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgWLMn+U; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgWLMn+U"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-68bfcf11050so8621104a12.0
        for <linux-input@vger.kernel.org>; Mon, 08 Jun 2026 13:20:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780950048; cv=none;
        d=google.com; s=arc-20240605;
        b=jXXUyAZza3qcBgOgb0H7YjokK/jz2ZZGbwTuZsZzKFwK1PnhXhpsfqax5D+NquGwOo
         iAPhGvBFT3FuDbQYtwsFno7gIj6MdP2bulLTCYPHlVGmFFypN6M1jXx3Ng/mbYzL7go6
         yi/Piq7fY7662p1OBrQGSfX80w7nIPsRdQNXSm0bRRblx7PGIg3PKtRKJLRNuz8BvdXz
         9VM1qkbf0UkwPj0O/3xF0sRQlL+Acmb/tk1MUA9xXV7+eXTqrIXbQbdu19W63cYX5tBD
         d5QZ54YPj0iSA7qvUhKCXkwmqpIlktyY+rINxHdVqlXg6iIiCQHNeys26Y/6JMWrEv6/
         5iQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4RHUt2a3tGK9rkXId5mJpPnrZX4F2h+VjNJpe7zp9xs=;
        fh=gZYnotoHaRxE7sjsTLrRkxpyPQEcJhlNgrpxw5agc40=;
        b=a9OGxGDyK2yNG2DmZ5forUu0jRj1HZ3e6OCem2AECqlZIkKMq/u7yOqp7791cK1Q+1
         Fc79uH75DEQ+cskWvfhGiPZMhz9GhYEZrg8E4t446Yik+e+6ZDNh1azGBGyZUkcGuuiN
         7Vse+I4onBmUiJKbFYVpz0CM4EZTWb+A/6vSOGkODHuk1xSyMR2zJAitY6FCvx12hYIy
         HD3Kqg7+rj/Tb/VkrnM0rJZpKHh7zCs4AH8JHcxPPYtdepErZsoHuOTr/ju8iil+YnXs
         b7COehaO7rHYG7z5B1fN0hgKQL9gdsVVXmRLdNzkkDAQh+JiNIrguuW10DPV+aVAKr6O
         nc1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780950048; x=1781554848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RHUt2a3tGK9rkXId5mJpPnrZX4F2h+VjNJpe7zp9xs=;
        b=cgWLMn+UirGhxjI1Ynedv7URDXymcrilnkRyNUlNEdoaJk85kR1IjCMA39FxeK8Xhq
         AarERpCuXNFFxdlJFT4PKIscbymERQWS45tLnVpW03aOSd6aQ7jd6ME6RJ+QG7Mq8C8Z
         cb33CFX0ZXljg08IdtjVhIgFH8cH+B5TDEetvtBfiKz30MuMYY4TbweWQEXXygrM74Rs
         zu47as0tPtS7X+JlfNpp7TRKQ+bTzP2taBzbdfd9SfcTMqj0rc5Ql5+qgM0jfFH7UbPp
         PQhWb+oPXWyevEngzK800hFvZBfFl8Ma2JhhZ+wIeeKV4+n4P1+O/QMknqrQg1JIHY7J
         B3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780950048; x=1781554848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4RHUt2a3tGK9rkXId5mJpPnrZX4F2h+VjNJpe7zp9xs=;
        b=CjPL5ZHcRmwKQWHKs8+dJ+/4OeVvyC/c2gBBmGgWuMnms7CeZp22HD7zMPrlJ6ccmR
         adfwTUz9TbNHd2ArCkMTkqdoK8OFstlBKPTbWuH/zGv9d8IGx903PAEc+O6bQ6RkQkLu
         iJj4Wdue0YMY30XerPVuglwOg7aUTfhc3Yd/KioIEKvIK6s3d4O8LRf6TD6EnusokVoX
         /V/iiRHX1+1PHFa2ktT3NxA+8c3VeqdCSntvoVuAJABAuEi7iRrDVLx/zzh/XjIF2/UQ
         FgAPKPquhFqIHN0GrUrJEW5ho+1sWxYqN8vuyMwp6Prj94c4GZN5sZb+v3VNxV1y6UmB
         TXNw==
X-Gm-Message-State: AOJu0YzQRL2hH0F60JmiF3q21fGxtHCjKjEglrsvHC1c1s3DeTU9GGp/
	JB9M0egWQxLmrV2Z9NRYO/XGEQFOZ+VxkIcnLNHAZIRjRuszPuQnoL4gmkVt6LwIYh4u+o65+/8
	K4PHyRsd+1dnhkADM0vkpBdjr9jVcWB3iesO/tYY=
X-Gm-Gg: Acq92OEAQx3luVC4hfD3yZhtOixXNBSnPkgVdkMKXtYFtEIdazuG07a5jIh4E6exOoZ
	IOFXBw1QsOWetU00ZaruxNppg/LHj+wHzdgdyvyBP5ZEkRbxCIIvTqiR5vENm0DpZMLrNv2XHkJ
	YLa1Jf6Emky4LuoaVvmfgebnqaquNBdVKnYmtc0OTjKNebtGCtO5DXwaqPpLau7HV5NfXSz9lgn
	TS/D2qn8tZsUWmh5ySoSsa/3b1RLgVkTQGEzV0PKKL+k/P+0IDuqBumsP+ewc/NJQjMaSWGTplq
	nrs5jSWcXSY57o9vAwZD4Pd80Dk5ewBRw6h4bU625xbuSqzgeUMnXtu57VcKtDFN4OSvutn8b5t
	WFSXvnfL2Tuq94CJ+wZmaXOprtEwir+uvan0D/On1HtPU9wXiEddaJy3WRmm6kkC9ycU8
X-Received: by 2002:a17:906:cc59:b0:bee:215e:5486 with SMTP id
 a640c23a62f3a-bf3725405f2mr614443366b.36.1780950048416; Mon, 08 Jun 2026
 13:20:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608045041.4664-1-rosenp@gmail.com> <aibx1y8ANiZoMHyY@google.com>
In-Reply-To: <aibx1y8ANiZoMHyY@google.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 8 Jun 2026 13:20:36 -0700
X-Gm-Features: AVVi8CdX_rrC5xztWw5gXaZRacCnczIxXwJC1OV5Ze93V6neo92G2KtI55OaleA
Message-ID: <CAKxU2N8s8z5jD2JVU4b166jQYsUjWMj4Q5a-B6vkX7-fhCK8LQ@mail.gmail.com>
Subject: Re: [PATCH] input: ipaq-micro-keys: simplify allocation
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 9:49=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Rosen,
>
> On Sun, Jun 07, 2026 at 09:50:41PM -0700, Rosen Penev wrote:
> > Use a flexible array member to have a single allocation.
>
> Why does it have to be flexible? The size is known.
From a quick glance, that would be a compilation error. micro_keycodes
gets declared after ipaq_micro_keys

From looking at a bunch of struct definitions, [ARRAY_SIZE(foo)] seems
to be atypical.
>
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/input/keyboard/ipaq-micro-keys.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/input/keyboard/ipaq-micro-keys.c b/drivers/input/k=
eyboard/ipaq-micro-keys.c
> > index ca7ec054b1ce..0fc5b5dcdef5 100644
> > --- a/drivers/input/keyboard/ipaq-micro-keys.c
> > +++ b/drivers/input/keyboard/ipaq-micro-keys.c
> > @@ -23,7 +23,7 @@
> >  struct ipaq_micro_keys {
> >       struct ipaq_micro *micro;
> >       struct input_dev *input;
> > -     u16 *codes;
> > +     u16 codes[];
> >  };
> >
> >  static const u16 micro_keycodes[] =3D {
> > @@ -90,10 +90,11 @@ static int micro_key_probe(struct platform_device *=
pdev)
> >       int error;
> >       int i;
> >
> > -     keys =3D devm_kzalloc(&pdev->dev, sizeof(*keys), GFP_KERNEL);
> > +     keys =3D devm_kzalloc(&pdev->dev, struct_size(keys, codes, ARRAY_=
SIZE(micro_keycodes)), GFP_KERNEL);
>
> Please keep to the limits for the kernel. 100 columns is acceptable when
> leads to better readability, but I prefer 80 when it makes sense.
Seems I forgot to run git clang-format here. Will resend.
>
> checkpatch.pl would have warned you.
>
> Thanks.
>
> --
> Dmitry
