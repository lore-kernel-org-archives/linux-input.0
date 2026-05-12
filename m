Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E57360EDB
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590838; cv=pass; b=UESNkTOuNoAXDZM8oZygVjtiXS3qqvTzWbmytkN+HivVIXdV/wtEVwM8nlF/jXw1Ni0C+mvK2D42uDOoXUDd0Ht/01etRETVevkw/dZ+jlU9NGH7Sq7KFgvt665cUnwQlrUpEg+8fn9REWB64vSkU5IveXcq2Hxi1b6D5W7XQlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590838; c=relaxed/simple;
	bh=YuM53joYsuqA/fqOKsW+xz9cxbWMg+9daWwdkzmHkN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cKjoE2mi1egdl31ArAUo1vENyZ5suWAsCsY1DGBuoF1ymYAq8srNHu9Nw51nJD/GgPrRfSsNbbdngSuw7OCi5GSB9sZ0AxaukYb9juG7U6Y5Rc+F1zFhb/uEwcQmc6S7ZUPEghTReY9VIs7CfyG75f0gdWQZ8pcQubxUjXMU51Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kojBv8oc; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kojBv8oc"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b4520f6b32so9452068eec.0
        for <linux-input@vger.kernel.org>; Tue, 12 May 2026 06:00:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778590835; cv=none;
        d=google.com; s=arc-20240605;
        b=fICnX6eQYK4Wle9T8WM/Idie+8EO0Ygmus2YWT8bIQlHYmuOnoWK2K2IaQ5p9yr+Vn
         LnLaquYuCAC9O7PSO04zU6EmKZXBwi+eKMEZjcfwj5CJGY0TgBj/38T84cr99ORr1QCO
         23/HEIKcY0hXu9Mf1DZFFySjsiTD3+bV7A3FednW9Si9aps1Acsq7MztHHkrQTJp6YLp
         MwhHl9BGHQXfgtb3r4zj25Q1ZieWufGLajgaLGyrE0smv5wA9iE/x9MfRDmQq+2BgtWl
         GmJc5hDnjLWtZfr5GXSZ/Xn/NCAq8TyJcWN0WcdqYDEnGHXUEnwct2OnJKCtSmQSIw25
         MWJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2IS5oluGQ9rzg5bXFenlg6gcPX4ICtDWNMpGHTlzVao=;
        fh=/aPbg+7B5QORenQLY3DDSyyj2vpSCDl4bXTKmY84TA0=;
        b=IhZGv7/M61CBFsECj06+SZJspATQWscdqQjEulKURKvXtO7v0+NVEpQnh+In/QsFoD
         PCwj0kqOffiLUDJ97OzldtQGC38eIbJILSW3NedURNJioG0++gKgY0gIqFPluGVky1Zf
         KxZn3yP2hz3tagYRGvPgFBMSWIVL6Uf4d4F+Dxtvy6/5dUR4c2sMLteGMMBBRt2cIhfF
         tezkztYVTiV+WAL4q047RYhhdMRRs77H5VaZq+UdEX19U5PmzmB0N7lnJga67+qip6jL
         S8Gxwl+ispomHheG014+o2iJ8D5BluIDlI8doREdVdjORqewQvzAmVNbx9YBViEj5Hvm
         KWag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778590835; x=1779195635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IS5oluGQ9rzg5bXFenlg6gcPX4ICtDWNMpGHTlzVao=;
        b=kojBv8ocv5FfzX8wx0SpcbJluVbvKsL7UUpwx5Z3LPvFc7lmqYncPJH7/YcKjDUHGe
         gDfyIoX+BbEx5JoYwNth1+b5i5Fs0FrgDeXyZiwE1YuNc+zY6uABEk1W2GVOGPKWC+Yl
         Y0mWvGYv8E9QOdt6Mn81YWAsZNniik2uxMDMkMPkz4ZPpkJUHI7eGdJPkTNYf2oly4pv
         7xI3UGUmESwzjtxLTxgZ2GnD/Vodrr7uwzROpmY4cw0Q1N5jZzZqCnCNWEKtbJafmfKw
         +nCpu4UB4JACewnyKQcZfE9r7OQX8Pump+6e+X8X3a/2INUn9eWwJYW7ls+cIccXMsGh
         OQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778590835; x=1779195635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2IS5oluGQ9rzg5bXFenlg6gcPX4ICtDWNMpGHTlzVao=;
        b=j/1xVczAKanJnZMzu/Ri4B/uP5dwNBMEvWpCZDhxXEnMDSsk2HX1A+t6w457DM1bin
         uS84iGGTu5KmZb3ZVgRTvKCMBco1a6mXnnFDtZWPFcSjGxrGx9HjR/eKWAjmjCp5C4QX
         vX4wkcR+s0KR1ZzZEZEbyECpuVx5ZNhBiHPt9e9xO8lbaqtc2RmI+g8nMejtWA2YtdOE
         J/dTyH6S178OS3Bw7SrLk/JcnAb8MGktbeOf1bMl9DDujvIG9WiurFKdSJNwjLS2AZE/
         9Dq6AInoed8KgpLfskZF0gIziQKgo0jVZdfMUiZ8vagVPj7C4RJ6tw3QU4N3o85F1id6
         CLuw==
