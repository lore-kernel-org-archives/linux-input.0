From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/4] input: Add new sun4i-lradc-keys drivers
Date: Fri, 3 Jan 2014 18:15:59 +0100
Message-ID: <20140103171559.GM3144@lukather>
References: <1388604610-20380-1-git-send-email-hdegoede@redhat.com>
 <20140101205603.GA1141@core.coreip.homeip.net>
 <52C5336B.9010903@redhat.com>
 <1700375.GaI3zFl6RI@phil>
 <52C56D79.1060506@redhat.com>
 <20140102202022.GK3144@lukather>
 <20140102203831.GA3239@core.coreip.homeip.net>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRcdkz6hei1hwa3U"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBR7CTOLAKGQEOJY6CBI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140102203831.GA3239-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--wRcdkz6hei1hwa3U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 02, 2014 at 12:38:31PM -0800, Dmitry Torokhov wrote:
> On Thu, Jan 02, 2014 at 09:20:22PM +0100, Maxime Ripard wrote:
> > On Thu, Jan 02, 2014 at 02:45:29PM +0100, Hans de Goede wrote:
> > > >Also, instead of inventing yet another vendor-specific property, why=
 not re-use
> > > >a button binding similar to gpio-keys like:
> > > >
> > > >        lradc: lradc@01c22800 {
> > > >                compatible =3D "allwinner,sun4i-lradc-keys";
> > > >                reg =3D <0x01c22800 0x100>;
> > > >                interrupts =3D <31>;
> > > >                allwinner,chan0-step =3D <200>;
> > > >
> > > >		#address-cells =3D <1>;
> > > >		#size-cells =3D <0>;
> > > >
> > > >		button@0 {
> > > >			reg =3D <0>; /* your channel index from above */
> > > >			linux,code =3D <115>; /* already used as dt-property */
> > > >		};
> > > >
> > > >		button@1 {
> > > >			reg =3D <1>;
> > > >			linux,code =3D <114>;
> > > >		};
> > >=20
> > > Ugh no. Having a vendor specific property which is KISS certainly
> > > beats this, both wrt ease of writing dts files as well as wrt the
> > > dts parsing code in the driver.
> >=20
> > I'd agree with Heiko here. This is pretty much the same construct
> > that's already in use in other input drivers, like gpio-keys.
> >=20
> > This is also something that can really easily be made generic, since
> > this is something that is rather common.
>=20
> Except that button definition from gpio-keys does not use 'reg' property
> but rather gpio. I'd rather we did not cram non-applicable attributes
> into that definition just to make it "reusable" like that.
>=20
> I'd be OK with having similar (but not claiming to be the same) mappings
> though.

Yes, this is what I was meaning. Sorry if it was not clear enough.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--wRcdkz6hei1hwa3U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSxvBPAAoJEBx+YmzsjxAgq4kQAKsIIt8iHTRqb88kolOF9ilq
EzCeG0+z+JZgr3PDKzOmaoa4e4lRa+j9KG/TMCku5I+WHxX37Lp/2C2/omVK8Epu
m3/1YoFJLekW6pAzHMhsLB6oPxoML4g9YKQwLZCe3yYym/oS3Z2bsse/RwDTqZYT
AN9ZIp8SjgqEC+HuCSYZm4VvMdaFFUQ/qdnRvx01FH1sjB2u6Dws4ClXwMkn+B4U
U0STUo5iZIRh4x9BsXS1GQouy2ebUrs3JL7bPqNgCUkjrOPrfOjNCgHklkuZhAVB
1YTrAO3NtaYppE2t6r97yELc6RyqcZr+BIyaRtH7i39nYV4bLF1/8HCPPYTXJ3rs
Ssqh59WctlQM6yXadPtlPTzICFcQyeuKkOm1VXsLlSKlR/YwW7LJa/5L7eR7Tfln
BnhbGEGmiKtrlLDBW77v9dy6WunLLvdf9RHcr28//6bSkEX02e/wIkYPemPiMOuD
O/cR8Esp3pc4ro1/w5uYPru1eqEI08oi2Q3z4YF8NeC6gMlQ/FUsZENmbgKKqZ9y
cD1ai29V2RKCsdEf3XvgBW0wIR/Ir0i5fBs6nQYM/TBe9Xa24TXpywQty8yj3xx6
8UZEY2s8JtqxjpZzyYmj8+yfU2r6QzZ6cNtE9CGBpHKmzIlMTPiukJd7Asq8Lszl
Xyzg4tiWVtCVLNRSVS4D
=aIxj
-----END PGP SIGNATURE-----

--wRcdkz6hei1hwa3U--
