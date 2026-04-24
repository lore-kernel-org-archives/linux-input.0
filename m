Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5D03DE45A
	for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777047100; cv=pass; b=tWeMX/6hkJvjdJeDtYWvWNrP9n+dfqly4Z8Nr2k/+Bt6IhOywdmRN/Vwc9Qe9/Yiruw6Ev1Rktgz0IQVj1kQeGO7Vkz0s6QWn2ltoecXwb0ySy0W3bzV0fYDCNwY3oNkMF43nXrawgOLp1Uq5zup0s1VNVs96L6UCld6Oo1S2VA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777047100; c=relaxed/simple;
	bh=XT58P0GNuT/agefMa/eIUPVlfhr8TDxtzlVjKt4js8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4oVPNb8FRSiBuuTCxGK6b3pzTwyxrXJw9NvGfQ3YXEtolJqnHRN++GHWclQ/itEqAQGtegVEKWYwIl57QHTDZJWfG545nDillZyl4Tgest/4FVxJEF3UdlXBrTY68HkFR8tmaAqxv35M0xP0hiFjuLMPzV9RhLbqpAsyrGaztM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aY6Nr3ej; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aY6Nr3ej"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so4987593f8f.3
        for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 09:11:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777047097; cv=none;
        d=google.com; s=arc-20240605;
        b=Krkg3faeiQv1T/3anpO/yjcHv2gITUourGa95MgS5tAEhGCi8gvHSe++38bRnDTdMp
         khLWV0f+P6zPT/auTNpGaKt3XtVLsf033OCOROnFcsDpQoEEBtCxWJeyoiHNaiMKpcnu
         5E+pwYmmiip9qsOzjP/ANzUpDm4v1DwbDqVbKriJvJXIwhBvzVCcisUrMWsnrGPSdeQy
         Gye2vRIj4zc6mzXm1QXj9d5nuatfozb/50AFVRCh8YnogGA1ZKv5qSM0sqrOaDsrpRm+
         +96F9sMUvoPyMXvKHPlwmFs4HSO2GR0XxsS8BTJep/dvpeVPpXA/qttL296xI3vOLaMO
         RDNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rHYuykEff/wrBFy5/qVUAiD99gisngBNcaqJxtGizX4=;
        fh=5KEfsZSgyAqk3zRrFURFErjSpFqPj0ga1yNiy/431NY=;
        b=dDNYQXSNr+79vQxUIwM/9rwxfHdkznyFt9yFMHlYVqxdhzbO7R8KRGPMd4Y0LeUbiS
         7Rqry4fp1Ua58Zi3tg11/pt6ltIGXgv0UHUaQ8MrFqAhtvgtk6Rvu2BFB3faIYqAI9KB
         ieihH8sgMvd1NjKfProXhXNr2yp7IlRqL2nMOBdYD6dNmPkfQYhb98o2Z/jcEQvrQ4wH
         y9v8YhhyvQ/0SsHudq7j7GyAgsJbLitNPUxwNtbJHpTzPID3Dq2Qpw8pqrSv+ic8IduE
         M32wH/8uGr6G1ZVnaTfmEM5hO4nKjF0bvzFP/CztZCFlwn5V6JQZDPJL+uUCz+wWsb+P
         qxhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777047097; x=1777651897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHYuykEff/wrBFy5/qVUAiD99gisngBNcaqJxtGizX4=;
        b=aY6Nr3ejFiSBvMFzL+UAqjHEXqxG3OFxHiIjVY9VlmJglU7TNJ6wmces2zXVcEFJgW
         C5z06bvoRBYeAkfVYEuIaz4lQ65No1O4vhoDudlRkBQbWhOQ9JM6ZSZrUT1MxHZV3+SC
         HVia/uSUe0zOTQV+rzOuXe+QrVNlDCf7blRc4BZ1XOVL0dB/Co0BINo7s/6XgdgmWE0V
         UaaQmH1IEZSrfLbjIfxmHzjbRNdIEqimPmpO9NXGMkSSmUfKdLicN1x6tKS2xJ51RwGs
         qZtXrlDrNehs4cea8CXmTSX2Zjo38iLBvL1sHZrRiWph686QZdv1emD4juDl+2s4Gyh4
         OpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777047097; x=1777651897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rHYuykEff/wrBFy5/qVUAiD99gisngBNcaqJxtGizX4=;
        b=X3f+5D+jdzNctH27fOTNCMsBm+8lxpxPnBWD1oKp3BxJWERWXry1Rs9IGHVk2ygtkd
         5C+3Oab7aM9sW/EzikEwNb7WLTAApWzBwesZw3tO8zU+kOJs9o4fSZo9OIk1kGnsbbW8
         jkGT6JKVksU3PHD3Kd29jG/+MadwNZCahV9pFz8PfPgG5PFStdk896+3reWjLxDUPhhh
         DVcbl89OMexzNCpfXBFdzVvqRJQvwt1Tcjy3p/d2WNlW5quCDmarN2HkbKEiJQYZFxZ6
         kottK/9+7g4N4fFdoUaJx3yLZFq9RCo/sHn1n6Wv4zUZ4COkEY5o2qE4HHXA8TIm+lJy
         KI/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/W2/DEWGCtCW02xBRMuOp8mzijkazzlwJQYlp9inf7T5jvospZwuJF2KeZqxCh2cvV7XiCrUKURCvolg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzNS6cUd4GWVUXRpY2KR0ib9BQQU7O2elJVgzL/lV9SHktds+Z
	/j+dcWqk0JEOdAZxjxrJBTmUsQLuWhOrI6jgdGdnRojFjnN7SxTpm0DG4n4XXUyggCVDw1J6m9f
	b0SGUPsqqMpuW5hjgo6tp5tEFqcflqLM=
