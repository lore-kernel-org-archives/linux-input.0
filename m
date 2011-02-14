From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] bma023: Support for Bosch BMA023, BMA150 and SMB380
 accelerometers
Date: Mon, 14 Feb 2011 12:27:27 +0000
Message-ID: <20110214122727.0cb550a5@lxorguk.ukuu.org.uk>
References: <20110214100622.2282.1584.stgit@bob.linux.org.uk>
	<4D5916F5.1090301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:43208 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754581Ab1BNMW3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Feb 2011 07:22:29 -0500
In-Reply-To: <4D5916F5.1090301@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: linux-input@vger.kernel.org

On Mon, 14 Feb 2011 17:20:13 +0530
Shubhrajyoti <shubhrajyoti@ti.com> wrote:

> Hello,
> Some comments inlined.

Please trim stuff when you add comments inline like that. Firstly it
saves bandwidth but more importantly it makes them easier to find !


> >   obj-$(CONFIG_INPUT_SGI_BTNS)		+=3D sgi_btns.o
> > +obj-$(CONFIG_INPUT_BMA023)			+=3D bma023.o
> May consider alphabetical order

oops - yes good point. I didn't check that when merging.


> > + *	bma023_xyz_read_reg	-	read the axes values
> > + *	@reg: register being updated
> > + *	@val: value to write
> Didn=E2=80=99t understand this

That would be because the comments need updating. Will fix that now.


> > +	struct bma023_sensor *sensor =3D dev_get_drvdata(dev);
> > +
> > +	pm_runtime_get_sync(dev);
> Not a comment really , what does  pm_runtime_get_sync(dev); do ?

We need to be sure it's powered up when we read it via sysfs.

> > +	pm_runtime_put(dev);
>=20
> Also did you  pm_runtime_put(dev); here? Didnt understand this did yo=
u=20
> mean sync?

No - as we don't care if it powers off immediately just that it gets
around to it.

> > +
> > +	return sprintf(buf, "(%d,%d,%d)\n",
> > +		sensor->data.x, sensor->data.y, sensor->data.z);
> > +}
> > +static DEVICE_ATTR(accel_data, S_IRUGO, bma023_show_xyz, NULL);
> Since it is reported as an input device do you need the sysfs entry?

Yes - the device is usable both as an input device (think about tilt
based games) and for other purposes like orientation or drop detection.
The sysfs interface covers the latter.


> > + *	Add an input device to the sensor. This will be used to report
> > + *	events from the sensor itself.
> > + */
> > +static int bma023_register_input_device(struct bma023_sensor *sens=
or)
> this could be devinit as well as called only from probe.

Looks like it could will check


> > +	if (idev)
> > +		input_free_device(idev);
> This check is there in the function

Yep


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
