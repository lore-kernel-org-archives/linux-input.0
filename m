Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795204976;
	b=N5PKO3fF0P3iZBsb4tjlQmLDXy8zOGwhhan34QaDKWLJb7A9UASPUNW6zNPyclN6Kn9K
	 xH8wlE0p4gkMR6eyXWifZQcGzEPA491W2qaeVJ9VtiRCBqlZIkDtu1s1eCls9x2+eO4VG
	 T/GslRWkTTmxv/OfTAsihsrStdqKoiUyb1ZRAArNEmK2drfBe6ug+IIZMy92xUq33liAU
	 6RHXGw7enJAVnhOhrVMXCL28TsQzW/BwcU6KRnVugGqfAbi6XunkbEZq1Od8B9UnYAxaW
	 cQGFcfKb/GHYz18xXQ2muodFinlRbpPeqMsmi74xHtAnkoJclZFr0krqmqa4+YEbgpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795204976;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4V7U58O8sKkT2FqZynxSVbl9uHZQNKqD+q26N4wEsfM=;
	b=xUk3vE81HQjbwc487FlLQ0cFEvXHV9n93gmL81zd+CzrOpG1fj09/u1FYxZflmR5UPtG
	 fupcB4bQyeIX8SRzap8YsCpEi5rpKVXRwW8QUz7J/yQ4jDFj43SXLrv96JuG4rskBy7iF
	 iMuDX0yayBR+GQrdCSfd9hTVpFluSndY6xOWV+/V9Dxj6qy3PCr3rrS4reSvQt4whwd3b
	 DczMI7UzBq/vPBk1OCD1mRucqm+fxNPFTcy40ROCQEYxK8Iyv4V6LQILmIeAqYXGYtfb0
	 6dZ+YSbgp6TCN3u2vXt+LXWq/z5SkH4YCErWL6eIDRNxKgQ5zE8nkd1qudF1lpsJ+kA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WaMYcHhB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4882760A2618
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 20:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4882760A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WaMYcHhB
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67db3a48dc6so1697352d50.3
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 12:02:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795204964; cv=none;
        d=google.com; s=arc-20260327;
        b=mLi8RqK5y4eLteLmRD6rs9RBmm0X1xy6GrKc/TU3rkihIJtQN9WqyEaLQRuQyr/zkX
         CFjLcuNPtp00T7ejHc6RNKmR6DPLaM0j5Rvj35uZosLnzKwVRNEzwQds5kmOyHguijfe
         4t8LoK1mb2+CYMJ+NcLmYiGoZDVPn5dbTHhMGdXGVNc2oaHFUsaH5x9/f6H5FRnUqYPx
         pEtomx0S6gfY/V8jLVTygqFGwFZyC+Mz5vRoItHhN9eGlxbC+G7dmrNVzdVrJkwI9Ovs
         l+Flm4c7IHvo5M3+8glB7mQqkZounVMq8FpxLr1MIQk7gMkL72TNgGI7O4n4qIzFKRlJ
         qxOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4V7U58O8sKkT2FqZynxSVbl9uHZQNKqD+q26N4wEsfM=;
        fh=L0ZIu6xnRTrwKKuUQMRPLhJ8SWr31VQaNHitVaAiJK0=;
        b=h0iRQjP56fCnAWCVqcKogVC8nz+WEOy+pooroaVVogCyRR8ki8pDe/Yr79D9WjpIw/
         Zidj8MBlrBNQ02MGJyjPC/vtFCfZi6Cl/qmpc4E13WNw/mWoQsDP6I3m/TmTRgf/2ML3
         VcXStKmVYHhHVZXPyiSwG+Ax6s/JQHWR4eOOJC4hWYScYp+kl12o5+5TPxBZQhqvTsAz
         IIF9cLDc2yGS//VSQxSKIO/nF2wCyctmxLxozmY25FORU73M2UDey+Eq6xWzqBIfmXaZ
         cTvgESfYrzYF9upMnVS9rXHz5/zuNySXUXtBXm5h7+HMkZLyJ2QOjIMBFkZkgKuyNWUl
         jLdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795204964; x=1795809764; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4V7U58O8sKkT2FqZynxSVbl9uHZQNKqD+q26N4wEsfM=;
        b=WaMYcHhBNZ+35v+6wpg2naLtL6eDcZGWsH/op1cQD4c03wrQ8D9MdgfrpovhVdIVdA
         2vQEBszX+L485tw/WsOjNI6nY9CG5gIGG0K7OjZRK2gMC/7bEIPYyrqsu7ZYpm9MYQC0
         3I6OnJRjbJW1M/wIfBUqPj0fZpDXE7cn+bncY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795204964; x=1795809764;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4V7U58O8sKkT2FqZynxSVbl9uHZQNKqD+q26N4wEsfM=;
        b=RuASWa+HSYx05YXAqZHSpiOLTnLApp3myjlzFdv/H1+jl859y6yUvTBM9aLI316xIw
         YsIRdxhELXcFVVh0xsEr38Km12VoM1EiNo4Op1HxyAx67xTMmM3SaAxuB5n9dN0mosLg
         b3sMs28jjKpn1Qj1iJVlMNSUQzRSIjRmdSNkMupNQc32/8S1tJrOaAWo1DIfjJFLxueV
         eQC83Du5+KZzz+8VWh9150/uRJfz7Qpl8i/SwFI/ZbKUuWCs0Cr8Ih7xtNOJ6Lidyt4y
         pXc9M5/bbYgV79Yl9H6eUPukS7KZr6vAQ4k6pIWVLVzOX+AvODUY9ePzTseURarj1+Xw
         SjbQ==
