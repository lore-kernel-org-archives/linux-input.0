Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7284078C2
	for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 07:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789975864; cv=pass; b=dqURxUuxWM6Qhcb99ugA8FglJFg6zs8qysFajPWcwXsiJgwzfR85vLtAmYoJ/g1VMg1vTMmUnU7JGvpQA8V+30kLyXixGiFNFk58W59f2rYtyTPU8/3UeX48K91pAkGucnXUr0mlOfZ82+BiuZZMkMvGynuvbJBf9warhrKJksg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789975864; c=relaxed/simple;
	bh=+kodcrZ7Rfq3RbtOm64zvOegmrBogr+8Wwr1ekULfyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZEZuM6Q11z+wjJ2+4McM+9vX7ipZnwUPQ6Xg8EbTZx2WUs3a0i9VLce9jyMfPL/OgLNsXp25D5ZRAhR3FiubLLOjhLqTm3s1V06hVc/yocU18CctVEiA3k9bShGs6/VgTM2fC0Gc+vKnhrnKq7eC7cBiBofEhkBYcsK+c3Kq/lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jD1gc/W/; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jD1gc/W/"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4bfd1so1775341a12.0
        for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 00:31:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789975862; cv=none;
        d=google.com; s=arc-20260327;
        b=VfBGr1Ei5azfR4zKST3VH0iNeA8k8PZGaImw1kWpexQWisCLcpmnltmDD64GqoAjxP
         fM/X5NJtsfS7fJ89prBVO88wF8IcvJZroGGLQ8uf88oHAJ8S9Csu6UgC0q11XY41b+97
         Mc1r6dFZJ3LrcOwsRCvgSWHc/tVll/jEKsbNvnIsVPk23F2mtvuLcnOoNEBov9wCZqRd
         EhGEsFHBCiEdxH2R49YHK98Bhs6dQj4nhrTPerUJRGAxCoEXknRn6LZDO2ZqaK08nZWO
         i+aB3a0Io8CfsYffKvfgl9sbjzINCrBS0vN4VfERa25c1WnDZqO/2ZLc44oxpCc3X7Jh
         01PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q1BZ6sJCmqeFIahqjVQKO9ObElEe/vXNKUx/QqdQ6iE=;
        fh=JtHyjYhOEQgdRJvrMCaErD+5j6DgeAT271J3AU5VlBg=;
        b=XSyfhTuVgX+C/c9e3vyU6NPHO75SwgCD/8GHJ2XpSHVOBCClG7SvIiAlRZ+KJFztrD
         019n3HrWzgd2SA+foPlkzsZ84qxEs0g8KxgZj0sEUU0ks1FWkl0LhTLd5RHkSxRtUgG/
         9ax8k7kYbg8j+2gOfZT7FDx2tBPxGd87DGxKU37tmf+YRiguJbryEmHFumNteOyR2VUb
         djdLvR2YpENkl7DN5B/MRnCIPfA4hu4+rajfwPIq4vGWeQlYkgi7aKF6XhPFIQhJdGe/
         /K+F2EfW8NlemMe0/YL1u/OEzmwlApZajx7QyZtDx42AOVKaD45gbwyVqA5GyfJ/0Qc3
         8Kvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789975862; x=1790580662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q1BZ6sJCmqeFIahqjVQKO9ObElEe/vXNKUx/QqdQ6iE=;
        b=jD1gc/W/eQYVqx+yirVe2qcyxe+donWRgWllTIa+7VE9+YQJpmeal1Rk0LOgaDcry3
         CuOI/JxJJI52Wsmu7eYoX1vkz5XJvFN+BfSEzY0Gn5YGMnZZ+WpXeMtv/PCNa3YpWlo8
         s9hlAknJ3Qs1c0R42qcLm2LyzNL24XghGRMB1PXSn54MvoQOde6Cud7hsfyOlSGdMN9n
         8FJXDNTZlmmR79EqWzI6FBGzPfCGDgiRg9UWmYQl9dgfe0NzixXKlHk5TC/12PLNK4zS
         RbqumxQSe17kO1x8LDxXCTnnBqvxMkz+ipuP2SCD7m6l6cbkmTgd4ow7pTU+7NgWu8UD
         wPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789975862; x=1790580662;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q1BZ6sJCmqeFIahqjVQKO9ObElEe/vXNKUx/QqdQ6iE=;
        b=13lVqOzP7VRtDLJIxazDvi0cY2jpG3YYpVZn/Ixhfg10DTISj54E9nyqYw0QtGoyfN
         Q9K2WeX3aEL18USafCFkdL3A6c30eZCcXIEhIRUtY+6oCRpRxg2mOg45iBPnDUD58xAE
         a1MVg3fn/G2iAV8OiVN2WsUwvjfezrKK66/z6ITinGgJ9Ub2R4r27mglKmzzMMCfoZIM
         ooqZB9xYv5ytaP/wXfxVeqz7pZ7yTcEXCnv03kYDuVBfXF45GNWr9zLOvkL3XnJmG0SB
         UXsXkgHVhkMyBq3L96WZfOvzLNkAtqRBvFYXhCyNMDLM7fRrZ0isau3UIy8Tq3Iyg9ff
         8TAw==
