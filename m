Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766E13DA7C6
	for <linux-input@vger.kernel.org>; Wed, 20 May 2026 17:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297922; cv=pass; b=l4OmUhI3xaHKQ56eNRKdrMeY2+j/jwaLt704mcL4xKsKLnQlJes6vBEplXImvhjRCVEa2SDzguJghOopN3fDoP5bqktkR2MRjDEoNkW0U8UG/yoi83IHeOwNi+Z0Ed7rcCM8zzHC8Xh0t8ocvEF3InEy2IsyVPJxpy7IbrU6Xo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297922; c=relaxed/simple;
	bh=W2Zmr4LzjuX8U/fTumYg4RTnYzSgBW2304Rq62FECyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jC7zXB6agPxC0cNEkxuQ0Uerb1O5o+P567SvkdSRFg4SKXOU3jxIYd8Apd10qXrciXxDucAex6l1aDsNh9UKWz0JIav6vh/cHmgbvMq6Zb1291gzAFovzkeNx6ZxBDRFKvzsik++tyQHgO2GJ39qkxHmRWPBtgWOmIJ8HvrobMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAkANWxY; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAkANWxY"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2f36da5c8fbso4658360eec.0
        for <linux-input@vger.kernel.org>; Wed, 20 May 2026 10:25:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779297920; cv=none;
        d=google.com; s=arc-20240605;
        b=Hs9Vtk7wZRYOb9b+DOQgqUQG1PNGDMSMUFm95uVpmRISxDuo7ssaR03iSA3nX+kwtZ
         VghIzJBdfGkFghlJJ3+p1T+Mht/vox1AAK7qmLKLIfeuNsOcxq6012hxU2qyqIgOe3Q2
         9oIDINL8lJcUDUEKlnfKCG7inRUkn7WikN0nEI+tAw7XOwIBHCrHdbv3Waz1+nkqQbGY
         Q9N6OMDRMZ+GVxx16zyRQJ6sRANhezMYAiTN4iZm/1ZIWscpfS2qJEOigC6ns2Xr1dlA
         rlhtvc7NY1IOaDXYXVW4h3PrPAWN9W389GVhyeN/KcP1MxcKtO/BwkdFB4s4zt7OLT72
         Lj0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pTJ+qpNqxTVRFJSoAdeWMwfmemEjKB7qZTfcUw2okZU=;
        fh=7XvvBbWtlYsGpzB3sjD8Ye+nlbwB812zjwmFmDYwhqE=;
        b=R87MkPFOP0f00xtbB1VquIhfyy2cns5CUYJikYdTcMjJQavog3KFOWz6IbOTJq1sOS
         3ar67aBEU/71a2gwx6AfujaXo/6f3EdWQFzV1GJICM6Di0q1w+XnSGuJdsD9AkFgwoVR
         9WjfR4puBlfri20ZhZw7W6+dLSmoKeJZy+asc8eT2dOVozLa334PjoaZUMbO86WJ54F6
         69iX7XgOsHpEUj8UHFc5ABiqKNoTSSUqTdObCI/2DXkpn2Zz63XAYMf2K9MM25edL5hL
         cENrJ32WwYIl8MKMmlWszU8WKrpm3NZ31U4NoDxEiGwYbU54/F69RjagEz/YbNwYr7qh
         dakQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779297920; x=1779902720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTJ+qpNqxTVRFJSoAdeWMwfmemEjKB7qZTfcUw2okZU=;
        b=gAkANWxYemAGONkvLMT1fPXjq+Yt9PD1eHV23t/UFmaCX8k8McSRrj5tfiUjcqftiJ
         uSVc5DSjJp+hQoGF3CrxuedDFr8CUG70gU4x97mONWH4A+BO360ehTZvOcnWQnJP+53S
         iF+cnm2QmpJaGaGTSxUJmo9u8zVhsdnhFEn224A3t/ATpq9TaLJDsApuc2WevTRvgVxe
         j40yq35FYPx9PbYMToT/6Fd4WpccBSwJgYznwA37/b1yL2Jp/W4u0as9TH1+cDdeDz9m
         bt47CeJAqL9a4aM+LHDXEesTRZWS7534BZ324PhyAgmkg1MNhZP+VdJ7g1RQDFT3L9A+
         s9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779297920; x=1779902720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pTJ+qpNqxTVRFJSoAdeWMwfmemEjKB7qZTfcUw2okZU=;
        b=DoF3NqQ0H5MD20T+0wyyTav28jPNXey5Ud7uZkzfnMWsO5FgTf296DChLaG4S85aZG
         TfMkRXVzARWAHxlGB+2dQlB3wcIGWu2Clgw7Iry22QrkXRIyLzl8SQWv9BXq6N98NsLU
         pGwYCL3L1iSjeNUH4zXAA5Erx2PdswuD8rYKjAthAi1W/jn/1uFqW59LpMsgDXRIZanJ
         RV6zt8OkJj7sQIEplH1gMVjRKbELUEHW8stWArpd9LnHaFJvUJ597qcTsDcZDA3hzee8
         6IljfEo1uw5DD76BaFDRRsUhwhk59fAS8eGUFiVFEyoIYgNo7CwoAz7VAFiVEK8k2u0+
         n5ag==
