Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26E839EF30
	for <linux-input@vger.kernel.org>; Thu, 30 Apr 2026 09:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777540582; cv=none; b=iLMIdz5sKYSTRVepPJppKBXrosvVPzR6XOwz0Q5UmvQzDgbsgpKRsbeHbGMDHEXca7qHO9rNqPcQstFMDSGokBr3nb1LoHvToRRaqLr5HOOsICfKAWXpym62ZHGj/O1DpI4ZvJgUw7Oit2/4ILSjRv4YvhTfRaJaONl1VVK7I0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777540582; c=relaxed/simple;
	bh=l/a9wTobf92jzFsZf8ZAfVoB3S09T9fDX5ODjewF+L8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHyTf3aiEnr8H1hZWgbd0O/7HFQqj+M9HFAx3O7LlKDj8WWA2GYZLT+stsyfwu6ti7VTn3vCMfdbIv4WrHzjLa/Glhhrxku+9QaXr8GA9DnjT7n5QxYHHDYH/zFRHHJJVoKdJhL638JRa3pkBDnfLyVmfcBmarya0TdZPSt6aDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxSw9Azx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxSw9Azx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5693DC2BCB3
	for <linux-input@vger.kernel.org>; Thu, 30 Apr 2026 09:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777540582;
	bh=l/a9wTobf92jzFsZf8ZAfVoB3S09T9fDX5ODjewF+L8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XxSw9AzxoYt46bWLk0+BUP246OuYJuavYu58ARFXbwxQDvbl9wJNpP4njjiFJ+znQ
	 l3CzvECCTjE1v9YM3fVA9yVzRMpjccUimLzbeWx3sIRB+8ok5/k5EgAaC4TkN5Nwe3
	 Iwt2BbgDnI5+eF2oO9JeyCW1GpgD64kWo3YpAMPzSrJdg3RG4ulDh2j+jAhKzGayhy
	 au3vssuRMFpoIX7q/Pq43M4Tvv9wz0etUTbgS9gJ8HPdJ3kNNJyvGb6g5Py7M3XYjw
	 baPvjV88aJdsiJZqszHLaGwvTu4WLaDjV0wDTb+DsQ8Djt8ElbZwUWrVpSS+TSC3kl
	 nQc+kYeU/QTWA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a62a049c1fso667932e87.3
        for <linux-input@vger.kernel.org>; Thu, 30 Apr 2026 02:16:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8T8Za06fPzcX+YRH3cP0auSUKQKB39BgMdFV8QKu1SzrCyVQ41zBKYFJzgWnySSOJRIxKm/EKMp1CLRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yze469Mg7VYVNYUAHfKx7y3TrYcobgGK7NtluFz+ybfmw0giPdk
	5Aq2IzNPZ2gfUsDHRB34REHxaBQw0q4sF55JqIRugoh8BeZI98pdY2o0JuDvb+jYa64se9NIEPV
	93XPHIpDvNQLEhfiEwr5wMRvYcp4e2pw=
X-Received: by 2002:ac2:4e0a:0:b0:5a7:46f9:a6be with SMTP id
 2adb3069b0e04-5a8522ae059mr614505e87.2.1777540581025; Thu, 30 Apr 2026
 02:16:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428114308.113253-1-clamor95@gmail.com>
In-Reply-To: <20260428114308.113253-1-clamor95@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 30 Apr 2026 11:16:09 +0200
X-Gmail-Original-Message-ID: <CAD++jLmNKWwHAxV8OLK5wupwj4dT1TWEn2Dmd6gP-Ez9Pgk0tw@mail.gmail.com>
X-Gm-Features: AVHnY4KwPkvtgXF1IwqfGILo71AwcUURVjSi3qnAcbBTxlC6djjCjkTEfm11Kfo
Message-ID: <CAD++jLmNKWwHAxV8OLK5wupwj4dT1TWEn2Dmd6gP-Ez9Pgk0tw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] input: misc: add support for Imagis ISA1200 haptic
 motor driver
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 1:43=E2=80=AFPM Svyatoslav Ryhel <clamor95@gmail.co=
m> wrote:

> The ISA1200 is a haptic feedback unit from Imagis Technology using two
> motors for haptic feedback in mobile phones. Used in many mobile devices
> c. 2012 including Samsung Galxy S Advance GT-I9070 (Janice), Samsung Beam
> GT-I8350 (Gavini), LG Optimus 4X P880 and LG Optimus Vu P895.
>
> The exact datasheet for the ISA1200 is not available; all data was modele=
d
> based on available downstream kernel sources for various devices and
> fragments of information scattered across the internet.

I applied a patch to the Janice devicetree like this:

+               /* Haptic feedback unit Immersion ISA1200 */
+               haptic-engine@49 {
+                       compatible =3D "immersion,isa1200";
+                       reg =3D <0x49>;
+
+                       /* clkout1 from ACLK divided by 8 */
+                       clocks =3D <&clkout_clk DB8500_CLKOUT_1
DB8500_CLKOUT_SRC_ACLK 8>;
+
+                       /*
+                        * GPIO194 pin HEN (motor hardware enable)
+                        * GPIO195 pin LEN (motor LDO enable)
+                        */
+                       control-gpios =3D <&gpio6 2 GPIO_ACTIVE_HIGH>,
<&gpio6 3 GPIO_ACTIVE_HIGH>;
+
+                       imagis,clk-div =3D <256>;
+                       imagis,pll-div =3D <2>;
+
+                       imagis,mode =3D <0>; /* LRA_MODE */
+
+                       imagis,period-ns =3D <1340000>;
+                       imagis,duty-cycle-ns =3D <100>;
+
+                       pinctrl-names =3D "default";
+                       pinctrl-0 =3D <&isa1200_janice_default>;
+
+                       ldo {
+                               regulator-name =3D "vdd_vib";
+                               regulator-min-microvolt =3D <3000000>;
+                               regulator-max-microvolt =3D <3000000>;
+                       };
+               };

It works, I get rumble on the keys.

Tested-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
