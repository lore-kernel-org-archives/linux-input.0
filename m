From: Pali =?UTF-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: byd - use DMI detection
Date: Sat, 12 Nov 2016 13:12:29 +0100
Message-ID: <58270744.cf3fc20a.1e77d.30f0@mx.google.com>
References: <20161111235759.11988-1-chris@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35300 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936990AbcKLMMy (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 12 Nov 2016 07:12:54 -0500
Received: by mail-wm0-f66.google.com with SMTP id a20so2987801wme.2
        for <linux-input@vger.kernel.org>; Sat, 12 Nov 2016 04:12:54 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Diamand <chris@diamand.org>, Richard Pospesel <pospeselr@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On So 12. November 2016 00:57 Chris Diamand wrote:
...
> +static const struct dmi_system_id byd_dmi_table[] = {
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "SharkBay Platform"),
> +			DMI_MATCH(DMI_PRODUCT_SERIAL, "System Serial Number"),
> +			DMI_MATCH(DMI_BOARD_NAME, "WhiteTip Mountain1 Fab2"),
> +			DMI_MATCH(DMI_CHASSIS_VENDOR, "To Be Filled By O.E.M."),
> +		},
> +	},
> +};

Hi! This looks very fragile. We really cannot test presence of some device
by DMI string "To Be Filled By O.E.M." or by "WhiteTip Mountain1 Fab2".
Look at other dmi detection code. We match full device and vendor.

...
> +	if (!dmi_check_system(byd_dmi_table))
> +		return -1;
> +
>  if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
>  return -1;
>  if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
...

If we really have a problem when byd detect incorrect detect some non-byd
device as byd, we either needs:

1) extend detect code to include also parts of init sequence (this should
   fix problem on wrongly detected non-byd devices, but init code on them
   will take longer)

2) or use another detection technique, which will address above problem (
   your "To Be Filled By O.E.M." is not good; maybe looking at ACPI?)

- -- 
Pali Rohár
pali.rohar@gmail.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlgnBy0ACgkQi/DJPQPkQ1JWmwCffbqKKjwjxVc+y2Gghb9bCcSB
Ae8AoJ8Hn+xP4h3tFqEi2Yna9hpYGYql
=Dvey
-----END PGP SIGNATURE-----
