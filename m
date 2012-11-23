From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 5/5] Documentation: Describe bindings for STMPE Keypad
 driver
Date: Fri, 23 Nov 2012 15:54:21 +0000
Message-ID: <20121123155421.GG28552@gmail.com>
References: <1352900837-20759-1-git-send-email-lee.jones@linaro.org>
 <1352900837-20759-6-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46581 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631Ab2KWPy0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Nov 2012 10:54:26 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so3936931bkw.19
        for <linux-input@vger.kernel.org>; Fri, 23 Nov 2012 07:54:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1352900837-20759-6-git-send-email-lee.jones@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Wed, 14 Nov 2012, Lee Jones wrote:

> Here we add the required documentation for the STMPE Device
> Tree bindings. It describes all of the bindings currently
> supported by the driver.
>=20
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  .../devicetree/bindings/input/stmpe-keypad.txt     |   39 ++++++++++=
++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/stmpe-key=
pad.txt
>=20
> diff --git a/Documentation/devicetree/bindings/input/stmpe-keypad.txt=
 b/Documentation/devicetree/bindings/input/stmpe-keypad.txt
> new file mode 100644
> index 0000000..1b97222
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/stmpe-keypad.txt
> @@ -0,0 +1,39 @@
> +* STMPE Keypad
> +
> +Required properties:
> + - compatible               : "st,stmpe-keypad"
> + - linux,keymap             : See ./matrix-keymap.txt
> +
> +Optional properties:
> + - debounce-interval        : Debouncing interval time in millisecon=
ds
> + - st,scan-count            : Scanning cycles elapsed before key dat=
a is updated
> + - st,no-autorepeat         : If specified device will not autorepea=
t
> +
> +Example:
> +
> +	stmpe_keypad {
> +		compatible =3D "st,stmpe-keypad";
> +
> +		debounce-interval =3D <64>;
> +		st,scan-count =3D <8>;
> +		st,no-autorepeat;
> +
> +		linux,keymap =3D <0x205006b
> +				0x4010074
> +				0x3050072
> +				0x1030004
> +				0x502006a
> +				0x500000a
> +				0x5008b
> +				0x706001c
> +				0x405000b
> +				0x6070003
> +				0x3040067
> +				0x303006c
> +				0x60400e7
> +				0x602009e
> +				0x4020073
> +				0x5050002
> +				0x4030069
> +				0x3020008>;
> +	};
> --=20
> 1.7.9.5
>=20

Last one.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
