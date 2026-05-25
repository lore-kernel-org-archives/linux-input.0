Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020842F7EFD
	for <linux-input@vger.kernel.org>; Mon, 25 May 2026 03:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779680355; cv=pass; b=NkCyXuWT+IYVXUaDizJWgbeh4S1gf7Wi6VQm+yt3KsmRN4RXkGdEQK8Ojmi4Bhk2Atwl41sq8NzeaaE65PnVx6NLMGqFmTTQ9spxYKEyGFpkoM2/93720EOfAO3xcYZHQJAE1J/WiVE1JF7AibeypHUjuxFEzTWQGxlsfhkvShc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779680355; c=relaxed/simple;
	bh=z6cIIRV9zGTa+jtuvPQ/j2H/8Y/1y7aaysy9OHxuTIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUvHljPgY0n8VyDfeIWqpVbJyrtbJN8XDRNQt2gC71FnNo0x9SFa7cP1r6+7Fqxcqup2VNIviAwIqg4nBN8H2/f+WHLkzV6eAMrMK4s3/24N1ZMNIxOjtZ63LWfRyyEwMRvZWTjE6TytSWqHh96Y9hHt2TBIk8RmGWz8zapjTmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcrdKaUN; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcrdKaUN"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8b98482b253so155344606d6.1
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 20:39:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779680353; cv=none;
        d=google.com; s=arc-20240605;
        b=NdmcrkFxSmPSins85GsUaMJPlVtJvvyzCGyHaXDcsQTwwX4/HTvmvlZ86RzEp0PULi
         wef0eARqzEBqeOJ7Bmtcu03R1Fy/ALd6lNy0jOwPPqZOzBqAf19QkXfoUvUk4ynoATc4
         kARtuByf7kNyCR6K6ONngJ+E1sEkMKscH/x6i+Dt21oMnKuA2T2S+/bjgm68QbvnyZNd
         ZI2PP2hGcn8nvA49M0uNgXU2tc5jybE83lP9l7Cpxgz8dz6BhM38Rsg0WCZduk/6lrC9
         RobhLwZ/9QPh6o3/gefw/Jp1Oxx9BCV73sk8wAxEkzb54X5lDXs0ExiWIhtbQEuBavfW
         FJNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7LAITZFVNXe1IqWBb+mpAAhUQyr1/OI7LF6K9KvFcO4=;
        fh=IbJf+Fbje9342SdCmSFkppn3yAKOoBw83aPO2Lnym8U=;
        b=ldHjBbl1KProE5USCWQF1dgagk3TNeXpR9ygonebCrLgrw59jzCM1rgpvDgARvOFnr
         cTng52XUh2lpuvSuytHArQ0TXjNEEnBrDNBoJ6/xxljOADBvQXd8VLAZ/V0zkZwe2XF4
         TkfShYtXcaEbLPFMLobOkd6Z+AWT7iCjah+w+Uarn16LhMIM1b5FIWMZxzSMGTa8Xv17
         rjfef5oaQpRC/aLgV6Duss1cH0NfW5lAMVXlBCzNV/4dW3IZunZWsxF0cnNyCACbVY6y
         J9BE7NgOTZVhDXuK6K8fzwemZOHlvMl3lXeie/Vwc4EPtF6yvL+b+JKYA596k9GlUFrB
         thQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779680353; x=1780285153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LAITZFVNXe1IqWBb+mpAAhUQyr1/OI7LF6K9KvFcO4=;
        b=EcrdKaUNMY1Bu1TSX+57xYT8eI8qP/MQ+OLyidQJAdGfl57xLuDgS2qPZhG9kyYW8L
         yvcBz27fwORMxbtwxsxd1SibkoVUoNXywbJKQGhGPcnYaHaO4UJLdmHXcdnigTfuOzqa
         VBdd2zH7wex6NLRS2nUSm3eh3gADvtRU0/uQtJXchFvPX1UcVVjbqCLOGU+n/1bBqV5z
         tQ6xA7dFDU2iBJ2US/LtHHBpoYHrvfftul6D9L9sa29MutRbbLsl0U/pHnc2ax3QvVto
         6Zuvl7DQ0oTJkdu5CJdVslvTB0MrlQbxKW9szaPug0RsiA2x0jdG3qq4w8PcX9TNl49o
         CWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779680353; x=1780285153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7LAITZFVNXe1IqWBb+mpAAhUQyr1/OI7LF6K9KvFcO4=;
        b=c9oya9gK3pVNxJQZS1J47yIZJz+vj2f/gp8rVEGKWaD2h96Rsa5kCfLtV9OC1Z/WS9
         Th5W1MsVEziPNtqjj2XYTn0Nfi7vp9/qBMKl92SgGzuse1dOgpjyh+TAsACUe6hsX+zH
         ziGD6N5endn6nFTZy03vgGGTvwvvMzpuISBHIXymt6jkkRBrCbrGfVw3wrboySFLDvqV
         gqQx43yHHea0UgToQl01uJXw5MfCFo4HI5VoJbwzv/iAAX6Ffs7jKkb1uuKhD+lexzyR
         VOodJJi5J3Pn5riCQidGbQsnCuZOmVIUkXtBeKD46qOZrLAbNMPaxWxU/KupeaARtAwO
         g6Ew==
