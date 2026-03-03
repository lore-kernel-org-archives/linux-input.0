Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C684364946
	for <linux-input@vger.kernel.org>; Tue,  3 Mar 2026 13:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772546000; cv=none; b=Ktk07o5QeQh+2DWSg+DxSM/Lt1gowu/7fJSTf17vxdxT2Qm5LLG6U+rOqlcAhrhkjNaeB95goDiZOj/HV0IjncTaWyfsIZHhfTnToLtLoDiRXn1qgE4Ko7fycbns8kvFmfxsMRgGdLeC/TVg/8L22RinI3/RjwxurmfYmgHgu0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772546000; c=relaxed/simple;
	bh=o1uQy6drhsv5pZD0LZDFkCYjjp8aERY7B+ED/OHab84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kDFr6TfNH3qbnTxzzIdt6cPjkJtoMhjVC8WhsSf7DlJ79J59IBY4zmSbUOI3YNJcKHTiblmwU/MpW3NlFRvFbWaXfIfP1xr28p5gT0m+YixcOT/sSs3KnQzYJMmvIV7AHDdGF0YtE+Gs9EOxVum7YUEpfXP9aQG3E8LCCSBmKrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEXma8uV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEXma8uV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FD5C2BCAF
	for <linux-input@vger.kernel.org>; Tue,  3 Mar 2026 13:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772546000;
	bh=o1uQy6drhsv5pZD0LZDFkCYjjp8aERY7B+ED/OHab84=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oEXma8uVZmBZdCV84TKivC0vLoyWFYSojkK0qJP/Ey4vlkNLGD4FL6UTtI/K/y+W6
	 zCrhRzg9Qn+A0t8K9Q8nMmXa0RWZbtEfSVBw+VvW5aS0oDRGHnibhInat6eRVWo+cD
	 3WJad2wTiNTcRrILyUTrNWoJaPBxMSknA+2ibnyy4OcDfaJ0Nk770aihtIjW/0g41X
	 hsSfQTajCkqPlaL7iCC9S8HYz5Kheguv32/eisgnUBmeFT1icetiRHhrmwyMC0hzIY
	 O3u2j4aYoQTZfCkFibHdzAfB3UxVgIWt0ekkofAnAZZ9zIvF9c/ZlSrTwSWgqLMWCk
	 Bqn3JBVv7cKrQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65faaa8b807so1059806a12.3
        for <linux-input@vger.kernel.org>; Tue, 03 Mar 2026 05:53:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXAjy6rQ4k3/2j2ZZ+LFk1qG9CpcAQgFsaxOgeZXTkSzQN6e22sztZ/F7y4YFkiLT535cF/7/T+RPT3JA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCBelnQ4/Yr3SPZXi/r1sHsko5AcfmmzcS+VTGe4cD51/5XZqw
	+1Vbwpmwe+9zv+qkfUFA17G5z4BZ+ArO/F5rgiHaGhji0tG284uCP1zohPaCnWHN6u+J9Q/mZUh
	adr0cmmqmmPtExvp4RUxr4I2hfJLJQg==
X-Received: by 2002:a05:6402:51d3:b0:660:b913:faa with SMTP id
 4fb4d7f45d1cf-660b91311ffmr782984a12.7.1772545998078; Tue, 03 Mar 2026
 05:53:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org> <20260303-send-upstream-v1-9-1515ba218f3d@chromium.org>
In-Reply-To: <20260303-send-upstream-v1-9-1515ba218f3d@chromium.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 3 Mar 2026 07:53:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKN45FswZjo+27OzoHMeM7ec3hS7piF7SKNykmXNSmA0g@mail.gmail.com>
X-Gm-Features: AaiRm53ac9QEFDq8SvGBhIqKLe9Px3qYmH3XP37nJ_98UhLN34dE0tk0zj5PhvU
Message-ID: <CAL_JsqKN45FswZjo+27OzoHMeM7ec3hS7piF7SKNykmXNSmA0g@mail.gmail.com>
Subject: Re: [PATCH 09/12] dt-bindings: input: Document hid-over-spi DT schema
To: Jingyuan Liang <jingyliang@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, hbarnor@chromium.org, 
	Dmitry Antipov <dmanti@microsoft.com>, Jarrett Schultz <jaschultz@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 12:14=E2=80=AFAM Jingyuan Liang <jingyliang@chromium=
.org> wrote:
>
> Documentation describes the required and optional properties for
> implementing Device Tree for a Microsoft G6 Touch Digitizer that
> supports HID over SPI Protocol 1.0 specification.
>
> The properties are common to HID over SPI.
>
> Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
> ---
>  .../devicetree/bindings/input/hid-over-spi.yaml    | 153 +++++++++++++++=
++++++
>  1 file changed, 153 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/input/hid-over-spi.yaml b/=
Documentation/devicetree/bindings/input/hid-over-spi.yaml
> new file mode 100644
> index 000000000000..b623629ed9d3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
> @@ -0,0 +1,153 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/hid-over-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HID over SPI Devices
> +
> +maintainers:
> +  - Benjamin Tissoires <benjamin.tissoires@redhat.com>
> +  - Jiri Kosina <jkosina@suse.cz>
> +
> +description: |+
> +  HID over SPI provides support for various Human Interface Devices over=
 the
