From: Roman Volkov <v1ron-oLhuKTjYqW/YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 4/5] i8042: Prepare i8042 driver for DT support
Date: Wed, 4 Feb 2015 12:30:38 +0300
Message-ID: <20150204123038.3fb7e6e1@v1ron-s7>
References: <1422913730-12663-1-git-send-email-v1ron@v1ros.org>
	<1422913730-12663-4-git-send-email-v1ron@v1ros.org>
	<20150203193835.GC20256@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150203193835.GC20256@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roman Volkov <v1ron-JGs/UdohzUI@public.gmane.org>, Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

=D0=92 Tue, 3 Feb 2015 11:38:35 -0800
Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> =D0=BF=D0=B8=D1=88=D0=B5=D1=
=82:

> On Tue, Feb 03, 2015 at 12:48:49AM +0300, Roman Volkov wrote:
> > Use platform_device_probe() instead of platform_create_bundle() whe=
n
> > compiled with DT support, since the latter function is not suitable
> > for handling the OF device tree.
> >=20
> > The order of initialization is changed, since i8042_platform_init()
> > for DT requires initialized platform_device structure. To avoid
> > searching of the compatible node twice, the platform_device
> > structure pointer must be passed to the i8042_platform_init()
> > function right after initialization by platform_device_probe().
> >=20
> > Signed-off-by: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
> > Signed-off-by: Roman Volkov <v1ron-oLhuKTjYqW/YtjvyW6yDsg@public.gmane.org>
> > ---
> >=20
> > Yes, many of these ifdefs look ugly. Suggestions on how to avoid
> > this are welcome (except using of_find_compatible_node() for
> > searching the node twice before calling the probe function).
>=20
> I guess we need to split the dirver into part that create platform
> device and the standard driver part. Then your OF code can supply mos=
t
> of the needed data via resources/platform data. Yes, it is a larger
> change, but the current splat of ifdefs makes my eyes water.
>=20
> Thanks.
>=20

Dmitry, could you describe this in details? Currently there is
platform_create_bundle() function in the driver that is not acceptable
to be used with OF (it creates additional device). This function must b=
e
replaced with platform_driver_probe() and it is all that common
between various architectures and can be the "standard" part of the
driver.

The difference is in device creation between OF case and, for example,
x86 case. Here is a chicken-and-egg problem that needs to be solved, if
we try to make the code consistent between various platforms. The
problem is that i8042_platform_init() expected to be called first, but
at this point DT version requires platform_device structure pointer.

Regards,
Roman.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