X-Forwarded-Encrypted: i=1; AFNElJ/9Lp1OL3XPxLixP6NK4Yn4YWHbRS0tx0nHM1avjJCNJmgxw5Cv+kMYtbcrzEqA5tlmODNSbDF6Uz9YKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRy2E+51u0ilcNeunIdMWuvGgGupd+x0g15b9eKOYryhSWz9fi
	OK5qrF1K+z9gJp/vWCXdOPGbmlw+BCewAODYCdn+gVoygM/dLHQdIEaZ1C9/hCQ0VhvNvoCJerp
	Cg2aqbuggWNPvsUhkJEiYzXNkirfBcoo=
X-Gm-Gg: Acq92OFRSIEf0NUFIIl0gPHXRN9ul8MHO1GDcTOQllkfYKgW196QsvypsYekYoxswyT
	awrNzUUV7nsnVmXUiHLJ4WAbOallFde6VIG3wynLzboUIEAsvuqu63b/szX5/+/78ut/6N6KZCH
	guynRJ1KUIS29zZ5DwzWN75WCRxx3L6e50NCKtUmzOfvbL02RX7UmGxAMWnD4xSD4lHn8MAemLq
	NENXdm061bn8gMmaYKaDjcMZHoYuTItCl8aeuNkoevf179f6i9VjRWK7sAHKnPHjVA5Vzw1KJPi
	XuA2gr6r1LHwp6qi/w==
X-Received: by 2002:ad4:5bce:0:b0:8cc:d41:ba14 with SMTP id
 6a1803df08f44-8cc7b628b68mr239101266d6.44.1779680352862; Sun, 24 May 2026
 20:39:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525020543.519082-3-derekjohn.clark@gmail.com> <20260525031507.088AC1F000E9@smtp.kernel.org>
