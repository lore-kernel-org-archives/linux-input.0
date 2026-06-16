Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299D33FBB5B
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 06:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781592339; cv=pass; b=fvoiCMUAyKWDAiU2B61q7w8AufXlXbdo0oZaGsyUpWKu5gJEWnpDvntFOTp97sV593EpvUz9jLGe25O5tGH05s8jRtlAayf3u+G0WhtON3ASljvbMabz9PJGF/es2BlD0590rmibgi606maiVyL1r3tSzSKeLLOpo7dNq+34zLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781592339; c=relaxed/simple;
	bh=9MITQHlZE2jQG0r+zMqCjYjCQ3rQ90HVws6GvzoB1Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UcCFA2v7//9+UMyq8SMsqovgsBAEjmAd0k0TIxSaBykgeFVwd8Y9Nope1GH6tGFZlhyGyJddUs468WSCPIOB2SZdWZfC8FySyA2b9DVuIBl31dyubYKgb2H8XSAV/URVMzPxNM4O0cZmTO6tAyk2x6hDBEkIB4VkQ2BhLhsP/uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p/GjyagX; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/GjyagX"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30b932e4bf1so2387561eec.0
        for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 23:45:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781592337; cv=none;
        d=google.com; s=arc-20240605;
        b=XZUKhz82Ouh59jDCcARMVQMgR3OTMZvFekgxpF6n6MygUJfaM8wOoYGBQ6VMzf6W9z
         M+2uPbYDKzSpf81ldcQkUUgB58I6G/ycqxYzz/0N1SdwoQOGQHqz3J68USOW8B6g/sak
         C3RSAVoKuXpQCNrEE0LiG+IuQzssWj2Zhx3u5wItzQXoaAXteSA2K8qotSwJf/CGDo54
         0oFq+6Oqp69Hegq0jwM8edTEjrRlPlyhTfp6+3Ez4634s/qTZqhFnnS9JGIkJ35rE0UT
         qc8DjjJ1q36MmD1Uj7ZSbPqSrOozTr2Ei5MuHZrkazc5zbIlyUNuOlh5d3lXHfR2aBUv
         xpvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8kFsmTNaVGUIcmzldWaeRj4JyXsXyJHFJfqk2C+U9Gs=;
        fh=RbOIwcPwMZiIWgZb4izUWrG842my8mUon8lZKI8uh38=;
        b=BQN/4yObzjeXH1B1ycuATajPNMX4Kj1E9P/o2RBhyqEtU/MsuAg3rqDSiy9e6Q9J+d
         uv5eZUcVoAFphdOIyj+SVxXn1/4KtIPI+CYwdkUU+zyfgrrnIM/P5iWoMaCaffhMrG+7
         k+NhjkwYhGsSkCA5PKBdAfhswFsUsLfpcsyOvYeIj5mAVy7gnB7M5iME5GjnpiBS6+GJ
         mwoPFZ0K6W+9+HGHZPMXNs19i/+mIW3oOKAD0uzMGQfrwOxBjNaVilzPqP6GMoxMYOfx
         p7QYBCc+f7YqYO8R3IP2QUxLNjS7cRlLj0ptio5EZDxhzTvWF4cZ/BdO/HJc2tneSKJ7
         NV+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781592337; x=1782197137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kFsmTNaVGUIcmzldWaeRj4JyXsXyJHFJfqk2C+U9Gs=;
        b=p/GjyagX+PBrsY8ZGDhoJ2tR7Mc6RyJJuOwO1LieKk78tt8H7G0A1xzgN1G+1Ppet+
         iOka0pCUUSrxyhorKchevKQ72l4Cbx7Td3JfpN2eH2Ev8xa+avjwW5h11YUaFyFKOpuS
         nWWck7SesawjEWhBJuBeUoNG0lNTjjAVl/5T82eqyg0TO3vaU4Vz2VvrRknTqrkzhHeh
         n818B30I+vhZDfUSRLE83U9per5I6GHkDGq/F06yo2uC8zzTuaclUB4aG/q9SCNntdSG
         NuoRDzsvYrzqfE2+fOU4Io1TeD2ZBV8ltHNnPPQ3W8cVhXJXlVAEmx8k/Uss0hqDdkbJ
         ajVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781592337; x=1782197137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8kFsmTNaVGUIcmzldWaeRj4JyXsXyJHFJfqk2C+U9Gs=;
        b=V2GfyZXlD78R0eicIQBSxZkQGC+LJOuZCrSWked1pu27YRZIyYzppPSuOPNbEOlN2A
         j3LSXaGS6EEow5NEQdo2pRNy6WlqrgMJRkRjDdTbDkvb0PKFPtYYwlrLfbMXVE8/QF1W
         gB+mcPM8m+Y78hD8T+3gglFxykXjthQbbQ6elfwmBx3Oky5W3zkl9FkCQnhekBN0k/po
         tPevUQtDupaFiyJSSTidC0mQukPjp8CGqCAtvX0OmDWZaAY3OFt1x60WEy822U5bOaQM
         uj4Sr6JpAYhOZu8db5q7m7rX5I4mMkK7IRmWX6VXO6gMD5ZPmULkuvhJsoKCFrwqp0Op
         kbGg==
