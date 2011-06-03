From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH v2 3/3] Add sixaxis plugin: USB pairing and LEDs
 settings
Date: Fri, 3 Jun 2011 13:59:04 +0200
Message-ID: <20110603135904.096660bc.ospite@studenti.unina.it>
References: <1298628292-8842-1-git-send-email-ospite@studenti.unina.it>
	<1298628292-8842-4-git-send-email-ospite@studenti.unina.it>
	<1304644488.16101.28.camel@novo.hadess.net>
	<20110507011412.ba0ad1e9.ospite@studenti.unina.it>
	<1304787442.2427.11.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__3_Jun_2011_13_59_04_+0200_mVEDVqtRpixb3rl3"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp209.alice.it ([82.57.200.105]:58874 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754497Ab1FCL7J (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 3 Jun 2011 07:59:09 -0400
In-Reply-To: <1304787442.2427.11.camel@novo.hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org, linux-input@vger.kernel.org, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, "Pascal A . Brisset" <pascal44973@pabr.org>, Marcin Tolysz <tolysz@gmail.com>, Christian Birchinger <joker@netswarm.net>, Filipe Lopes <falktx@gmail.com>, Alan Ott <alan@signal11.us>, Mikko Virkkila <virkkila@kapsi.fi>

--Signature=_Fri__3_Jun_2011_13_59_04_+0200_mVEDVqtRpixb3rl3
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 07 May 2011 17:57:07 +0100
Bastien Nocera <hadess@hadess.net> wrote:

> On Sat, 2011-05-07 at 01:14 +0200, Antonio Ospite wrote:
> > On Fri, 06 May 2011 02:14:38 +0100
> > Bastien Nocera <hadess@hadess.net> wrote:
> >=20
> > > On Fri, 2011-02-25 at 11:04 +0100, Antonio Ospite wrote:
> > > > +                       [AC_LANG_PROGRAM([[
> > > > +                               #include <sys/ioctl.h>
> > > > +                               #include <linux/hidraw.h>
> > > > +                               #if ! (defined(HIDIOCSFEATURE) &&
> > > > defined(HIDIOCGFEATURE))
> > > > +                               #error "HIDIOCSFEATURE and
> > > > HIDIOCGFEATURE are required (linux-libc-dev >=3D 2.6.3x)"
> > > > +                               #endif
> > > > +                               ]],=20
> > >=20
> > > The only part of the patch I have a problem with is this one.
> > >=20
> > > I'd rather the code had:
> > > #ifndef HIDIOCSFEATURE
> > > #define HIDIOCSFEATURE bleh
> > > #endif
> > >=20
[...]
> Again, it's not compiling against older kernels. but compiling against
> older kernel headers, which is a wildly different thing.
>=20
> I'd like the plugin to be enabled, even if building with older kernel
> headers, as those have no relation to the capabilities of the running
> kernel.
>=20
> It would also make the whole thing easier to test (just install a newer
> kernel with the patches merged in, and voila, working sisaxis pairing).
>=20

Bastien, I'd fulfill your request on the lines of the following
WIP patch, the intent is to make the plugin compile unconditionally
still mentioning the soft dependency on 2.6.39-rc1.
I could have set HAVE_HIDIOCxFEATURE in acinclude.m4 and checked for
that in sixaxis.c in place of the explicit ifdefs, what is the common
practice about that?

I still have to take care of the runtime check when running on older
kernels.

Regards,
   Antonio

diff --git a/acinclude.m4 b/acinclude.m4
index 901bb4d..e3e0fdd 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -167,12 +167,12 @@ AC_DEFUN([AC_PATH_SIXAXIS], [
 			)],[
 				ac_cv_have_HIDIOCxFEATURE=3Dyes
 			],[
-				ac_cv_have_HIDIOCxFEATURE=3D"no, get linux-libc-dev >=3D 2.6.39-rc1"
+				ac_cv_have_HIDIOCxFEATURE=3D"no, emulating linux-libc-dev >=3D 2.6.39-=
rc1"
 			]
 		)]
 	)
=20
-	if ( test "${udev_found}" =3D "yes" && test "${ac_cv_have_HIDIOCxFEATURE}=
" =3D "yes" ); then
+	if ( test "${udev_found}" =3D "yes" ); then
 		sixaxis_plugin_deps_found=3Dyes
 	fi
 ])
diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 49aad25..fc12878 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -58,6 +58,16 @@
 #include "storage.h"
 #include "sdp_lib.h"
=20
+/* Fallback definitions to compile with older headers */
+#ifndef HIDIOCGFEATURE
+#define HIDIOCGFEATURE(len)    _IOC(_IOC_WRITE|_IOC_READ, 'H', 0x07, len)
+#endif
+
+#ifndef HIDIOCSFEATURE
+#define HIDIOCSFEATURE(len)    _IOC(_IOC_WRITE|_IOC_READ, 'H', 0x06, len)
+#endif
+
+
 #define BDADDR_STR_SIZE 18 /* strlen("00:00:00:00:00:00") + 1 */
=20
 /* Vendor and product ID for the Sixaxis PS3 controller */


--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Fri__3_Jun_2011_13_59_04_+0200_mVEDVqtRpixb3rl3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3ozIgACgkQ5xr2akVTsAE+TgCeO6V5b15L/AA1dSZhK/O1Ubee
8vsAnjtDY2jApXcjfyupNiBxMwghxBrT
=DQd9
-----END PGP SIGNATURE-----

--Signature=_Fri__3_Jun_2011_13_59_04_+0200_mVEDVqtRpixb3rl3--
