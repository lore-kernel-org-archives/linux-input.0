From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: ATMEL camera interface
Date: Mon, 3 May 2010 16:03:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005031556570.4231@axis700.grange>
References: <4BD9AA8A.7030306@atmel.com> <Pine.LNX.4.64.1004291824200.4666@axis700.grange>
 <4BDED3A8.4090606@atmel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:52859 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759220Ab0ECODf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 May 2010 10:03:35 -0400
In-Reply-To: <4BDED3A8.4090606@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, linux-input@vger.kernel.org

On Mon, 3 May 2010, Sedji Gaouaou wrote:

> Hi,
>=20
> I will try to write a soc driver(it seems easier ;)).
>=20
> Are the mx?_camera.c a good starting point?

In principle - yes. But think about one pretty important distinction -=20
what videobuf implementation is your driver going to use? Are you going=
 to=20
support scatter-gather or only contiguous buffers? If SG - the only suc=
h=20
example in the mainline is pxa_camera.c. If contiguous - feel free to u=
se=20
any one of the rest. Further, mx3_camera uses the dmaengine API, others=
=20
don't. Hope, this will simplify your choice a bit;)

Thanks
Guennadi

> Regards,
> Sedji
>=20
> Le 4/29/2010 6:35 PM, Guennadi Liakhovetski a =E9crit :
> > Hi Sedji
> >=20
> > On Thu, 29 Apr 2010, Sedji Gaouaou wrote:
> >=20
> > > Hi,
> > >=20
> > > I need to re-work my driver so I could commit it to the community=
=2E
> > > Is there a git tree that I can use?
> >=20
> > Nice to hear that! As far as soc-camera is concerned, the present A=
PIs are
> > pretty stable. Just use the Linus' git tree, or, if you like, you c=
an use
> > the v4l-dvb git tree at git://linuxtv.org/v4l-dvb.git. In fact, you=
 don't
> > have to use the soc-camera API these days, you can just write a com=
plete
> > v4l2-device driver, using the v4l2-subdev API to interface to video
> > clients (sensors, decoders, etc.) However, you can still write your=
 driver
> > as an soc-camera host driver, which would make your task a bit easi=
er at
> > the cost of some reduced flexibility, it's up to you to decide.
> >=20
> > Thanks
> > Guennadi
> > ---
> > Guennadi Liakhovetski, Ph.D.
> > Freelance Open-Source Software Developer
> > http://www.open-technology.de/
> >=20
>=20
>=20

---
Guennadi Liakhovetski, Ph.D.
=46reelance Open-Source Software Developer
http://www.open-technology.de/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
