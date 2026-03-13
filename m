Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A773090C5
	for <linux-input@vger.kernel.org>; Fri, 13 Mar 2026 01:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773363644; cv=pass; b=h6qbxkCpwqbbrsz3budfvFZ9mLaKJsT2bvWdUMUnGpi/oxOyWiFRaDLEDsDiMYmIjTwnAsOtTCQRAHSHkN8AHhftOpQTE5NpwyCGb49JbOnf34K371Jx5r7cUL9gW9oRapFQjLQQH9BZch4vNttARlv0ZG2VyIYigB/SQ86N0gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773363644; c=relaxed/simple;
	bh=sWXbHUNWyCssRT+Z0j94kKl4zmDZN0doACSqgWVnHEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uAHvSHLOyZs008CnvU3zPnDxGUmSJIOnNmjpF4t8X59DQSK4arvfymOBa1kBMTSa19oeDWSyo2JBvlhiLA6DFG+asYQHmsHdhxpFjdPGKlYriOwngQ6z/zna7IH0irksRZmNVhxhY4ssgbh4wBvcWJDqyG49x9z+n7B2ZFFjM7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZA/lz0jz; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZA/lz0jz"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64ca09f2170so1806835d50.1
        for <linux-input@vger.kernel.org>; Thu, 12 Mar 2026 18:00:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773363641; cv=none;
        d=google.com; s=arc-20240605;
        b=GzsxeckqraSG6BGrOqM1pVTAkvElM2w4XaYbr7rjSeqaOC1dzEyHb94afPLOy9yty+
         XB14GsbL2EFeQCUtH9Xep0x1EHh36Lm7Ma1hgvoF0ilZTGacNYimt5SwalUSc8+TYBJ4
         UpsNJN2wBpLzC6/VeRgVWXolG3t4R325zWS6l9OUO9AAnYMIlemikYq0tckzNlfeVru7
         93LoiYbYO6aGYH8F3sRgH6EFjNksDOl1Z89w/PBFevZbvzyi++40Zw50woeC/f38K/5b
         zwk0LI2pirwrwaGEpdk/Mswy3yTwjFNkPi//5pNYGHQnjtlPaMW4UzGA7f1nGXnUVN+v
         itzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WEIoHUDBRKW7sPjWtgozpXFsqYAeqWilfaHlivAXGTA=;
        fh=7LF27BWIJ9tUnsi/3rE3ElbOTHNYpNsjGJTDI5h4wB8=;
        b=bs4Qf5wc43V0iTmjO3MSLwSw8AEeiQrhl4ssMQOUECqW0FA1c8koou+nG/DYQtOeLp
         jRSAHATbGuaSc0v5C1G3d1obeW58PD5BeGVJUYh1J2sN9O4sv4cZo57a0Gg+YenGUWIA
         87bZjrRj+FQcDC1h2VWo/RF2i9lf/zj8Q+MziOJDgZ4JFny2sNVWWfqMDk3Nn/ks4N31
         jdvJHP6QIZ4cLBZsuGBhy37Mw7AXeOZ5odwjIfC1v/d7CEtn5CW4w65IkpovcUDF1M16
         z2U3qnKw7o8D7nNhqC3R9XPzcjCYYiFMzDIFF+lc2yJXhhnqnk9XpSBnsPtnv0rR6EBi
         uECQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773363641; x=1773968441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEIoHUDBRKW7sPjWtgozpXFsqYAeqWilfaHlivAXGTA=;
        b=ZA/lz0jzZ5SnEt27k5mt290nazi42vhGGnOyNcbDIrJk0WzjSHSUXA0OXFphwHSWli
         WNhDUXBka7oi/+/SldIRtUuf1Po9CwQ6Y0+CSBiC/7rRru2Mvrwgy2C7Lvu84y8UZU3c
         nmLVa2qKS2YKHBiYT/MZ/bSmE8EFdQz3BwQto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773363641; x=1773968441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WEIoHUDBRKW7sPjWtgozpXFsqYAeqWilfaHlivAXGTA=;
        b=VOU+96Xwy+41/eY+7zrPFvl9Yfj2lBCZ1ktRSfiIqbJrMxZTqK8HIYBZ23SPfG+AaL
         gP2g3LZrl98wTNCZEweF23EHZSjdqLnD17v9wBDC4jbVKqgBR3mh1NATHbFd2V+1eSLe
         X0Pkx3waqjzOoZjzHmo9JxWfZFQS3hkHvXILzrM/tFYUJDQ04VGSm8sdMj+cnMMm5Aip
         JHXpy5CQnZsfKiXH0Olq3FX0z1rRf6G1jxVAs/H+10f272KCJGYj5r3wPqOusF5y8wUG
         dnOH5ouNr2dpQtMYSkD3HC0ygZGrEEK6BANROD0H0uM+n74N32UiE4C6owfqsIW/sdyK
         ryIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE/QLP+B09w8BlPaDl9/Muc1HJVKp5sV0J0/+Ul8fbJmufYX1Ho1i6aQma0aVFJUqMl+KFWYhT45HCkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOv7jX8aGC4IMYtldl++MZd85vC/2YdGnOAF0XIgdvlppsM3Ru
	z7jd00P4+fhsU0lqiJ9wHMTljS2olRfxAHrpwB8FBx1BgvGZIJ6n7vhgv9H5uSYZuj/BeFZX/Ws
	VDSDGDN0FmFoQ9JtyFlx13hUp/6fe49/3koOGQdMa