X-Gm-Gg: AeBDiesfy7HQ1UaK4P5kcP4aTEmsoNN5hwBtADEql+/RF+TjFZU4ziFi124uasHUXqK
	RLJFIdGm+2Y5Uj4dzOW3041sx7tD+BEtH3bGNBQ4JpPjJH55qGYyXrff7oEgQduZCjw9sRbPnAE
	zjKPGivukuXqcSTatm5kj0yxsExlLSthykwyH124yDERQoPwzFTeIwSPA0PHs2He07RAq7qb/cL
	ZKCbRoKh8Sfa4w7NWAB/hmj1qLjVf/6ESvqYzvbWBJgZcJlUZXgHmyn55Vlkvue1EQ6PV2NCZMn
	4/HzjRoqrbfN8/otcKE=
X-Received: by 2002:a05:6000:258a:b0:441:2381:b630 with SMTP id
 ffacd0b85a97d-4412381b6dfmr22787166f8f.24.1777047097235; Fri, 24 Apr 2026
 09:11:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424071305.89503-1-clamor95@gmail.com> <20260424071305.89503-2-clamor95@gmail.com>
 <177701943440.2848156.923810545023102522.robh@kernel.org> <CAPVz0n3Wxk=9YpmU0nXsOQdtxBhoTBv8283+OHhUr-TKxkAb5A@mail.gmail.com>
 <CAL_Jsq+dekx_vVFXxLb3oFQ7MM6xkPSSB7vyTV0YWh9BPLhEDw@mail.gmail.com>
 <CAPVz0n1Pmq+fKFw5sPG7Gxjxs59jsA2s64ChnWt2SqkjGon2Aw@mail.gmail.com> <CAL_JsqKxCdeXDEMirnsBPUnV=3KPFaEeK=PJ+T1_izw5+YsfUQ@mail.gmail.com>
In-Reply-To: <CAL_JsqKxCdeXDEMirnsBPUnV=3KPFaEeK=PJ+T1_izw5+YsfUQ@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 24 Apr 2026 19:11:25 +0300
X-Gm-Features: AQROBzB8M5T82W_SzNVUW1u76oB-t0u0G0IStj3xeIZcNs1Rh5H_C49Sb_96yQw
Message-ID: <CAPVz0n0jFyEwJe_VLY2b3_x1pzx2OzLL7C6PuBzDn8jvD+_pTw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: input: Document Imagis ISA1200 haptic
 motor driver
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Linus Walleij <linusw@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 24 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 17:5=
8 Rob Herring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri, Apr 24, 2026 at 7:58=E2=80=AFAM Svyatoslav Ryhel <clamor95@gmail.=
com> wrote:
> >
> > =D0=BF=D1=82, 24 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=BE =
14:55 Rob Herring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Fri, Apr 24, 2026 at 3:57=E2=80=AFAM Svyatoslav Ryhel <clamor95@gm=
ail.com> wrote:
> > > >
> > > > =D0=BF=D1=82, 24 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=
=BE 11:30 Rob Herring (Arm) <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > >
> > > > >
> > > > > On Fri, 24 Apr 2026 10:13:04 +0300, Svyatoslav Ryhel wrote:
> > > > > > Document the Imagis ISA1200 haptic motor driver, used primarily=
 in mobile
