From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 1/2] Add Palm support to Mainstone
	accelerated touch
Date: Fri, 17 Jul 2009 13:10:14 +0200
Message-ID: <200907171310.14935.marek.vasut@gmail.com>
References: <200907171000.24408.marek.vasut@gmail.com>
	<20090717102217.GE3439@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WwFYKLg8MK7WuEN"
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090717102217.GE3439@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-input@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

--Boundary-00=_WwFYKLg8MK7WuEN
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dne P=C3=A1 17. =C4=8Dervence 2009 12:22:18 Mark Brown napsal(a):
> On Fri, Jul 17, 2009 at 10:00:24AM +0200, Marek Vasut wrote:
> > From f32fa9ef6476be0cf8106bc57a98724c48d4baa1 Mon Sep 17 00:00:00 2001
> > From: Marek Vasut <marek.vasut@gmail.com>
> > Date: Fri, 17 Jul 2009 09:54:13 +0200
> > Subject: [PATCH 1/2] Add Palm support to Mainstone accelerated touch
> >
> > This patch refactors the Mainstone accelerated touch code a little and
> > adds support for interrupt driven touchscreen on Palm LifeDrive, TX and
> > Tungsten T5.
> >
> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
>
> The code looks OK but it looks like your mailer has damaged the patch
> rather badly - it appears to be padded with whitespace to 80 columns.
> When you resend for this please just remove the version number from the
> driver, it's not needed now the code is in mainline.
>
> You've also submitted to the wrong subsystem, this patch is for the
> input subsystem so should go to Dmitry and linux-input (CC me).

Ok, sending to linux-input, CC Mark, Dmitry, alsa-devel. Im sending the pat=
ch=20
as an attachment to prevent breakage (sorry, I'll investigate what's wrong=
=20
with KMail or my settings).

--Boundary-00=_WwFYKLg8MK7WuEN
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-Add-Palm-support-to-Mainstone-accelerated-touch.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Add-Palm-support-to-Mainstone-accelerated-touch.patch"

=46rom fded04a841d96814cc50a51a541410ed102bcf1e Mon Sep 17 00:00:00 2001
=46rom: Marek Vasut <marek.vasut@gmail.com>
Date: Fri, 17 Jul 2009 09:54:13 +0200
Subject: [PATCH 1/2] Add Palm support to Mainstone accelerated touch

This patch refactors the Mainstone accelerated touch code a little and
adds support for interrupt driven touchscreen on Palm LifeDrive, TX and
Tungsten T5.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
=2D--
 drivers/input/touchscreen/Kconfig            |    4 +-
 drivers/input/touchscreen/mainstone-wm97xx.c |   50 +++++++++++++++++-----=
=2D---
 2 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/=
Kconfig
index 72e2712..0fdae1a 100644
=2D-- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -366,11 +366,11 @@ config TOUCHSCREEN_WM97XX_ATMEL
 	  be called atmel-wm97xx.
=20
 config TOUCHSCREEN_WM97XX_MAINSTONE
=2D	tristate "WM97xx Mainstone accelerated touch"
+	tristate "WM97xx Mainstone/Palm accelerated touch"
 	depends on TOUCHSCREEN_WM97XX && ARCH_PXA
 	help
 	  Say Y here for support for streaming mode with WM97xx touchscreens
=2D	  on Mainstone systems.
+	  on Mainstone, Palm Tungsten T5, TX and LifeDrive systems.
=20
 	  If unsure, say N.
=20
diff --git a/drivers/input/touchscreen/mainstone-wm97xx.c b/drivers/input/t=
ouchscreen/mainstone-wm97xx.c
index 4cc047a..de02f87 100644
=2D-- a/drivers/input/touchscreen/mainstone-wm97xx.c
+++ b/drivers/input/touchscreen/mainstone-wm97xx.c
@@ -31,9 +31,11 @@
 #include <linux/interrupt.h>
 #include <linux/wm97xx.h>
 #include <linux/io.h>
+#include <linux/gpio.h>
+
 #include <mach/regs-ac97.h>
=20
=2D#define VERSION		"0.13"
+#include <asm/mach-types.h>
=20
 struct continuous {
 	u16 id;    /* codec id */
@@ -62,6 +64,7 @@ static const struct continuous cinfo[] =3D {
 /* continuous speed index */
 static int sp_idx;
 static u16 last, tries;
+static int irq;
=20
 /*
  * Pen sampling frequency (Hz) in continuous mode.
@@ -171,7 +174,7 @@ up:
=20
 static int wm97xx_acc_startup(struct wm97xx *wm)
 {
=2D	int idx =3D 0;
+	int idx =3D 0, ret =3D 0;
=20
 	/* check we have a codec */
 	if (wm->ac97 =3D=3D NULL)
@@ -191,18 +194,37 @@ static int wm97xx_acc_startup(struct wm97xx *wm)
 		 "mainstone accelerated touchscreen driver, %d samples/sec\n",
 		 cinfo[sp_idx].speed);
=20
+	/* IRQ driven touchscreen is used on Palm hardware */
+	if (machine_is_palmt5() || machine_is_palmtx() || machine_is_palmld()) {
+		pen_int =3D 1;
+		irq =3D 27;
+	} else if (machine_is_mainstone() && pen_int)
+		irq =3D 4;
+
+	if (irq) {
+		ret =3D gpio_request(irq, "Touchscreen IRQ");
+		if (ret)
+			goto out;
+
+		ret =3D gpio_direction_input(irq);
+		if (ret) {
+			gpio_free(irq);
+			goto out;
+		}
+
+		wm->pen_irq =3D gpio_to_irq(irq);
+		set_irq_type(wm->pen_irq, IRQ_TYPE_EDGE_BOTH);
+	} else	/* pen irq not supported */
+		pen_int =3D 0;
+
 	/* codec specific irq config */
 	if (pen_int) {
 		switch (wm->id) {
 		case WM9705_ID2:
=2D			wm->pen_irq =3D IRQ_GPIO(4);
=2D			set_irq_type(IRQ_GPIO(4), IRQ_TYPE_EDGE_BOTH);
 			break;
 		case WM9712_ID2:
 		case WM9713_ID2:
=2D			/* enable pen down interrupt */
 			/* use PEN_DOWN GPIO 13 to assert IRQ on GPIO line 2 */
=2D			wm->pen_irq =3D MAINSTONE_AC97_IRQ;
 			wm97xx_config_gpio(wm, WM97XX_GPIO_13, WM97XX_GPIO_IN,
 					   WM97XX_GPIO_POL_HIGH,
 					   WM97XX_GPIO_STICKY,
@@ -220,23 +242,17 @@ static int wm97xx_acc_startup(struct wm97xx *wm)
 		}
 	}
=20
=2D	return 0;
+out:
+	return ret;
 }
=20
 static void wm97xx_acc_shutdown(struct wm97xx *wm)
 {
 	/* codec specific deconfig */
 	if (pen_int) {
=2D		switch (wm->id & 0xffff) {
=2D		case WM9705_ID2:
=2D			wm->pen_irq =3D 0;
=2D			break;
=2D		case WM9712_ID2:
=2D		case WM9713_ID2:
=2D			/* disable interrupt */
=2D			wm->pen_irq =3D 0;
=2D			break;
=2D		}
+		if (irq)
+			gpio_free(irq);
+		wm->pen_irq =3D 0;
 	}
 }
=20
=2D-=20
1.6.3.3


--Boundary-00=_WwFYKLg8MK7WuEN
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_WwFYKLg8MK7WuEN--
