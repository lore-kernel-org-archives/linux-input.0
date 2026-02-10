Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F788318EC6
	for <linux-input@vger.kernel.org>; Tue, 10 Feb 2026 11:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770721209; cv=pass; b=KLJyc0Ybp3td47kc8v3sOZXe1flQ+vcYpLje1Kl0s2o+6D8BgarO8qnFs4Xl5g8GhS7TE+wP551z3A/dj05xxVoYmX0LL6Gm9NQUrAltMhBGNEr3NLCehs54CM4BFr+2+jyrIdb17bs2bd0CTWTIEasiY/2CWBFpM7uDCtCF8Qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770721209; c=relaxed/simple;
	bh=1OYwpF7TO7xoKHzCuy52J4aRjvgLTtucW1e1JzBZV/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFePDcKr3Wr78GgIXS2Wwhhp7w1kUhNlTGASsyhvbyd1XfN8LiF50Is0YWfY9IQdwT9XyvAhDiuk01BKBwpxx7XJigk4sarC7BgMXWAOOM5nXnrxIjzw4qwreKTqGmhr04RuPh/XY/mkyTvNUwL8ajoHcTwUsVDW6YUSRUwYgdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IB5Zvk76; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IB5Zvk76"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43284ed32a0so3704464f8f.3
        for <linux-input@vger.kernel.org>; Tue, 10 Feb 2026 03:00:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770721205; cv=none;
        d=google.com; s=arc-20240605;
        b=hOIN9k3OE8FxXhxSawZDQiXOwMOj5PYY4V6AhYAPXiFwAjdw+6HpBfjXZqVXXtqQ/9
         X35xBvmDYi1nvY8kafp+sl1lcvkgwUTEMx5Dzmr/cPLdl2r8YUs2Gm0N+i+BdfNWoGry
         0lOoCObmFMS2Te6XTkUkMJIpMfQsrwIguPhmLR5VbIwHlayailTdFVVZx0oMP5w8FDx2
         RCfzM0vU43qqM54qyAy3ckII5gOQ5pYeg5rK8V3/YnGsI5Tj5pPj0jRePFyJSsa2EF+e
         zaaKWstZBAaYUC5/phrrGjpIXk37aVXzqbf9VRHCM8tWEAAgDmuvkSgGV8aAOVrcGHZ0
         3PWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OfSBwZ5L6uqnAzvcQ05vMPY2K5kDs14EhIIFhtKNvQM=;
        fh=e3aY/cRkGaS3WKgtr5gZ/9zzijmbO8ksrbvGQ27bpdg=;
        b=Tm143rUVXCDz04dwA1PJHSbrgRgsHR/fCWBpWUfxSiQPzx2bILlc7pEWwYtQTxI4H1
         hWwoV+bIOxmdIOcROY8HGT89scdRLY8gT+NuadAZRRdUvvxDQtHqk0uy+xt/lwHb8ssh
         kbSoGF20dcTGQZum/7MmhdVeH3IG9keH2q0sykxO0dTKKauz5ziL1kEOVAYPzpSJW0be
         v/x7WkTw2JCMW0qK01/s27AJiRqrBvRidJqLjwTdoBXyevMKGFMsk52grY+IiGJsZOxB
         F0SYPjeAl9fpVPduGRw8Oc47FJuwZDNd5n2KPSgrIVLHcSU+YbP+DA+PUtl/A0HE9iXu
         XN2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770721205; x=1771326005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfSBwZ5L6uqnAzvcQ05vMPY2K5kDs14EhIIFhtKNvQM=;
        b=IB5Zvk76VicVMOwP5OTF/oc7e2kErV3U3/Z8I2dJzS8UzMScFyV6fILwusyIvugkAi
         bsYQlBd7/VZYsx2dxt1iCQAo3DTZOLJA4ls+e4a/xV+oqCA0SXmFfwLoy0YY8OtfV0BX
         lunMzkjiHvk5lqRF427yB+uAP8t4ARoplWh7XfzS5GNfJkQq9/sGj4VKAdOfpthtJ/J4
         xCKB9g27f1mJHwljbsZ8zJzZ6LaZz/LIKQzstixgGD8SlfVJI71D6aHpcEMFUbbKKjoN
         ScE4W6gNG9wLGZarv4lah+ED/DPqrQm1hx29hCqfLlxaWMP5jQwWo6VJDV/bcOFa8Pwu
         j9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770721205; x=1771326005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OfSBwZ5L6uqnAzvcQ05vMPY2K5kDs14EhIIFhtKNvQM=;
        b=oKwt28W6bQg48sz3gOCrshowSZTJanCxsWNllMcNR+4fMH1rG3JAM+Vo+SIswzde3m
         KpzmVcqey/emoEK8TiG5CywQbQYgCcTyX2VR+VE9ge/T4Bexwf2N1WToYZ51hNFvC2Je
         9nZ8sGenr0xKvFj8l5cxMmUANyLnqqKBPTY7u4STNsh2a6+nTSInTsBOI7VaWbv2Jtpp
         EASoPKJnbP7dPFRjCqwxFyxYl6THJhMIzVS07TomkBofYED7C7yEXbYEyFr8wle6qc4B
         V/IGl9s+3cwtibYXQVIpbH42tnRKXiUxrxO8mCnTioAFvnXZUrJbyz8VBefGzVeM7zGR
         c23A==