X-Gm-Gg: ATEYQzzX3pdc4kZjaRXbsYJxybC+Yoqi/34L7Km+ryhd1J/AOOVZkW04kZUh8HR/+91
	/KSwtQUILNJxWJoRaMlnupJQYnNOq2MVaccEIwidn/QWa3dADvCZUhmIQkf19wVnFVA8MoY/Vu2
	qp2hfBMkTtmwgMH8muVoLttmy6z/zknDmLHEztlxH0h2GzcfG4OTf38ZLK2avK9UXXAJ74oJX73
	jH3qAOqcuXv6i0HrdbT0/qDK2sD+eTIzd7qWigxQUpEPKZpVbIxtWVMhoqS4SoDufkymUPz+J3s
	i0CNJNlfESJ6SyX0x3t2+riMzRtreAABwcPYJtMG
X-Received: by 2002:a05:690e:23c6:b0:64c:a815:511b with SMTP id
 956f58d0204a3-64e62f59679mr1215624d50.3.1773363641056; Thu, 12 Mar 2026
 18:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
 <20260303-send-upstream-v1-9-1515ba218f3d@chromium.org> <1cc6de61-8b56-492e-ab78-e3aa448f58ad@packett.cool>
In-Reply-To: <1cc6de61-8b56-492e-ab78-e3aa448f58ad@packett.cool>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Thu, 12 Mar 2026 18:00:30 -0700
X-Gm-Features: AaiRm529-VNRFl8j9TL1yc6G4h205p6aiqQ4Ar4V5wWtWy0meX15btognc57fcQ
Message-ID: <CAEe3GZF7ct1ZFH2Zd6AJnO1vBJQZobGaQKO+hTMJjFcCQddq6Q@mail.gmail.com>
Subject: Re: [PATCH 09/12] dt-bindings: input: Document hid-over-spi DT schema
To: Val Packett <val@packett.cool>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, hbarnor@chromium.org, 
	Dmitry Antipov <dmanti@microsoft.com>, Jarrett Schultz <jaschultz@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 11:25=E2=80=AFPM Val Packett <val@packett.cool> wrot=
e:
>
>
> On 3/3/26 3:13 AM, Jingyuan Liang wrote:
> > Documentation describes the required and optional properties for
> > implementing Device Tree for a Microsoft G6 Touch Digitizer that
> > supports HID over SPI Protocol 1.0 specification.
> > [=E2=80=A6]
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - microsoft,g6-touch-digitizer
> > +          - const: hid-over-spi
> > +      - description: Just "hid-over-spi" alone is allowed, but not rec=
ommended.
> > [=E2=80=A6]
> > +required:
> > +  - compatible
> > +  - interrupts
> > +  - reset-gpios
>
> Why is reset required? Is it so implausible on some device implementing
> the spec there wouldn't be a reset gpio?
>
> > +  - vdd-supply
> Linux makes up a dummy regulator if DT doesn't provide one, so can
> regulators even be required?
> > [=E2=80=A6]
> > +        compatible =3D "hid-over-spi";
> Not following your own recommendation from above :)

Thanks! I will fix this in v2.

> > +        reg =3D <0x0>;
> > +        interrupts-extended =3D <&gpio 42 IRQ_TYPE_EDGE_FALLING>;
> > +        reset-gpios =3D <&gpio 27 GPIO_ACTIVE_LOW>;
> > +        vdd-supply =3D <&pm8350c_l3>;
> > +        pinctrl-names =3D "default";
> > +        pinctrl-0 =3D <&ts_d6_reset_assert &ts_d6_int_bias>;
>
> Heh, "reset_assert" is a name implying it would actually set the value
> from the pinctrl properties, which is what had to be done before
> reset-gpios were supported. But now reset-gpios are supported.

Taken from the original patch. Will fix this in v2.

>
>
> Thanks,
> ~val
>
>
> P.S. happy to see work on this happen again!
>