In-Reply-To: <20260525031507.088AC1F000E9@smtp.kernel.org>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Sun, 24 May 2026 20:39:01 -0700
X-Gm-Features: AVHnY4Jkg14EBH81qkvmp6MNtputIjbMMV1eI_YJztpyOEWe6LAzE8V4hKQar8w
Message-ID: <CAFqHKTmTVnOivNMvTVBD+-n_pCMknQyUf+D=KqM_Um4Y+gW5=g@mail.gmail.com>
Subject: Re: [PATCH v9 2/4] HID: hid-msi: Add M-key mapping attributes
To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2026 at 8:15=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 4 potential issu=
e(s) to consider:
> - [High] Typographical error checking `gamepad_registered` instead of `gp=
_registered` causes newly added sysfs attributes to unconditionally return =
`-ENODEV`.
> - [High] Dangling asynchronous ACK from `SYNC_TO_ROM` can prematurely com=
plete subsequent commands, corrupting the device state machine.
> - [Medium] Spurious or late `READ_PROFILE_ACK` packets incorrectly abort =
subsequent profile reads with `-EINVAL`.
> - [Medium] If `claw_hw_output_report()` fails in `claw_mkey_show()`, the =
function exits without clearing the `profile_pending` state.
> --
>
> commit fe7de95a59af02c44e638aba1fcc1763f3b5354f
> Author: Derek J. Clark <derekjohn.clark@gmail.com>
>
>     HID: hid-msi: Add M-key mapping attributes
>
> Adds attributes that allow for remapping the M-keys with up to 5 values w=
hen in
> macro mode. Mapped events will fire from gamepad, keyboard, or mouse evde=
vs.
>
> > diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> > index 3a176f44f2c43..5f20102eae69d 100644
> > --- a/drivers/hid/hid-msi.c
> > +++ b/drivers/hid/hid-msi.c
> [ ... ]
> > @@ -87,24 +249,47 @@ struct claw_command_report {
> >       u8 data[59];
> >  } __packed;
> >
> [ ... ]
> >  struct claw_drvdata {
> >       /* MCU General Variables */
> > +     enum claw_profile_ack_pending profile_pending;
> >       struct completion send_cmd_complete;
> [ ... ]
> >       /* Gamepad Variables */
> >       enum claw_mkeys_function_index mkeys_function;
> >       enum claw_gamepad_mode_index gamepad_mode;
> > +     u8 m1_codes[CLAW_KEYS_MAX];
> > +     u8 m2_codes[CLAW_KEYS_MAX];
> > +     bool gamepad_registered;
> >       spinlock_t mode_lock; /* Lock for mode data read/write */
> > +     const u16 *bmap_addr;
> > +     bool bmap_support;
> >       bool gp_registered;
> >  };
> [ ... ]
> > @@ -165,9 +383,20 @@ static int claw_raw_event(struct claw_drvdata *drv=
data, struct hid_report *repor
> >                       complete(&drvdata->send_cmd_complete);
> >               }
> >
> > +             break;
> > +     case CLAW_COMMAND_TYPE_READ_PROFILE_ACK:
> > +             ret =3D claw_profile_event(drvdata, cmd_rep);
> > +             if (drvdata->waiting_for_ack &&
> > +                 drvdata->waiting_cmd =3D=3D CLAW_COMMAND_TYPE_READ_PR=
OFILE) {
> > +                     drvdata->cmd_status =3D ret;
> > +                     drvdata->waiting_for_ack =3D false;
> > +                     complete(&drvdata->send_cmd_complete);
> > +             }
>
> [Severity: Medium]
> If a spurious or late READ_PROFILE_ACK packet arrives, claw_profile_event=
()
> will return -EINVAL. Does this unconditionally pass the error to cmd_stat=
us
> and prematurely complete the wait for a valid, currently pending READ_PRO=
FILE
> command?

This is a limitation of the hardware. In real life usage this issue is
unlikely to occur, and if it does it will just cause a timeout of the
next command which can be re-sent.

