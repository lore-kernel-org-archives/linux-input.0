From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/3 RESEND] mfd: tc3589x: Reform device tree probing
Date: Thu, 23 Jan 2014 13:31:41 +0000
Message-ID: <20140123133141.GD8586@lee--X1>
References: <1390481008-23900-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:65331 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbaAWNbs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jan 2014 08:31:48 -0500
Received: by mail-we0-f179.google.com with SMTP id w62so1163194wes.10
        for <linux-input@vger.kernel.org>; Thu, 23 Jan 2014 05:31:47 -0800 (PST)
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

Patch looks good to me. Is there any reason why we should rush this in
for v3.14, or is it okay to go to -next?

Acked-by: Lee Jones <lee.jones@linaro.org>

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
