Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C6A3BF685
	for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 11:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777031741; cv=none; b=gqUGs4NIoxarxsN8uyV6iCNvhJkZWekJ7ylRP7gdCknKPmRXbIOPbVjDAVl/9F5FXG49IBQirpDov/w3RSVjbMg8jVTkZTZy3vNkg1Dv452dtv5BouO08vwyn15CYcnE9uSNCoTsHoPwGX0/1ZPWDInpOXHpJPVUkYQWGwoACCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777031741; c=relaxed/simple;
	bh=toMsnNJX6E5PIJUeiQm+YCKjCZSuaUlKKE63jlxSXqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=izisiSn+lbpj1Xwbg22K0BA/lxMM1OOuDoLz5lAR6ELW55i5XXtQjHdiwZAEoWPueAV6/3TTC05GZCPCuS8eCZxmp7XTE/qkof/EQUDdwy+yblWADLZ79zYpiSXfpjQpJBeRx2/I2r/xcNme4TAl7F9UvJmIPodd6IKxAe57J4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEIo9iW7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEIo9iW7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3B2C2BCB5
	for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 11:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777031740;
	bh=toMsnNJX6E5PIJUeiQm+YCKjCZSuaUlKKE63jlxSXqw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rEIo9iW7GOlNdMXY92+kZYZqaLzlB5hmT4f9tn67stmlVFwpzH8dJHhqjO3UKAkaB
	 fhGv5hk9JbPzR5MrCmu8f1O2zbgjoTv1p8I5tLkhzg0QUvPzfHmeqWSj56jTRnji3v
	 7uI9/HuruBSYjlMnhjJglXGmYdbMU0A7+Eqz/E/rWo1SJm5hbo/nhQaPAgVXlDZ43C
	 2a/PWzW1KG/DcY211Xn3+4Qzhvvgo24ojKvxOGP8EVAgDKYhbHmy0pQcyJrHO4L/Bg
	 r9SEJot7oMbed28PMEdZMSA65XNbjgNWFJmkn2HHaZZWmqxrkC/R0VO0KNxHIrzgmJ
	 sczrQeLcUhIcw==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-676e62faf2bso5683472a12.1
        for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 04:55:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+r57RehtNn+meXkR4eBxetbvxu1NC+6Ej61suEmwJnWn/CrU6USqgYZwDUjBjjDW2ywoIEZvotu+t5AA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmzw4eurF6CBqhzq0QCuEzGn18oNXpSo0bgwQkCuUD6gsB3jqh
	mNp/UinrBMfGnhSHhoYlTtMTw5hv+j/95GsBS1nB839m02/M6y3iNw+GEPQ1ue1Pqa9REBYRj/b
	IksjvWFUepl3wft5YGtXJMoDquR1BHg==
X-Received: by 2002:a05:6402:46cf:b0:673:1d30:29b4 with SMTP id
 4fb4d7f45d1cf-6731d302a0emr11422216a12.23.1777031739555; Fri, 24 Apr 2026
 04:55:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424071305.89503-1-clamor95@gmail.com> <20260424071305.89503-2-clamor95@gmail.com>
 <177701943440.2848156.923810545023102522.robh@kernel.org> <CAPVz0n3Wxk=9YpmU0nXsOQdtxBhoTBv8283+OHhUr-TKxkAb5A@mail.gmail.com>
In-Reply-To: <CAPVz0n3Wxk=9YpmU0nXsOQdtxBhoTBv8283+OHhUr-TKxkAb5A@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 24 Apr 2026 06:55:27 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+dekx_vVFXxLb3oFQ7MM6xkPSSB7vyTV0YWh9BPLhEDw@mail.gmail.com>
X-Gm-Features: AQROBzCB2LQouwLR1SfLFurtF5sQbqRsaQtswRmzBFCyA6eJeH_sC7mjhXJr1Y8
Message-ID: <CAL_Jsq+dekx_vVFXxLb3oFQ7MM6xkPSSB7vyTV0YWh9BPLhEDw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: input: Document Imagis ISA1200 haptic
 motor driver
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Linus Walleij <linusw@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 3:57=E2=80=AFAM Svyatoslav Ryhel <clamor95@gmail.co=
m> wrote:
>
> =D0=BF=D1=82, 24 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 11=
:30 Rob Herring (Arm) <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> >
> > On Fri, 24 Apr 2026 10:13:04 +0300, Svyatoslav Ryhel wrote:
> > > Document the Imagis ISA1200 haptic motor driver, used primarily in mo=
bile
> > > handheld devices and capable of supporting up to two motors.
> > >
> > > The exact datasheet for the ISA1200 is not available; all data was mo=
deled
> > > based on available downstream kernel sources for various devices and
> > > fragments of information scattered across the internet.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  .../bindings/input/imagis,isa1200.yaml        | 145 ++++++++++++++++=
++
> > >  include/dt-bindings/input/isa1200.h           |  16 ++
> > >  2 files changed, 161 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/input/imagis,is=
a1200.yaml
> > >  create mode 100644 include/dt-bindings/input/isa1200.h
> > >
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings=
/input/imagis,isa1200.example.dtb: haptic-engine@49 (imagis,isa1200): enabl=
e-gpios: [[4294967295, 22, 0], [4294967295, 23, 0]] is too long
> >         from schema $id: http://devicetree.org/schemas/gpio/gpio-consum=
er-common.yaml
> >
> > doc reference errors (make refcheckdocs):
> >
> > See https://patchwork.kernel.org/project/devicetree/patch/2026042407130=
5.89503-2-clamor95@gmail.com
> >
> > The base for the series is generally the latest rc1. A different depend=
ency
> > should be noted in *this* patch.
> >
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> >
> > pip3 install dtschema --upgrade
> >
> > Please check and re-submit after running the above command yourself. No=
te
> > that DT_SCHEMA_FILES can be set to your schema file to speed up checkin=
g
> > your schema. However, it must be unset to test all examples with your s=
chema.
> >
>
> I am not sure what is going on here. I have installed dtschema-2026.4
> which seems to be the latest. Running the check with this schema gives
> a clean result, no errors produced.
>
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   CHKDT   ./Documentation/devicetree/bindings
>   LINT    ./Documentation/devicetree/bindings
>   DTEX    Documentation/devicetree/bindings/input/imagis,isa1200.example.=
dts
>   DTC [C] Documentation/devicetree/bindings/input/imagis,isa1200.example.=
dtb

Let me guess, you have DT_SCHEMA_FILES set? Then you are only
validating against the schemas that match and not all of them. There's
a single binding target now. See commit 400fbf4b5870 ("dt-bindings:
kbuild: Support single binding targets"). Of course, changes in this
schema could affect any other example, so you ultimately have to check
everything with just 'make dt_binding_check'.

The issue here is enable-gpios is defined as a standard property name
with 1 GPIO. I don't think we want to extend that because with more
than 1 you have to know what each signal is and the relationship
between them which will vary.

Rob
