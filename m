From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/4] input: Add new sun4i-lradc-keys drivers
Date: Fri, 3 Jan 2014 18:36:05 +0100
Message-ID: <20140103173605.GN3144@lukather>
References: <1388604610-20380-1-git-send-email-hdegoede@redhat.com>
 <20140101205603.GA1141@core.coreip.homeip.net>
 <52C5336B.9010903@redhat.com>
 <1700375.GaI3zFl6RI@phil>
 <52C56D79.1060506@redhat.com>
 <20140102202022.GK3144@lukather>
 <52C5E9F1.9010700@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RCmTxl7vebBeMGsQ"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRB5XLTOLAKGQEPKOTVQI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52C5E9F1.9010700-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--RCmTxl7vebBeMGsQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 02, 2014 at 11:36:33PM +0100, Hans de Goede wrote:
> Hi,
>=20
> On 01/02/2014 09:20 PM, Maxime Ripard wrote:
> >On Thu, Jan 02, 2014 at 02:45:29PM +0100, Hans de Goede wrote:
> >>>Also, instead of inventing yet another vendor-specific property, why n=
ot re-use
> >>>a button binding similar to gpio-keys like:
> >>>
> >>>        lradc: lradc@01c22800 {
> >>>                compatible =3D "allwinner,sun4i-lradc-keys";
> >>>                reg =3D <0x01c22800 0x100>;
> >>>                interrupts =3D <31>;
> >>>                allwinner,chan0-step =3D <200>;
> >>>
> >>>		#address-cells =3D <1>;
> >>>		#size-cells =3D <0>;
> >>>
> >>>		button@0 {
> >>>			reg =3D <0>; /* your channel index from above */
> >>>			linux,code =3D <115>; /* already used as dt-property */
> >>>		};
> >>>
> >>>		button@1 {
> >>>			reg =3D <1>;
> >>>			linux,code =3D <114>;
> >>>		};
> >>
> >>Ugh no. Having a vendor specific property which is KISS certainly
> >>beats this, both wrt ease of writing dts files as well as wrt the
> >>dts parsing code in the driver.
> >
> >I'd agree with Heiko here. This is pretty much the same construct
> >that's already in use in other input drivers, like gpio-keys.
>=20
> In the gpio case there is a 1 on 1 relation between a single hw
> entity (the gpio-pin) and a single keycode. Here there is 1 hw entity
> which maps to an array of key-codes, certainly using an array rather
> then a much more complicated construct is the correct data-structure
> to represent this.

You can build an array in your driver out of this very easily, it's 10
lines in your probe. And you gain from this something that is more
generic, can be shared by other similar drivers and is consistent with
what is already in use.

> >This is also something that can really easily be made generic,
> >since this is something that is rather common.
> >
> >Speaking of which. I believe this should actually come in two
> >different drivers:
> >   - The ADC driver itself, using IIO
> >   - A generic button handler driver on top of IIO.
> >
> > The fact that on most board this adc is used for buttons doesn't make
> > any difference, it's actually a hardware designer choice, we should
> > support that choice, but we should also be able to use it just as an
> > ADC.
>=20
> No, this is not a generic adc, as mentioned in the commit msg, this
> adc is specifically designed to be used this way.
>=20
> The adc won't start sampling data, and won't generate any interrupts
> until a button is pressed. That is until the input voltage drops below
> 2/3 of Vref, this is checked through a built-in analog comparator, which
> hooks into the control logic.
>=20
> It has button down and button up interrupts, and can detect long
> presses (unused) and generate a second type of down interrupt for those.
>=20
> This really is an input device, which happens to use an adc.

Hmm, yes, ok.

> >Carlo Caione already started to work on an IIO driver for the LRADC:
> >https://github.com/carlocaione/linux/tree/sunxi-lradc
> >maybe you can take over his work.
>=20
> That won't work because the adc won't sample if the input gets above
> 2/3 of Vref. There may be some other mode which does not do that, but
> that is not clearly documented.
>=20
> Even if an IIO driver turns out to be doable, I strongly believe that
> having a separate input driver for this is best, since this device
> was designed to be used as such. Building input on top of IIO would
> mean polling the adc, while with my driver it actually generates
> button down / up interrupts without any polling being involved.

Not really. iio_channel_read calls the read_raw function (in that
case) of your driver. If the read_raw function in your driver wants to
poll the device, fine, but most of the time, it will just block
waiting for an interrupt to come and return the data to the caller,
which is obviously the saner behaviour, and you don't actually end up
polling the device. Which is pretty much the architecture you're using
already, just with an intermediate layer in between.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--RCmTxl7vebBeMGsQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSxvUFAAoJEBx+YmzsjxAgo38P/1/r48NTARW6uxoKYBMrcAcF
Q0b65+qpLRHOlb19NriI29G0E+dyIX4QU14YTD01hcjWg+FJQFj3fErIbquuBsPj
QcRXbwTyMCfT5Y3pbLKSDBwUke/9+loCprFnppb4V1UA7Ma8xw0PbZJELGz9Mxdz
udPnYuYd7rxFZ1J7Tk1nWMPltK5jVFWIMq6g+tS8p313jh+/RdC8ejInC5/rL9lo
cMUPOI9wxFaiqqE4kGxY7dgi2DX91S4Vc0ZNScxDZtq33AEw2nGwZGf5H2RtaLEj
n42LbuGTG86JZiGzMd2n3JMrePOXeNzM5z0LmJeBAclRV+rpTdraJphzgs9eSh0n
yScgixbgrBle+Fs/0HYfllRKIeILWY3+h/D1AB6Pxzf9aMtEh8Lpd+MBcUw6Sjc+
h/LBqHB1cpXdd1CQkuF74cYHSiN5xo7xKLgMJKIhb35P5naxfo6FZ8+UIJK2G/Tt
4ahnbhvRAKVWID0+u/68TCpVvyjEzORxFruvi12u9eJ6lTK185H+fuhHoxBGJxTO
vBP774zivmDqGDv7BONPnbGoRdxYDDAomd//4W0Hb27woP9bCobO9nCngP4APaG1
jBUmCDld3pJRU5yT6Dn4OOlqueAtrU+IxZDYunFiyCdMssILpRMECr7XvcglFCTy
YUNx+N/h89tKof+VAV0U
=rNMR
-----END PGP SIGNATURE-----

--RCmTxl7vebBeMGsQ--
