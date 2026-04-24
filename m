Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293853C4545
	for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777035536; cv=pass; b=Rf2HguzbZSosnSQujyo2ssDFrmc/jR8b41i4axBJL2QlgSAtOZAG36QIq3nx6sDyDTu9/2KAa8IRdY5V21jCBU2cH0pJ6VhHRtOnHWk9k33olHCO3vrDOvEXyx/QLVqQOtgx/XVjFwHR41NUgXzwYx2ND1SmqJvouliuPZoF5Kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777035536; c=relaxed/simple;
	bh=ChMklle/g4BHeag6UQCkoA0kKv0IAhf6rxUmuITbmqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KthaHRgX5C6x6smM/D2u/AqHqXEvJ8xcjjpmOjTr3+31ODJP1/fmfyKgUqH/Pxm6jXT3P6NTrklx8TgmTGjaOJL27elXrArNgo2SUBbiqLFEHc9bSjgZ61upcdQzLiiBaasC8/LAMHjis24Rb/HH4tOuDluGZ7sW3ce++D6D2QA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFyF8nEz; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFyF8nEz"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d572f7437so5160116f8f.1
        for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 05:58:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777035526; cv=none;
        d=google.com; s=arc-20240605;
        b=M/FbJpqLprBtvLVeRcxulAFusLuIGGcxTA5cHnfX4nuRRxso2yN2raY0SlyUx4wPJI
         ih3dzuBJ+uhR48pPQPIVAc4SIlsEVxAAWu0oQHVd/II8Mu+pvcFnvX4OmCAZVyNx00Aq
         Q4DCAxy0fna9pkxChoFYhyDjRr+33EA2k8BsVOgFR5/Zt7gqdncRcsAcEiClDwdqdlCM
         2td15Q4em08hr3u4eD1s02Te90scAWvLdrWsE0W9QPCmNPCRbXPn4LwIV4gXgfc9Y+YX
         T0XoFKGpNfW32tRkLNvJuOQf1WvhMwXpUjvDqP4QA7iZtUM1vmJIGgw3GgYgU9d7MdNT
         cgow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wFsKGWNGgInqejR3E/bOc4DWytiIehmTO4wKF2AyXZI=;
        fh=ns4ReZyZpmh7creiAzm5SnUuB7J+4F1+oHX13SUMEKA=;
        b=AumHJ2iT1uiIj4zJkGwF0+mQvN7uqUVwI6AxOD1MDrh/ONHxxKxYWcayQ0MP0RocJU
         p97WoTkl0AuxwCmHHZbBqw9aW+O+9YhGHi+Gv5fJyPxPrfA1x/EXkJCsxZ3G1NjxztQr
         VChkXORkosQzg3T/aHv8Ov2T89vAE+nIFGAuDG72qvoijWKwj72muKtZ2zxPsqV/kffh
         KHa4iL1vLgslnW5X5G6O+oCrHkwyPyuVvpIY+Tb/nDtJNr8algTiNatmF5/OhlYlHoFT
         rnxrJVWoxyQIf3+HDZKmN3EttAEjTKa+W5IRl+tRywJEq+ful7uuwdhRcpjTNaNnudAW
         NaiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777035526; x=1777640326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFsKGWNGgInqejR3E/bOc4DWytiIehmTO4wKF2AyXZI=;
        b=gFyF8nEzzJN/laq3H+355n9mb1550gG8CdafiGl8gzvzI8Li8mnXMHivpPxrcf9P/x
         WizW+CKJnkSU6R9KobQmnMcv0k/ujLM0a2wn5YQEGIlY25GrBJhrA3uiCRg8zjA1gkHz
         bkjM8DFtX9JarnOcr7PgE7oS9QUpM1a3UfjFtFkoaK0ZBjMCV/1TTOa2Zw3KrmAm6Wxo
         lVBJqwHofZmwtTT0YPWiA5/LTSVEKe1gmy60E1/zsnOuBo82AeCVXjezudKPqLUXB8Sh
         rO7l1oyZG4j3fxcOjY8XHmdqMnUMCjsymPR7HVQLG+6Ki8lR0pBKqNiiiD3B+5D/pqJF
         nPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777035526; x=1777640326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wFsKGWNGgInqejR3E/bOc4DWytiIehmTO4wKF2AyXZI=;
        b=NHm1xNiZmkXa+YL3azYvf4XxCarX8Gcth/gQ6MBGsVMpxmCGQgJvi0gj3S0yvdBZKM
         mOcAol6986Ib7cmlAJWR9Ro5YwG6HAplGgqEvFXjSWbJld1ccsR9eO7ITKq1OaHvHKWY
         Q3opeoJ7GoJ3EiclLb+Gxb5V5fSPZhARHJtzH/DaXvF4Z5raLbIrPz/W5mL5/+R7S3IZ
         VpMHFjj39Q5m8gWFKiEX0cs1k+X4SMWyjE3ynIvZXeI73/UBh4PLkNIpXIWbHhkO4nuf
         BrKsEbYHMa5uEdzff9fqFQltE8J7FKu3CGrlfiFRTWB94DMK7Mae88V1BwBab77mFqbS
         YwOg==
