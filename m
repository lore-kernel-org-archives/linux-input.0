From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/3 RESEND] mfd: tc3589x: Reform device tree probing
Date: Mon, 3 Feb 2014 11:01:16 +0000
Message-ID: <20140203110116.GU13529@lee--X1>
References: <1390481008-23900-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:39420 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301AbaBCLBW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Feb 2014 06:01:22 -0500
Received: by mail-wg0-f53.google.com with SMTP id y10so11729923wgg.20
        for <linux-input@vger.kernel.org>; Mon, 03 Feb 2014 03:01:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1390481008-23900-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: devicetree@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>

> This changes the following mechanisms in the TC3589x device tree
> probing path:
>=20
> - Use the .of_match_table in struct device_driver to match the
>   device in the device tree.
> - Add matches for the proper compatible strings "toshiba,..."
>   and all sub-variants, just as is done for the .id matches.
> - Move over all the allocation of platform data etc to the
>   tc3589x_of_probe() function and follow the pattern of passing
>   a platform data pointer back, or an error pointer on error,
>   as found in the STMPE driver.
> - Match the new (proper) compatible strings for the GPIO and
>   keypad MFD cells.
> - Use of_device_is_compatible() rather than just !strcmp()
>   to discover which cells to instantiate.
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mfd/tc3589x.c | 84 ++++++++++++++++++++++++++++++++++++-----=
----------
>  1 file changed, 59 insertions(+), 25 deletions(-)

Looks good, applied.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