X-Forwarded-Encrypted: i=1; AL+hErE3kx2UhNWCCLMwRIWBDDbJgu/9PDunu9wyCz4jRpS6e4AY7vHG9zzrRmLq3uvy1EU5EQDzkSFuBVZKQw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9MuKa4DY6cuygvZfpmQaWZzz+MaI4uEIRO56Ue/l2EnZycMkmE
	tOeNbc7uXjzvzbFDVryrzwp+OC7fyM3qPVTvpwQzd/6LIlh71VkuaTn3Dmur2ZiYnlXcKLPPiQq
	JB+8Z/oByr7TaNmfiV0IjoX2c3ITrGpT6vuVlDUB3
X-Gm-Gg: AZFdTZczslzNAtzCMif/zLcng7LVgOeHNkZ0xcXgJ30Y1w0pbdFK9zjielGKn6zqj0U
	2JSTK3BEvMxBO///CUsBvgX1hQJhf6jwoREJYZL1xt9UA8acWihx/2UyVaOprqBN1+Jx4G483/Z
	IJXwj0COC6ZCH2s3QwmXQhBLCDlrB1T2ph/pS6+jfBod7Lmy3sluIlWIVosdMx35YDrZ6d9zG+/
	sq+kRS5Dz0fejKs678tG9ug8gYBjYoyOKIFasTjmneVooke81vrgS7EITwEqbN5GejSF7ivmzpD
	fgYZMuvtQbqAs/sRf27Bp3W0Eo8f2zgP57phhWkkLsMoqil9k7D6jxGTviw18jsfewgMcADSU2/
	lR5717je02hLVMLrMj+5ex8CEU2oEDWI4rXDbb08MK4O4HZL+9VNncAqfOntUMYNKfoDz
X-Received: by 2002:a05:690e:4008:b0:67d:e36c:6bc8 with SMTP id
 956f58d0204a3-67df44c1825mr1431647d50.146.1795204963908; Fri, 20 Nov 2026
 12:02:43 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
 <20261024-send-upstream-v7-8-abad13174b43@chromium.org> <20261027-silicon-unvented-a0c8dc394e87@spud>
