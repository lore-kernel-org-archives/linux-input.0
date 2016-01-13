From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND 2/2] Input: Documentation and MAINTAINERS parts.
Date: Tue, 12 Jan 2016 22:47:08 -0800
Message-ID: <CAKdAkRQyU0jtUP3AAwKTu+-ncPfwBj6uRYmyudTCzcGf8dTFbg@mail.gmail.com>
References: <1452664315-28078-1-git-send-email-mika.penttila@nextfour.com>
	<1452664315-28078-5-git-send-email-mika.penttila@nextfour.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f194.google.com ([209.85.214.194]:36209 "EHLO
	mail-ob0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbcAMGrI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jan 2016 01:47:08 -0500
Received: by mail-ob0-f194.google.com with SMTP id is5so6208770obc.3
        for <linux-input@vger.kernel.org>; Tue, 12 Jan 2016 22:47:08 -0800 (PST)
In-Reply-To: <1452664315-28078-5-git-send-email-mika.penttila@nextfour.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: mika.penttila@nextfour.com
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, =?UTF-8?B?5pu+5am36JGzICh0YW1teV90c2VuZyk=?= <tammy_tseng@sis.com>, =?UTF-8?B?5ri45pOx6LGqICh5dWdlcl95dSk=?= <yuger_yu@sis.com>

Hi Mika,

On Tue, Jan 12, 2016 at 9:51 PM,  <mika.penttila@nextfour.com> wrote:
> From: Mika Penttil=C3=A4 <mika.penttila@nextfour.com>
>
> ---
>  .../bindings/input/touchscreen/sis_i2c.txt         | 22 ++++++++++++=
++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>  MAINTAINERS                                        |  7 +++++++
>  3 files changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscre=
en/sis_i2c.txt
>
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/sis_=
i2c.txt b/Documentation/devicetree/bindings/input/touchscreen/sis_i2c.t=
xt
> new file mode 100644
> index 0000000..b0e9980
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/sis_i2c.txt
> @@ -0,0 +1,22 @@
> +* SiS I2C Multiple Touch Controller
> +
> +Required properties:
> +- compatible: must be "sis,9200_ts"
> +- reg: i2c slave address
> +- interrupt-parent: the phandle for the interrupt controller
> +- interrupts: touch controller interrupt
> +- irq-gpios: the gpio pin used as irq pin
> +- reset-gpios: the gpio pin used to reset the controller
> +
> +Example:
> +
> +       sis9255@5c  {
> +                compatible =3D "sis,9200_ts";
> +                reg =3D <0x5c>;
> +                pinctrl-names =3D "default";
> +                pinctrl-0 =3D <&pinctrl_sis>;
> +                interrupt-parent =3D <&gpio3>;
> +                interrupts =3D <19 2>;
> +                irq-gpios =3D <&gpio3 19 0>;
> +                reset-gpios =3D <&gpio2 30 0>;
> +       };
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/=
Documentation/devicetree/bindings/vendor-prefixes.txt
> index 55df1d4..a6ed5f9 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -207,6 +207,7 @@ simtek
>  sii    Seiko Instruments, Inc.
>  silergy        Silergy Corp.
>  sirf   SiRF Technology, Inc.
> +sis    Silicon Integrated Systems Corp.
>  sitronix       Sitronix Technology Corporation
>  skyworks       Skyworks Solutions, Inc.
>  smsc   Standard Microsystems Corporation
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 233f834..fbf9470 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9809,6 +9809,13 @@ L:       netdev@vger.kernel.org
>  S:     Maintained
>  F:     drivers/net/ethernet/sis/sis900.*
>
> +SIS 9200 I2C TOUCHSCREEN DRIVER
> +M:     Mika Penttil=C3=A4 <mika.penttila@nextfour.com>
> +L:     linux-input@vger.kernel.org
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/input/touchscreen/sis_i2c.t=
xt
> +F:     drivers/input/touchscreen/sis_i2c.c

I have seen (and reviewed) the driver for the same part posted by SIS
folks, are you working with them?

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