X-Forwarded-Encrypted: i=1; AJvYcCVyBh772QNdN38WIvlGvzq9MqXTSul7sgJNuWc9QlY5l73tGwD7Uu7IANT6OE++f/tfIl4Lmsv0/l+kiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Pk1NwAOJwST+P0kAHKtXoA9xCV+Uys6BOAj8T5yuB6FgF5dL
	MSxaBsG5TnG5hRHnesUwnE+F7erYksDTRqkb3WJKYsrONrfiSEUrbaypw+g8LndrpnNKyVI6FOb
	wV05mMuasHHnKW9ASjB7F35dYO//hrT1sVA==
X-Gm-Gg: AZuq6aICRQ+x+aFQCWGD9A8LVueG67XL9bJ4FwK+VLxlcUArnpQHteC+vYAqV4+Xk+d
	GovqXoc0ONN8TTsp7NzVuwXNi9fw/RyXXWSnCx1UJYsVK76DaUBFFk1DnErngCzeadI9s9TIKr2
	qwzl0jUK4Fwk3ml6bTYViuTmhbxJNP9t4HS58Z1bYaJlN87N7cfGPOAi9zbGLFw+fwt5zSV23IW
	Euydu1nE/ryE7PLqI7uqK3qVmOvucBOJFMKM1FNNVWLvT7wn8hjF3FXLouflrO15xfMb+/R0QFo
	bvjLcw+G
X-Received: by 2002:a05:6000:22c4:b0:436:38a7:b486 with SMTP id
 ffacd0b85a97d-4377a5021c6mr2312017f8f.8.1770721204589; Tue, 10 Feb 2026
 03:00:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209104407.116426-1-clamor95@gmail.com> <20260209104407.116426-4-clamor95@gmail.com>
 <20260210-sexy-grumpy-sambar-44edd2@quoll> <CAPVz0n3fizf=r58Fr4YQ6pnjHq5p-7yFz95obss6w6x0bfgnDg@mail.gmail.com>
 <d1973810-d3f5-4ed7-ba0f-6bf93c1c7f3d@kernel.org>