X-Forwarded-Encrypted: i=1; AFNElJ9eJ5iIH3MI5Mb08f9yNtxIwHexh3rOy59tU5tBDtQc900EJTqOhdNI7rxz0DCR2s4wZGauZYEo0xZvQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAd/VVq6vPGzaqcrf2s7zjbP103TJ+am0/gZib/KbgNglRjAE9
	/iHmjHunsYctgPRLC+oLmrUnv04i2W54OWLKwxIJILhB9w3/o/Pche36/K526EinzTWm/063HLc
	hrn387javz1i3/f2OtbEl3bf70dbQ5w8=
X-Gm-Gg: AeBDiet1mmABs22eqwXY/qgEVRsMzWWsaL5a133IBof940/TmA90sTp/1iNZv5pJRe0
	Vt5HPLmjthQKzqbcHS9AiRCok2I//Cffm3ozMU7dtaRCcF6OHiKYugobWbq9VtIEJBhLR9BLRiY
	ZioCASAzFJHIaQD7/9acEan0yQ/CctTnqmHNEWH+isYw84wwvM+otQRQOiwXoO7l3ztAvQoBcrn
	smbo4F6SA3/4lZ6sDIeuJNC8oCpH+a3JjSW9SALiWyewXjIo6PFAOLEeIDPUOqYLP7v1o67XXzp
	kjNCLasav5yFg1PfIMQ=
X-Received: by 2002:a05:6000:1886:b0:43d:7e11:1b72 with SMTP id
 ffacd0b85a97d-43fe3dbece0mr46576017f8f.9.1777035525465; Fri, 24 Apr 2026
 05:58:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424071305.89503-1-clamor95@gmail.com> <20260424071305.89503-2-clamor95@gmail.com>
 <177701943440.2848156.923810545023102522.robh@kernel.org> <CAPVz0n3Wxk=9YpmU0nXsOQdtxBhoTBv8283+OHhUr-TKxkAb5A@mail.gmail.com>
 <CAL_Jsq+dekx_vVFXxLb3oFQ7MM6xkPSSB7vyTV0YWh9BPLhEDw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+dekx_vVFXxLb3oFQ7MM6xkPSSB7vyTV0YWh9BPLhEDw@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 24 Apr 2026 15:58:34 +0300
