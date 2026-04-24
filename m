Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6B43DC4D9
	for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777042685; cv=none; b=Zw012lLCBZz1sg7irwF96XhWw4kQfKaGJ9U+D+8di9XrK4E0CTD9vz3w+vuQMxKvtArMLSbY238rNyDKY+HtXHLM+eePHuzAfPtwk198/v2vk4Rwu3rk37hZ3Vuocp6KB2N1EN4UmJENlr8ut5/1lSC5Qz+eRgVRFHEftvTzXSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777042685; c=relaxed/simple;
	bh=Ms9FdgAlE34xA8czjY+eX1UHbeoCAsMnS9+UL958FeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jlJbR6zbn0mGImT2gE5UwAe7K0DkBKtVdMSJnWA3Arm+Kk/szTuojR9wknVEOh8ueK5FmthpoOH+cBWT44ivdUceLdKyWRJ0Clw5LRdYs5/kv+2P7nDISWfN6vHOBGZUoao7lvV2xxg8YPVU34OEeH+e6XDFc46kN3XOlFj5kRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXq8qjvs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXq8qjvs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6439BC2BCB7
	for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 14:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777042685;
	bh=Ms9FdgAlE34xA8czjY+eX1UHbeoCAsMnS9+UL958FeM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eXq8qjvsdXNoFW5bb8hhJGcrsl4Mft0odoWVT1Qi+lTZg6MAV6MGvUYQvkH0hubhd
	 izzu03atf4BsGZM68JnGh9YUvJb1SpqkVOPsvPNX17/GG8tSxza6RX1GWOQVPbp1PF
	 twN8uU6QGker5G1W/n5RqOAYzgFz/7Pd/LFcVNCpGfg8NvmY4XDdssSCGhcD8JtdCu
	 /XJhGrzf4k9it73zBLOk2R1Pd2wdWHCA3tJpGgYSh9BrVw6g+UsDAxIEb13YXE9EXB
	 +dOgbONDqlHy1AKSQs/0BUJZwzpBroVpiGOv6wswXlZnJ+H/mKor1w/IOtgNhqtZD/
	 doCpAcI/QMW5w==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-676fec7e946so4631098a12.3
        for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 07:58:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ80SA2Yr2e8mDk+74BL/nW1tXfs5WrBB+8KrsMec9RyJNpl52hExBqzxMDqQ83WKAHg74TxzsKwGMB9Bw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYqauz0bQxxkvGdJdIwZ7gOkbSqtYMvnZ2Dj2a3/q0Xx0hTQIM
	UvlQHTPm5ojdlE/KNOgJMVg6Bw2MsKDHrZD0M0PJTte7BA1Tpmes64rkMYDF2oGgWTTtt2s+Qcy
	Q278rQN+1mTHWzBvr7Lauev5RLoO1Ow==
X-Received: by 2002:a05:6402:3253:b0:677:75e5:a1b3 with SMTP id
 4fb4d7f45d1cf-67775e5a23amr3137351a12.18.1777042683918; Fri, 24 Apr 2026
 07:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424071305.89503-1-clamor95@gmail.com> <20260424071305.89503-2-clamor95@gmail.com>
 <177701943440.2848156.923810545023102522.robh@kernel.org> <CAPVz0n3Wxk=9YpmU0nXsOQdtxBhoTBv8283+OHhUr-TKxkAb5A@mail.gmail.com>
 <CAL_Jsq+dekx_vVFXxLb3oFQ7MM6xkPSSB7vyTV0YWh9BPLhEDw@mail.gmail.com> <CAPVz0n1Pmq+fKFw5sPG7Gxjxs59jsA2s64ChnWt2SqkjGon2Aw@mail.gmail.com>