X-Forwarded-Encrypted: i=1; AFNElJ9Iubzl+tRmT7mp40IkrvfYkqV9yFLHqXwj99rrFua6ud1UKkO1BvHp4tDYPbgT37SZe5xDvN094e1kBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvpFvu0PZQEAyZ6/MJUhG5hsIYZo8AVkOYsdZajbhXKh+0mk4G
	NS1UkRMhpe2O/r4OxD1kof6aJKU2pFkb8xEVYosibMPjG1PBNKDH2R02fCn8wA4uZ91oR06+aKS
	x+UDp+iKPQZd8sW02XQmmKZMxwRmng7s=
X-Gm-Gg: Acq92OF6fbtMEkU1M4q0G8GtirPtW0cu/269/NDtzrrukvSv227DEihSzgX6Dma3ImV
	wUnj4E/Ale+9bo3pRxHhof5yflVJ84uJu+yvdtiM4qAYfVv0rMg3GiyJU7/D53zeeC01RFmDOpw
	kiaZXBIyUrcMcU+zyVs0zYhlJGJLEKsqMjF0zc9foiQ/XOLZ47JW7hQu08nDN9Qnk15XkylhKTi
	srDlAv8mp8HLvDK0EYgUDjoqrJ12v9S5DyVL4kUnTrjMZ606+aftPoCTfuykYNv7yNiQDijRAid
	9F+HNNEytD2b3+y4UpY=
X-Received: by 2002:a05:7301:9f18:b0:2e2:4979:ec7 with SMTP id
 5a478bee46e88-30398188068mr12104364eec.10.1779297919372; Wed, 20 May 2026
 10:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510110804.33045-1-clamor95@gmail.com> <20260510110804.33045-6-clamor95@gmail.com>
 <20260520150758.GG2767592@google.com> <CAPVz0n0t4PXfmgWYQ1vSTFwfg=+g4oGU+-dwgnBVKxUoUwHGqw@mail.gmail.com>
 <20260520160548.GK2767592@google.com> <CAPVz0n2s32uYP76R9VNtWYnHrDQJKK+qC1uRRdkaX1ekF15Pww@mail.gmail.com>
 <20260520170234.GN2767592@google.com>
