From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Input: q40kbd - convert driver to the split model
Date: Sun, 22 Jan 2012 12:16:40 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1201221214160.28391@ayla.of.borg>
References: <20111231010814.7392.52389.stgit@hammer.corenet.prv> <CAMuHMdV+FFPG8TVA7NwfpCvA3+FrVixE4bfdOu8a_1=xTaKiRg@mail.gmail.com> <20120111081118.GC18668@core.coreip.homeip.net> <CAMuHMdXfs2ru7KG-xFRoKPso5Y+UuAnOOUie8HoOZHYyoVeyaA@mail.gmail.com>
 <20120111173051.GB21047@core.coreip.homeip.net> <20120118092548.GD32285@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <20120118092548.GD32285@core.coreip.homeip.net>
Sender: linux-m68k-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-m68k@lists.linux-m68k.org
List-Id: linux-input@vger.kernel.org

On Wed, 18 Jan 2012, Dmitry Torokhov wrote:
> Input: q40kbd - convert driver to the split model
>=20
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>=20
> Convert the driver to standard spilt model arch-specific code registe=
rs
> platform device to which driver code can bind later.
>=20
> Also request IRQ immediately upon binding to the device instead of do=
ing
> this when serio port is being opened.
>=20
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>=20
>  arch/m68k/q40/config.c       |    7 ++
>  drivers/input/serio/q40kbd.c |  139 ++++++++++++++++++++++++--------=
----------
>  2 files changed, 86 insertions(+), 60 deletions(-)
>=20
>=20
> diff --git a/arch/m68k/q40/config.c b/arch/m68k/q40/config.c
> index ad10fec..c72a3ed 100644
> --- a/arch/m68k/q40/config.c
> +++ b/arch/m68k/q40/config.c
> @@ -24,6 +24,7 @@
>  #include <linux/rtc.h>
>  #include <linux/vt_kern.h>
>  #include <linux/bcd.h>
> +#include <linux/platform_device.h>
> =20
>  #include <asm/io.h>
>  #include <asm/rtc.h>
> @@ -329,3 +330,9 @@ static int q40_set_rtc_pll(struct rtc_pll_info *p=
ll)
>  	} else
>  		return -EINVAL;
>  }
> +
> +static __init int q40_add_kbd_device(void)
> +{
> +	return platform_device_register_simple("q40kbd", -1, NULL, 0);

arch/m68k/q40/config.c: In function =A1q40_add_kbd_device=A2:
arch/m68k/q40/config.c:336: warning: return makes integer from pointer =
without a cast

Either ignore the error and always return 0, or:

diff --git a/arch/m68k/q40/config.c b/arch/m68k/q40/config.c
index c72a3ed..be93648 100644
--- a/arch/m68k/q40/config.c
+++ b/arch/m68k/q40/config.c
@@ -333,6 +333,12 @@ static int q40_set_rtc_pll(struct rtc_pll_info *pl=
l)
=20
 static __init int q40_add_kbd_device(void)
 {
-	return platform_device_register_simple("q40kbd", -1, NULL, 0);
+	struct platform_device *pdev;
+
+	pdev =3D platform_device_register_simple("q40kbd", -1, NULL, 0);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	return 0;
 }
 arch_initcall(q40_add_kbd_device);

The rest is
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
							    -- Linus Torvalds
