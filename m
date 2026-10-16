Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034294F7CAF
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 16:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167273; cv=pass; b=ORIK7q5EApgm2v7ce7PRA3K58EvkfAIBtnB/6NJGjeNJJxDUs+Nd0dRJQY0sogjK6WwRwF86XN1LX2c83hvyNAmFw0oW6FlYb0vxhOHuos8hl72uy2bESraNTcSB7dbzV8dWrNX8B7JR+kA0yRlOOJD5q2hApTOtTeE5KnFm4G8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167273; c=relaxed/simple;
	bh=XWM0PptT48SHio98kQC9yyK4EB0SbfqQBSb6AQOxOw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BeiTCMTNsM2gcTKh877K2snVo/BWPJVD7Dwi0POsxJt3BPmtyrAQ9DPUUzCyoERi+sLps5l5S8S+O9GJBnlAp7Nmxa8UXWQE8z6E50wUXRLx471+xmVuXR3Ac3D91Q9UvTIAJu6X59uzraPhJlTL03uBx0HRQ7rkcGUCiN56HvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyE0CH1/; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyE0CH1/"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3a9ad623098so330361fa.1
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 09:14:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792167269; cv=none;
        d=google.com; s=arc-20260327;
        b=OExGsYsuHEHU+ssiSNc2+jAOnRt/tKO31m79MJsyp+dvAtNFnM+PLc8w2fMcoYtYpc
         FmRTZkrOfsaaZ5OLGUdI/wUrYbK4iOHZnQ3TjXcMJnee5XJnDvmdnwQ3DqJ6n2YIpseH
         lIpMqhGIyvqmT2zoLyDP2jG7qhsX9nQfeBS4WE9F45PGlevKvfDsRPFabWJDS7jD6RJl
         M4ACVYeQ6NUXdVCv7e/RPGRoZvZSKnwnKqStoDn92HT0AeNlEnEmmRqlfHl2Q+cRdZbH
         GLABfVcLSnI0noyN7w1TP0n85NSPRWMx/q88eKNYifs3GdvATwtCzFB3mVNjF7BbrD3C
         bgyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gZER+Z2hSHjmZyeGIvEluIbU09gJM9ZpLypRSxth3j0=;
        fh=dfvPRi+t5KvUF1qpgNVmacxvd83mvku6fE8K+/2kbH8=;
        b=jEaOjq1rVcfBH6krQZaRJmJ2idjr5z77mcGZlHltGMdI0Emgl0GfRToDX0DHEupB9+
         6aOltP8kf9r1iux3E23I3A5Wl8Wi2IHBAEq/F6DLlCCWolqftM9/p0DYV/v0WDn43gR0
         ihOvK9Y9WxOhYJ8ei1axn69xEFdvVKUQqKJlgGP8H88oXxNmEP5T6cO7sbyvosre2bY6
         KBUwEQe3nNE1G4/Sc7b7kqe4QzatG4XjBQuH3OxsjWYCUMIhiUp1drUwjvlu7KEN25x/
         0cKqFfz2hf2XA3qKRPTB2pUxhQOFI9IxHqJ7dSp+Z2pTuVCe2BXxtgUSNUZ3jj+qY+hj
         ua6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792167269; x=1792772069; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gZER+Z2hSHjmZyeGIvEluIbU09gJM9ZpLypRSxth3j0=;
        b=FyE0CH1/3k3Y4x0ZC0WBdKR/xBvrp5AkV6fWDY38Zph43mpi8pS7aJiFFXBoJG69vE
         WY3sTDbAxTpERtQT93X0edh/rXqbqZobNDt9xsI4/XA6qrjlPf9vr2eLiHhrzxO6N9jd
         Zt4izMjSqz3+IBiVZya23DN7//cKuO9w5zW6qWFQOVTuX5ZnnxTZcpzrQjGrQdPiSIcu
         3BQO9FKtWsJefmuSe/EbYuU1ETStnNcVwtUvWb0Ejttmtv2I/JJBFMiJ2SvgsEUchkVX
         O6/viFVChCbvqWs1vMPT4Y5OlCG5/IVQ1nK+WryNeie7tVRNsUWO3EojBArLZW4W/DFf
         8GnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792167269; x=1792772069;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gZER+Z2hSHjmZyeGIvEluIbU09gJM9ZpLypRSxth3j0=;
        b=WI5tfM1I/37UxkMF59LHix/VrFwfSJaGUpND8DFxOg+njAgJt2YaYWU+A47i/y7ylS
         mie/HpKGRTMTpj1ebGAZBFF3UsXbK9AT4ZwX41ickulF3F/Dohyh8QXwthMmOnjC/iF6
         zqn1kFc7aXUY583NpGkNkSYlyxGfuUTvf+dMO6WO/Ss76hw+EqXof7qoBM43ARsIXELj
         rGn6W0RSViNziN2jj9h0NxGEgj9MF1gmryd0r6AQBmf04qMMCK2doDd9pO/30KI6LHbp
         PPkkaT4nETlw7C03yMsGKVzRBLLPiqmAd8mlC0L2F/iED1Y6hnVyAdn1y8oXUHUDKMPi
         lVzQ==