X-Gm-Message-State: AOJu0Yy5a75DefJrTUptIucNXkcwlWmt4xaT+JkHtm4Z+XueH97UvsDF
	A3Smq96S9eQMf8UU+4t5X+AtewT0Xa265E4qebao1SgXIpfyd6nOQRukiRh47BUUWPKT9ei+xrK
	OMZD8F3qFL5UrkQC4supBxrhzzcgwE/g=
X-Gm-Gg: Acq92OFA8LTlmApKxLETjbVXUTFmv4t+p601BfBn2X1KZmoAXgMDhi5XdftcEhWvTOU
	MycDnHYSp6zYKdaGGwtIzjtbFXxeOnsT0Mw+UOh3ym+P7BphQ/Su4URorRGc+7wnebeYCrK95mB
	SJ9CxYUFHck3SGtmjN3uYMK0uh8V0qPxfFGNsQcgFsP1Pq5YUIZviLWgMA2RFu6dBX01HUT2QGX
	/CdgyTYZX0V5x0wXTXzXC/qPIzolbqO3DuIPDTlDK/2gMdDH7cROVMpxhkmjB3HIg4Kr0i8nNnW
	fOcdw89DGwW4UGPx/KI=
X-Received: by 2002:a05:7300:7481:b0:304:d32e:65f5 with SMTP id
 5a478bee46e88-30940261180mr8677062eec.26.1781592337166; Mon, 15 Jun 2026
 23:45:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512102445.55372-1-clamor95@gmail.com> <20260512102445.55372-3-clamor95@gmail.com>
 <CAPVz0n3Dw6Vtqqn8if=MYkBbYittXqsBKbDvrs1ntbD5Zn6iig@mail.gmail.com>
 <CAPVz0n3iCSeT3xJ2XkwZ6PYofwSLkc0gfm+iYo4xbKBkAtihcQ@mail.gmail.com> <ajDEsU8oZWT7KB9d@google.com>
