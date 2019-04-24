From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 1/3] mfd: apple-ibridge: Add Apple iBridge MFD driver.
Date: Wed, 24 Apr 2019 20:13:17 +0100
Message-ID: <20190424201317.2a472120@archlinux>
References: <20190422031251.11968-1-ronald@innovation.ch>
        <20190422031251.11968-2-ronald@innovation.ch>
        <20190422123426.2d0b4bdf@archlinux>
        <20190424104718.GA31301@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424104718.GA31301@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: "Life is hard, and then you die" <ronald@innovation.ch>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 24 Apr 2019 03:47:18 -0700
"Life is hard, and then you die" <ronald@innovation.ch> wrote:

>   Hi Jonathan,
>=20
> On Mon, Apr 22, 2019 at 12:34:26PM +0100, Jonathan Cameron wrote:
> > On Sun, 21 Apr 2019 20:12:49 -0700
> > Ronald Tschal=C3=A4r <ronald@innovation.ch> wrote:
> >  =20
> > > The iBridge device provides access to several devices, including:
> > > - the Touch Bar
> > > - the iSight webcam
> > > - the light sensor
> > > - the fingerprint sensor
> > >=20
> > > This driver provides the core support for managing the iBridge device
> > > and the access to the underlying devices. In particular, since the
> > > functionality for the touch bar and light sensor is exposed via USB H=
ID
> > > interfaces, and the same HID device is used for multiple functions, t=
his
> > > driver provides a multiplexing layer that allows multiple HID drivers=
 to
> > > be registered for a given HID device. This allows the touch bar and A=
LS
> > > driver to be separated out into their own modules.
> > >=20
> > > Signed-off-by: Ronald Tschal=C3=A4r <ronald@innovation.ch =20
> > Hi Ronald,
> >=20
> > I've only taken a fairly superficial look at this.  A few global
> > things to note though. =20
>=20
> Thanks for this review.
>=20
> > 1. Please either use kernel-doc style for function descriptions, or
> >    do not.  Right now you are sort of half way there. =20
>=20
> Apologies, on re-reading the docs I realize what you mean here. Should
> be fixed now (next rev).
>=20
> > 2. There is quite a complex nest of separate structures being allocated,
> >    so think about whether they can be simplified.  In particular
> >    use of container_of macros can allow a lot of forwards and backwards
> >    pointers to be dropped if you embed the various structures directly.=
 =20
>=20
> Done (see also below).
>=20
> [snip]
> > > +#define	call_void_driver_func(drv_info, fn, ...)			\ =20
> >=20
> > This sort of macro may seem like a good idea because it saves a few lin=
es
> > of code.  However, that comes at the cost of readability, so just
> > put the code inline.
> >  =20
> > > +	do {								\
> > > +		if ((drv_info)->driver->fn)				\
> > > +			(drv_info)->driver->fn(__VA_ARGS__);		\
> > > +	} while (0)
> > > +
> > > +#define	call_driver_func(drv_info, fn, ret_type, ...)			\
> > > +	({								\
> > > +		ret_type rc =3D 0;					\
> > > +									\
> > > +		if ((drv_info)->driver->fn)				\
> > > +			rc =3D (drv_info)->driver->fn(__VA_ARGS__);	\
> > > +									\
> > > +		rc;							\
> > > +	}) =20
>=20
> Just to clarify, you're only talking about removing/inlining the
> call_void_driver_func() macro, not the call_driver_func() macro,
> right?

Both please. Neither adds much.