X-Forwarded-Encrypted: i=1; AFNElJ+Rshm18na41ri5dPNsMiz28uYVwGKOnQY7OKJ5dgEWtYJzbNKt4G/K6qZ9BIAbDqyh040CKRN3xeyMyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwfeO70BcjM9a+u1mJTRBQ7/zryzJqgcRJvbUXG37pY4FwhRUj
	Xp/RH79EOm6uabmxL9ssuoe+dRlWta/4be/5vSBX1kPSyTgkSlHj5rojErXPJy1WBrb6320mzLp
	o6bl+8egAlczy31C5CWZEXuIkeMH72Ws=
X-Gm-Gg: Acq92OFeZxFaZ14HOh4tzXmm6mzvJwDjvEwvks82swunhAGpzGVZb+ArcRcuEs+jpLO
	voz7R8mdDz0J+b6cKfdNva/bRbML/ovm6eMLzGZBBfRnm9TAfw/zo2LBA4F8wEa5mPL7s26AKAH
	HTDjqripTpbYy++KesSYiVFBgH5/iLH3+7dOXtTY4anNHv34k+NE6sq9I9Iiq3pNCnkAHdwCYT7
	Uizh4WL5iw3Hgxux9qhaDU1jrtxzw1HK+3bDw2hikgqsKAT8955eIt6+Wnx8RNAyiBtAe1aEJPu
	W2mqBClD
X-Received: by 2002:a05:7300:ec01:b0:2e1:e3e6:2909 with SMTP id
 5a478bee46e88-2f54dc8dfdcmr12882765eec.9.1778590834832; Tue, 12 May 2026
 06:00:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510110804.33045-1-clamor95@gmail.com> <20260510110804.33045-4-clamor95@gmail.com>
 <20260512125309.GA1476682-robh@kernel.org>
In-Reply-To: <20260512125309.GA1476682-robh@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 12 May 2026 16:00:23 +0300
X-Gm-Features: AVHnY4Lg9-rZZxak_7A8-rgTbdgv1Xf5Fk-dRQ_iaShma4n8Z6iLa9Gayv32ho8
Message-ID: <CAPVz0n0QSvht+_ejbErDsf0o6Bt1STynVydJOemcSYXrr-TgHw@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] dt-bindings: mfd: motorola-cpcap: convert to DT schema
To: Rob Herring <robh@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 12 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 15:5=
3 Rob Herring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, May 10, 2026 at 02:08:01PM +0300, Svyatoslav Ryhel wrote:
> > Convert devicetree bindings for the Motorola CPCAP MFD from TXT to YAML=
.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >  .../bindings/mfd/motorola,cpcap.yaml          | 414 ++++++++++++++++++
> >  .../bindings/mfd/motorola-cpcap.txt           |  78 ----
> >  2 files changed, 414 insertions(+), 78 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/motorola,cpca=
p.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/mfd/motorola-cpca=
p.txt
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml =
b/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
> > new file mode 100644
> > index 000000000000..7f257f3a1a5a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
> > @@ -0,0 +1,414 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/motorola,cpcap.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Motorola CPCAP PMIC MFD
> > +
> > +maintainers:
> > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: motorola,cpcap
> > +      - const: st,6556002
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  interrupt-controller: true
> > +
> > +  "#interrupt-cells":
> > +    const: 2
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
>
> There aren't any child nodes with an address. These 2 can be dropped.
>