> > > > > > handheld devices and capable of supporting up to two motors.
> > > > > >
> > > > > > The exact datasheet for the ISA1200 is not available; all data =
was modeled
> > > > > > based on available downstream kernel sources for various device=
s and
> > > > > > fragments of information scattered across the internet.
> > > > > >
> > > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > > ---
> > > > > >  .../bindings/input/imagis,isa1200.yaml        | 145 ++++++++++=
++++++++
> > > > > >  include/dt-bindings/input/isa1200.h           |  16 ++
> > > > > >  2 files changed, 161 insertions(+)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/input/ima=
gis,isa1200.yaml
> > > > > >  create mode 100644 include/dt-bindings/input/isa1200.h
> > > > > >
> > > > >
> > > > > My bot found errors running 'make dt_binding_check' on your patch=
:
> > > > >
> > > > > yamllint warnings/errors:
> > > > >
> > > > > dtschema/dtc warnings/errors:
> > > > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bi=
ndings/input/imagis,isa1200.example.dtb: haptic-engine@49 (imagis,isa1200):=
 enable-gpios: [[4294967295, 22, 0], [4294967295, 23, 0]] is too long
> > > > >         from schema $id: http://devicetree.org/schemas/gpio/gpio-=
consumer-common.yaml
> > > > >
> > > > > doc reference errors (make refcheckdocs):
> > > > >
> > > > > See https://patchwork.kernel.org/project/devicetree/patch/2026042=
4071305.89503-2-clamor95@gmail.com
> > > > >
> > > > > The base for the series is generally the latest rc1. A different =
dependency
> > > > > should be noted in *this* patch.
> > > > >
> > > > > If you already ran 'make dt_binding_check' and didn't see the abo=
ve
> > > > > error(s), then make sure 'yamllint' is installed and dt-schema is=
 up to
> > > > > date:
> > > > >
> > > > > pip3 install dtschema --upgrade
> > > > >
> > > > > Please check and re-submit after running the above command yourse=
lf. Note
> > > > > that DT_SCHEMA_FILES can be set to your schema file to speed up c=
hecking
> > > > > your schema. However, it must be unset to test all examples with =
your schema.
> > > > >
> > > >
> > > > I am not sure what is going on here. I have installed dtschema-2026=
.4
> > > > which seems to be the latest. Running the check with this schema gi=
ves
> > > > a clean result, no errors produced.
> > > >
> > > >   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> > > >   CHKDT   ./Documentation/devicetree/bindings
> > > >   LINT    ./Documentation/devicetree/bindings
> > > >   DTEX    Documentation/devicetree/bindings/input/imagis,isa1200.ex=
ample.dts
> > > >   DTC [C] Documentation/devicetree/bindings/input/imagis,isa1200.ex=
ample.dtb
> > >
> > > Let me guess, you have DT_SCHEMA_FILES set? Then you are only
> > > validating against the schemas that match and not all of them. There'=
s
> > > a single binding target now. See commit 400fbf4b5870 ("dt-bindings:
> > > kbuild: Support single binding targets"). Of course, changes in this
> > > schema could affect any other example, so you ultimately have to chec=
k
> > > everything with just 'make dt_binding_check'.
> > >
> >
> > Thank you for explanation. That is unfortunate.
> >
> > > The issue here is enable-gpios is defined as a standard property name
> > > with 1 GPIO. I don't think we want to extend that because with more
> > > than 1 you have to know what each signal is and the relationship
> > > between them which will vary.
> > >
> >
> > Is it still possible to use enable-gpios for 2 gpios in local cases
> > (like this one) or I have to use some non-standard naming like
> > en-gpios or control-gpios etc.? This device has 2 pins called hen and
> > len, usually they are hooked to a single gpio, but that is not
> > universally true.
>
> Just do hen-gpios and len-gpios.
>

That would require reworking all gpio handling. Would you mind if I
use control-gpios? It is not standard and does not cause that
complain.

Additionally, is it acceptable to use header defines in imagis,clk-div
or should it use direct values instead. Thank you.

> Rob
