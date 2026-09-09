Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728A655C1A4
	for <linux-input@vger.kernel.org>; Wed,  9 Sep 2026 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973115; cv=pass; b=qa79BwOpyduwYzA8ehuxdOz2TUiJqCKLl+PTuEVLEpU62+/lU4GArDPRBePjS2qD0unpAs0aKKkH9aBUYWj8Hp83yWQ2Ck85Ezo7B2OIIrtEtVf4gXUpMD0YawFAxaC3x7H5d41TNKTJtmCbSB1n8F+e7iQM4W02q1xmaSyx4sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973115; c=relaxed/simple;
	bh=pX375j8sh6vF6kmJpBXuTbigJC1Pj462kQb14+L3SCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tW36uOwbMqfJRH204/oLPTqBvmSpTs5av0bOsgaPZDjTFCRhH/fNJCNGB44kY8MFUOxuBJ7iwhmV00LY/fCtP79P86ZgPt5o9yC7+YbXP0ID8cbk002imkrktfJ0UEjMzFtZzJoEdukWuGYyCuxJ3rh/M9VokHleSx64gVk1bpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPez6to0; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPez6to0"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a302c23fb2so3968941fa.2
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 09:58:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788973111; cv=none;
        d=google.com; s=arc-20260327;
        b=eOpunRF84/p0M8FOY6NtINge7IPbuol41lJC0FSc95+0flG5T5wvvB4nV3sh1xfXRR
         XHQLjmNiWn9epOvCNSJ51sdbh/r5tQqB19b8Gcu9T0GP/ZS+VXNZW2HkKREotNk1BLLD
         Ya+ZR1/78auLTsxJ7fcKoEdPshE88fPlR6BQDbrUSPhaB+VEYmhhYj6Jbc14Ge0jmS5u
         qdX0OpbALW71KCfa/LzajLDCgPHQlNtSTOaEFVVdye3WdXqRB+nBT4D9otP+JEXx68kg
         Xy6iO0SyJoWw4OqAffCCth9qTHEcIXpooitU+LHFoNCImDUV3eGxdAV0g4J7Q1/sVwB7
         fc1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gaSEqqQVvbHkTy3GU8KhCzhbcZLDrCGnsQ+LbvJQKCs=;
        fh=OqaoWer4Clf2GAzYGAxU4zboXTf2mVk9RDcKSPRr040=;
        b=Sdz2y6N1mfEU0V7yAoxE7LiWcFiWj6vC+alE8Vc3efaeqBNIX63sWjlpK0QZaAcUQV
         s4Xlv3xLVWoiUpP8wr7SnZJQ1NMM/MLQerxHmBgWYYDl/smvTSGd4l65CBh3esi31b5d
         YmdgeTEtD0DZU3pNUsdk4bN/NyOCpKtIXJ1WjRfDx38A0MhEfgLLrZ4SPmwO7DswXAG1
         vdRwwMM/tAqd+N42QakQI+vHOhGdluqFypRdGNoXzTdnUA67XbySoYopLQeEFaXvdrAq
         zTgo575e1LJ0UTxVOTiIMIMQ1KkPsQGneAp+Ax3V0FS3w3h4MP1R+1YJcIBoIvFGJs1T
         /quw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788973111; x=1789577911; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gaSEqqQVvbHkTy3GU8KhCzhbcZLDrCGnsQ+LbvJQKCs=;
        b=JPez6to0/upAxFvTeCcK5giXlbijmVzULQg4HuzSWKC0OahY6oZgvVVgnZLoq6DYVq
         08hWZ8AgX2KREhhygVY5PmDsL4kNj8zDT+asDDgmchDESsNAD4UywTpLD+u9EsaOUwwM
         yASxmSqOwYwJ66j/OtRdWCLYWnGMvM+/AQ398RFWomu4sqZKgjscIDcH6fqRkityoWSp
         cAv/BGyhrJF/QDQiX5CLfMMHAnFugj95j067CEpr0EWkLsCZqUeEFnJqs6KShTFCzfvU
         cHaI9nRi/VGvJIgxxoS44RrnZOmTJ/bQGAcMDc1HVA765Lp8fDApiqhl3QymCtw5eIU6
         boXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788973111; x=1789577911;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gaSEqqQVvbHkTy3GU8KhCzhbcZLDrCGnsQ+LbvJQKCs=;
        b=DBhQykl43m1QbGc4mOVlsVumXUYC2BGrbA5XAOqB1IqJi5ImhIGgBfTw76wZtfcn9P
         QygxEKmdjVhOcOos3z2YNrpmO1Pmhf3PHUr0Z3Wg4rd/f2hFR/IdIkmVHUjs1BYbsBXg
         /kNgIfaucPaUZx4sP8/r4LnSRhkiYFegWnnZ+xQf8IqTlINCKJNuMeNc+dAXjx/uQC54
         zUk3XIedT6mQiBwW2qqsS8UarwkZZuOjKEILeNP1LutYW2SJKfWjxNlErNM8+d4EGJMn
         XqKTFWzChbM30AwHjHAFKwPkHQ8leM8h3hPiZj9uW+USQch6K+nbvDed4WnSIc57YOHf
         iUHQ==
