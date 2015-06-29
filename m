From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH] HID-picoLCD: Deletion of unnecessary checks before
 three function calls
Date: Mon, 29 Jun 2015 08:34:47 +0200
Message-ID: <20150629083447.68b6cd0c@pluto.restena.lu>
References: <5307CAA2.8060406@users.sourceforge.net>
	<alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
	<530A086E.8010901@users.sourceforge.net>
	<alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
	<530A72AA.3000601@users.sourceforge.net>
	<alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
	<530B5FB6.6010207@users.sourceforge.net>
	<alpine.DEB.2.10.1402241710370.2074@hadrien>
	<530C5E18.1020800@users.sourceforge.net>
	<alpine.DEB.2.10.1402251014170.2080@hadrien>
	<530CD2C4.4050903@users.sourceforge.net>
	<alpine.DEB.2.10.1402251840450.7035@hadrien>
	<530CF8FF.8080600@users.sourceforge.net>
	<alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
	<530DD06F.4090703@users.sourceforge.net>
	<alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
	<5317A59D.4@users.sourceforge.net>
	<546CD595.3090508@users.sourceforge.net>
	<558FE090.8030307@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <558FE090.8030307@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-input@vger.kernel.org

On Sun, 28 Jun 2015 13:54:56 +0200 SF Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Wed, 19 Nov 2014 18:30:22 +0100
> >=20
> > The functions backlight_device_unregister(), lcd_device_unregister(=
) and
> > rc_unregister_device() test whether their argument is NULL and then
> > return immediately. Thus the test around the call is not needed.
> >=20
> > This issue was detected by using the Coccinelle software.
> >=20
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > ---
> >  drivers/hid/hid-picolcd_backlight.c | 3 +--
> >  drivers/hid/hid-picolcd_cir.c       | 3 +--
> >  drivers/hid/hid-picolcd_lcd.c       | 3 +--
> >  3 files changed, 3 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/hid/hid-picolcd_backlight.c b/drivers/hid/hid-=
picolcd_backlight.c
> > index a32c5f8..808807a 100644
> > --- a/drivers/hid/hid-picolcd_backlight.c
> > +++ b/drivers/hid/hid-picolcd_backlight.c
> > @@ -94,8 +94,7 @@ void picolcd_exit_backlight(struct picolcd_data *=
data)
> >  	struct backlight_device *bdev =3D data->backlight;
> > =20
> >  	data->backlight =3D NULL;
> > -	if (bdev)
> > -		backlight_device_unregister(bdev);
> > +	backlight_device_unregister(bdev);
> >  }
> > =20
> >  int picolcd_resume_backlight(struct picolcd_data *data)
> > diff --git a/drivers/hid/hid-picolcd_cir.c b/drivers/hid/hid-picolc=
d_cir.c
> > index 045f8eb..9628651 100644
> > --- a/drivers/hid/hid-picolcd_cir.c
> > +++ b/drivers/hid/hid-picolcd_cir.c
> > @@ -145,7 +145,6 @@ void picolcd_exit_cir(struct picolcd_data *data=
)
> >  	struct rc_dev *rdev =3D data->rc_dev;
> > =20
> >  	data->rc_dev =3D NULL;
> > -	if (rdev)
> > -		rc_unregister_device(rdev);
> > +	rc_unregister_device(rdev);
> >  }
> > =20
> > diff --git a/drivers/hid/hid-picolcd_lcd.c b/drivers/hid/hid-picolc=
d_lcd.c
> > index 89821c2..22dcbe1 100644
> > --- a/drivers/hid/hid-picolcd_lcd.c
> > +++ b/drivers/hid/hid-picolcd_lcd.c
> > @@ -92,8 +92,7 @@ void picolcd_exit_lcd(struct picolcd_data *data)
> >  	struct lcd_device *ldev =3D data->lcd;
> > =20
> >  	data->lcd =3D NULL;
> > -	if (ldev)
> > -		lcd_device_unregister(ldev);
> > +	lcd_device_unregister(ldev);
> >  }
> > =20
> >  int picolcd_resume_lcd(struct picolcd_data *data)
> >=20
>=20
> Would you like to integrate this update suggestion
> into another source code repository?

Sorry for forgetting about this patch.

Looks good to me:
  Reviewed-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>

Jiri, can you take it?

Best regards,
Bruno

> Regards,
> Markus
