From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Samsung R510
Date: Tue, 15 Sep 2009 20:46:09 -0700
Message-ID: <20090916034609.GB2756@core.coreip.homeip.net>
References: <f3f71ab90909110117t4d9de95cv2f71b42f2a9a7992@mail.gmail.com> <f3f71ab90909151403o688c31aew9bca512302d616d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f172.google.com ([209.85.221.172]:36675 "EHLO
	mail-qy0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbZIPDqJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Sep 2009 23:46:09 -0400
Received: by mail-qy0-f172.google.com with SMTP id 2so3749051qyk.21
        for <linux-input@vger.kernel.org>; Tue, 15 Sep 2009 20:46:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f3f71ab90909151403o688c31aew9bca512302d616d@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Lothian <mike@fireburn.co.uk>
Cc: linux-input@vger.kernel.org

Hi Mike,

On Tue, Sep 15, 2009 at 10:03:25PM +0100, Mike Lothian wrote:
> 2009/9/11 Mike Lothian <mike@fireburn.co.uk>:
> > Hi
> >
> > Please could the following patch be added to the kernel
> >
> > diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboar=
d/atkbd.c
> > index 95fe045..592623e 100644
> > --- a/drivers/input/keyboard/atkbd.c
> > +++ b/drivers/input/keyboard/atkbd.c
> > @@ -1572,6 +1572,16 @@ static struct dmi_system_id
> > atkbd_dmi_quirk_table[] __initdata =3D {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.callback =3D atkbd_setup_forced_rel=
ease,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.driver_data =3D atkbd_samsung_force=
d_release_keys,
> > =A0 =A0 =A0 =A0},
> > + =A0 =A0 =A0 =A0{
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.ident =3D "Samsung R510/P510",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.matches =3D {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DMI_MATCH(DMI_SYS_=
VENDOR, "SAMSUNG
> > ELECTRONICS CO., LTD."),
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DMI_MATCH(DMI_PROD=
UCT_NAME, "R510/P510"),
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.callback =3D atkbd_setup_forced_r=
elease,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.driver_data =3D atkbd_samsung_for=
ced_release_keys,
> > + =A0 =A0 =A0 =A0},
> > +
> > =A0 =A0 =A0 =A0{
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.ident =3D "Fujitsu Amilo PA 1510",
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.matches =3D {
> >
> > This fixes the forced release keys for me
> >
> > Thanks
> >
> > Mike
> >
> > PS I'm not subscribed to this list so please CC me
> >
>=20
> Ping is this the correct list?

This is correct list. However atkbd has just been adjusted to allow
manipulating the force release bitmap from userspace (via sysfs) so no
more patches will be accepted in the kernel. We will rely on UDEV/HAL t=
o
take care of setting it up properly.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