X-Gm-Features: AQROBzAJjSjFj8WjNqd-oMltJq7zQMurtPb02KET3uiSv0VX_tvTiMnlwtA6iIc
Message-ID: <CAPVz0n1Pmq+fKFw5sPG7Gxjxs59jsA2s64ChnWt2SqkjGon2Aw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: input: Document Imagis ISA1200 haptic
 motor driver
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Linus Walleij <linusw@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 24 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 14:5=
5 Rob Herring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri, Apr 24, 2026 at 3:57=E2=80=AFAM Svyatoslav Ryhel <clamor95@gmail.=
com> wrote:
> >
> > =D0=BF=D1=82, 24 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=BE =
11:30 Rob Herring (Arm) <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > >
> > > On Fri, 24 Apr 2026 10:13:04 +0300, Svyatoslav Ryhel wrote:
> > > > Document the Imagis ISA1200 haptic motor driver, used primarily in =
mobile
> > > > handheld devices and capable of supporting up to two motors.
> > > >
> > > > The exact datasheet for the ISA1200 is not available; all data was =
modeled
> > > > based on available downstream kernel sources for various devices an=
d
> > > > fragments of information scattered across the internet.
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  .../bindings/input/imagis,isa1200.yaml        | 145 ++++++++++++++=
++++
> > > >  include/dt-bindings/input/isa1200.h           |  16 ++
> > > >  2 files changed, 161 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/input/imagis,=
isa1200.yaml
> > > >  create mode 100644 include/dt-bindings/input/isa1200.h
> > > >
> > >
> > > My bot found errors running 'make dt_binding_check' on your patch:
> > >
> > > yamllint warnings/errors:
> > >
> > > dtschema/dtc warnings/errors:
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindin=
gs/input/imagis,isa1200.example.dtb: haptic-engine@49 (imagis,isa1200): ena=
ble-gpios: [[4294967295, 22, 0], [4294967295, 23, 0]] is too long
> > >         from schema $id: http://devicetree.org/schemas/gpio/gpio-cons=
umer-common.yaml
> > >
> > > doc reference errors (make refcheckdocs):
> > >
> > > See https://patchwork.kernel.org/project/devicetree/patch/20260424071=
305.89503-2-clamor95@gmail.com
> > >
> > > The base for the series is generally the latest rc1. A different depe=
ndency
> > > should be noted in *this* patch.
> > >
> > > If you already ran 'make dt_binding_check' and didn't see the above
> > > error(s), then make sure 'yamllint' is installed and dt-schema is up =
to
> > > date:
> > >
> > > pip3 install dtschema --upgrade
> > >
> > > Please check and re-submit after running the above command yourself. =
Note
> > > that DT_SCHEMA_FILES can be set to your schema file to speed up check=
ing
> > > your schema. However, it must be unset to test all examples with your=
 schema.
> > >
> >
> > I am not sure what is going on here. I have installed dtschema-2026.4
> > which seems to be the latest. Running the check with this schema gives
> > a clean result, no errors produced.
> >
> >   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> >   CHKDT   ./Documentation/devicetree/bindings
> >   LINT    ./Documentation/devicetree/bindings
> >   DTEX    Documentation/devicetree/bindings/input/imagis,isa1200.exampl=
e.dts
> >   DTC [C] Documentation/devicetree/bindings/input/imagis,isa1200.exampl=
e.dtb
>
> Let me guess, you have DT_SCHEMA_FILES set? Then you are only
> validating against the schemas that match and not all of them. There's
> a single binding target now. See commit 400fbf4b5870 ("dt-bindings:
> kbuild: Support single binding targets"). Of course, changes in this
> schema could affect any other example, so you ultimately have to check
> everything with just 'make dt_binding_check'.
>

Thank you for explanation. That is unfortunate.

> The issue here is enable-gpios is defined as a standard property name
> with 1 GPIO. I don't think we want to extend that because with more
> than 1 you have to know what each signal is and the relationship
> between them which will vary.
>

Is it still possible to use enable-gpios for 2 gpios in local cases
(like this one) or I have to use some non-standard naming like
en-gpios or control-gpios etc.? This device has 2 pins called hen and
len, usually they are hooked to a single gpio, but that is not
universally true.

> Rob