X-Forwarded-Encrypted: i=1; AKwUvByBHAs6/AI32P9wAXR4glkRGGy8yj9Pg5Atx1L5pGt9u3G7fWEqVRwUDyv3W0Hd6acvreDmRGv1AcpbPA==@vger.kernel.org
X-Gm-Message-State: AFuF++l8yLz+Ooe6Ap0yiF2bhmaLe7eFloTmDjQyZT0YUontdc/wcBDI
	CKHa0k8spsOprFimNgtzzstEieqs9et6O5Zx5vO1dgaQu5Ue5HHztlfCarSC422dr6+vCEnCcfX
	Co9JgY+F3XHIN2z45fPS4IPDDNIuYmFDQdiZ3QR0=
X-Gm-Gg: AYBFou3mN5kcJSdOaJ52DV7Zkpqp+/JBS0BibLFe9P9+burRM80Z9LvFjYtEeNwjT21
	snx9G0hnB3TFTVrEzPBZy8eGHw/C8gPCW5JwtUrq5ZzOqVE3fMvXsQOQqV2HBdDUTQMu7sPGLBY
	lpW/O5WJ+XPxtnAAHzeacdQThn2OBf7+/Fl+guSppz8C+kncVY2Q40wUrakrNDIUZ2PJGcKPyB8
	yv02jRNURCB/F1aYi64LJd2e/FRuQsc32nA4wMSCrXsOnNre1AJ2tBylD/94zdtCUtYr04CpYXC
	1jzR1DZ1FzZobpBcKD9wwE64ls1eqIynSb2VZ2yKnTBkmBZBslOFjoV0LSjIlret+8Sx/TV9TEp
	K/9H/s/3m5T0w
X-Received: by 2002:a17:907:da1:b0:c26:1648:a069 with SMTP id
 a640c23a62f3a-c2941b50c5emr98787066b.36.1788972621568; Wed, 09 Sep 2026
 09:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721095654.429346-1-clamor95@gmail.com> <20260721095654.429346-2-clamor95@gmail.com>
 <178463529533.2776661.17291216407355479584.robh@kernel.org> <20260909162654.GK2133376@google.com>
In-Reply-To: <20260909162654.GK2133376@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 9 Sep 2026 19:50:08 +0300
X-Gm-Features: AcwNN1XKwhxknUsv6HKXytCI9drSinxM2O3i8RIi3hHlsgo01tXMW3-PL-0Uk58
Message-ID: <CAPVz0n2zLd2SPrHGb5vSX3AvRrofbA7Q54YFpmcPP6032MUw+Q@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] dt-bindings: leds: leds-cpcap: convert to DT schema
To: Lee Jones <lee@kernel.org>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Pavel Machek <pavel@kernel.org>, devicetree@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 9 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 19:27 Lee J=
ones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, 21 Jul 2026, Rob Herring (Arm) wrote:
>
> >
> > On Tue, 21 Jul 2026 12:56:48 +0300, Svyatoslav Ryhel wrote:
> > > Convert LEDs devicetree bindings for the Motorola CPCAP MFD from TXT =
to
> > > YAML format. This patch does not change any functionality; the bindin=
gs
> > > remain the same.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > > ---
> > >  .../devicetree/bindings/leds/leds-cpcap.txt   | 29 -------------
> > >  .../bindings/leds/motorola,cpcap-leds.yaml    | 42 +++++++++++++++++=
++
> > >  2 files changed, 42 insertions(+), 29 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/leds/leds-cpcap=
.txt
> > >  create mode 100644 Documentation/devicetree/bindings/leds/motorola,c=
pcap-leds.yaml
> > >
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> >
> >
> > doc reference errors (make refcheckdocs):
> > Warning: Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yam=
l references a file that doesn't exist: Documentation/devicetree/bindings/m=
fd/motorola,cpcap.yaml
> > Warning: Documentation/devicetree/bindings/mfd/motorola-cpcap.txt refer=
ences a file that doesn't exist: Documentation/devicetree/bindings/leds/led=
s-cpcap.txt
> > Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml: Docume=
ntation/devicetree/bindings/mfd/motorola,cpcap.yaml
> > Documentation/devicetree/bindings/mfd/motorola-cpcap.txt: Documentation=
/devicetree/bindings/leds/leds-cpcap.txt
> >
> > See https://patchwork.kernel.org/project/devicetree/patch/2026072109565=
4.429346-2-clamor95@gmail.com
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
>
> This one.
>

As you can see only complain is that reference in the leds yaml to
Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml does not
exist. All cpcap cell bindings were converted one by one as separate
commits, so this is natural since motorola,cpcap.yaml will be
converted last and patch doing this is included in the series. It does
not bring any regressions in yaml and dt schema checks.

> --
> Lee Jones