X-Gm-Message-State: AFq9FYKLKs3qnjaszh0G3kVNwCUeMCXxmp4wIlyqKp/Yf931yrSn4QjL
	/P9gGpVZVK61L7Xt/m6DhG89du5e1nZekL1fb2jlWa4f85QWSx5oXnfajyt12xd/+BNEOtZlz2K
	Ta41Dc+w2YZooMiSAG/vSsOWgXL8DZf4=
X-Gm-Gg: AYBFou1rddHWRHBWEwr3lvFq5Jgg3JXv074qQmUxu4Mr+KdEo5R52gP8p4PDHR+g56E
	lJtqzQ16lMtthGURmjmr2a7uM6m2mCKT0zqgiegeD+cp5k50lVcTXst7rAn+W3UvQ62tWLIgY9t
	wYpEZ2jw4mlSlgdiDgQ6hrrvDmG+w8P8lWCI3OMD7BJ0UTCWn04yJPelwWNwNruCfNV2myJzLbp
	qs1eUDLn54lpow+zGfxurj4ybuzl5xdz9IurUGnh0JV36I+QFAkwm6U4q7FEtv2UVAmkG7fR9xt
	CQk1KxNnXVPJuJ89ZEVfsxKczgaiGy0C98ngF0ahAa/WIs8BtQ7sDx1atDd9pQMC6evxUFYlX0n
	JuLYADS59IHeM
X-Received: by 2002:a05:651c:1501:b0:3a9:a9f3:1e93 with SMTP id
 38308e7fff4ca-3ab29290997mr609181fa.10.1792167268791; Fri, 16 Oct 2026
 09:14:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016114757.1099300-1-meven@kde.org> <sashiko-outbox-174261@kernel.org>
In-Reply-To: <sashiko-outbox-174261@kernel.org>
From: =?UTF-8?B?TcOpdmVu?= <meven29@gmail.com>
Date: Fri, 16 Oct 2026 18:14:15 +0200
X-Gm-Features: AclHuK934t3G5978UIGy52jZ8v9DVUSyCs0cEfT2mYhlpX3AVMrgexX3inHtJ8k
Message-ID: <CAOvFf8NOvVUhuD=Ak=kXUN-e32HJTtUh+qyNG2thTHFf-HjHVA@mail.gmail.com>
Subject: Re: [PATCH v4] HID: logitech-headset: add a battery driver for the
 PRO X 2
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 16 oct. 2026 =C3=A0 13:58, <sashiko-bot@kernel.org> a =C3=A9crit :
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] kconfig: unmet direct dependency on USB_HID for HID_LOGITECH_HEAD=
SET
> --
>
> commit d9d20c74276791f547d49f85750e9fd359bb8c0c
> Author: M=C3=A9ven Car <meven29@gmail.com>
> Subject: HID: logitech-headset: add a battery driver for the PRO X 2
>
> The PRO X 2 LIGHTSPEED receiver does not speak HID++, so
> hid-logitech-hidpp cannot read its battery. Its report descriptor has a
> consumer collection for the media keys and two vendor collections, and
> no report 0x10 or 0x11.
>
> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > index 0e3a0ccd6901e..60f579be1da69 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -680,6 +680,7 @@ config HID_LOGITECH_DJ
> >       depends on HIDRAW
> >       depends on HID_LOGITECH
> >       select HID_LOGITECH_HIDPP
> > +     select HID_LOGITECH_HEADSET
> >       help
> >       Say Y if you want support for Logitech receivers and devices.
> >       Logitech receivers are capable of pairing multiple Logitech compl=
iant
>
> [ ... ]
>
> > @@ -687,6 +688,18 @@ config HID_LOGITECH_DJ
> >       generic USB_HID driver and all incoming events will be multiplexe=
d
> >       into a single mouse and a single keyboard device.
> >
> > +config HID_LOGITECH_HEADSET
> > +     tristate
> > +     depends on USB_HID
> > +     select POWER_SUPPLY
> > +     help
>
> [Severity: Low]
> Could this select statement in HID_LOGITECH_DJ cause an unmet direct depe=
ndency
> warning?
>
> HID_LOGITECH_DJ unconditionally selects HID_LOGITECH_HEADSET, but
> HID_LOGITECH_HEADSET specifies a direct dependency on USB_HID.
>
> Because Kconfig's select directive forces the symbol on without evaluatin=
g its
> dependencies, enabling HID_LOGITECH_DJ in a configuration lacking USB_HID=
 will
> produce an 'unmet direct dependencies' build warning.
>
> Should HID_LOGITECH_DJ inherit the dependency on USB_HID, or should the s=
elect
> be conditional?

HID_LOGITECH_DJ already depends on USB_HID, so it cannot be enabled
without it, and the select cannot leave HID_LOGITECH_HEADSET with an
unmet dependency.

HID_LOGITECH_HIDPP also depends on HID_LOGITECH that itself depends on USB_=
HID.

--=20
M=C3=A9ven
