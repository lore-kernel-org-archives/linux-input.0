From: Daniel Stone <daniel@fooishbar.org>
Subject: Re: Warning: evdev changes - no auto-grabs anymore
Date: Fri, 15 Aug 2008 17:31:19 +0300
Message-ID: <20080815143119.GB2779@fooishbar.org>
References: <20080814044337.GA11632@emu>
	<1218725645.907.27.camel@thor.sulgenrain.local>
	<1218736209.4467.11.camel@localhost.localdomain>
	<20080815002458.GA16836@emu> <20080815065159.GA16680@sci.fi>
	<20080815080247.GA17613@fooishbar.org>
	<20080815082629.GB16680@sci.fi>
	<20080815100717.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2093089557=="
Return-path: <xorg-bounces@lists.freedesktop.org>
In-Reply-To: <20080815100717.ZZRA012@mailhub.coreip.homeip.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Mime-version: 1.0
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Michel D?nzer <michel@tungstengraphics.com>, xorg@lists.freedesktop.org
List-Id: linux-input@vger.kernel.org


--===============2093089557==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2008 at 10:10:10AM -0400, Dmitry Torokhov wrote:
> On Fri, Aug 15, 2008 at 11:26:29AM +0300, Ville Syrj?l? wrote:
> > On Fri, Aug 15, 2008 at 11:02:48AM +0300, Daniel Stone wrote:
> > > On Fri, Aug 15, 2008 at 09:51:59AM +0300, Ville Syrj?l? wrote:
> > > > I was pondering about the same issue wrt. DirectFB. I wonder if
> > > > KDSETMODE/KD_GRAPHICS could be extended to take care of this or
> > > > would it break some existing applications.
> > >=20
> > > Yeah, I was thinking about that, but that would mean we have issues
> > > under older kernels. I think the best was what I was proposing, which
> > > would be EVIOCSERIOUSLYDONTSENDANYCONSOLEINPUTWEWILLDEALWITHIT().
> >=20
> > Yeah that would be better since support for it could be detected runtime
> > so the driver could do the right thing when running with a recent kerne=
l,
> > and it could just fall back to the normal grab with old kernels.
>=20
> If evdev support in X is maturing why does it even need using tty and
> mousedev multiplexors? If you just use evdev for all of your devices
> you would not have the problem of duplicate events coming from 2
> interfaces.

We don't, and killing them is fine.  Even so, try doing that, and
realise that the TTY layer has helpfully spewed out every single thing
you've typed, oh, and Ctrl-C kills the X server.

So it would seem that an ioctl to say 'I'm dealing with this, don't let
the TTY layer and mousedev get at it' would be helpful, but one that
stops short of a full grab.

Cheers,
Daniel

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkilkzcACgkQUVYB1rKAgJS+7ACaAqiO5GQZbOaFYTwbKTIiBluj
gqEAn1zjvaJczLw9y1xxdY7qvLirB50z
=YAkU
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--

--===============2093089557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
xorg mailing list
xorg@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/xorg
--===============2093089557==--
