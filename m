From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: w90p910_ts - depend on ARCH_W90X900
Date: Sat, 19 Apr 2014 22:38:56 -0700
Message-ID: <20140420053856.GF12454@core.coreip.homeip.net>
References: <20140401142046.14d4bb8c@endymion.delvare>
 <CAKT61h__8fuJDs94akU73grWns82+mk1vmSdQw5fwd1Cx-455g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:61065 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932080AbaDTFi7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Apr 2014 01:38:59 -0400
Received: by mail-pd0-f171.google.com with SMTP id r10so2661774pdi.16
        for <linux-input@vger.kernel.org>; Sat, 19 Apr 2014 22:38:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKT61h__8fuJDs94akU73grWns82+mk1vmSdQw5fwd1Cx-455g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: Jean Delvare <jdelvare@suse.de>, linux-input@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Tue, Apr 01, 2014 at 09:17:03PM +0800, Wan ZongShun wrote:
> ---------- Forwarded message ----------
> From: Jean Delvare <jdelvare@suse.de>
> Date: 2014-04-01 20:20 GMT+08:00
> Subject: [PATCH] Input: w90p910_ts - depend on ARCH_W90X900
> To: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
> =E6=8A=84=E9=80=81=EF=BC=9A Wan ZongShun <mcuos.com@gmail.com>, Dmitr=
y Torokhov
> <dmitry.torokhov@gmail.com>
>=20
>=20
> The w90p910_ts touchscreen driver is heavily architecture dependent,
> so there is no point in letting it be built on other architectures
> than it was written for.
>=20
> All other W90P910/W90X900 drivers already have that dependency, so it
> makes things more consistent and configuration easier.
>=20
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Wan ZongShun <mcuos.com@gmail.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> --- linux-3.14-rc8.orig/drivers/input/touchscreen/Kconfig
> 2014-02-09 16:53:02.945634113 +0100
> +++ linux-3.14-rc8/drivers/input/touchscreen/Kconfig    2014-04-01
> 14:10:08.936933702 +0200
> @@ -867,7 +867,7 @@ config TOUCHSCREEN_TSC2007
>=20
>  config TOUCHSCREEN_W90X900
>         tristate "W90P910 touchscreen driver"
> -       depends on HAVE_CLK
> +       depends on ARCH_W90X900
>         help
>           Say Y here if you have a W90P910 based touchscreen.
>=20
> Sure, your idea is reasonable.
>=20
> Acked-by Wan Zongshun <mcuos.com@gmail.com>

Applied, thank you.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