In-Reply-To: <20260520170234.GN2767592@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 20 May 2026 20:25:08 +0300
X-Gm-Features: AVHnY4JZhma2ixtU98PfXtnc_wi0qyCf3_sR6bNe6Gls04f5jclDHbIKfn1qbLE
Message-ID: <CAPVz0n29SdjJxj6nx7GPx4+L_a-wZ-i+5jiOpL2btR_FQdp47Q@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] mfd: motorola-cpcap: diverge configuration per-board
To: Lee Jones <lee@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Tony Lindgren <tony@atomide.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 20 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 20:0=
2 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, 20 May 2026, Svyatoslav Ryhel wrote:
>
> > =D1=81=D1=80, 20 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE =
19:05 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Wed, 20 May 2026, Svyatoslav Ryhel wrote:
> > >
> > > > =D1=81=D1=80, 20 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=
=BE 18:08 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > >
> > > > > On Sun, 10 May 2026, Svyatoslav Ryhel wrote:
> > > > >
> > > > > > MFD have rigid subdevice structure which does not allow flexibl=
e dynamic
> > > > > > subdevice linking. Address this by diverging CPCAP subdevice co=
mposition
> > > > > > to take into account board specific configuration.
> > > > > >
> > > > > > Create a common default subdevice composition, rename existing =
subdevice
> > > > > > composition into cpcap_mapphone_mfd_devices since it targets ma=
inly
> > > > > > Mapphone board.
> > > > > >
> > > > > > Removed st,6556002 as it is no longer applicable to all cases a=
nd
> > > > > > duplicates motorola,cpcap, which is used as the default composi=
tion.
> > > > > >
> > > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > > ---
> > > > > >  drivers/mfd/motorola-cpcap.c       | 142 ++++++++++++++++-----=
--------
> > > > > >  include/linux/mfd/motorola-cpcap.h |   6 ++
> > > > > >  2 files changed, 87 insertions(+), 61 deletions(-)
> > > > >
> > > > > Looking much better, thanks.
> > > > >
> > > > > Nit: A patch-level changelog really is much more helpful to revie=
wers.
> > > > >
> > > >
> > > > Noted, but I will not guarantee that I will do patch-level changelo=
gs, sorry.
> > >
> > > That's fine.  All I can do is ask.
> > >
> > > Note that, helping out reviewers usually ends up helping you too.
> > >
> > > [...]
> > >
> > > > > > +static const struct mfd_cell cpcap_default_mfd_devices[] =3D {
> > > > > > +     MFD_CELL_OF("cpcap_adc", NULL, NULL, 0, 0, "motorola,cpca=
p-adc"),
> > > > > > +     MFD_CELL_OF("cpcap_battery", NULL, NULL, 0, 0,
> > > > > > +                 "motorola,cpcap-battery"),
> > > > > > +     MFD_CELL_OF("cpcap-regulator", NULL, NULL, 0, 0,
> > > > > > +                 "motorola,cpcap-regulator"),
> > > > > > +     MFD_CELL_OF("cpcap-rtc", NULL, NULL, 0, 0, "motorola,cpca=
p-rtc"),
> > > > > > +     MFD_CELL_OF("cpcap-pwrbutton", NULL, NULL, 0, 0,
> > > > > > +                 "motorola,cpcap-pwrbutton"),
> > > > > > +     MFD_CELL_OF("cpcap-usb-phy", NULL, NULL, 0, 0,
> > > > > > +                 "motorola,cpcap-usb-phy"),
> > > > > > +     MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 0, "motorola,cpca=
p-led-red"),
> > > > > > +     MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 1, "motorola,cpca=
p-led-green"),
> > > > > > +     MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 2, "motorola,cpca=
p-led-blue"),
> > > > > > +     MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 3, "motorola,cpca=
p-led-adl"),
> > > > > > +     MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 4, "motorola,cpca=
p-led-cp"),
> > > > > > +     MFD_CELL_NAME("cpcap-codec"),
> > > > > > +};
> > > > >
> > > > > Nit: I wouldn't complain if you wanted to have all of these on a =
single
> > > > > line for neatness.
> > > > >
> > > >
> > > > Noted
> > > >
> > > > > > +static const struct mfd_cell cpcap_mapphone_mfd_devices[] =3D =
{
> > > > > > +     MFD_CELL_OF("cpcap_adc", NULL, NULL, 0, 0,
> > > > > > +                 "motorola,mapphone-cpcap-adc"),
> > > > > > +     MFD_CELL_OF("cpcap_battery", NULL, NULL, 0, 0,
> > > > > > +                 "motorola,cpcap-battery"),
> > > > > > +     MFD_CELL_OF("cpcap-charger", NULL, NULL, 0, 0,
> > > > > > +                 "motorola,mapphone-cpcap-charger"),
> > > > > > +     MFD_CELL_OF("cpcap-regulator", NULL, NULL, 0, 0,
> > > > > > +                 "motorola,mapphone-cpcap-regulator"),
> > > > > > +     MFD_CELL_OF("cpcap-rtc", NULL, NULL, 0, 0, "motorola,cpca=
p-rtc"),
> > > > > > +     MFD_CELL_OF("cpcap-pwrbutton", NULL, NULL, 0, 0,
> > > > > > +                 "motorola,cpcap-pwrbutton"),
> > > > > > +     MFD_CELL_OF("cpcap-usb-phy", NULL, NULL, 0, 0,
> > > > > > +                 "motorola,mapphone-cpcap-usb-phy"),
> > > > > > +     MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 0, "motorola,cpca=
p-led-red"),
> > > > > > +     MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 1, "motorola,cpca=
p-led-green"),
> > > > > > +     MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 2, "motorola,cpca=
p-led-blue"),
> > > > > > +     MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 3, "motorola,cpca=
p-led-adl"),
> > > > > > +     MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 4, "motorola,cpca=
p-led-cp"),
> > > > > > +     MFD_CELL_NAME("cpcap-codec"),
> > > > > >  };
> > > > >
> > > > > A lot of these are duplicated, right?
> > > > >
> > > > > I would have a comment set, then the differences in separate cont=
ainers.
> > > >
> > > > It may be impossible to predict a generic setup since some devices =
may
> > > > require unique compatibles, other may not have LEDs, third may be
> > > > partially incompatible with existing cells. In other mfd cases
> > > > creating a generic bundle might be good, but in this case I would
> > > > suggest better to keep these separate entirely per-device. They wil=
l
> > > > not take much space, nor add confusion with these macros.
> > >
> > > I'm not sure we're understanding each other.  Let me give you an exam=
ple:
> > >
> > > static const struct mfd_cell cpcap_common_devices[] =3D {
> > >      MFD_CELL_OF("cpcap_battery", NULL, NULL, 0, 0, "motorola,cpcap-b=
attery"),
> > >      MFD_CELL_OF("cpcap-rtc", NULL, NULL, 0, 0, "motorola,cpcap-rtc")=
,
> > >      MFD_CELL_OF("cpcap-pwrbutton", NULL, NULL, 0, 0, "motorola,cpcap=
-pwrbutton"),
> > >      MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 0, "motorola,cpcap-led-r=
ed"),
> > >      MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 1, "motorola,cpcap-led-g=
reen"),
> > >      MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 2, "motorola,cpcap-led-b=
lue"),
> > >      MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 3, "motorola,cpcap-led-a=
dl"),
> > >      MFD_CELL_OF("cpcap-led", NULL, NULL, 0, 4, "motorola,cpcap-led-c=
p"),
> > >      MFD_CELL_NAME("cpcap-codec"),
> > > };
> > >
> > > static const struct mfd_cell cpcap_default_devices[] =3D {
> > >      MFD_CELL_OF("cpcap_adc", NULL, NULL, 0, 0, "motorola,cpcap-adc")=
,
> > >      MFD_CELL_OF("cpcap-regulator", NULL, NULL, 0, 0, "motorola,cpcap=
-regulator"),
> > >      MFD_CELL_OF("cpcap-usb-phy", NULL, NULL, 0, 0, "motorola,cpcap-u=
sb-phy"),
> > > };
> > >
> > > static const struct mfd_cell cpcap_mapphone_devices[] =3D {
> > >      MFD_CELL_OF("cpcap_adc", NULL, NULL, 0, 0, "motorola,mapphone-cp=
cap-adc"),
> > >      MFD_CELL_OF("cpcap-charger", NULL, NULL, 0, 0, "motorola,mapphon=
e-cpcap-charger"),
> > >      MFD_CELL_OF("cpcap-regulator", NULL, NULL, 0, 0, "motorola,mapph=
one-cpcap-regulator"),
> > >      MFD_CELL_OF("cpcap-usb-phy", NULL, NULL, 0, 0, "motorola,mapphon=
e-cpcap-usb-phy"),
> > > };
> > >
> > > This way, it's super easy to read / maintain the common and unique de=
vices.
> > >
> > > The only potential drawback would be 2 calls to mfd_add_devices() but
> > > that's common practice.
> > >
> > > Also notice that I droped the "_mfd" parts, which you should too.
> > >
> >
> > What if next added device does not have cpcap-battery, cpcap-led-adl,
> > cpcap-pwrbutton, uses external codec and would require cpcap-watchdog
> > which is not yet present. This will cause issues. Even Mot introduces
> > in the last patch of this patchset has slightly different composition.
>
> We usually just code-up what we have _today_.
>
> If new devices come in with different requirements, it takes 5 mins to re=
jig.
>

Ok, but I will take into account Mot commit when factoring out common.

> --
> Lee Jones