>=20
> [snip]
> > > +static struct appleib_hid_dev_info *
> > > +appleib_add_device(struct appleib_device *ib_dev, struct hid_device =
*hdev,
> > > +		   const struct hid_device_id *id)
> > > +{
> > > +	struct appleib_hid_dev_info *dev_info;
> > > +	struct appleib_hid_drv_info *drv_info;
> > > +
> > > +	/* allocate device-info for this device */
> > > +	dev_info =3D kzalloc(sizeof(*dev_info), GFP_KERNEL);
> > > +	if (!dev_info)
> > > +		return NULL;
> > > +
> > > +	INIT_LIST_HEAD(&dev_info->drivers);
> > > +	dev_info->device =3D hdev;
> > > +	dev_info->device_id =3D id;
> > > +
> > > +	/* notify all our sub drivers */
> > > +	mutex_lock(&ib_dev->update_lock);
> > > + =20
> > This is interesting. I'd like to see a comment here on what
> > this flag is going to do.  =20
>=20
> I'm not sure I follow: update_lock is simply a mutex protecting all
> driver and device update (i.e. add/remove) functions. Are you
> therefore looking for something like:

That ended up in the wrong place...
It was the in_hid_probe just after here that I was referring to.

>=20
> 	/* protect driver and device lists against concurrent updates */
> 	mutex_lock(&ib_dev->update_lock);
>=20
> [snip]
> > > +static int appleib_probe(struct acpi_device *acpi)
> > > +{
> > > +	struct appleib_device *ib_dev;
> > > +	struct appleib_platform_data *pdata; =20
> > Platform_data has a lot of historical meaning in Linux.
> > Also you have things in here that are not platform related
> > at all, such as the dev pointer.  Hence I would rename it
> > as device_data or private or something like that. =20
>=20
> Ok. I guess I called in platform_data because it's stored in the mfd
> cell's "platform_data" field. Anyway, changed it per your suggestion.
>=20
> > > +	int i;
> > > +	int ret;
> > > +
> > > +	if (appleib_dev) =20
> > This singleton bothers me a bit. I'm really not sure why it
> > is necessary.  You can just put a pointer to this in
> > the pdata for the subdevs and I think that covers most of your
> > usecases.  It's generally a bad idea to limit things to one instance
> > of a device unless that actually major simplifications.
> > I'm not seeing them here. =20
>=20
> Yes, this one is quite ugly. appleib_dev is static so that
> appleib_hid_probe() can find it. I could not find any other way to
> pass the appleib_dev instance to that probe function.
>=20
> However, on looking at this again, I realized that hid_device_id has
> a driver_data field which can be used for this; so if I added the
> hid_driver and hid_device_id structs to the appleib_device (instead of
> making them static like now) I could fill in the driver_data and avoid
> this hack. This looks much cleaner.
>=20
> Thanks for pointing this uglyness out again.
>=20
> [snip]
> > > +	if (!ib_dev->subdevs) {
> > > +		ret =3D -ENOMEM;
> > > +		goto free_dev;
> > > +	}
> > > +
> > > +	pdata =3D kzalloc(sizeof(*pdata), GFP_KERNEL); =20
> >=20
> > Might as well embed this in ib_dev as well. =20
>=20
> Agreed.
>=20
> > That would let
> > you used container_of to avoid having to carry the ib_dev pointer
> > around in side pdata. =20
>=20
> I see. I guess my main reservation is that the functions exported to
> the sub-drivers would now take a 'struct appleib_device_data *'
> argument instead of a 'struct appleib_device *', which just seems a
> bit unnatural. E.g.
>=20
>   int appleib_register_hid_driver(struct appleib_device_data *ib_ddata,
>                                   struct hid_driver *driver, void *data);
>=20
> instead of (the current)
>=20
>   int appleib_register_hid_driver(struct appleib_device *ib_dev,
>                                   struct hid_driver *driver, void *data)

I'm not totally sure I can see why.  You can go from backwards and forwards
from any of the pointers...

>=20
> [snip]
> > > +	ret =3D mfd_add_devices(&acpi->dev, PLATFORM_DEVID_NONE,
> > > +			      ib_dev->subdevs, ARRAY_SIZE(appleib_subdevs),
> > > +			      NULL, 0, NULL);
> > > +	if (ret) {
> > > +		dev_err(LOG_DEV(ib_dev), "Error adding MFD devices: %d\n", ret);
> > > +		goto free_pdata;
> > > +	}
> > > +
> > > +	acpi->driver_data =3D ib_dev;
> > > +	appleib_dev =3D ib_dev;
> > > +
> > > +	ret =3D hid_register_driver(&appleib_hid_driver);
> > > +	if (ret) {
> > > +		dev_err(LOG_DEV(ib_dev), "Error registering hid driver: %d\n",
> > > +			ret);
> > > +		goto rem_mfd_devs;
> > > +	}
> > > +
> > > +	return 0;
> > > +
> > > +rem_mfd_devs:
> > > +	mfd_remove_devices(&acpi->dev);
> > > +free_pdata:
> > > +	kfree(pdata);
> > > +free_subdevs:
> > > +	kfree(ib_dev->subdevs);
> > > +free_dev:
> > > +	appleib_dev =3D NULL;
> > > +	acpi->driver_data =3D NULL; =20
> > Why at this point?  It's not set to anything until much later in the
> > probe flow. =20
>=20
> If the hid_register_driver() call fails, we get here after driver_data
> has been assigned. However, looking at this again, acpi->driver_data
> is only used by the remove, suspend, and resume callbacks, and those
> will not be called until a successful return from probe; therefore I
> can safely move the setting of driver_data to after the
> hid_register_driver() call and avoid having to set it to NULL in the
> error cleanup.
>=20
> > May be worth thinking about devm_ managed allocations
> > to cleanup some of these allocations automatically and simplify
> > the error handling. =20
>=20
> Good point, thanks.
>=20
> [snip]
> > > +
> > > +	rc =3D acpi_execute_simple_method(ib_dev->asoc_socw, NULL, 0);
> > > +	if (ACPI_FAILURE(rc))
> > > +		dev_warn(LOG_DEV(ib_dev), "SOCW(0) failed: %s\n", =20
> >=20
> > I can sort of see you might want to do the LOG_DEV for consistency
> > but here I'm fairly sure it's just dev which might be clearer. =20
>=20
> Sorry, you mean rename the macro LOG_DEV() to just DEV()?
No, just dev_warn(dev,....)

It's the same one I think at this particular location.
>=20
>=20
>   Cheers,
>=20
>   Ronald
>=20