In-Reply-To: <20261027-silicon-unvented-a0c8dc394e87@spud>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Fri, 20 Nov 2026 12:02:32 -0800
X-Gm-Features: Aa3M54pc-1DTIKZ-A-hc9wj9AlprRrg4PvxeOwd0_HsaV1fm3yOGyT9vmhS6ZyM
Message-ID: <CAEe3GZF+P2hHHAQO_eWq=yv83HYw9ebEdkO_RZ4zPkQ6e_bAeQ@mail.gmail.com>
Subject: Re: [PATCH v7 08/11] dt-bindings: input: Document hid-over-spi DT schema
To: Conor Dooley <conor@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, hbarnor@chromium.org, tfiga@chromium.org, 
	fqwqf@fqwqf.xyz, daleyo@gmail.com, Dmitry Antipov <dmanti@microsoft.com>, 
	Jarrett Schultz <jaschultz@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 11:17=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Sat, Oct 24, 2026 at 12:51:42AM +0000, Jingyuan Liang wrote:
> > From: Dmitry Antipov <dmanti@microsoft.com>
> >
> > Documentation describes the required and optional properties for
> > implementing Device Tree for a Microsoft G6 Touch Digitizer that
> > supports HID over SPI Protocol 1.0 specification.
> >
> > Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> > Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> > Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
>
> Personally I prefer how this is done now, but definitely worth those who
> approved the previous iteration taking a look at this because it has
> changed significantly and no longer contains any of the properties that
> cover the timings etc anymore.
>
> Worth noting that this changed since the previous version after I
> pointed out that the second hid-over-spi device did not make use of them
> at all and needed specific handling in the driver.
>
> > ---
> >  .../devicetree/bindings/input/hid-over-spi.yaml    | 75 ++++++++++++++=
++++++++
> >  1 file changed, 75 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/input/hid-over-spi.yaml =
b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
>
> Typically this would need to match a compatible, but I think this is okay
> provided other hid-over-spi devices actually get added here - the series
> adding the second hid-over-spi device didn't do so but should be able to
> I think?
>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> Thanks,
> Conor.
>

Hi Conor,

Thanks for the review and suggestion. The intent is for this to be the
common binding for HID over SPI devices, and I hope more devices
get added here over time.

Thanks,
Jingyuan

> > new file mode 100644
> > index 000000000000..bed0746f004c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
> > @@ -0,0 +1,75 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/input/hid-over-spi.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: HID over SPI Devices
> > +
> > +maintainers:
> > +  - Benjamin Tissoires <bentiss@kernel.org>
> > +  - Jiri Kosina <jikos@kernel.org>
> > +  - Jingyuan Liang <jingyliang@chromium.org>
> > +
> > +description: |+
> > +  HID over SPI provides support for various Human Interface Devices ov=
er the
> > +  SPI bus. These devices can be for example touchpads, keyboards, touc=
h screens
> > +  or sensors.
> > +
> > +  The specification has been written by Microsoft and is currently ava=
ilable
> > +  here: https://www.microsoft.com/en-us/download/details.aspx?id=3D103=
325
> > +
> > +allOf:
> > +  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - microsoft,g6-touch-digitizer
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +    description:
> > +      GPIO specifier for the device's reset line. The HID over SPI
> > +      specification requires a dedicated, host-driven, active-low rese=
t
> > +      line. The line must be flagged with GPIO_ACTIVE_LOW.
> > +
> > +  vdd-supply:
> > +    description:
> > +      Regulator for the VDD supply voltage.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - reset-gpios
> > +  - vdd-supply
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    spi {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +
> > +      hid@0 {
> > +        compatible =3D "microsoft,g6-touch-digitizer";
> > +        reg =3D <0x0>;
> > +        interrupts-extended =3D <&gpio 42 IRQ_TYPE_EDGE_FALLING>;
> > +        reset-gpios =3D <&gpio 27 GPIO_ACTIVE_LOW>;
> > +        vdd-supply =3D <&pm8350c_l3>;
> > +        pinctrl-names =3D "default";
> > +        pinctrl-0 =3D <&ts_d6_int_bias>;
> > +      };
> > +    };
> >
> > --
> > 2.56.0.257.gf7497c7d27-goog
> >
