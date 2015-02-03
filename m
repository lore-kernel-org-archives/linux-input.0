From: =?gb2312?B?uunSu9bxIA==?= <sam.hung@emc.com.tw>
Subject: RE: input: elantech.c: adding more Fujtisu notebooks to force crc_enabled
Date: Tue, 3 Feb 2015 09:00:18 +0800
Message-ID: <000801d03f4c$c7c33d70$5749b850$@emc.com.tw>
References: <54C74A69.7060105@ts.fujitsu.com> <20150127232752.GA24529@dtor-ws> <CEAEAFEECC474A8ABBE703BECE8C37CF@elan.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:36384 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754385AbbBCBAW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Feb 2015 20:00:22 -0500
In-Reply-To: <CEAEAFEECC474A8ABBE703BECE8C37CF@elan.corp>
Content-Language: zh-tw
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'duson' <dusonlin@emc.com.tw>, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, 'Rainer Koenig' <Rainer.Koenig@ts.fujitsu.com>
Cc: linux-input@vger.kernel.org, jeff.chuang7178@gmail.com, james.chen@emc.com.tw, herman.lin@emc.com.tw

Dear Rainer:

Please help us get the computer records.
as below steps:

Step1.open terminal.
Step2.reboot pc
Step3.dmesg > elanTouch.txt
Step4.send elanTouch.txt to me.

**Keeping mount elan Touchpad on PC.

Thanks!

BR,
Sam
-----Original Message-----
=46rom: duson [mailto:dusonlin@emc.com.tw]=20
Sent: Wednesday, January 28, 2015 11:38 AM
To: 'Dmitry Torokhov'; 'Rainer Koenig'; sam.hung@emc.com.tw
Cc: linux-input@vger.kernel.org; jeff.chuang7178@gmail.com;
james.chen@emc.com.tw; herman.lin@emc.com.tw
Subject: RE: input: elantech.c: adding more Fujtisu notebooks to force
crc_enabled

 Loop Sam

Hi Sam,
Please help to take care this.

Duson

> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Wednesday, January 28, 2015 7:28 AM
> To: Rainer Koenig
> Cc: linux-input@vger.kernel.org; jeff.chuang7178@gmail.com;=20
> james.chen@emc.com.tw; herman.lin@emc.com.tw; Duson Lin
> Subject: Re: input: elantech.c: adding more Fujtisu notebooks to forc=
e=20
> crc_enabled
>=20
> On Tue, Jan 27, 2015 at 09:20:57AM +0100, Rainer Koenig wrote:
> > Extending the patch from November 2014 with two more
> Fujitsu LIFEBOOK
> > models that also ship the Elantech touchpad and don't work with=20
> > crc_disabled.
> >=20
> > Signed-off-by: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>
>=20
> Applied, thank you.
>=20
> However I am not happy with the direction we are going - the fact tha=
t=20
> we need to add more and more laptops to the quirk.  It would be bette=
r=20
> if we could detect whether we need CRC or not by querying the touchpa=
d=20
> somehow. Elantech folks, could you help us here?
>=20
> Thanks!
>=20
> >=20
> > ---
> > My responsibility is enabling Linux on Fujitsu desktops and
> sometimes
> > also notebooks. Stumbled into this issue during investigation of a=20
> > customer project and successfully tested the patch on both machines=
=2E
> >=20
> > diff -uNr old/drivers/input/mouse/elantech.c
> new/drivers/input/mouse/elantech.c
> > --- old/drivers/input/mouse/elantech.c	2015-01-27=20
> 08:51:18.101122218 +0100
> > +++ new/drivers/input/mouse/elantech.c	2015-01-27=20
> 08:51:00.880921663 +0100
> > @@ -1475,6 +1475,20 @@
> >  			DMI_MATCH(DMI_PRODUCT_NAME, "CELSIUS H730"),
> >  		},
> >  	},
> > +	{
> > +		/* Fujitsu LIFEBOOK E554  does not work with
> crc_enabled =3D=3D 0 */
> > +		.matches =3D {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E554"),
> > +		},
> > +	},
> > +	{
> > +		/* Fujitsu LIFEBOOK E544  does not work with
> crc_enabled =3D=3D 0 */
> > +		.matches =3D {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E544"),
> > +		},
> > +	},
> >  #endif
> >  	{ }
> >  };
> >=20
> > --
> > Dipl.-Inf. (FH) Rainer Koenig
> > Project Manager Linux Clients
> > Dept. PDG WPS R&D SW OSE
> >=20
> > Fujitsu Technology Solutions
> > B=A8=B9rgermeister-Ullrich-Str. 100
> > 86199 Augsburg
> > Germany
> >=20
> > Telephone: +49-821-804-3321
> > Telefax:   +49-821-804-2131
> > Mail:      mailto:Rainer.Koenig@ts.fujitsu.com
> >=20
> > Internet         ts.fujtsu.com
> > Company Details  ts.fujitsu.com/imprint.html
>=20
> --
> Dmitry
>=20



--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
