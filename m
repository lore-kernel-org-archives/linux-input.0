From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH v4 1/6] hid: new driver for PicoLCD device
Date: Mon, 29 Mar 2010 12:16:11 +0200
Message-ID: <20100329121611.0c22dcaf@pluto.restena.lu>
References: <20100324233707.7243b04d@neptune.home>
	<20100324234022.0361bd80@neptune.home>
	<20100326065656.GC26602@core.coreip.homeip.net>
	<20100326102951.3b9ecda1@neptune.home>
	<alpine.LNX.2.00.1003262156280.24576@pobox.suse.cz>
	<20100327012245.0ace6a09@neptune.home>
	<alpine.LNX.2.00.1003291144350.24576@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1003291144350.24576@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Oliver Neukum <oliver@neukum.org>, Jaya Kumar <jayakumar.lkml@gmail.com>
List-Id: linux-input@vger.kernel.org

On Mon, 29 Mar 2010 11:47:27 +0200 Jiri Kosina <jkosina@suse.cz> wrote:
> On Sat, 27 Mar 2010, Bruno Pr=C3=A9mont wrote:
>=20
> > +#ifdef CONFIG_PM
> > +static int picolcd_suspend(struct hid_device *hdev)
> > +{
> > +	dbg_hid(PICOLCD_NAME " device ready for suspend\n");
> > +	return 0;
> > +}
> > +
> > +static int picolcd_resume(struct hid_device *hdev)
> > +{
> > +	return 0;
> > +}
> > +
> > +static int picolcd_reset_resume(struct hid_device *hdev)
> > +{
> > +	int ret;
> > +	ret =3D picolcd_reset(hdev);
> > +	if (ret)
> > +		dbg_hid(PICOLCD_NAME " resetting our device failed: %d\n", ret);
> > +	return 0;
> > +}
> > +#endif
> [ ... ]
> > +static struct hid_driver picolcd_driver =3D {
> > +	.name =3D          "hid-picolcd",
> > +	.id_table =3D      picolcd_devices,
> > +	.probe =3D         picolcd_probe,
> > +	.remove =3D        picolcd_remove,
> > +	.raw_event =3D     picolcd_raw_event,
> > +#ifdef CONFIG_PM
> > +	.suspend =3D       picolcd_suspend,
> > +	.resume =3D        picolcd_resume,
> > +	.reset_resume =3D  picolcd_reset_resume,
> > +#endif
> > +};
>=20
> struct hid_driver doesn't provide power-management related callbacks.
> So I guess that you have either not tested this feature at all, or
> you have some extra patch somewhere which adds such callbacks to HID
> core, but you haven't sent it out for review?
>=20
> In any cases, this will very likely cause compilation failure with=20
> CONFIG_PM turned on.

That's the patch I referred to (under series introduction mail) when
saying:
> The series depends on my previous patch adding HID suspend support
> (I've not yet looked at improving it).

Link to the patch:
  http://lkml.org/lkml/2010/2/24/233

Especially the reset-resume part is important as the device has to be
reprogrammed with framebuffer content, brightness/contrast in that case=
=2E


As stated, Oliver didn't like the implementation of the addition of
those hooks too much and I have yet to look at improving it.

Thanks,
Bruno
