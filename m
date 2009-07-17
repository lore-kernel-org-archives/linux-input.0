From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 2/2] Add possibility to control the GPIO_STATUS shift
Date: Fri, 17 Jul 2009 16:45:21 +0200
Message-ID: <200907171645.21352.marek.vasut@gmail.com>
References: <200907171001.16889.marek.vasut@gmail.com> <200907171353.59356.marek.vasut@gmail.com> <20090717121159.GA20904@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_B6IYKPKVVLTGNGU"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f228.google.com ([209.85.218.228]:39257 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933907AbZGQOpm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jul 2009 10:45:42 -0400
Received: by bwz28 with SMTP id 28so778820bwz.37
        for <linux-input@vger.kernel.org>; Fri, 17 Jul 2009 07:45:40 -0700 (PDT)
In-Reply-To: <20090717121159.GA20904@rakim.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, alsa-devel@alsa-project.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

--Boundary-00=_B6IYKPKVVLTGNGU
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dne P=C3=A1 17. =C4=8Dervence 2009 14:11:59 Mark Brown napsal(a):
> On Fri, Jul 17, 2009 at 01:53:59PM +0200, Marek Vasut wrote:
> > Dne P=C3=A1 17. =C4=8Dervence 2009 13:43:12 Mark Brown napsal(a):
> > > The same way your current patch does it.  I'm just saying you should
> > > change the way the configuration is passed in so that it is clear that
> > > this is only useful for WM1613.
> >
> > But there might appear some other chips that have this issue.
>
> Then they can get handled the same way - it might be an idea to have the
> data that's passed in be a chip number to allow for this.

Will this one be more to your liking ?

--Boundary-00=_B6IYKPKVVLTGNGU
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0002-Add-possibility-to-control-the-GPIO_STATUS-shift.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0002-Add-possibility-to-control-the-GPIO_STATUS-shift.patch"

=46rom 1ea286d088993e05b5b374a08ee6f933242d3561 Mon Sep 17 00:00:00 2001
=46rom: Marek Vasut <marek.vasut@gmail.com>
Date: Thu, 4 Jun 2009 21:56:59 +0200
Subject: [PATCH 2/2] Add possibility to control the GPIO_STATUS shift

This patch allows tweaking the behaviour of GPIO_STATUS register
shift quirk that's in wm97xx-core. The problem with GPIO_STATUS
register being shifted by one doesn't appear on all hardware it
seems and causes problems with accelerated touchscreen drivers on
Palm hardware. Therefore an accelerated touchscreen driver can select
if the shift is/isn't happening on the hardware.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
=2D--
 drivers/input/touchscreen/mainstone-wm97xx.c |    3 +++
 drivers/input/touchscreen/wm97xx-core.c      |    6 ++++--
 include/linux/wm97xx.h                       |    7 +++++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/mainstone-wm97xx.c b/drivers/input/t=
ouchscreen/mainstone-wm97xx.c
index de02f87..e000ab3 100644
=2D-- a/drivers/input/touchscreen/mainstone-wm97xx.c
+++ b/drivers/input/touchscreen/mainstone-wm97xx.c
@@ -198,6 +198,9 @@ static int wm97xx_acc_startup(struct wm97xx *wm)
 	if (machine_is_palmt5() || machine_is_palmtx() || machine_is_palmld()) {
 		pen_int =3D 1;
 		irq =3D 27;
+		/* There is some obscure mutant of WM9712 interbred with WM9713
+		 * used on Palm HW */
+		wm->variant =3D WM97xx_WM1613;
 	} else if (machine_is_mainstone() && pen_int)
 		irq =3D 4;
=20
diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchs=
creen/wm97xx-core.c
index 2957d48..252eb11 100644
=2D-- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -204,7 +204,7 @@ void wm97xx_set_gpio(struct wm97xx *wm, u32 gpio,
 	else
 		reg &=3D ~gpio;
=20
=2D	if (wm->id =3D=3D WM9712_ID2)
+	if (wm->id =3D=3D WM9712_ID2 && wm->variant !=3D WM97xx_WM1613)
 		wm97xx_reg_write(wm, AC97_GPIO_STATUS, reg << 1);
 	else
 		wm97xx_reg_write(wm, AC97_GPIO_STATUS, reg);
@@ -307,7 +307,7 @@ static void wm97xx_pen_irq_worker(struct work_struct *w=
ork)
 					 WM97XX_GPIO_13);
 		}
=20
=2D		if (wm->id =3D=3D WM9712_ID2)
+		if (wm->id =3D=3D WM9712_ID2 && wm->variant !=3D WM97xx_WM1613)
 			wm97xx_reg_write(wm, AC97_GPIO_STATUS, (status &
 						~WM97XX_GPIO_13) << 1);
 		else
@@ -582,6 +582,8 @@ static int wm97xx_probe(struct device *dev)
=20
 	wm->id =3D wm97xx_reg_read(wm, AC97_VENDOR_ID2);
=20
+	wm->variant =3D WM97xx_GENERIC;
+
 	dev_info(wm->dev, "detected a wm97%02x codec\n", wm->id & 0xff);
=20
 	switch (wm->id & 0xff) {
diff --git a/include/linux/wm97xx.h b/include/linux/wm97xx.h
index 6f69968..0c98781 100644
=2D-- a/include/linux/wm97xx.h
+++ b/include/linux/wm97xx.h
@@ -16,6 +16,12 @@
 #include <linux/platform_device.h>
=20
 /*
+ * WM97xx variants
+ */
+#define	WM97xx_GENERIC			0x0000
+#define	WM97xx_WM1613			0x1613
+
+/*
  * WM97xx AC97 Touchscreen registers
  */
 #define AC97_WM97XX_DIGITISER1		0x76
@@ -283,6 +289,7 @@ struct wm97xx {
 	unsigned pen_is_down:1;		/* Pen is down */
 	unsigned aux_waiting:1;		/* aux measurement waiting */
 	unsigned pen_probably_down:1;	/* used in polling mode */
+	u16 variant;			/* WM97xx chip variant */
 	u16 suspend_mode;               /* PRP in suspend mode */
 };
=20
=2D-=20
1.6.3.3


--Boundary-00=_B6IYKPKVVLTGNGU--
