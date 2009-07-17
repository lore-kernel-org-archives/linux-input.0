From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 2/2] Add possibility to control the GPIO_STATUS shift
Date: Fri, 17 Jul 2009 13:12:15 +0200
Message-ID: <200907171312.15548.marek.vasut@gmail.com>
References: <200907171001.16889.marek.vasut@gmail.com> <20090717103253.GF3439@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PyFYKV+KXR0iDHS"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:36682 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934422AbZGQLMf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jul 2009 07:12:35 -0400
Received: by fxm18 with SMTP id 18so661163fxm.37
        for <linux-input@vger.kernel.org>; Fri, 17 Jul 2009 04:12:33 -0700 (PDT)
In-Reply-To: <20090717103253.GF3439@rakim.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

--Boundary-00=_PyFYKV+KXR0iDHS
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dne P=C3=A1 17. =C4=8Dervence 2009 12:32:53 Mark Brown napsal(a):
> On Fri, Jul 17, 2009 at 10:01:16AM +0200, Marek Vasut wrote:
> > This patch allows tweaking the behaviour of GPIO_STATUS register
> > shift quirk that's in wm97xx-core. The problem with GPIO_STATUS
> > register being shifted by one doesn't appear on all hardware it
> > seems and causes problems with accelerated touchscreen drivers on
> > Palm hardware. Therefore an accelerated touchscreen driver can select
> > if the shift is/isn't happening on the hardware.
>
> Again, this isn't an ALSA patch.
>
> I've done some checking internally and I'm very suspicous that what's
> going on here is actually the masking of some other bug elsewhere in the
> system.  Which CPU are the systems you're observing this on using?
> There is at least one special case in the current code for GPIO register
> readbacks in the PXA AC97 driver code and there have been a number of
> interoperabilty issues in that area...

About the mailer, same here, sending as attachment, sorry.

The CPU used is pxa270c5 and pxa270c0. The chip is WM1613 (seems to report=
=20
itself as WM9712 though). Maybe it's correction in that chip? There's no=20
datasheet available to it though.


--Boundary-00=_PyFYKV+KXR0iDHS
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0002-Add-possibility-to-control-the-GPIO_STATUS-shift.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0002-Add-possibility-to-control-the-GPIO_STATUS-shift.patch"

=46rom e7179d9d34b0a6078324fbe2c3666937937c0fde Mon Sep 17 00:00:00 2001
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
 drivers/input/touchscreen/mainstone-wm97xx.c |    2 ++
 drivers/input/touchscreen/wm97xx-core.c      |   19 +++++++++----------
 include/linux/wm97xx.h                       |    1 +
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/mainstone-wm97xx.c b/drivers/input/t=
ouchscreen/mainstone-wm97xx.c
index de02f87..7b95741 100644
=2D-- a/drivers/input/touchscreen/mainstone-wm97xx.c
+++ b/drivers/input/touchscreen/mainstone-wm97xx.c
@@ -198,6 +198,8 @@ static int wm97xx_acc_startup(struct wm97xx *wm)
 	if (machine_is_palmt5() || machine_is_palmtx() || machine_is_palmld()) {
 		pen_int =3D 1;
 		irq =3D 27;
+		wm->gpio_offset =3D 0;	/* interestingly, on Palm hardware, the
+					 * GPIO_STATUS shift doesn't occur */
 	} else if (machine_is_mainstone() && pen_int)
 		irq =3D 4;
=20
diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchs=
creen/wm97xx-core.c
index 2957d48..6621c0e 100644
=2D-- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -204,10 +204,7 @@ void wm97xx_set_gpio(struct wm97xx *wm, u32 gpio,
 	else
 		reg &=3D ~gpio;
=20
=2D	if (wm->id =3D=3D WM9712_ID2)
=2D		wm97xx_reg_write(wm, AC97_GPIO_STATUS, reg << 1);
=2D	else
=2D		wm97xx_reg_write(wm, AC97_GPIO_STATUS, reg);
+	wm97xx_reg_write(wm, AC97_GPIO_STATUS, reg << wm->gpio_offset);
 	mutex_unlock(&wm->codec_mutex);
 }
 EXPORT_SYMBOL_GPL(wm97xx_set_gpio);
@@ -307,12 +304,8 @@ static void wm97xx_pen_irq_worker(struct work_struct *=
work)
 					 WM97XX_GPIO_13);
 		}
=20
=2D		if (wm->id =3D=3D WM9712_ID2)
=2D			wm97xx_reg_write(wm, AC97_GPIO_STATUS, (status &
=2D						~WM97XX_GPIO_13) << 1);
=2D		else
=2D			wm97xx_reg_write(wm, AC97_GPIO_STATUS, status &
=2D						~WM97XX_GPIO_13);
+		wm97xx_reg_write(wm, AC97_GPIO_STATUS, (status &
+				~WM97XX_GPIO_13) << wm->gpio_offset);
 		mutex_unlock(&wm->codec_mutex);
 	}
=20
@@ -582,6 +575,12 @@ static int wm97xx_probe(struct device *dev)
=20
 	wm->id =3D wm97xx_reg_read(wm, AC97_VENDOR_ID2);
=20
+	/* On some versions of WM9712, the GPIO_STATUS register is shifted */
+	if (wm->id =3D=3D WM9712_ID2)
+		wm->gpio_offset	=3D 1;
+	else
+		wm->gpio_offset	=3D 0;
+
 	dev_info(wm->dev, "detected a wm97%02x codec\n", wm->id & 0xff);
=20
 	switch (wm->id & 0xff) {
diff --git a/include/linux/wm97xx.h b/include/linux/wm97xx.h
index 6f69968..c6dc15b 100644
=2D-- a/include/linux/wm97xx.h
+++ b/include/linux/wm97xx.h
@@ -283,6 +283,7 @@ struct wm97xx {
 	unsigned pen_is_down:1;		/* Pen is down */
 	unsigned aux_waiting:1;		/* aux measurement waiting */
 	unsigned pen_probably_down:1;	/* used in polling mode */
+	unsigned gpio_offset:1;		/* gpio register offset */
 	u16 suspend_mode;               /* PRP in suspend mode */
 };
=20
=2D-=20
1.6.3.3


--Boundary-00=_PyFYKV+KXR0iDHS--