I will adjust in v6 if there will be need in one.

> > +
> > +  spi-max-frequency:
> > +    maximum: 9600000
> > +
> > +  spi-cs-high: true
> > +  spi-cpol: true
> > +  spi-cpha: true
> > +
> > +  adc:
> > +    $ref: /schemas/iio/adc/motorola,cpcap-adc.yaml#
> > +
> > +  audio-codec:
> > +    type: object
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      interrupts:
> > +        items:
> > +          - description: headset detect interrupt
> > +          - description: microphone bias 2 detect interrupt
> > +
> > +      interrupt-names:
> > +        items:
> > +          - const: hs
> > +          - const: mb2
> > +
> > +      "#sound-dai-cells":
> > +        const: 1
> > +
> > +      VAUDIO-supply:
> > +        description:
> > +          Codec power supply, usually VAUDIO regulator of CPCAP.
> > +
> > +      ports:
> > +        $ref: /schemas/graph.yaml#/properties/ports
> > +
> > +        properties:
> > +          port@0:
> > +            $ref: /schemas/graph.yaml#/properties/port
> > +            description: port connected to the Stereo HiFi DAC
> > +
> > +          port@1:
> > +            $ref: /schemas/graph.yaml#/properties/port
> > +            description: port connected to the Voice DAC
> > +
> > +        required:
> > +          - port@0
> > +          - port@1
> > +
> > +    required:
> > +      - interrupts
> > +      - interrupt-names
> > +      - "#sound-dai-cells"
> > +
> > +  battery:
> > +    $ref: /schemas/power/supply/cpcap-battery.yaml#
> > +
> > +  charger:
> > +    $ref: /schemas/power/supply/cpcap-charger.yaml#
> > +
> > +  key-power:
> > +    $ref: /schemas/input/motorola,cpcap-pwrbutton.yaml#
> > +
> > +  phy:
> > +    $ref: /schemas/phy/motorola,cpcap-usb-phy.yaml#
> > +
> > +  regulator:
> > +    $ref: /schemas/regulator/motorola,cpcap-regulator.yaml#
> > +
> > +  rtc:
> > +    $ref: /schemas/rtc/motorola,cpcap-rtc.yaml#
> > +
> > +patternProperties:
> > +  "^led(-[a-z]+)?$":
> > +    $ref: /schemas/leds/motorola,cpcap-leds.yaml#
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - interrupt-controller
> > +  - "#interrupt-cells"
> > +  - spi-max-frequency
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/input/linux-event-codes.h>
> > +
> > +    spi {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        cpcap: pmic@0 {
> > +            compatible =3D "motorola,cpcap", "st,6556002";
> > +            reg =3D <0>; /* cs0 */
> > +
> > +            interrupt-parent =3D <&gpio1>;
> > +            interrupts =3D <7 IRQ_TYPE_EDGE_RISING>;
> > +
> > +            interrupt-controller;
> > +            #interrupt-cells =3D <2>;
> > +
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            spi-max-frequency =3D <3000000>;
> > +            spi-cs-high;
> > +
> > +            spi-cpol;
> > +            spi-cpha;
> > +
> > +            cpcap_adc: adc {
> > +                compatible =3D "motorola,cpcap-adc";
> > +
> > +                interrupt-parent =3D <&cpcap>;
> > +                interrupts =3D <8 IRQ_TYPE_NONE>;
> > +                interrupt-names =3D "adcdone";
> > +
> > +                #io-channel-cells =3D <1>;
> > +            };
> > +
> > +            cpcap_audio: audio-codec {
> > +                interrupt-parent =3D <&cpcap>;
> > +                interrupts =3D <9 IRQ_TYPE_NONE>, <10 IRQ_TYPE_NONE>;
> > +                interrupt-names =3D "hs", "mb2";
> > +
> > +                VAUDIO-supply =3D <&vdd_audio>;
> > +
> > +                #sound-dai-cells =3D <1>;
> > +
> > +                ports {
> > +                    #address-cells =3D <1>;
> > +                    #size-cells =3D <0>;
> > +
> > +                    /* HiFi */
> > +                    port@0 {
> > +                        reg =3D <0>;
> > +
> > +                        cpcap_audio_codec0: endpoint {
> > +                        };
> > +                    };
> > +
> > +                    /* Voice */
> > +                    port@1 {
> > +                        reg =3D <1>;
> > +
> > +                        cpcap_audio_codec1: endpoint {
> > +                        };
> > +                    };
> > +                };
> > +            };
> > +
> > +            cpcap_battery: battery {
> > +                compatible =3D "motorola,cpcap-battery";
> > +
> > +                interrupt-parent =3D <&cpcap>;
> > +                interrupts =3D <6 IRQ_TYPE_NONE>, <5 IRQ_TYPE_NONE>,
> > +                             <3 IRQ_TYPE_NONE>, <20 IRQ_TYPE_NONE>,
> > +                             <54 IRQ_TYPE_NONE>, <57 IRQ_TYPE_NONE>;
> > +                interrupt-names =3D "eol", "lowbph", "lowbpl",
> > +                                  "chrgcurr1", "battdetb", "cccal";
> > +
> > +                io-channels =3D <&cpcap_adc 0>, <&cpcap_adc 1>,
> > +                              <&cpcap_adc 5>, <&cpcap_adc 6>;
> > +                io-channel-names =3D "battdetb", "battp",
> > +                                   "chg_isense", "batti";
> > +                power-supplies =3D <&cpcap_charger>;
> > +            };
> > +
> > +            cpcap_charger: charger {
> > +                compatible =3D "motorola,mapphone-cpcap-charger";
> > +
> > +                interrupt-parent =3D <&cpcap>;
> > +                interrupts =3D <13 IRQ_TYPE_NONE>, <12 IRQ_TYPE_NONE>,
> > +                             <29 IRQ_TYPE_NONE>, <28 IRQ_TYPE_NONE>,
> > +                             <22 IRQ_TYPE_NONE>, <21 IRQ_TYPE_NONE>,
> > +                             <20 IRQ_TYPE_NONE>, <19 IRQ_TYPE_NONE>,
> > +                             <54 IRQ_TYPE_NONE>;
> > +                interrupt-names =3D "chrg_det", "rvrs_chrg", "chrg_se1=
b",
> > +                                  "se0conn", "rvrs_mode", "chrgcurr2",
> > +                                  "chrgcurr1", "vbusvld", "battdetb";
> > +
> > +                mode-gpios =3D <&gpio3 29 GPIO_ACTIVE_LOW>,
> > +                             <&gpio3 23 GPIO_ACTIVE_LOW>;
> > +
> > +                io-channels =3D <&cpcap_adc 0>, <&cpcap_adc 1>,
> > +                              <&cpcap_adc 2>, <&cpcap_adc 5>,
> > +                              <&cpcap_adc 6>;
> > +                io-channel-names =3D "battdetb", "battp",
> > +                                   "vbus", "chg_isense",
> > +                                   "batti";
> > +            };
> > +
> > +            key-power {
> > +                compatible =3D "motorola,cpcap-pwrbutton";
> > +
> > +                interrupt-parent =3D <&cpcap>;
> > +                interrupts =3D <23 IRQ_TYPE_NONE>;
> > +            };
> > +
> > +            led-red {
> > +                compatible =3D "motorola,cpcap-led-red";
> > +                vdd-supply =3D <&vdd_led>;
> > +                label =3D "status-led::red";
> > +            };
> > +
> > +            led-green {
> > +                compatible =3D "motorola,cpcap-led-green";
> > +                vdd-supply =3D <&vdd_led>;
> > +                label =3D "status-led::green";
> > +            };
> > +
> > +            led-blue {
> > +                compatible =3D "motorola,cpcap-led-blue";
> > +                vdd-supply =3D <&vdd_led>;
> > +                label =3D "status-led::blue";
> > +            };
> > +
> > +            cpcap_usb2_phy: phy {
> > +                compatible =3D "motorola,cpcap-usb-phy";
> > +
> > +                pinctrl-0 =3D <&usb_gpio_mux_sel1>, <&usb_gpio_mux_sel=
2>;
> > +                pinctrl-1 =3D <&usb_ulpi_pins>;
> > +                pinctrl-2 =3D <&usb_utmi_pins>;
> > +                pinctrl-3 =3D <&uart3_pins>;
> > +                pinctrl-names =3D "default", "ulpi", "utmi", "uart";
> > +                #phy-cells =3D <0>;
> > +
> > +                interrupts-extended =3D
> > +                    <&cpcap 15 IRQ_TYPE_NONE>, <&cpcap 14 IRQ_TYPE_NON=
E>,
> > +                    <&cpcap 28 IRQ_TYPE_NONE>, <&cpcap 19 IRQ_TYPE_NON=
E>,
> > +                    <&cpcap 18 IRQ_TYPE_NONE>, <&cpcap 17 IRQ_TYPE_NON=
E>,
> > +                    <&cpcap 16 IRQ_TYPE_NONE>, <&cpcap 49 IRQ_TYPE_NON=
E>,
> > +                    <&cpcap 48 IRQ_TYPE_NONE>;
> > +                interrupt-names =3D "id_ground", "id_float", "se0conn"=
,
> > +                                  "vbusvld", "sessvld", "sessend",
> > +                                  "se1", "dm", "dp";
> > +
> > +                mode-gpios =3D <&gpio2 28 GPIO_ACTIVE_HIGH>,
> > +                             <&gpio1 0 GPIO_ACTIVE_HIGH>;
> > +
> > +                io-channels =3D <&cpcap_adc 2>, <&cpcap_adc 7>;
> > +                io-channel-names =3D "vbus", "id";
> > +
> > +                vusb-supply =3D <&avdd_usb>;
> > +            };
> > +
> > +            regulator {
> > +                compatible =3D "motorola,cpcap-regulator";
> > +
> > +                regulators {
> > +                    vdd_cpu: SW1 {
> > +                        regulator-name =3D "vdd_cpu";
> > +                        regulator-min-microvolt =3D <750000>;
> > +                        regulator-max-microvolt =3D <1125000>;
> > +                        regulator-enable-ramp-delay =3D <1500>;
> > +                        regulator-always-on;
> > +                        regulator-boot-on;
> > +                    };
> > +
> > +                    vdd_core: SW2 {
> > +                        regulator-name =3D "vdd_core";
> > +                        regulator-min-microvolt =3D <950000>;
> > +                        regulator-max-microvolt =3D <1300000>;
> > +                        regulator-enable-ramp-delay =3D <1500>;
> > +                        regulator-always-on;
> > +                        regulator-boot-on;
> > +                    };
> > +
> > +                    vdd_1v8_vio: SW3 {
> > +                        regulator-name =3D "vdd_1v8_vio";
> > +                        regulator-min-microvolt =3D <1800000>;
> > +                        regulator-max-microvolt =3D <1800000>;
> > +                        regulator-enable-ramp-delay =3D <0>;
> > +                        regulator-always-on;
> > +                        regulator-boot-on;
> > +                    };
> > +
> > +                    vdd_aon: SW4 {
> > +                        regulator-name =3D "vdd_aon";
> > +                        regulator-min-microvolt =3D <950000>;
> > +                        regulator-max-microvolt =3D <1300000>;
> > +                        regulator-enable-ramp-delay =3D <1500>;
> > +                        regulator-always-on;
> > +                        regulator-boot-on;
> > +                    };
> > +
> > +                    vdd_led: SW5 {
> > +                        regulator-name =3D "vdd_led";
> > +                        regulator-min-microvolt =3D <5050000>;
> > +                        regulator-max-microvolt =3D <5050000>;
> > +                        regulator-enable-ramp-delay =3D <1500>;
> > +                        regulator-boot-on;
> > +                    };
> > +
> > +                    vdd_hvio: VHVIO {
> > +                        regulator-name =3D "vdd_hvio";
> > +                        regulator-min-microvolt =3D <2775000>;
> > +                        regulator-max-microvolt =3D <2775000>;
> > +                        regulator-enable-ramp-delay =3D <1000>;
> > +                    };
> > +
> > +                    vcore_emmc: VSDIO {
> > +                        regulator-name =3D "vcore_emmc";
> > +                        regulator-min-microvolt =3D <1500000>;
> > +                        regulator-max-microvolt =3D <3000000>;
> > +                        regulator-enable-ramp-delay =3D <1000>;
> > +                        regulator-always-on;
> > +                        regulator-boot-on;
> > +                    };
> > +
> > +                    avdd_dsi_csi: VCSI {
> > +                        regulator-name =3D "avdd_dsi_csi";
> > +                        regulator-min-microvolt =3D <1200000>;
> > +                        regulator-max-microvolt =3D <1200000>;
> > +                        regulator-enable-ramp-delay =3D <1000>;
> > +                        regulator-boot-on;
> > +                    };
> > +
> > +                    avdd_3v3_periph: VWLAN2 {
> > +                        regulator-name =3D "avdd_3v3_periph";
> > +                        regulator-min-microvolt =3D <2775000>;
> > +                        regulator-max-microvolt =3D <3300000>;
> > +                        regulator-enable-ramp-delay =3D <1000>;
> > +                        regulator-boot-on;
> > +                    };
> > +
> > +                    vddio_usd: VSIMCARD {
> > +                        regulator-name =3D "vddio_usd";
> > +                        regulator-min-microvolt =3D <1800000>;
> > +                        regulator-max-microvolt =3D <2900000>;
> > +                        regulator-enable-ramp-delay =3D <1000>;
> > +                        regulator-boot-on;
> > +                    };
> > +
> > +                    vdd_haptic: VVIB {
> > +                        regulator-name =3D "vdd_haptic";
> > +                        regulator-min-microvolt =3D <1300000>;
> > +                        regulator-max-microvolt =3D <3000000>;
> > +                        regulator-enable-ramp-delay =3D <1000>;
> > +                    };
> > +
> > +                    avdd_usb: VUSB {
> > +                        regulator-name =3D "avdd_usb";
> > +                        regulator-min-microvolt =3D <3300000>;
> > +                        regulator-max-microvolt =3D <3300000>;
> > +                        regulator-enable-ramp-delay =3D <1000>;
> > +                        regulator-always-on;
> > +                        regulator-boot-on;
> > +                    };
> > +
> > +                    vdd_audio: VAUDIO {
> > +                        regulator-name =3D "vdd_audio";
> > +                        regulator-min-microvolt =3D <2775000>;
> > +                        regulator-max-microvolt =3D <2775000>;
> > +                        regulator-enable-ramp-delay =3D <1000>;
> > +                        regulator-always-on;
> > +                        regulator-boot-on;
> > +                    };
> > +                };
> > +            };
> > +
> > +            cpcap_rtc: rtc {
> > +                compatible =3D "motorola,cpcap-rtc";
> > +
> > +                interrupt-parent =3D <&cpcap>;
> > +                interrupts =3D <39 IRQ_TYPE_NONE>, <26 IRQ_TYPE_NONE>;
> > +            };
> > +        };
> > +    };
> > +
> > +...
> > diff --git a/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt b=
/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
> > deleted file mode 100644
> > index 18c3fc26ca93..000000000000
> > --- a/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
> > +++ /dev/null
> > @@ -1,78 +0,0 @@
> > -Motorola CPCAP PMIC device tree binding
> > -
> > -Required properties:
> > -- compatible         : One or both of "motorola,cpcap" or "ste,6556002=
"
> > -- reg                        : SPI chip select
> > -- interrupts         : The interrupt line the device is connected to
> > -- interrupt-controller       : Marks the device node as an interrupt c=
ontroller
> > -- #interrupt-cells   : The number of cells to describe an IRQ, should =
be 2
> > -- #address-cells     : Child device offset number of cells, should be =
1
> > -- #size-cells                : Child device size number of cells, shou=
ld be 0
> > -- spi-max-frequency  : Typically set to 3000000
> > -- spi-cs-high                : SPI chip select direction
> > -
> > -Optional subnodes:
> > -
> > -The sub-functions of CPCAP get their own node with their own compatibl=
e values,
> > -which are described in the following files:
> > -
> > -- Documentation/devicetree/bindings/power/supply/cpcap-battery.yaml
> > -- Documentation/devicetree/bindings/power/supply/cpcap-charger.yaml
> > -- Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
> > -- Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml
> > -- Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
> > -- Documentation/devicetree/bindings/rtc/cpcap-rtc.txt
> > -- Documentation/devicetree/bindings/leds/leds-cpcap.txt
> > -- Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml
> > -
> > -The only exception is the audio codec. Instead of a compatible value i=
ts
> > -node must be named "audio-codec".
> > -
> > -Required properties for the audio-codec subnode:
> > -
> > -- #sound-dai-cells =3D <1>;
> > -- interrupts         : should contain jack detection interrupts, with =
headset
> > -                       detect interrupt matching "hs" and microphone b=
ias 2
> > -                       detect interrupt matching "mb2" in interrupt-na=
mes.
> > -- interrupt-names    : Contains "hs", "mb2"
> > -
> > -The audio-codec provides two DAIs. The first one is connected to the
> > -Stereo HiFi DAC and the second one is connected to the Voice DAC.
> > -
> > -Example:
> > -
> > -&mcspi1 {
> > -     cpcap: pmic@0 {
> > -             compatible =3D "motorola,cpcap", "ste,6556002";
> > -             reg =3D <0>;      /* cs0 */
> > -             interrupt-parent =3D <&gpio1>;
> > -             interrupts =3D <7 IRQ_TYPE_EDGE_RISING>;
> > -             interrupt-controller;
> > -             #interrupt-cells =3D <2>;
> > -             #address-cells =3D <1>;
> > -             #size-cells =3D <0>;
> > -             spi-max-frequency =3D <3000000>;
> > -             spi-cs-high;
> > -
> > -             audio-codec {
> > -                     #sound-dai-cells =3D <1>;
> > -                     interrupts-extended =3D <&cpcap 9 0>, <&cpcap 10 =
0>;
> > -                     interrupt-names =3D "hs", "mb2";
> > -
> > -                     /* HiFi */
> > -                     port@0 {
> > -                             endpoint {
> > -                                     remote-endpoint =3D <&cpu_dai1>;
> > -                             };
> > -                     };
> > -
> > -                     /* Voice */
> > -                     port@1 {
> > -                             endpoint {
> > -                                     remote-endpoint =3D <&cpu_dai2>;
> > -                             };
> > -                     };
> > -             };
> > -     };
> > -};
> > -
> > --
> > 2.51.0
> >
