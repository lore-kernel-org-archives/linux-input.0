From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v2 1/6] ARM: pxa27x/pxa3xx: moved pxa27x_keypad.h to platform pxa directory
Date: Sat, 4 Sep 2010 04:11:28 +0200
Message-ID: <201009040411.28325.marek.vasut@gmail.com>
References: <1282836457-5651-1-git-send-email-mark.brown314@gmail.com> <1282836457-5651-2-git-send-email-mark.brown314@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45613 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783Ab0IDCMa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Sep 2010 22:12:30 -0400
In-Reply-To: <1282836457-5651-2-git-send-email-mark.brown314@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Mark F. Brown" <mark.brown314@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Dne =C4=8Ct 26. srpna 2010 17:27:32 Mark F. Brown napsal(a):
> mach-mmp utilizes pxa27x_keypad code so we need to move header to
> platform pxa directory.
>=20
Hey, so what's so V2-ish on this one? Isn't this just a resubmission ?

Cheers
> Signed-off-by: Mark F. Brown <mark.brown314@gmail.com>
> ---
>  arch/arm/mach-pxa/devices.c                        |    2 +-
>  arch/arm/mach-pxa/em-x270.c                        |    2 +-
>  arch/arm/mach-pxa/ezx.c                            |    2 +-
>  arch/arm/mach-pxa/littleton.c                      |    2 +-
>  arch/arm/mach-pxa/mainstone.c                      |    4 ++--
>  arch/arm/mach-pxa/mioa701.c                        |    2 +-
>  arch/arm/mach-pxa/palmld.c                         |    2 +-
>  arch/arm/mach-pxa/palmt5.c                         |    2 +-
>  arch/arm/mach-pxa/palmtreo.c                       |    2 +-
>  arch/arm/mach-pxa/palmtx.c                         |    2 +-
>  arch/arm/mach-pxa/palmz72.c                        |    2 +-
>  arch/arm/mach-pxa/tavorevb.c                       |    2 +-
>  arch/arm/mach-pxa/z2.c                             |    2 +-
>  arch/arm/mach-pxa/zylonite.c                       |    2 +-
>  .../mach =3D> plat-pxa/include/plat}/pxa27x_keypad.h |    0
>  drivers/input/keyboard/pxa27x_keypad.c             |    2 +-
>  16 files changed, 16 insertions(+), 16 deletions(-)
>  rename arch/arm/{mach-pxa/include/mach =3D>
> plat-pxa/include/plat}/pxa27x_keypad.h (100%)
>=20
> diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.=
c
> index a2fc859..08b4103 100644
> --- a/arch/arm/mach-pxa/devices.c
> +++ b/arch/arm/mach-pxa/devices.c
> @@ -11,7 +11,7 @@
>  #include <mach/mmc.h>
>  #include <mach/irda.h>
>  #include <mach/ohci.h>
> -#include <mach/pxa27x_keypad.h>
> +#include <plat/pxa27x_keypad.h>
>  #include <mach/pxa2xx_spi.h>
>  #include <mach/camera.h>
>  #include <mach/audio.h>
> diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.=
c
> index 0517c17..51286a7 100644
> --- a/arch/arm/mach-pxa/em-x270.c
> +++ b/arch/arm/mach-pxa/em-x270.c
> @@ -43,7 +43,7 @@
>  #include <mach/pxafb.h>
>  #include <mach/ohci.h>
>  #include <mach/mmc.h>
> -#include <mach/pxa27x_keypad.h>
> +#include <plat/pxa27x_keypad.h>
>  #include <plat/i2c.h>
>  #include <mach/camera.h>
>  #include <mach/pxa2xx_spi.h>
> diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
> index 3fe61f4..f997e84 100644
> --- a/arch/arm/mach-pxa/ezx.c
> +++ b/arch/arm/mach-pxa/ezx.c
> @@ -32,7 +32,7 @@
>  #include <mach/ohci.h>
>  #include <plat/i2c.h>
>  #include <mach/hardware.h>
> -#include <mach/pxa27x_keypad.h>
> +#include <plat/pxa27x_keypad.h>
>  #include <mach/camera.h>
>=20
>  #include "devices.h"
> diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/little=
ton.c
> index 83f3236..eb58506 100644
> --- a/arch/arm/mach-pxa/littleton.c
> +++ b/arch/arm/mach-pxa/littleton.c
> @@ -43,7 +43,7 @@
>  #include <mach/pxafb.h>
>  #include <mach/mmc.h>
>  #include <mach/pxa2xx_spi.h>
> -#include <mach/pxa27x_keypad.h>
> +#include <plat/pxa27x_keypad.h>
>  #include <mach/littleton.h>
>  #include <plat/i2c.h>
>  #include <plat/pxa3xx_nand.h>
> diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainst=
one.c
> index c2a8717..126dca1 100644
> --- a/arch/arm/mach-pxa/mainstone.c
> +++ b/arch/arm/mach-pxa/mainstone.c
> @@ -41,7 +41,7 @@
>  #include <asm/mach/irq.h>
>  #include <asm/mach/flash.h>
>=20
> -#include <mach/pxa27x.h>
> +#include <plat/pxa27x.h>
>  #include <mach/gpio.h>
>  #include <mach/mainstone.h>
>  #include <mach/audio.h>
> @@ -50,7 +50,7 @@
>  #include <mach/mmc.h>
>  #include <mach/irda.h>
>  #include <mach/ohci.h>
> -#include <mach/pxa27x_keypad.h>
> +#include <plat/pxa27x_keypad.h>
>=20
>  #include "generic.h"
>  #include "devices.h"
> diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.=
c
> index dc66942..ffb3f5a 100644
> --- a/arch/arm/mach-pxa/mioa701.c
> +++ b/arch/arm/mach-pxa/mioa701.c
> @@ -45,7 +45,7 @@
>=20
>  #include <mach/pxa27x.h>
>  #include <mach/regs-rtc.h>
> -#include <mach/pxa27x_keypad.h>
> +#include <plat/pxa27x_keypad.h>
>  #include <mach/pxafb.h>
>  #include <mach/mmc.h>
>  #include <mach/udc.h>
> diff --git a/arch/arm/mach-pxa/palmld.c b/arch/arm/mach-pxa/palmld.c
> index 91038ee..3ff0c4a 100644
> --- a/arch/arm/mach-pxa/palmld.c
> +++ b/arch/arm/mach-pxa/palmld.c
> @@ -39,7 +39,7 @@
>  #include <mach/mmc.h>
>  #include <mach/pxafb.h>
>  #include <mach/irda.h>
> -#include <mach/pxa27x_keypad.h>
> +#include <plat/pxa27x_keypad.h>
>  #include <mach/palmasoc.h>
>  #include <mach/palm27x.h>
>=20
> diff --git a/arch/arm/mach-pxa/palmt5.c b/arch/arm/mach-pxa/palmt5.c
> index 1c28199..5b9f766 100644
> --- a/arch/arm/mach-pxa/palmt5.c
> +++ b/arch/arm/mach-pxa/palmt5.c
> @@ -39,7 +39,7 @@
>  #include <mach/mmc.h>
>  #include <mach/pxafb.h>
>  #include <mach/irda.h>
> -#include <mach/pxa27x_keypad.h>
> +#include <plat/pxa27x_keypad.h>
>  #include <mach/udc.h>
>  #include <mach/palmasoc.h>
>  #include <mach/palm27x.h>
> diff --git a/arch/arm/mach-pxa/palmtreo.c b/arch/arm/mach-pxa/palmtre=
o.c
> index 52defd5..f685a60 100644
> --- a/arch/arm/mach-pxa/palmtreo.c
> +++ b/arch/arm/mach-pxa/palmtreo.c
> @@ -39,7 +39,7 @@
>  #include <mach/mmc.h>
>  #include <mach/pxafb.h>
>  #include <mach/irda.h>
> -#include <mach/pxa27x_keypad.h>
> +#include <plat/pxa27x_keypad.h>
>  #include <mach/udc.h>
>  #include <mach/ohci.h>
>  #include <mach/pxa2xx-regs.h>
> diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
> index 144dc2b..89a3792 100644
> --- a/arch/arm/mach-pxa/palmtx.c
> +++ b/arch/arm/mach-pxa/palmtx.c
> @@ -43,7 +43,7 @@
>  #include <mach/mmc.h>
>  #include <mach/pxafb.h>
>  #include <mach/irda.h>
> -#include <mach/pxa27x_keypad.h>
> +#include <plat/pxa27x_keypad.h>
>  #include <mach/udc.h>
>  #include <mach/palmasoc.h>
>  #include <mach/palm27x.h>
> diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.=
c
> index 87e4b10..38f4425 100644
> --- a/arch/arm/mach-pxa/palmz72.c
> +++ b/arch/arm/mach-pxa/palmz72.c
> @@ -41,7 +41,7 @@
>  #include <mach/mmc.h>
>  #include <mach/pxafb.h>
>  #include <mach/irda.h>
> -#include <mach/pxa27x_keypad.h>
> +#include <plat/pxa27x_keypad.h>
>  #include <mach/udc.h>
>  #include <mach/palmasoc.h>
>  #include <mach/palm27x.h>
> diff --git a/arch/arm/mach-pxa/tavorevb.c b/arch/arm/mach-pxa/tavorev=
b.c
> index f02dcb5..0f440c9 100644
> --- a/arch/arm/mach-pxa/tavorevb.c
> +++ b/arch/arm/mach-pxa/tavorevb.c
> @@ -25,7 +25,7 @@
>=20
>  #include <mach/pxa930.h>
>  #include <mach/pxafb.h>
> -#include <mach/pxa27x_keypad.h>
> +#include <plat/pxa27x_keypad.h>
>=20
>  #include "devices.h"
>  #include "generic.h"
> diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
> index f0d0228..8c44bc4 100644
> --- a/arch/arm/mach-pxa/z2.c
> +++ b/arch/arm/mach-pxa/z2.c
> @@ -37,7 +37,7 @@
>  #include <mach/z2.h>
>  #include <mach/pxafb.h>
>  #include <mach/mmc.h>
> -#include <mach/pxa27x_keypad.h>
> +#include <plat/pxa27x_keypad.h>
>  #include <mach/pxa2xx_spi.h>
>=20
>  #include <plat/i2c.h>
> diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonit=
e.c
> index 2edad61..69df3ed 100644
> --- a/arch/arm/mach-pxa/zylonite.c
> +++ b/arch/arm/mach-pxa/zylonite.c
> @@ -30,7 +30,7 @@
>  #include <mach/zylonite.h>
>  #include <mach/mmc.h>
>  #include <mach/ohci.h>
> -#include <mach/pxa27x_keypad.h>
> +#include <plat/pxa27x_keypad.h>
>  #include <plat/pxa3xx_nand.h>
>=20
>  #include "devices.h"
> diff --git a/arch/arm/mach-pxa/include/mach/pxa27x_keypad.h
> b/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h similarity index 100=
%
> rename from arch/arm/mach-pxa/include/mach/pxa27x_keypad.h
> rename to arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
> diff --git a/drivers/input/keyboard/pxa27x_keypad.c
> b/drivers/input/keyboard/pxa27x_keypad.c index 0e53b3b..0610d10 10064=
4
> --- a/drivers/input/keyboard/pxa27x_keypad.c
> +++ b/drivers/input/keyboard/pxa27x_keypad.c
> @@ -32,7 +32,7 @@
>  #include <asm/mach/map.h>
>=20
>  #include <mach/hardware.h>
> -#include <mach/pxa27x_keypad.h>
> +#include <plat/pxa27x_keypad.h>
>  /*
>   * Keypad Controller registers
>   */
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