> > +
> > +             break;
> >       case CLAW_COMMAND_TYPE_ACK:
> [ ... ]
> > @@ -442,6 +671,177 @@ static ssize_t reset_store(struct device *dev, st=
ruct device_attribute *attr,
> [ ... ]
> > +static int claw_mkey_store(struct device *dev, const char *buf, u8 mke=
y)
> > +{
> > +     struct hid_device *hdev =3D to_hid_device(dev);
> > +     struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> > +     struct claw_mkey_report report =3D { {0x01, cpu_to_be16(drvdata->=
bmap_addr[mkey])},
> > +                                0x07, 0x04, 0x00, {0xff, 0xff, 0xff, 0=
xff, 0xff} };
> > +     char **raw_keys __free(argv_free) =3D NULL;
> > +     int ret, key_count, i;
> > +
> > +     scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
> > +             /* Pairs with smp_store_release from cfg_setup_fn in syst=
em_wq context */
> > +             if (!smp_load_acquire(&drvdata->gamepad_registered))
> > +                     return -ENODEV;
> > +     }
>
> [Severity: High]
> Does this check the newly added gamepad_registered field instead of the
> already existing gp_registered field?

Mistake in rebase, will fix.
> Since gamepad_registered is never set to true, it looks like this will
> unconditionally return -ENODEV, rendering the sysfs attributes inaccessib=
le.
>
> > +
> > +     raw_keys =3D argv_split(GFP_KERNEL, buf, &key_count);
> [ ... ]
> > +set_buttons:
> > +     scoped_guard(mutex, &drvdata->rom_mutex) {
> > +             ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_WRI=
TE_PROFILE_DATA,
> > +                                         (u8 *)&report, sizeof(report)=
, 25);
> > +             if (ret)
> > +                     return ret;
> > +             /* MCU will not send ACK until the USB transaction comple=
tes. ACK is sent
> > +              * immediately after and will hit the stale state machine=
, before the next
> > +              * command re-arms the state machine. Timeout 0 ensures n=
o deadlock waiting
> > +              * for ACK that ill never come.
> > +              */
> > +             ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_SYN=
C_TO_ROM, NULL, 0, 0);
>
> [Severity: High]
> Since this command uses a timeout of 0, could the asynchronous ACK from
> SYNC_TO_ROM arrive while the driver is waiting for a subsequent command
> (like another WRITE_PROFILE_DATA)?
>
This is also a limitation of the hardware and unlikely to occur.
> If the generic ACK arrives after the driver starts waiting for the next
> command, it seems it could falsely complete the next command prematurely
> and break the lock-step protocol between host and MCU.
>
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static int claw_mkey_show(struct device *dev, char *buf, enum claw_key=
_index m_key)
> > +{
> > +     struct hid_device *hdev =3D to_hid_device(dev);
> > +     struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> > +     struct claw_mkey_report report =3D { {0x01, cpu_to_be16(drvdata->=
bmap_addr[m_key])}, 0x07 };
> > +     int i, ret, count =3D 0;
> > +     const char *name;
> > +     u8 *codes;
> > +
> > +     scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
> > +             /* Pairs with smp_store_release from cfg_setup_fn in syst=
em_wq context */
> > +             if (!smp_load_acquire(&drvdata->gamepad_registered))
> > +                     return -ENODEV;
> > +     }
> > +
> > +     codes =3D (m_key =3D=3D CLAW_KEY_M1) ? drvdata->m1_codes : drvdat=
a->m2_codes;
> > +
> > +     guard(mutex)(&drvdata->profile_mutex);
> > +     scoped_guard(spinlock_irqsave, &drvdata->profile_lock)
> > +             drvdata->profile_pending =3D (m_key =3D=3D CLAW_KEY_M1) ?=
 CLAW_M1_PENDING
> > +                                                               : CLAW_=
M2_PENDING;
> > +
> > +     ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_READ_PROFIL=
E,
> > +                                 (u8 *)&report, sizeof(report), 25);
> > +     if (ret)
> > +             return ret;
>
> [Severity: Medium]
> If claw_hw_output_report() fails or times out, this returns immediately.
> Does this leave drvdata->profile_pending set to a pending state?
>
> If the state is left dangling after the mutex is released, could a subseq=
uent
> late or spurious profile packet be incorrectly accepted and parsed into t=
he
> local codes arrays?
>
Subsequent profile events will overwrite profile_pending before
sending their data. This isn't a problem.
- Derek
> > +
> > +     for (i =3D 0; i < CLAW_KEYS_MAX; i++) {
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525020543.51=
9082-1-derekjohn.clark@gmail.com?part=3D2