In-Reply-To: <ajDEsU8oZWT7KB9d@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 16 Jun 2026 09:45:25 +0300
X-Gm-Features: AVVi8Cdni-YgjbkGwaPHD4SvqBamlP3Fi3rQTRtFFK2Yd7Pl3xlrNDqDtcouRWU
Message-ID: <CAPVz0n26H2t=pi_C+t8jP_cWXGSa5pk=1cpTZtkBh3=RQsUk2g@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] Input: isa1200 - new driver for Imagis ISA1200
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linusw@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 16 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 07:1=
6 Dmitry Torokhov <dmitry.torokhov@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On Mon, Jun 15, 2026 at 09:19:27AM +0300, Svyatoslav Ryhel wrote:
> > =D1=87=D1=82, 28 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE =
08:38 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > =D0=B2=D1=82, 12 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=
=BE 13:24 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > >
> > > > From: Linus Walleij <linusw@kernel.org>
> > > >
> > > > The ISA1200 is a haptic feedback unit from Imagis Technology using =
two
> > > > motors for haptic feedback in mobile phones. Used in many mobile de=
vices
> > > > c. 2012 including Samsung Galxy S Advance GT-I9070 (Janice), Samsun=
g Beam
> > > > GT-I8350 (Gavini), LG Optimus 4X P880 and LG Optimus Vu P895.
> > > >
> > > > The exact datasheet for the ISA1200 is not available; all data was =
modeled
> > > > based on available downstream kernel sources for various devices an=
d
> > > > fragments of information scattered across the internet.
> > > >
> > > > Tested-by: Linus Walleij <linusw@kernel.org> # GT-I9070 Janice
> > > > Signed-off-by: Linus Walleij <linusw@kernel.org>
> > > > Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  drivers/input/misc/Kconfig   |  12 +
> > > >  drivers/input/misc/Makefile  |   1 +
> > > >  drivers/input/misc/isa1200.c | 524 +++++++++++++++++++++++++++++++=
++++
> > > >  3 files changed, 537 insertions(+)
> > > >  create mode 100644 drivers/input/misc/isa1200.c
> > > >
> > >
> > > Hello Dmitry! Do I need to make any further adjustments to this drive=
r?
> >
> > Hello Dmitry! Do I need to make any further adjustments to this
> > driver? This driver is hanging in LKML for some time already without
> > responds from input maintainer. It is still relevant and I would like
> > it to move forward.
>
> There were valid sashiko comments on the patch regarding resetting
> "level" to 0 and also potential racing conditions, as well as suggestion
> to check number of gpios specified in the device tree.
>
> Please see if the following works for you:
>
> diff --git a/drivers/input/misc/isa1200.c b/drivers/input/misc/isa1200.c
> index ff82252a08e1..c61adc4b605c 100644
> --- a/drivers/input/misc/isa1200.c
> +++ b/drivers/input/misc/isa1200.c
> @@ -131,6 +131,7 @@ struct isa1200 {
>         struct work_struct play_work;
>         struct isa1200_config config;
>
> +       bool suspended;
>         bool active;
>         int level;
>  };
> @@ -247,17 +248,21 @@ static void isa1200_stop(struct isa1200 *isa)
>                                isa->supplies);
>
>         isa->active =3D false;
> -       isa->level =3D 0;
>  }
>
>  static void isa1200_play_work(struct work_struct *work)
>  {
>         struct isa1200 *isa =3D container_of(work, struct isa1200, play_w=
ork);
> -
> -       if (isa->level)
> -               isa1200_start(isa);
> -       else
> -               isa1200_stop(isa);
> +       struct input_dev *input =3D isa->input;
> +
> +       scoped_guard(mutex_try, &input->mutex) {
> +               if (!isa->suspended) {
> +                       if (isa->level)
> +                               isa1200_start(isa);
> +                       else
> +                               isa1200_stop(isa);
> +               }
> +       }
>  }
>
>  static int isa1200_vibrator_play_effect(struct input_dev *input, void *d=
ata,
> @@ -280,7 +285,8 @@ static int isa1200_vibrator_play_effect(struct input_=
dev *input, void *data,
>
>         if (isa->level !=3D level) {
>                 isa->level =3D level;
> -               schedule_work(&isa->play_work);
> +               if (!READ_ONCE(isa->suspended))
> +                       schedule_work(&isa->play_work);
>         }
>
>         return 0;
> @@ -292,6 +298,7 @@ static void isa1200_vibrator_close(struct input_dev *=
input)
>
>         cancel_work_sync(&isa->play_work);
>         isa1200_stop(isa);
> +       isa->level =3D 0;
>  }
>
>  static int isa1200_of_probe(struct i2c_client *client)
> @@ -331,6 +338,9 @@ static int isa1200_of_probe(struct i2c_client *client=
)
>                 return dev_err_probe(dev, PTR_ERR(isa->enable_gpios),
>                                      "failed to get enable gpios\n");
>
> +       if (isa->enable_gpios && isa->enable_gpios->ndescs > ISA1200_EN_P=
INS_MAX)
> +               return dev_err_probe(dev, -EINVAL, "too many enable gpios=
\n");
> +
>         ldo_node =3D device_get_named_child_node(dev, "ldo");
>         if (!ldo_node)
>                 return dev_err_probe(dev, -ENODEV,
> @@ -479,9 +489,9 @@ static int isa1200_suspend(struct device *dev)
>         guard(mutex)(&isa->input->mutex);
>
>         if (input_device_enabled(isa->input)) {
> +               WRITE_ONCE(isa->suspended, true);
>                 cancel_work_sync(&isa->play_work);
> -               if (isa->level)
> -                       isa1200_stop(isa);
> +               isa1200_stop(isa);
>         }
>
>         return 0;
> @@ -493,9 +503,11 @@ static int isa1200_resume(struct device *dev)
>
>         guard(mutex)(&isa->input->mutex);
>
> -       if (input_device_enabled(isa->input))
> +       if (input_device_enabled(isa->input)) {
> +               WRITE_ONCE(isa->suspended, false);
>                 if (isa->level)
> -                       isa1200_start(isa);
> +                       schedule_work(&isa->play_work);
> +       }
>
>         return 0;
>  }
>
> --
> Dmitry

I have tested your code on my P895 and it works perfectly fine. Should
I resend with these changes or you can integrate them while picking
patchset?

Thank you for your suggestions and efforts!

Best regards,
Svyatoslav R.