> +  SPI bus. These devices can be for example touchpads, keyboards, touch =
screens
> +  or sensors.
> +
> +  The specification has been written by Microsoft and is currently avail=
able here:
> +  https://www.microsoft.com/en-us/download/details.aspx?id=3D103325
> +
> +  If this binding is used, the kernel module spi-hid will handle the com=
munication
> +  with the device and the generic hid core layer will handle the protoco=
l.
> +
> +allOf:
> +  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - microsoft,g6-touch-digitizer
> +          - const: hid-over-spi
> +      - description: Just "hid-over-spi" alone is allowed, but not recom=
mended.
> +        const: hid-over-spi
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO specifier for the digitizer's reset pin (active low). The lin=
e must
> +      be flagged with GPIO_ACTIVE_LOW.
> +
> +  vdd-supply:
> +    description:
> +      Regulator for the VDD supply voltage.

Is this part of the spec? This won't scale for multiple devices with
different power rails.

> +
> +  input-report-header-address:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 0xffffff
> +    description:
> +      A value to be included in the Read Approval packet, listing an add=
ress of
> +      the input report header to be put on the SPI bus. This address has=
 24
> +      bits.
> +
> +  input-report-body-address:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 0xffffff
> +    description:
> +     A value to be included in the Read Approval packet, listing an addr=
ess of
> +      the input report body to be put on the SPI bus. This address has 2=
4 bits.
> +
> +  output-report-address:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 0xffffff
> +    description:
> +      A value to be included in the Output Report sent by the host, list=
ing an
> +      address where the output report on the SPI bus is to be written to=
. This
> +      address has 24 bits.
> +
> +  post-power-on-delay-ms:
> +    description:
> +      Optional time in ms required by the device after enabling its regu=
lators
> +      or powering it on, before it is ready for communication.

Drop. This should be implied by the compatible.

> +
> +  minimal-reset-delay-ms:
> +    description:
> +      Optional minimum amount of time in ms that device needs to be in r=
eset
> +      state for the reset to take effect.

Drop. This should be implied by the compatible.

> +
> +  read-opcode:
> +  $ref: /schemas/types.yaml#/definitions/uint8
> +    description:
> +      Value to be used in Read Approval packets. 1 byte.
> +
> +  write-opcode:
> +  $ref: /schemas/types.yaml#/definitions/uint8
> +    description:
> +      Value to be used in Write Approval packets. 1 byte.

Why are these and the address properties above not defined by the
spec? Do they vary for a specific device? If not, then they should be
implied by the compatible.

> +
> +  hid-over-spi-flags:
> +  $ref: /schemas/types.yaml#/definitions/uint16
> +    description:
> +      16 bits.
> +      Bits 0-12 - Reserved (must be 0)
> +      Bit 13 - SPI Write Mode. Possible values -
> +        * 0b0- Writes are carried out in Single-SPI mode
> +        * 0b1- Writes are carried out in the Multi-SPI mode specified by=
 bits
> +               14-15
> +      Bits 14-15 - Multi-SPI Mode. Possible values -
> +        * 0b00- Single SPI
> +        * 0b01- Dual SPI
> +        * 0b10- Quad SPI

We already have SPI properties to define the bus width for read and write.

> +
> +required:
> +  - compatible
> +  - interrupts
> +  - reset-gpios
> +  - vdd-supply
> +  - input-report-header-address
> +  - input-report-body-address
> +  - output-report-address
> +  - read-opcode
> +  - write-opcode
> +  - hid-over-spi-flags
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      hid@0 {
> +        compatible =3D "hid-over-spi";
> +        reg =3D <0x0>;
> +        interrupts-extended =3D <&gpio 42 IRQ_TYPE_EDGE_FALLING>;
> +        reset-gpios =3D <&gpio 27 GPIO_ACTIVE_LOW>;
> +        vdd-supply =3D <&pm8350c_l3>;
> +        pinctrl-names =3D "default";
> +        pinctrl-0 =3D <&ts_d6_reset_assert &ts_d6_int_bias>;
> +        input-report-header-address =3D <0x1000>;
> +        input-report-body-address =3D <0x1004>;
> +        output-report-address =3D <0x2000>;
> +        read-opcode =3D <0x0b>;
> +        write-opcode =3D <0x02>;
> +        hid-over-spi-flags =3D <0x0000>;
> +        post-power-on-delay-ms =3D <5>;
> +        minimal-reset-delay-ms =3D <5>;
> +      };
> +    };
> \ No newline at end of file

Fix this.

Rob