In-Reply-To: <d1973810-d3f5-4ed7-ba0f-6bf93c1c7f3d@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 10 Feb 2026 12:59:53 +0200
X-Gm-Features: AZwV_QjgDJzQTiiKU4SQZozTCvRGlQSh-OCg1lxd7C4cK92P8FnftCEFnLl9FiU
Message-ID: <CAPVz0n1foyy9g7MAurSAyLCUHTzrPPu0ceqy9YpcDA9uzgjGng@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] dt-bindings: mfd: document ASUS Transformer EC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sebastian Reichel <sre@kernel.org>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Ion Agorria <ion@agorria.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 10 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 12:48 Krzy=
sztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 10/02/2026 10:37, Svyatoslav Ryhel wrote:
> > =D0=B2=D1=82, 10 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 11:22 =
Krzysztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >>
> >> On Mon, Feb 09, 2026 at 12:44:01PM +0200, Svyatoslav Ryhel wrote:
> >>> Document embedded controller used in ASUS Transformer device series.
> >>>
> >>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >>> ---
> >>>  .../devicetree/bindings/mfd/asus,ec.yaml      | 152 ++++++++++++++++=
++
> >>>  1 file changed, 152 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/mfd/asus,ec.yam=
l
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/mfd/asus,ec.yaml b/Doc=
umentation/devicetree/bindings/mfd/asus,ec.yaml
> >>> new file mode 100644
> >>> index 000000000000..1d1a62761b71
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/mfd/asus,ec.yaml
> >>
> >> EC do not go to MFD, but to dedicated directory (there is such).
> >>
> >
> > Noted
> >
> >>> @@ -0,0 +1,152 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/mfd/asus,ec.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: ASUS Transformer's Embedded Controller
> >>> +
> >>> +description:
> >>> +  Several Nuvoton based Embedded Controller attached to an I2C bus,
> >>> +  running a custom ASUS firmware, specific to the Asus Transformer
> >>> +  device series.
> >>> +
> >>> +maintainers:
> >>> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    oneOf:
> >>
> >> Drop oneOf
> >>
> >
> > Noted
> >
> >>> +      - enum:
> >>> +          - asus,ec-pad  # Pad part of Asus Transformer
> >>> +          - asus,ec-dock # Dock part of Asus Transformer
> >>
> >>
> >> Compatibles are way too generic. "ec" basically means you document all
> >> Asus EC, which is for sure not true. You need specific compatible for
> >> this specific model.
> >>
> >
> > Asus were not so generous to provide more specific data, they call
> > there controllers asusdec and asusped in their sources.
>
> Look how other ECs are called. Your device is not "", but e.g.
> "Transformer".
>
> >
> >> Missing blank line.
> >>
> >
> > noted
> >
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  interrupts:
> >>> +    maxItems: 1
> >>> +
> >>> +  request-gpio:
> >>
> >> gpio is deprecated. gpios, look at any other binding.
> >>
> >
> > noted
> >
> >>> +    maxItems: 1
> >>> +
> >>> +  asus,dockram:
> >>> +    $ref: /schemas/types.yaml#/definitions/phandle
> >>> +    description: I2C device used to access power related functions.
> >>> +
> >>> +  asus,clear-factory-mode:
> >>> +    type: boolean
> >>> +    description: clear Factory Mode bit in EC control register
> >>
> >> Why would this be a static/fixed property over lifecycle of all device=
s?
> >>
> >
> > Specify pls.
>
> Provide rationale why we need to clear it every time, not once. Or any
> other rationale why we would accept that property.
>

Cause it is done by original Asus code and Asus did not provide
schematic or any data apart from downstream source regarding this EC.

> >
> >>> +
> >>> +  battery:
> >>> +    type: object
> >>> +    $ref: /schemas/power/supply/power-supply.yaml
> >>> +    unevaluatedProperties: false
> >>> +
> >>> +    properties:
> >>> +      compatible:
> >>> +        const: asus,ec-battery
> >>> +
> >>> +    required:
> >>> +      - compatible
> >>> +
> >>> +  charger:
> >>> +    type: object
> >>> +    $ref: /schemas/power/supply/power-supply.yaml
> >>> +    additionalProperties: false
> >>> +
> >>> +    properties:
> >>> +      compatible:
> >>> +        const: asus,ec-charger
> >>> +
> >>> +      monitored-battery: true
> >>> +
> >>> +    required:
> >>> +      - compatible
> >>> +
> >>> +  keyboard-ext:
> >>> +    type: object
> >>> +    description: top row of multimedia keys
> >>> +    additionalProperties: false
> >>> +
> >>> +    properties:
> >>> +      compatible:
> >>> +        const: asus,ec-keys
> >>> +
> >>> +    required:
> >>> +      - compatible
> >>> +
> >>> +  led:
> >>> +    type: object
> >>> +    additionalProperties: false
> >>> +
> >>> +    properties:
> >>> +      compatible:
> >>> +        const: asus,ec-led
> >>> +
> >>> +    required:
> >>> +      - compatible
> >>> +
> >>> +  serio:
> >>
> >> All of these children are pointless - no resources. Drop all of them,
> >> it's btw explicitly documented rule in writing bindings.
> >>
> >
> > They are all needed to be able to disable them individually from the
> > device tree if needed.
>
> They should not be disabled from DT, so they are not valid here. The
> given EC for given device is fixed/static. Does not change.
>

Have you considered a possibility that function may be
disabled/unrouted within the controller. By the vendor.

>
> Best regards,
> Krzysztof
