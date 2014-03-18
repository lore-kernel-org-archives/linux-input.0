From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/8] input: misc: Add driver for AXP20x
 Power Enable Key
Date: Tue, 18 Mar 2014 10:58:51 +0000
Message-ID: <20140318105851.GO25478@lee--X1>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
 <1394898225-28452-4-git-send-email-carlo@caione.org>
 <20140318090013.GU27873@lukather>
 <20140318095002.GM25478@lee--X1>
 <20140318101554.GZ27873@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDA7X7F2WUEBB4ONUCMQKGQEYF5FL6I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140318101554.GZ27873@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-input@vger.kernel.org

> > > > This patch add support for the Power Enable Key found on MFD AXP202=
 and
> > > > AXP209. Besides the basic support for the button, the driver adds t=
wo
> > > > entries in sysfs to configure the time delay for power on/off.
> > > >=20
> > > > Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
> > > > ---
> > > >  drivers/input/misc/Kconfig      |  11 ++
> > > >  drivers/input/misc/Makefile     |   1 +
> > > >  drivers/input/misc/axp20x-pek.c | 267 ++++++++++++++++++++++++++++=
++++++++++++
> > > >  3 files changed, 279 insertions(+)
> > > >  create mode 100644 drivers/input/misc/axp20x-pek.c
> > >=20
> > > From what I understood of the MFD framework, you usually have a MFD
> > > core driver that gets loaded from the DT and instantiate its various
> > > functions through sub-devices, that are registered through
> > > mfd_add_devices, and the drivers for these sub-devices are supported
> > > in sub-drivers that are located in the driver/mfd, alongside the core
> > > driver.
> > >=20
> > > I believe that such a pattern allows for two interesting things:
> > >   - You don't have to search around the whole kernel tree to find
> > >     where a given sub-feature is supported.
> > >   - You don't have to cripple your DT with instantiation of all the
> > >     subcomponents, while you only really have one device.
> > >=20
> > > Do you have a reason for not following this pattern?
> >=20
> > Sorry Maxime, this is not the case.
> >=20
> > If an MFD contains Regulators and USB & GPIO Controllers, I'd expect
> > to see the device represented in the following way:
> >=20
> >   drivers/mfd/<id>.c
> >   drivers/{gpio,pinctrl}/{gpio,pinctrl}-<id>.c
> >   drivers/regulator/<id>-regulator.c
> >   drivers/usb/host/<id>.c
>=20
> Oh, ok. Nevermind then :)
>=20
> Just out of curiosity, some drivers at least seem to follow that trend
> in drivers/mfd, is there any reason for this (other than historical) ?

Would you mind providing an example?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
