Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1550C2D8DCF
	for <linux-input@vger.kernel.org>; Fri, 13 Feb 2026 07:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770967415; cv=pass; b=YgU8ttkfUSV/peTplKBqQhvg5FSklhG+i04uPqNXP4EC96ei950K751KkCzsxA32j1MICSSTeQlfHI8L74WX5cHz8nBENpBHi9/Pl1s7QRWYfe7kERe+jddWz8iI5wh1b322FdkayGc9UI/YMwXT6xP3a/ZjRUTMUJy5+lW0M9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770967415; c=relaxed/simple;
	bh=MmyEyVaUK0nInRHofYHUBo4aN8wM9mt3v+WrEEIMH9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6RBpzYcj6y08e0Ta1qY2Sy+ta+4O3Cp+kUleS9UMkEd++RtkcNecAfMLPnnrXqXsWAHps1DfbBMpBaCSE8Kas2H097Jaa8q5tISSLRN/JPkuWQ0zrjKtwMis0ylBNMXUZP59tHgTMqgTTdc8V9f2wcoRC67huBP4cY1QVNlTpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myyQa0+0; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myyQa0+0"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-483770e0b25so24025e9.0
        for <linux-input@vger.kernel.org>; Thu, 12 Feb 2026 23:23:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770967410; cv=none;
        d=google.com; s=arc-20240605;
        b=jSl9AoKtAj+rIIu0MH7H97Wo6Rp4dsjamQgB/3WWLP5vHB8pob9zeg8GOF2ZO7iQTb
         s5dMNnEe4VZ4VCqCJfmZUPi8F2U3Ugd3bgWKNUoLQ8JdXS6x6nABwB7wMQno2NEzkJgx
         aSihC7RK78hXO2u7H5CC8sro3zmk59UL185atN24GzeK6elf46wiDo8k1qwdVwQZBZBN
         7BmK8BicfK0Yv4wZKXo+wgkeuOmH7zTP2CIeLHVjeASsx0V+Ym8QhtO6d398BQTNkXuu
         StqKFKxOBkeja1+a6fWbOR0dcckpr+peVA3jejnIrlogmzgnQ8HqqmpnmCZ/h2JyESlV
         5Xfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VBWGvgMwD89B2tOYl/7fTry4UgR0kuVd41YN846Sbf0=;
        fh=fK82PJJwxeJMtk58vvpQUMxLCUkvoGOOI0hbZUeG+Sg=;
        b=HIEaixSSQDNGGfqxhIvnBK0G2hpnYln4mVl7NFP3kxGE1uqgLR9uUlt2wDmxo1tOLO
         ATjcSIOPbNXIp2OyO0Re/2w/WaRKRgaG/zjZmm+ktol2V4e5V/JFaXu7rlIurdfZDKIJ
         i/cU0OVLXXBfbhHd+NoaYjPnyQUJcwPiYqmVACHuIeiZt9Xiq4qgJ6a4p60ytLkXkIc0
         8Pe937mTwZCMs3rWNUzOV7R1v6NIM5Dmp3IwpSpjeh8J5j943oo3O8DVR8t4CjMT3WHR
         9Q8dqToUOZJGFmReaX97vGW7OGgkTDfys/Bwy+wWKE97QUPS4rCR3zrGxu55XCuY2eIL
         wV8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770967410; x=1771572210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBWGvgMwD89B2tOYl/7fTry4UgR0kuVd41YN846Sbf0=;
        b=myyQa0+0cdZ+6BCDWQ9XRyfq36ArqkIuxg3T0B0e0k3KTN7Fxgoza3JurNqt2hIZ73
         Z8KwemYutt8a8dmsYEa2cW5TON/PySdU4wGeWtt1jiX+oI8PKGY0C21vpyywSg04XAnM
         cAZkTinhBo7tp7ijknJZGHWS7qK4EW+9jQ0UykLEXXpPrW5XASJwMPNVDtBJm5zFeuCw
         kg83RWB/vx57hGCKzvOnJgXA/b2Xa2tWpYcQqB5NPd5nYEUK9CZ5Ff4uyOJdO5K2Oth6
         pVkInJIEja5yeUvaUK+jxWU4C5HbQdUhXNdKsMBGitLgviYxiCARAeZew8gezjZNy5vC
         iYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770967410; x=1771572210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VBWGvgMwD89B2tOYl/7fTry4UgR0kuVd41YN846Sbf0=;
        b=KWliMYEqiwSsDfU+iDFVvKPsXapTVp6xIul5fqWHlB2g8Pe8wC2hk1g73zZnKs8IKP
         5h6yeTYkMvnznUhJ4lnP/4sU17PZ2OTtbisgF5yp4vv+7/lZdgUCZvATrpp9DoEJKL2v
         MW65YN4c5RLY1+2Wda8dAArX3KM1GfgxDAfsXZ7gxk/ljdsGvHo73OEayTvzGfRtFl8p
         IhqH45swCdgTKlfPRKiGmB8KImWTKqb7N/u2RzXUtT8VJB5VXNLGJh6XRftDZfW7Ksb+
         FU0ok3/IWIEK+2g51c/+tQHPD+qGbT9Wx78O2ci4nSNdiNAbu7KW0l+Jj7/1OGGgsb5H
         0nLw==
