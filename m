Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF96635DA7F
	for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777021070; cv=pass; b=mW/za5Rlz7ZZK30VzWASszdlErtqDZbDZ1Fbzu4+PsLBKt9Hzh8Ar+zm/71kcM6tCKF83MOlet8CnvWBWbJEGNUHS1+gpGXdVlP3Lfc6JuiT553GB3G7zzdAZi+P/Oc356lJSW/bBFr0iJmY9KkpRPFS5/qF1Kih/jg+0uz7YZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777021070; c=relaxed/simple;
	bh=IfKvf93/fHy1rj1oZj9bcZtbnRQSWZ5z4Es12q0WTSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RwVVZvJGSbnqSGx4PkJZ4+Lu1Zu5qw+TcxSEAPBgijEiiaEAhBerUqfVKbVLvRooXa4NsLRJxVDK9HvjAbC0jS4ltfm6+1MeKdhesHQnkS0O/W/LNZD9DrQ5X4oBLKmkV2l0u6oDVsnFCWwkjBIWF7orwv3qMDDu5F5lxfYRB2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQj6qIkj; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQj6qIkj"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d7badbd7dso3751579f8f.2
        for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 01:57:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777021067; cv=none;
        d=google.com; s=arc-20240605;
        b=CSqBedZC5KhcKkDDlqKTlA0NkjXCTgsAj+BVTTUuGjUnwJIMNm5UedTp1s+FC8oic7
         twagpK5x5M8vXLLuPkDBFeOPaGxHWdWLZIKZofxIZa9MLRCRg9XX0+JHu+7EuntMg3Wr
         LaVrTRdpz3OaHj+6+brFkq+Joi7n7D6KJxGfwZ6oM9h37uKZHmJCgUwtuFJXScd76fHk
         nxzvMY7zbiK8vyqxVH89fmik8nxFEVh5ENsrAS0fzxYFQ2385fCYleiIpb9bH2GCKoRD
         x6VVsUrPoN0vaktdtXkxkYGf5HQs4/wCJzQLiaCqejCvyVbeX7hDS7kk/lU4QPi8wSJB
         qjcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9z4hswWE287FQxlOjCjfpY7MiH4HcJodItFz2a2PWxQ=;
        fh=IT/4e7ksjmjYqSoPew3gBnyFyqPvp1LloqCgsr3V7Jc=;
        b=F+eF88ixFeLv7GPQ4kwI0BUiAQiBt7w2b4QvTa7QCyO6cmG81TPmxRLDfbLHHgTE2y
         PM3YFXeSJrQfEkVLe3z2tMP/5E0kD1SXzRqCiJh4nYz4bXwMOgJeqRPXlnMIs3kVRKY6
         d+FWTtqav6/cTiZzvmUZORa5rH7/s65wBXPae/B+/RD9E6aarZqYkB381hYV9hdnAXDI
         IKFHN+vvhysTCbQSDryJ5vAt7Z7UOmECskhdoVzW6ZpXgBYoS/0orlXj9rhCtVqgmWA7
         gzZJ/HfwiTqqNqoiCiHpaJyoIF0vqPLQvPCc0I63thTgDjqprgPrLEXrFGI4s0tQ/DbG
         QLIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777021067; x=1777625867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9z4hswWE287FQxlOjCjfpY7MiH4HcJodItFz2a2PWxQ=;
        b=BQj6qIkjQe47mpx2I0zTSHuwW5rImrI9mLcugHhZK76giYbaLZpsIYTKZDDq6Di+Dy
         CeoaTCHXypzMeNpamD1Od9LYzZSjeQekz+n8QhZD/TfSO9BoBk4R3lp/fdw02i+vkqPs
         T3UDICxuFW61k1TKioYOlGTdKq8Tbj4PpWr0jLoyo6uCiT2aR2QmNHrcEkUA8hDMSPqR
         48j5OKf1Rzxo39+jFETuC9L2lT0FemW7/S+6Eyvl14SKSNSRW6a++27tmKTdNf8HxOcz
         +6MQzSsq1zVGmqfge7LQ2+lmQoxG3OcOw0vAjDvE/vjRB9f1VoqJSHpa8k12dSnNruoh
         AvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777021067; x=1777625867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9z4hswWE287FQxlOjCjfpY7MiH4HcJodItFz2a2PWxQ=;
        b=QkeHKZabtjrqBW/WZiFxWx8xSoyd6aP5JWJ/bqeu02UARvyMYos3Q/zHGk3Skk6TPB
         FItV302ExhkxgxC5n8lQtUl1LG7IWgaLeHO7m+zSsXDfbhj3mrZAmnsj4BZ4bWX7TOZ2
         VgIoaJY+aErjC7K+rj4XuEpLVDbczriSKWsLOH3RMGWvjokL+Q1x9Lq+9pU4Oaaag76F
         ZsDZMu8kH+9E3APHjZxRoUFtfZgxs5fRua4LqMCbHd86LRffRAgOo1S2oIoajNzuJcnW
         YcwLi5gZWgFI4OKLgz19GcExaCL5ykQ+dr4VTsYYPb1FNWQFyz58UW/5h70237/0/gj7
         2/GA==
