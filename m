From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 0/6] Fixes for ALPS trackstick
Date: Thu, 15 Jan 2015 21:28:41 +0100
Message-ID: <201501152128.41419@pali>
References: <1421276154-8689-1-git-send-email-dmitry.torokhov@gmail.com> <201501152019.59611@pali> <20150115193818.GA19367@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart21219821.qb3L8Vr2pK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:54412 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbbAOU2o (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Jan 2015 15:28:44 -0500
Received: by mail-wg0-f44.google.com with SMTP id y19so17094695wgg.3
        for <linux-input@vger.kernel.org>; Thu, 15 Jan 2015 12:28:43 -0800 (PST)
In-Reply-To: <20150115193818.GA19367@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

--nextPart21219821.qb3L8Vr2pK
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 15 January 2015 20:38:18 Dmitry Torokhov wrote:
> On Thu, Jan 15, 2015 at 08:19:59PM +0100, Pali Roh=C3=A1r wrote:
> > On Thursday 15 January 2015 19:18:20 Dmitry Torokhov wrote:
> > > On Thu, Jan 15, 2015 at 11:49:32AM +0100, Pali Roh=C3=A1r wrote:
> > > > On Wednesday 14 January 2015 23:55:48 Dmitry Torokhov=20
wrote:
> > > > > Hi Pali,
> > > > >=20
> > > > > This series try to address the issue you brought
> > > > > regarding trackstick initialization on Dell Latitudes
> > > > > in a different way than the patches you proposed.
> > > > > Basically in this series we move resetting and all
> > > > > detection in alps_detect() and make sure we keep the
> > > > > state so alps_init() can reuse it and not perform the
> > > > > detection all over again. Doing this allows us to set
> > > > > up device characteristics (name, version, etc)
> > > > > properly from the get go while still performing reset
> > > > > only once.
> > > > >=20
> > > > > This is untested as I do not have any ALPS devices
> > > > > anymore so I'd appreciate you giving it a spin.
> > > > >=20
> > > > > Thanks!
> > > >=20
> > > > Hi Dmitry,
> > > >=20
> > > > on top of which branch/repository should I apply your
> > > > patches?
> > >=20
> > > Should be applicable to my 'next' branch (which I just
> > > upreved to 3.19-rc4).
> > >=20
> > > Thanks.
> >=20
> > Not working at top of next (0c3e994).
> >=20
> > Applying: Input: ALPS - renumber protocol numbers
> > Applying: Input: ALPS - make Rushmore a separate protocol
> > error: patch failed: drivers/input/mouse/alps.c:1275
> > error: drivers/input/mouse/alps.c: patch does not apply
> > Patch failed at 0002 Input: ALPS - make Rushmore a separate
> > protocol
>=20
> Hmm.. I created a new alps branch (based on 3.19-rc4), can you
> try it?
>=20
> Thanks.

Compiled from your new alps branch (with "if (!priv)" fix) and=20
modprobing psmouse.ko caused laptop freeze :-( Even sysrq not=20
responded. So something is not working...

(My original patch series worked fine on my laptop, so when you=20
reused my code it should work)

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart21219821.qb3L8Vr2pK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlS4IvkACgkQi/DJPQPkQ1JfLgCfVmGSR8YRKVAuy8bY0rlOXQIZ
8DoAn2nqM9AEZ/ANvCQOwXZoAUxK7TQE
=PWWG
-----END PGP SIGNATURE-----

--nextPart21219821.qb3L8Vr2pK--