X-Forwarded-Encrypted: i=1; AJvYcCV/J+csm3/I6UUy/59DDGXKlUgeunGnZWpnLol7pJmDpmeUa2ihndKubG+kKlDskBmXVNxCaY+SwWEJ3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy92LbnnmDyHoBs5g2R5iNLdwN8dKH5LtV1ZsBF6Sg94ayQVt37
	M9NLCDA2SXnRibGMC1b2EyYJTbH+2+SEXKSD1Ee2YLPBqjQO7s3CGT2OZty36xveNaI2i7LijD4
	9xW3S1HkZyDxPOAwE/H7ahRWzPE+/0WA=
X-Gm-Gg: AZuq6aJAHStP8dJkZU5NncXSswqUS2zHgglR+ynamOoJ3i8ePsta+RqJLnbJ3cvQX/c
	mukJGdUfqx2ejdoH7+fZtTh35hSz+f4rIthBJrhLnprgKBuLaWL7OcmGWn/NzAREbB9Zep3bpQJ
	2l8HcIvmxA20tBhPp4bCu0RzWjgLYxL+oFaalcffK4ejv0nPxqZzvIhVNh5u3neEx85c+HbugSF
	/jFRD+72JIQSvKn5IUY0/AXiFZrY4X/vfZt6GQwOFUpa0uPHvI7uEoA5p5ByNGzQjTuz6wJxeov
	AePzkznx
X-Received: by 2002:a05:600c:314b:b0:482:eec4:772 with SMTP id
 5b1f17b1804b1-483710962c5mr18176375e9.32.1770967409817; Thu, 12 Feb 2026
 23:23:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206172845.145407-1-clamor95@gmail.com> <20260206172845.145407-9-clamor95@gmail.com>
 <20260211212016.GA3910589-robh@kernel.org> <E5BC797C-4362-4C75-BCAC-7C32A51C4725@gmail.com>
 <CAL_JsqLcFAP7oP0KzLp7DfcCpz0DjsjoAW3PcfnWu2nc-dG1CQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLcFAP7oP0KzLp7DfcCpz0DjsjoAW3PcfnWu2nc-dG1CQ@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 13 Feb 2026 09:23:17 +0200
X-Gm-Features: AZwV_QgDJIV6_g_jAAOQ5PvTpgIhruzFFHa64dzcRToVwkVZEzE9kWpIOm1s5Xg
Message-ID: <CAPVz0n3oSpaW4w74Wxv9G_RUhCYX-WsnVexoAbp1tU6rkJ4nNw@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] dt-bindings: mfd: motorola-cpcap: convert to DT schema
To: Rob Herring <robh@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Dixit Parmar <dixitparmar19@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 12 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 22:19 Rob =
Herring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Feb 11, 2026 at 11:30=E2=80=AFPM Svyatoslav Ryhel <clamor95@gmail=
.com> wrote:
> >
> >
> >
> > 11 =D0=BB=D1=8E=D1=82=D0=BE=D0=B3=D0=BE 2026=E2=80=AF=D1=80. 23:20:16 G=
MT+02:00, Rob Herring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >On Fri, Feb 06, 2026 at 07:28:42PM +0200, Svyatoslav Ryhel wrote:
> > >> Convert devicetree bindings for the Motorola CPCAP MFD from TXT to Y=
AML.
> > >>
> > >> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > >> ---
> > >>  .../bindings/mfd/motorola,cpcap.yaml          | 411 +++++++++++++++=
+++
> > >>  .../bindings/mfd/motorola-cpcap.txt           |  78 ----
> > >>  2 files changed, 411 insertions(+), 78 deletions(-)
> > >>  create mode 100644 Documentation/devicetree/bindings/mfd/motorola,c=
pcap.yaml
> > >>  delete mode 100644 Documentation/devicetree/bindings/mfd/motorola-c=
pcap.txt
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/mfd/motorola,cpcap.ya=
ml b/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
> > >> new file mode 100644
> > >> index 000000000000..7e350721d9f6
> > >> --- /dev/null
> > >> +++ b/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
> > >> @@ -0,0 +1,411 @@
> > >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > >> +%YAML 1.2
> > >> +---
> > >> +$id: http://devicetree.org/schemas/mfd/motorola,cpcap.yaml#
> > >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > >> +
> > >> +title: Motorola CPCAP PMIC MFD
> > >> +
> > >> +maintainers:
> > >> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > >> +
> > >> +allOf:
> > >> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > >> +
> > >> +properties:
> > >> +  compatible:
> > >> +    enum:
> > >> +      - motorola,cpcap
> > >> +      - st,6556002
> > >
> > >This does not match the only user in the kernel .dts files as
> > >"st,6556002" should be a fallback.
> > >
> >
> > Honestly, I would remove st,6556002 since it is not the only cpcap mode=
l which can be used, hence it cannot serve as a universal fallback. Some de=
vices use ST produced cpcap chips, others use TI and range of models varies=
 too. I guess I have to multiply commits.
>
> The "cap" name goes way back to at least 2G Motorola phones. There
> were whitecap and redcap chips for different 2G technologies which got
> replaced by patriot (red+white+blue I guess) for 2.5G.
>
> Dropping is fine with me, but then you have to update the .dtsi. If it
> was me, I'd just make the binding match because that's 1 patch instead
> of 2. You can still drop it on the new compatibles you are adding.
>

Yeah, you are right. I will preserve st,6556002 fallback for
motorola,cpcap while Mapphone and Mot would not require this fallback.
Thank you for suggestion and for the cpcap's origin.

> Rob
