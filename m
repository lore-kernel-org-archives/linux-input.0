From: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Subject: Re: [PATCH BlueZ 2/4] Add sixaxis plugin: USB pairing and LEDs
 settings
Date: Thu, 18 Aug 2011 16:13:57 +0200
Message-ID: <20110818161357.8084ab94bff57391e7ec3284@studenti.unina.it>
References: <1312553358-26280-1-git-send-email-ospite@studenti.unina.it>
	<1312553358-26280-3-git-send-email-ospite@studenti.unina.it>
	<4E41EBE5.7040908@signal11.us>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__18_Aug_2011_16_13_57_+0200_wh8+x2HmBd_OEii4"
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E41EBE5.7040908-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>
Cc: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jim Paris <jim-XrPbb/hENzg@public.gmane.org>, Ranulf Doswell <ralf-fD3LYpizeBGsTnJN9+BGXg@public.gmane.org>, "Pascal A . Brisset" <pascal44973-dXI0m6hRz7k@public.gmane.org>, Marcin Tolysz <tolysz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christian Birchinger <joker-vQrvfurPyUjk1uMJSBkQmQ@public.gmane.org>, Filipe Lopes <falktx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mikko Virkkila <virkkila-/1wQRMveznE@public.gmane.org>, Simon Wood <simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org>, Arc Riley <arcriley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

--Signature=_Thu__18_Aug_2011_16_13_57_+0200_wh8+x2HmBd_OEii4
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 09 Aug 2011 22:24:37 -0400
Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org> wrote:

[...]
> > +	ret =3D create_sixaxis_association(adapter,
> > +					SIXAXIS_NAME,
> > +					device_bdaddr,
> > +					VENDOR, PRODUCT, SIXAXIS_PNP_RECORD);
>=20
> You create the association with a hard-coded VID/PID. You match the
> device on string name below (not VID/PID), so what if you used the
> actual VID/PID of the device for the association instead?
>

Or use statically defined VID/PID to match the device, see below.

[...]
> > +	/*
> > +	 * the total time the led is active (0xff means forever)
> > +	 * |     duty_length: how long a cycle is in deciseconds:
> > +	 * |     |                              (0 means "blink very fast")
> > +	 * |     |     ??? (Maybe a phase shift or duty_length multiplier?)
> > +	 * |     |     |     % of duty_length led is off (0xff means 100%)
> > +	 * |     |     |     |     % of duty_length led is on (0xff is 100%)
> > +	 * |     |     |     |     |
> > +	 * 0xff, 0x27, 0x10, 0x00, 0x32,
> > +	 */
> > +	unsigned char leds_report[] =3D {
> > +		0x01,
> > +		0x00, 0x00, 0x00, 0x00, 0x00, /* rumble values TBD */
> > +		0x00, 0x00, 0x00, 0x00, 0x1e, /* LED_1=3D0x02, LED_2=3D0x04 ... */
> > +		0xff, 0x27, 0x10, 0x00, 0x32, /* LED_4 */
> > +		0xff, 0x27, 0x10, 0x00, 0x32, /* LED_3 */
> > +		0xff, 0x27, 0x10, 0x00, 0x32, /* LED_2 */
> > +		0xff, 0x27, 0x10, 0x00, 0x32, /* LED_1 */
> > +		0x00, 0x00, 0x00, 0x00, 0x00,
> > +	};
> > =20
> > +	int leds =3D 0;
> > +	if (leds_status[0])
> > +		leds |=3D LED_1;
> > +	if (leds_status[1])
> > +		leds |=3D LED_2;
> > +	if (leds_status[2])
> > +		leds |=3D LED_3;
> > +	if (leds_status[3])
> > +		leds |=3D LED_4;
> > +
> > +	leds_report[10] =3D leds;
>=20
> If you are overwriting leds_report[10] unconditionally, why is it
> initialized to 0x1e in the leds_report initializer (unless I counted wron=
g)?
>

You are right having it initialized to 0x1e is not necessary at all,
but I'd still keep it to 0x1e in the initializer because this is the
"hardware default", meaning "all leds blinking", I see it as a form of
documentation-inside-code, but if it is confusing I will avoid that.=20

[...]
> > +
> > +static inline gboolean is_sixaxis(const char *hid_name)
> > +{
> > +	return g_str_has_suffix(hid_name, "PLAYSTATION(R)3 Controller") ||
> > +		g_str_has_suffix(hid_name,
> > +			"Sony Computer Entertainment Wireless Controller");
> > +}
>=20
> Why do you key on the string name here. This seems problematic,
> especially if you want to support things like the PSMove. I'd expect a
> table of VID/PIDs or something.
>

Right, I like this suggestion, I generalized the code a little bit to
handle different devices, see the two follow-up incremental patches, in
the first one I remove static #defines in favor of a structure
representing a device type, in the second one I match devices using
VID/PID from a table of device types.

If the idea looks OK I'll fold those patches in v5, along with the
plugin renaming to "sony-controller", and maybe I'll split the plugin in
several modules too:
  sony-controller.c 	/* udev and bluez stuff */
  sony-controller-hid.c	/* hidraw and device specific stuff */
  sony-controlled-hid.h

[...]
> > +
> > +static gboolean device_event_idle(struct udev_device *udevice)
> > +{
> > +	handle_device_plug(udevice);
> > +	udev_device_unref(udevice);
> > +	return FALSE;
> > +}
>=20
> I'm a little confused why this is called "idle."
>

I don't know either, maybe trying to communicate that it is called
asynchronously by glib (via g_timeout_add_seconds())? But even if so
this is not a property of the function itself, so I think we can just
call it device_event().

Ah Bastien, I noticed we are using g_timeout_add_seconds() with the
callback always returning FALSE, so the latter is called only once,
can't we in this case just sleep and then call the function directly?
Isn't the main loop in sixaxis_init() enough to handle multiple
overlapping udev events? Maybe I asked that already... :P

> Thanks for your work on this, Antonio. Linux working out of the box with
> these controllers will be really cool.
>=20
> Alan.
>

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Thu__18_Aug_2011_16_13_57_+0200_wh8+x2HmBd_OEii4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk5NHiUACgkQ5xr2akVTsAG/lgCfVbbRpr/3iguu1twdGTyMj0K9
bEwAnRc/F/z9IPYJBhLCv451fFxL0Eog
=UIeO
-----END PGP SIGNATURE-----

--Signature=_Thu__18_Aug_2011_16_13_57_+0200_wh8+x2HmBd_OEii4--