In-Reply-To: <CAPVz0n1Pmq+fKFw5sPG7Gxjxs59jsA2s64ChnWt2SqkjGon2Aw@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 24 Apr 2026 09:57:52 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKxCdeXDEMirnsBPUnV=3KPFaEeK=PJ+T1_izw5+YsfUQ@mail.gmail.com>
X-Gm-Features: AQROBzBi-u5TM--vgzIkPK90uWfOP1H6dsTmNLqr7LotD_4zY8PG8AIFnoxM2a0
Message-ID: <CAL_JsqKxCdeXDEMirnsBPUnV=3KPFaEeK=PJ+T1_izw5+YsfUQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: input: Document Imagis ISA1200 haptic
 motor driver
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Linus Walleij <linusw@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 7:58=E2=80=AFAM Svyatoslav Ryhel <clamor95@gmail.co=
m> wrote:
>
> =D0=BF=D1=82, 24 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 14=
:55 Rob Herring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Fri, Apr 24, 2026 at 3:57=E2=80=AFAM Svyatoslav Ryhel <clamor95@gmai=
l.com> wrote:
> > >
> > > =D0=BF=D1=82, 24 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=
=BE 11:30 Rob Herring (Arm) <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > > >
> > > >
> > > > On Fri, 24 Apr 2026 10:13:04 +0300, Svyatoslav Ryhel wrote:
> > > > > Document the Imagis ISA1200 haptic motor driver, used primarily i=
n mobile
> > > > > handheld devices and capable of supporting up to two motors.
> > > > >
> > > > > The exact datasheet for the ISA1200 is not available; all data wa=
s modeled
> > > > > based on available downstream kernel sources for various devices =
and
> > > > > fragments of information scattered across the internet.
> > > > >
> > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > ---
> > > > >  .../bindings/input/imagis,isa1200.yaml        | 145 ++++++++++++=
++++++
> > > > >  include/dt-bindings/input/isa1200.h           |  16 ++
> > > > >  2 files changed, 161 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/input/imagi=
s,isa1200.yaml
> > > > >  create mode 100644 include/dt-bindings/input/isa1200.h
> > > > >
> > > >
> > > > My bot found errors running 'make dt_binding_check' on your patch:
> > > >
> > > > yamllint warnings/errors:
> > > >
> > > > dtschema/dtc warnings/errors:
> > > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bind=
ings/input/imagis,isa1200.example.dtb: haptic-engine@49 (imagis,isa1200): e=
nable-gpios: [[4294967295, 22, 0], [4294967295, 23, 0]] is too long
> > > >         from schema $id: http://devicetree.org/schemas/gpio/gpio-co=
nsumer-common.yaml
> > > >
> > > > doc reference errors (make refcheckdocs):
> > > >
> > > > See https://patchwork.kernel.org/project/devicetree/patch/202604240=
71305.89503-2-clamor95@gmail.com
> > > >
> > > > The base for the series is generally the latest rc1. A different de=
pendency
> > > > should be noted in *this* patch.
> > > >
> > > > If you already ran 'make dt_binding_check' and didn't see the above
> > > > error(s), then make sure 'yamllint' is installed and dt-schema is u=
p to
> > > > date:
> > > >
> > > > pip3 install dtschema --upgrade
> > > >
> > > > Please check and re-submit after running the above command yourself=
. Note
> > > > that DT_SCHEMA_FILES can be set to your schema file to speed up che=
cking
> > > > your schema. However, it must be unset to test all examples with yo=
ur schema.
> > > >
> > >
> > > I am not sure what is going on here. I have installed dtschema-2026.4
> > > which seems to be the latest. Running the check with this schema give=
s
> > > a clean result, no errors produced.
> > >
> > >   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> > >   CHKDT   ./Documentation/devicetree/bindings
> > >   LINT    ./Documentation/devicetree/bindings
> > >   DTEX    Documentation/devicetree/bindings/input/imagis,isa1200.exam=
ple.dts
> > >   DTC [C] Documentation/devicetree/bindings/input/imagis,isa1200.exam=
ple.dtb
> >
> > Let me guess, you have DT_SCHEMA_FILES set? Then you are only
> > validating against the schemas that match and not all of them. There's
> > a single binding target now. See commit 400fbf4b5870 ("dt-bindings:
> > kbuild: Support single binding targets"). Of course, changes in this
> > schema could affect any other example, so you ultimately have to check
> > everything with just 'make dt_binding_check'.
> >
>
> Thank you for explanation. That is unfortunate.
>
> > The issue here is enable-gpios is defined as a standard property name
> > with 1 GPIO. I don't think we want to extend that because with more
> > than 1 you have to know what each signal is and the relationship
> > between them which will vary.
> >
>
> Is it still possible to use enable-gpios for 2 gpios in local cases
> (like this one) or I have to use some non-standard naming like
> en-gpios or control-gpios etc.? This device has 2 pins called hen and
> len, usually they are hooked to a single gpio, but that is not
> universally true.

Just do hen-gpios and len-gpios.

Rob
