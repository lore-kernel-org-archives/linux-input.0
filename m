From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/4] s3c24xx_ts: report touch only when stylus is down
Date: Sun, 21 Feb 2010 23:14:03 -0800
Message-ID: <20100222071403.GD2095@core.coreip.homeip.net>
References: <1266510750-9846-1-git-send-email-anarsoul@gmail.com>
 <201002212344.39633.anarsoul@gmail.com>
 <20100221225125.GA18604@core.coreip.homeip.net>
 <201002220058.52583.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45725 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab0BVHOI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Feb 2010 02:14:08 -0500
Received: by vws11 with SMTP id 11so930288vws.19
        for <linux-input@vger.kernel.org>; Sun, 21 Feb 2010 23:14:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201002220058.52583.anarsoul@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: arhuaco@freaks-unidos.net, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, linux-input@vger.kernel.org

On Mon, Feb 22, 2010 at 12:58:48AM +0200, Vasily Khoruzhick wrote:
> =D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 22 =D1=84=D0=B5=D0=B2=D1=80=D0=B0=D0=BB=D1=8F 2010 00:51:25 =D0=B0=D0=
=B2=D1=82=D0=BE=D1=80 Dmitry Torokhov =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BB:
> > We do put it in WAIT4INT mode rigtht there though so it looks like =
we
> > just need to move that call (well the original doing WAIT4INT | INT=
_UP)
> > before we check for pen state.
>=20
> And we need to disable WAIT4INT mode in s3c24xx_ts_schedule_read (act=
ually=20
> according to spec we need to disable it right after we got interrupt)=
=2E
>=20

So is the below sufficient to make it work? Even if it works aI think w=
e
need to add socke locking around scheduling reads from irq and
callback...

--=20
Dmitry


Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

---

 drivers/input/touchscreen/s3c2410_ts.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)


diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/tou=
chscreen/s3c2410_ts.c
index 60f18c2..b389648 100644
--- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -152,9 +152,12 @@ static void s3c24xx_ts_schedule_read(void)
  */
 static irqreturn_t s3c24xx_ts_stylus_irq(int irq, void *dev_id)
 {
-	if (s3c24xx_ts_check_pen_down())
+	if (s3c24xx_ts_check_pen_down()) {
+		/* Reset WAIT4INT state */
+		writel(0, ts.io + S3C2410_ADCTSC);
+
 		s3c24xx_ts_schedule_read();
-	else
+	} else
 		dev_info(ts.dev, "%s: count=3D%d\n", __func__, ts.count);
=20
 	return IRQ_HANDLED;
@@ -211,14 +214,25 @@ static void s3c24xx_ts_select(struct s3c_adc_clie=
nt *client, unsigned select)
 		/*
 		 * Conversion is complete, we have desired number of samples.
 		 */
+
+		/*
+		 * We need to be in WAIT4INT mode to successfully check for
+		 * pen state.
+		 */
+		writel(WAIT4INT | INT_UP, ts.io + S3C2410_ADCTSC);
+
 		pen_is_down =3D s3c24xx_ts_check_pen_down();
=20
 		s3c24xx_ts_report_state(pen_is_down);
=20
-		if (pen_is_down)
+		if (pen_is_down) {
+			/* Reset WAIT4INT state */
+			writel(0, ts.io + S3C2410_ADCTSC);
+
 			s3c24xx_ts_schedule_read();
-		else
+		} else {
 			writel(WAIT4INT | INT_DOWN, ts.io + S3C2410_ADCTSC);
+		}
 	}
 }
=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