X-Forwarded-Encrypted: i=1; AKwUvBxrbdydifrtrSOYyQfcA8k1IEjyID35BwoPafaAdxFXjNwrdrnQJq6Z+wJQ6xmDdKEYvokYfpr6bAJrng==@vger.kernel.org
X-Gm-Message-State: AFuF++no+xdzFB62KW4XDjwXUvskAPySlKhIaipYCGgnkxXpranJfJzR
	ZWZIRoFTHfeEDog1Mc6WLtfaZV4V3eTVpFkjHaLxzc90eSV986w2sEVdPrvDgdeaoW0JB1+pwjM
	G/0rJlIHWC7qeMkXgLxwAhyBfAFK+jn4=
X-Gm-Gg: AYBFou1OIcxRTRwfpH3L67XUX6PJMKLpQsrC1X1I3a31k0HMUKqmLxdNfCrlOEWFgm/
	WlNxu7RCr7UBbqCGOuSyLdYVOtXtEjtpmTRVWLP4uDzPhL9VhnXLjyFtlIXIW5qfyOyaxMCUoK1
	ksNGMYK7RQLpbjKY+8eIgmahwbie3/3hK38vLJi8F9j8yQ/ef3/93uxXi8WCooOSO5FXJwyN14p
	kK1a6q5a55k2yccWdOY/6/+nYJarr/0/kwowu39Td4Qhp0gJILuIqxmyBiO2GEpfa45JIfQ1pFl
	aEnemWIEHeD3nX9cvoQI/FatR/Ih3wm/KvokhcOk7wB9ukFvCXY7TtLWnzPt6p8zxQdFB2EgfOU
	h+P506hpDMoZy
X-Received: by 2002:a05:6a21:6b05:b0:3da:c2f5:a2aa with SMTP id
 adf61e73a8af0-3dd8c3323a9mr17128224637.18.1789975862197; Mon, 21 Sep 2026
 00:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721095654.429346-1-clamor95@gmail.com> <20260721095654.429346-2-clamor95@gmail.com>
 <178463529533.2776661.17291216407355479584.robh@kernel.org>
 <20260909162654.GK2133376@google.com> <CAPVz0n2zLd2SPrHGb5vSX3AvRrofbA7Q54YFpmcPP6032MUw+Q@mail.gmail.com>
In-Reply-To: <CAPVz0n2zLd2SPrHGb5vSX3AvRrofbA7Q54YFpmcPP6032MUw+Q@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 21 Sep 2026 10:30:50 +0300
X-Gm-Features: AcwNN1Xwan51ardBlULGfF9_kTLOoiJJ0xUxr2pfFDkGmuB0AEVFXrA3aSj0HMQ
Message-ID: <CAPVz0n2o0OYFWsoXrYXcoAPNz2L4sKi2=JvXPdQzfvha1mOm_A@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] dt-bindings: leds: leds-cpcap: convert to DT schema
To: Lee Jones <lee@kernel.org>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Pavel Machek <pavel@kernel.org>, devicetree@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 9 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 19:50 Svyat=
oslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> =D1=81=D1=80, 9 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 19:27 Lee=
 Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Tue, 21 Jul 2026, Rob Herring (Arm) wrote:
> >
> > >
> > > On Tue, 21 Jul 2026 12:56:48 +0300, Svyatoslav Ryhel wrote:
> > > > Convert LEDs devicetree bindings for the Motorola CPCAP MFD from TX=
T to
> > > > YAML format. This patch does not change any functionality; the bind=
ings
> > > > remain the same.
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > > > ---
> > > >  .../devicetree/bindings/leds/leds-cpcap.txt   | 29 -------------
> > > >  .../bindings/leds/motorola,cpcap-leds.yaml    | 42 +++++++++++++++=
++++
> > > >  2 files changed, 42 insertions(+), 29 deletions(-)
> > > >  delete mode 100644 Documentation/devicetree/bindings/leds/leds-cpc=
ap.txt
> > > >  create mode 100644 Documentation/devicetree/bindings/leds/motorola=
,cpcap-leds.yaml
> > > >
> > >
> > > My bot found errors running 'make dt_binding_check' on your patch:
> > >
> > > yamllint warnings/errors:
> > >
> > > dtschema/dtc warnings/errors:
> > >
> > >
> > > doc reference errors (make refcheckdocs):
> > > Warning: Documentation/devicetree/bindings/leds/motorola,cpcap-leds.y=
aml references a file that doesn't exist: Documentation/devicetree/bindings=
/mfd/motorola,cpcap.yaml
> > > Warning: Documentation/devicetree/bindings/mfd/motorola-cpcap.txt ref=
erences a file that doesn't exist: Documentation/devicetree/bindings/leds/l=
eds-cpcap.txt
> > > Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml: Docu=
mentation/devicetree/bindings/mfd/motorola,cpcap.yaml
> > > Documentation/devicetree/bindings/mfd/motorola-cpcap.txt: Documentati=
on/devicetree/bindings/leds/leds-cpcap.txt
> > >
> > > See https://patchwork.kernel.org/project/devicetree/patch/20260721095=
654.429346-2-clamor95@gmail.com
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
> >
> > This one.
> >
>
> As you can see only complain is that reference in the leds yaml to
> Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml does not
> exist. All cpcap cell bindings were converted one by one as separate
> commits, so this is natural since motorola,cpcap.yaml will be
> converted last and patch doing this is included in the series. It does
> not bring any regressions in yaml and dt schema checks.
>

Hello Lee!

Is this explanation sufficient? Rob left his Reviewed-by to all DT
related patches of this series.

> > --
> > Lee Jones
