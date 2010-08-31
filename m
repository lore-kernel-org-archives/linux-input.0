From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH 1/5] ARM: pxa27x/pxa3xx: moved pxa27x_keypad.h to platform
 pxa directory
Date: Tue, 31 Aug 2010 12:13:48 +0800
Message-ID: <AANLkTim64nZ_wATk+Mc7LpJ_=z_ESj1UCFzrzbmdbaH9@mail.gmail.com>
References: <1282814339-10934-1-git-send-email-mark.brown314@gmail.com> <1282814339-10934-2-git-send-email-mark.brown314@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59177 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913Ab0HaEOK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Aug 2010 00:14:10 -0400
In-Reply-To: <1282814339-10934-2-git-send-email-mark.brown314@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Mark F. Brown" <mark.brown314@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Thu, Aug 26, 2010 at 5:18 PM, Mark F. Brown <mark.brown314@gmail.com=
> wrote:
> mach-mmp utilizes pxa27x_keypad code so we need to move header to
> platform pxa directory.

Good move. I'm actually very inclined to move this into include/linux/i=
nput/.

And you may try '-M' when generating patches with 'git format-patch', a=
nd
see the difference of the output.

>
> Signed-off-by: Mark F. Brown <mark.brown314@gmail.com>
> ---
> =C2=A0arch/arm/mach-pxa/devices.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-
> =C2=A0arch/arm/mach-pxa/em-x270.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-
> =C2=A0arch/arm/mach-pxa/ezx.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-
> =C2=A0arch/arm/mach-pxa/include/mach/pxa27x_keypad.h | =C2=A0 59 ----=
--------------------
> =C2=A0arch/arm/mach-pxa/littleton.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-
> =C2=A0arch/arm/mach-pxa/mainstone.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A04 +-
> =C2=A0arch/arm/mach-pxa/mioa701.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-
> =C2=A0arch/arm/mach-pxa/palmld.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
> =C2=A0arch/arm/mach-pxa/palmt5.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
> =C2=A0arch/arm/mach-pxa/palmtreo.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
> =C2=A0arch/arm/mach-pxa/palmtx.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
> =C2=A0arch/arm/mach-pxa/palmz72.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-
> =C2=A0arch/arm/mach-pxa/tavorevb.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
> =C2=A0arch/arm/mach-pxa/z2.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
> =C2=A0arch/arm/mach-pxa/zylonite.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
> =C2=A0arch/arm/plat-pxa/include/plat/pxa27x_keypad.h | =C2=A0 59 ++++=
++++++++++++++++++++
> =C2=A0drivers/input/keyboard/pxa27x_keypad.c =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A02 +-
> =C2=A017 files changed, 75 insertions(+), 75 deletions(-)
> =C2=A0delete mode 100644 arch/arm/mach-pxa/include/mach/pxa27x_keypad=
=2Eh
> =C2=A0create mode 100644 arch/arm/plat-pxa/include/plat/pxa27x_keypad=
=2Eh
>
> diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.=
c
> index a2fc859..08b4103 100644
> --- a/arch/arm/mach-pxa/devices.c
> +++ b/arch/arm/mach-pxa/devices.c
> @@ -11,7 +11,7 @@
> =C2=A0#include <mach/mmc.h>
> =C2=A0#include <mach/irda.h>
> =C2=A0#include <mach/ohci.h>
> -#include <mach/pxa27x_keypad.h>
> +#include <plat/pxa27x_keypad.h>
> =C2=A0#include <mach/pxa2xx_spi.h>
> =C2=A0#include <mach/camera.h>
> =C2=A0#include <mach/audio.h>
> diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.=
c
> index 0517c17..51286a7 100644
> --- a/arch/arm/mach-pxa/em-x270.c
> +++ b/arch/arm/mach-pxa/em-x270.c
> @@ -43,7 +43,7 @@
> =C2=A0#include <mach/pxafb.h>
> =C2=A0#include <mach/ohci.h>
> =C2=A0#include <mach/mmc.h>
> -#include <mach/pxa27x_keypad.h>
> +#include <plat/pxa27x_keypad.h>
> =C2=A0#include <plat/i2c.h>
> =C2=A0#include <mach/camera.h>
> =C2=A0#include <mach/pxa2xx_spi.h>
> diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
> index 3fe61f4..f997e84 100644
> --- a/arch/arm/mach-pxa/ezx.c
> +++ b/arch/arm/mach-pxa/ezx.c
> @@ -32,7 +32,7 @@
> =C2=A0#include <mach/ohci.h>
> =C2=A0#include <plat/i2c.h>
> =C2=A0#include <mach/hardware.h>
> -#include <mach/pxa27x_keypad.h>
> +#include <plat/pxa27x_keypad.h>
> =C2=A0#include <mach/camera.h>
>
> =C2=A0#include "devices.h"
> diff --git a/arch/arm/mach-pxa/include/mach/pxa27x_keypad.h b/arch/ar=
m/mach-pxa/include/mach/pxa27x_keypad.h
> deleted file mode 100644
> index 7b4eadc..0000000
> --- a/arch/arm/mach-pxa/include/mach/pxa27x_keypad.h
> +++ /dev/null
> @@ -1,59 +0,0 @@
> -#ifndef __ASM_ARCH_PXA27x_KEYPAD_H
> -#define __ASM_ARCH_PXA27x_KEYPAD_H
> -
> -#include <linux/input.h>
> -#include <linux/input/matrix_keypad.h>
> -
> -#define MAX_MATRIX_KEY_ROWS =C2=A0 =C2=A0(8)
> -#define MAX_MATRIX_KEY_COLS =C2=A0 =C2=A0(8)
> -#define MATRIX_ROW_SHIFT =C2=A0 =C2=A0 =C2=A0 (3)
> -#define MAX_DIRECT_KEY_NUM =C2=A0 =C2=A0 (8)
> -
> -/* pxa3xx keypad platform specific parameters
> - *
> - * NOTE:
> - * 1. direct_key_num indicates the number of keys in the direct keyp=
ad
> - * =C2=A0 =C2=A0_plus_ the number of rotary-encoder sensor inputs, =C2=
=A0this can be
> - * =C2=A0 =C2=A0left as 0 if only rotary encoders are enabled, =C2=A0=
the driver will
> - * =C2=A0 =C2=A0automatically calculate this
> - *
> - * 2. direct_key_map is the key code map for the direct keys, if rot=
ary
> - * =C2=A0 =C2=A0encoder(s) are enabled, direct key 0/1(2/3) will be =
ignored
> - *
> - * 3. rotary can be either interpreted as a relative input event (e.=
g.
> - * =C2=A0 =C2=A0REL_WHEEL/REL_HWHEEL) or specific keys (e.g. UP/DOWN=
/LEFT/RIGHT)
> - *
> - * 4. matrix key and direct key will use the same debounce_interval =
by
> - * =C2=A0 =C2=A0default, which should be sufficient in most cases
> - */
> -struct pxa27x_keypad_platform_data {
> -
> - =C2=A0 =C2=A0 =C2=A0 /* code map for the matrix keys */
> - =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0matrix_key_rows;
> - =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0matrix_key_cols;
> - =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0*matrix_key_map;
> - =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
matrix_key_map_size;
> -
> - =C2=A0 =C2=A0 =C2=A0 /* direct keys */
> - =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
direct_key_num;
> - =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0direct_key_map[MAX_D=
IRECT_KEY_NUM];
> -
> - =C2=A0 =C2=A0 =C2=A0 /* rotary encoders 0 */
> - =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
enable_rotary0;
> - =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
rotary0_rel_code;
> - =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
rotary0_up_key;
> - =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
rotary0_down_key;
> -
> - =C2=A0 =C2=A0 =C2=A0 /* rotary encoders 1 */
> - =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
enable_rotary1;
> - =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
rotary1_rel_code;
> - =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
rotary1_up_key;
> - =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
rotary1_down_key;
> -
> - =C2=A0 =C2=A0 =C2=A0 /* key debounce interval */
> - =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0debounce_interval;
> -};
> -
> -extern void pxa_set_keypad_info(struct pxa27x_keypad_platform_data *=
info);
> -
> -#endif /* __ASM_ARCH_PXA27x_KEYPAD_H */
> diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/little=
ton.c
> index 83f3236..eb58506 100644
> --- a/arch/arm/mach-pxa/littleton.c
> +++ b/arch/arm/mach-pxa/littleton.c
> @@ -43,7 +43,7 @@
> =C2=A0#include <mach/pxafb.h>
> =C2=A0#include <mach/mmc.h>
> =C2=A0#include <mach/pxa2xx_spi.h>
> -#include <mach/pxa27x_keypad.h>
> +#include <plat/pxa27x_keypad.h>
> =C2=A0#include <mach/littleton.h>
> =C2=A0#include <plat/i2c.h>
> =C2=A0#include <plat/pxa3xx_nand.h>
> diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainst=
one.c
> index c2a8717..126dca1 100644
> --- a/arch/arm/mach-pxa/mainstone.c
> +++ b/arch/arm/mach-pxa/mainstone.c
> @@ -41,7 +41,7 @@
> =C2=A0#include <asm/mach/irq.h>
> =C2=A0#include <asm/mach/flash.h>
>
> -#include <mach/pxa27x.h>
> +#include <plat/pxa27x.h>
> =C2=A0#include <mach/gpio.h>
> =C2=A0#include <mach/mainstone.h>
> =C2=A0#include <mach/audio.h>
> @@ -50,7 +50,7 @@
> =C2=A0#include <mach/mmc.h>
> =C2=A0#include <mach/irda.h>
> =C2=A0#include <mach/ohci.h>
> -#include <mach/pxa27x_keypad.h>
> +#include <plat/pxa27x_keypad.h>
>
> =C2=A0#include "generic.h"
> =C2=A0#include "devices.h"
> diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.=
c
> index dc66942..ffb3f5a 100644
> --- a/arch/arm/mach-pxa/mioa701.c
> +++ b/arch/arm/mach-pxa/mioa701.c
> @@ -45,7 +45,7 @@
>
> =C2=A0#include <mach/pxa27x.h>
> =C2=A0#include <mach/regs-rtc.h>
> -#include <mach/pxa27x_keypad.h>
> +#include <plat/pxa27x_keypad.h>
> =C2=A0#include <mach/pxafb.h>
> =C2=A0#include <mach/mmc.h>
> =C2=A0#include <mach/udc.h>
> diff --git a/arch/arm/mach-pxa/palmld.c b/arch/arm/mach-pxa/palmld.c
> index 91038ee..3ff0c4a 100644
> --- a/arch/arm/mach-pxa/palmld.c
> +++ b/arch/arm/mach-pxa/palmld.c
> @@ -39,7 +39,7 @@
> =C2=A0#include <mach/mmc.h>
> =C2=A0#include <mach/pxafb.h>
> =C2=A0#include <mach/irda.h>
> -#include <mach/pxa27x_keypad.h>
> +#include <plat/pxa27x_keypad.h>
> =C2=A0#include <mach/palmasoc.h>
> =C2=A0#include <mach/palm27x.h>
>
> diff --git a/arch/arm/mach-pxa/palmt5.c b/arch/arm/mach-pxa/palmt5.c
> index 1c28199..5b9f766 100644
> --- a/arch/arm/mach-pxa/palmt5.c
> +++ b/arch/arm/mach-pxa/palmt5.c
> @@ -39,7 +39,7 @@
> =C2=A0#include <mach/mmc.h>
> =C2=A0#include <mach/pxafb.h>
> =C2=A0#include <mach/irda.h>
> -#include <mach/pxa27x_keypad.h>
> +#include <plat/pxa27x_keypad.h>
> =C2=A0#include <mach/udc.h>
> =C2=A0#include <mach/palmasoc.h>
> =C2=A0#include <mach/palm27x.h>
> diff --git a/arch/arm/mach-pxa/palmtreo.c b/arch/arm/mach-pxa/palmtre=
o.c
> index 52defd5..f685a60 100644
> --- a/arch/arm/mach-pxa/palmtreo.c
> +++ b/arch/arm/mach-pxa/palmtreo.c
> @@ -39,7 +39,7 @@
> =C2=A0#include <mach/mmc.h>
> =C2=A0#include <mach/pxafb.h>
> =C2=A0#include <mach/irda.h>
> -#include <mach/pxa27x_keypad.h>
> +#include <plat/pxa27x_keypad.h>
> =C2=A0#include <mach/udc.h>
> =C2=A0#include <mach/ohci.h>
> =C2=A0#include <mach/pxa2xx-regs.h>
> diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
> index 144dc2b..89a3792 100644
> --- a/arch/arm/mach-pxa/palmtx.c
> +++ b/arch/arm/mach-pxa/palmtx.c
> @@ -43,7 +43,7 @@
> =C2=A0#include <mach/mmc.h>
> =C2=A0#include <mach/pxafb.h>
> =C2=A0#include <mach/irda.h>
> -#include <mach/pxa27x_keypad.h>
> +#include <plat/pxa27x_keypad.h>
> =C2=A0#include <mach/udc.h>
> =C2=A0#include <mach/palmasoc.h>
> =C2=A0#include <mach/palm27x.h>
> diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.=
c
> index 87e4b10..38f4425 100644
> --- a/arch/arm/mach-pxa/palmz72.c
> +++ b/arch/arm/mach-pxa/palmz72.c
> @@ -41,7 +41,7 @@
> =C2=A0#include <mach/mmc.h>
> =C2=A0#include <mach/pxafb.h>
> =C2=A0#include <mach/irda.h>
> -#include <mach/pxa27x_keypad.h>
> +#include <plat/pxa27x_keypad.h>
> =C2=A0#include <mach/udc.h>
> =C2=A0#include <mach/palmasoc.h>
> =C2=A0#include <mach/palm27x.h>
> diff --git a/arch/arm/mach-pxa/tavorevb.c b/arch/arm/mach-pxa/tavorev=
b.c
> index f02dcb5..0f440c9 100644
> --- a/arch/arm/mach-pxa/tavorevb.c
> +++ b/arch/arm/mach-pxa/tavorevb.c
> @@ -25,7 +25,7 @@
>
> =C2=A0#include <mach/pxa930.h>
> =C2=A0#include <mach/pxafb.h>
> -#include <mach/pxa27x_keypad.h>
> +#include <plat/pxa27x_keypad.h>
>
> =C2=A0#include "devices.h"
> =C2=A0#include "generic.h"
> diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
> index f0d0228..8c44bc4 100644
> --- a/arch/arm/mach-pxa/z2.c
> +++ b/arch/arm/mach-pxa/z2.c
> @@ -37,7 +37,7 @@
> =C2=A0#include <mach/z2.h>
> =C2=A0#include <mach/pxafb.h>
> =C2=A0#include <mach/mmc.h>
> -#include <mach/pxa27x_keypad.h>
> +#include <plat/pxa27x_keypad.h>
> =C2=A0#include <mach/pxa2xx_spi.h>
>
> =C2=A0#include <plat/i2c.h>
> diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonit=
e.c
> index 2edad61..69df3ed 100644
> --- a/arch/arm/mach-pxa/zylonite.c
> +++ b/arch/arm/mach-pxa/zylonite.c
> @@ -30,7 +30,7 @@
> =C2=A0#include <mach/zylonite.h>
> =C2=A0#include <mach/mmc.h>
> =C2=A0#include <mach/ohci.h>
> -#include <mach/pxa27x_keypad.h>
> +#include <plat/pxa27x_keypad.h>
> =C2=A0#include <plat/pxa3xx_nand.h>
>
> =C2=A0#include "devices.h"
> diff --git a/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h b/arch/ar=
m/plat-pxa/include/plat/pxa27x_keypad.h
> new file mode 100644
> index 0000000..7b4eadc
> --- /dev/null
> +++ b/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
> @@ -0,0 +1,59 @@
> +#ifndef __ASM_ARCH_PXA27x_KEYPAD_H
> +#define __ASM_ARCH_PXA27x_KEYPAD_H
> +
> +#include <linux/input.h>
> +#include <linux/input/matrix_keypad.h>
> +
> +#define MAX_MATRIX_KEY_ROWS =C2=A0 =C2=A0(8)
> +#define MAX_MATRIX_KEY_COLS =C2=A0 =C2=A0(8)
> +#define MATRIX_ROW_SHIFT =C2=A0 =C2=A0 =C2=A0 (3)
> +#define MAX_DIRECT_KEY_NUM =C2=A0 =C2=A0 (8)
> +
> +/* pxa3xx keypad platform specific parameters
> + *
> + * NOTE:
> + * 1. direct_key_num indicates the number of keys in the direct keyp=
ad
> + * =C2=A0 =C2=A0_plus_ the number of rotary-encoder sensor inputs, =C2=
=A0this can be
> + * =C2=A0 =C2=A0left as 0 if only rotary encoders are enabled, =C2=A0=
the driver will
> + * =C2=A0 =C2=A0automatically calculate this
> + *
> + * 2. direct_key_map is the key code map for the direct keys, if rot=
ary
> + * =C2=A0 =C2=A0encoder(s) are enabled, direct key 0/1(2/3) will be =
ignored
> + *
> + * 3. rotary can be either interpreted as a relative input event (e.=
g.
> + * =C2=A0 =C2=A0REL_WHEEL/REL_HWHEEL) or specific keys (e.g. UP/DOWN=
/LEFT/RIGHT)
> + *
> + * 4. matrix key and direct key will use the same debounce_interval =
by
> + * =C2=A0 =C2=A0default, which should be sufficient in most cases
> + */
> +struct pxa27x_keypad_platform_data {
> +
> + =C2=A0 =C2=A0 =C2=A0 /* code map for the matrix keys */
> + =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0matrix_key_rows;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0matrix_key_cols;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0*matrix_key_map;
> + =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
matrix_key_map_size;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* direct keys */
> + =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
direct_key_num;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0direct_key_map[MAX_D=
IRECT_KEY_NUM];
> +
> + =C2=A0 =C2=A0 =C2=A0 /* rotary encoders 0 */
> + =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
enable_rotary0;
> + =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
rotary0_rel_code;
> + =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
rotary0_up_key;
> + =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
rotary0_down_key;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* rotary encoders 1 */
> + =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
enable_rotary1;
> + =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
rotary1_rel_code;
> + =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
rotary1_up_key;
> + =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
rotary1_down_key;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* key debounce interval */
> + =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0debounce_interval;
> +};
> +
> +extern void pxa_set_keypad_info(struct pxa27x_keypad_platform_data *=
info);
> +
> +#endif /* __ASM_ARCH_PXA27x_KEYPAD_H */
> diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/k=
eyboard/pxa27x_keypad.c
> index 0e53b3b..0610d10 100644
> --- a/drivers/input/keyboard/pxa27x_keypad.c
> +++ b/drivers/input/keyboard/pxa27x_keypad.c
> @@ -32,7 +32,7 @@
> =C2=A0#include <asm/mach/map.h>
>
> =C2=A0#include <mach/hardware.h>
> -#include <mach/pxa27x_keypad.h>
> +#include <plat/pxa27x_keypad.h>
> =C2=A0/*
> =C2=A0* Keypad Controller registers
> =C2=A0*/
> --
> 1.7.0.4
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
