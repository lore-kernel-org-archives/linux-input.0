From: Forest Bond <forest-B/PTSs0AgtP3p6jHtUh95NHuzzzSOjJt@public.gmane.org>
Subject: Re: [PATCH resend2] Input: usbtouchscreen - initialize eGalax
 devices
Date: Fri, 7 Sep 2012 16:42:32 -0400
Message-ID: <20120907204232.GA24528@alittletooquiet.net>
References: <20120903132648.GC11919@newmaster.mivlgu.local>
 <20120903173349.GA18666@alittletooquiet.net>
 <20120905060704.GC25962@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120905060704.GC25962-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Daniel Ritz <daniel.ritz-OI3hZJvNYWs@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Tue, Sep 04, 2012 at 11:07:04PM -0700, Dmitry Torokhov wrote:
> On Mon, Sep 03, 2012 at 01:33:50PM -0400, Forest Bond wrote:
> > From: Forest Bond <forest.bond-XbHmxybg72Wcj+tRJgl41g@public.gmane.org>
> >=20
> > Certain eGalax devices expose an interface with class HID and protocol
> > None.  Some work with usbhid and some work with usbtouchscreen, but
> > there is no easy way to differentiate.  Sending an eGalax diagnostic
> > packet seems to kick them all into using the right protocol for
> > usbtouchscreen, so we can continue to bind them all there (as opposed to
> > handing some off to usbhid).
> >=20
> > This fixes a regression for devices that were claimed by (and worked
> > with) usbhid prior to commit 139ebe8dc80dd74cb2ac9f5603d18fbf5cff049f
> > ("Input: usbtouchscreen - fix eGalax HID ignoring"), which made
> > usbtouchscreen claim them instead.  With this patch they will still be
> > claimed by usbtouchscreen, but they will actually report events
> > usbtouchscreen can understand.  Note that these devices will be limited
> > to the usbtouchscreen feature set so e.g. dual touch features are not
> > supported.
> >=20
> > I have the distinct pleasure of needing to support devices of both types
> > and have tested accordingly.
> >=20
> > Signed-off-by: Forest Bond <forest.bond-XbHmxybg72Wcj+tRJgl41g@public.gmane.org>
>=20
> Applied, thank you Forest.

Great, thanks a lot.

The other piece to this puzzle is that usbhid should blacklist these device=
s to
avoid binding if it happens to be loaded before usbtouchscreen.  To do this,
usbhid needs to be able to blacklist devices based on interface protocol (r=
ight
now it only supports blacklist on VID + PID).

Would you accept a patch set that implements this?

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.rapidrollout.com

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlBKXDgACgkQRO4fQQdv5AzkXACcC3upb94AXzpSfWp+bnVDsd0S
oKkAoIGclBWWg1pWcPC+Ix8M6ojyWa+d
=wQdN
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