X-Forwarded-Encrypted: i=1; AFNElJ9Q1UzjUUtYdWEi6RchrsSQXzr8ZbkxPL1l6Kvck2/79CimilsKYJsuWEGFPS09RDLltWGSCkTbwDB2/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwFqYmRt5KIuxSAhn29gMqvTaaCynW9bdg+KcnzM3aUAU2LGP+
	eBuAAMfoLDD93aPCFNepEmkcErFY9DbjKDCOgiGzHgEketGqGPpjiJNAVxpoI+dH11Z+Pjvzjtz
	nmRL2DunryoL8S6nZJhbD2yhmdS/IuL4=
X-Gm-Gg: AeBDietstKVxZvnU1INkH0UQQtJ+mPZXGMJ0DK52jQuErnSDihcX4ZhDkTp9E5v2cse
	YUEiKtI8oOB1oLlGvbt/8rkXDuilz5MmdH2PdMPaZxytt7OO2uVu0B3FfNiom12yHsgYDtbgemj
	rvTtgEgjt4yA05DwmC73S/9IOe3Kg8IVfy0S5isQGLnylRz3Vz63vCPq4zwSgTva4jiMEHw4+Kg
	5QaoS4CwPhbo/TWmOyZakdhx14kdNleu/2QSqMfpb70PhDnFOunelqg4u4vITeXAmhojyv2eOr4
	jykqJ8oD2xHftDtfUss=
X-Received: by 2002:a05:6000:22ca:b0:43d:6f0f:32fe with SMTP id
 ffacd0b85a97d-43fe3dfd65fmr45399717f8f.31.1777021066953; Fri, 24 Apr 2026
 01:57:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424071305.89503-1-clamor95@gmail.com> <20260424071305.89503-2-clamor95@gmail.com>
 <177701943440.2848156.923810545023102522.robh@kernel.org>
In-Reply-To: <177701943440.2848156.923810545023102522.robh@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 24 Apr 2026 11:57:35 +0300
X-Gm-Features: AQROBzDScWYaus6U9VV9QoT0Rdk9xjg-bMRUaI6ooRINx-Q4dXSeM0bN_-tH6O4
Message-ID: <CAPVz0n3Wxk=9YpmU0nXsOQdtxBhoTBv8283+OHhUr-TKxkAb5A@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: input: Document Imagis ISA1200 haptic
 motor driver
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Linus Walleij <linusw@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 24 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 11:3=
0 Rob Herring (Arm) <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
>
> On Fri, 24 Apr 2026 10:13:04 +0300, Svyatoslav Ryhel wrote:
> > Document the Imagis ISA1200 haptic motor driver, used primarily in mobi=
le
> > handheld devices and capable of supporting up to two motors.
> >
> > The exact datasheet for the ISA1200 is not available; all data was mode=
led
> > based on available downstream kernel sources for various devices and
> > fragments of information scattered across the internet.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../bindings/input/imagis,isa1200.yaml        | 145 ++++++++++++++++++
> >  include/dt-bindings/input/isa1200.h           |  16 ++
> >  2 files changed, 161 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/imagis,isa1=
200.yaml
> >  create mode 100644 include/dt-bindings/input/isa1200.h
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i=
nput/imagis,isa1200.example.dtb: haptic-engine@49 (imagis,isa1200): enable-=
gpios: [[4294967295, 22, 0], [4294967295, 23, 0]] is too long
>         from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer=
-common.yaml
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.kernel.org/project/devicetree/patch/20260424071305.=
89503-2-clamor95@gmail.com
>
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.
>

I am not sure what is going on here. I have installed dtschema-2026.4
which seems to be the latest. Running the check with this schema gives
a clean result, no errors produced.

  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  CHKDT   ./Documentation/devicetree/bindings
  LINT    ./Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/input/imagis,isa1200.example.dt=
s
  DTC [C] Documentation/devicetree/bindings/input/imagis,isa1200.example.dt=
b
