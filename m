From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Bug#622231: xserver-xorg-input-synaptics: synaptics driver not
 always used
Date: Sat, 19 Jan 2013 21:35:19 +0000
Message-ID: <1358631319.24121.62.camel@deadeye.wl.decadent.org.uk>
References: <20110509212417.GL25737@prunille.vinc17.org>
	 <20110716223759.GA14119@xvii.vinc17.org> <20120628014208.GA3372@burratino>
	 <20120628075544.GA11210@xvii.vinc17.org>
	 <20120820004328.GD15370@xvii.vinc17.org>
	 <20120820005448.GA614@mannheim-rule.local>
	 <20130108195618.GA1634@ypig.lip.ens-lyon.fr>
	 <20130110070116.GA5121@elie.Belkin>
	 <20130110210515.GA17973@xvii.vinc17.org>
	 <20130111003101.GF30784@google.com>
	 <20130111084850.GA12470@ioooi.vinc17.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-mn4i7ABJKE/A5J9ziXZ7"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37984 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751289Ab3ASVfc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Jan 2013 16:35:32 -0500
In-Reply-To: <20130111084850.GA12470@ioooi.vinc17.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, 622231@bugs.debian.org, Vincent Lefevre <vincent@vinc17.net>, linux-input@vger.kernel.org


--=-mn4i7ABJKE/A5J9ziXZ7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Vincent Lefevre reported that on a Dell Latitude E6400 the ALPS
DualPoint touchpad is sometimes detected as using generic PS/2 protocol
and not the ALPS protocol.  This can happen either at boot time or after
resume and with kernel versions ranging from at least 2.6.38 to 3.5.

He has now provided logs of the good and bad probes with i8042.debug=3D1,
which are attached to <http://bugs.debian.org/622231#160>.

Is there any more information he could provide that would help to debug
this?  Have you had any similar reports?

Ben.

--=20
Ben Hutchings
All the simple programs have been written, and all the good names taken.

--=-mn4i7ABJKE/A5J9ziXZ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUPsRl+e/yOyVhhEJAQq9fw/+L58yo0Yxnio+ywHZlmqbEoylW7xzyORp
5XB9lOg83diDCsRw/rlbxjx4RXh/h12J+NROQdfjwoX+LskJgO9KGQd7N8jtFMlL
TTVE/YaLlcTAeR00OLoJTOdfKaDoiviMsMlAnWAb1up2wAxtb6VNzClPaRILLwrL
k/awieXDiwSpzw2kYad8KDeYMqKf+P97mB1THhjAPLW+o4LHNdLSYyd0iWhha7dO
KPRYoAoxQyTM4zLVeiHtS/eotxhhgx73Lwf7GynOnEXFPPbTEKp0Jppx0OFtuW3W
XXH6m/CFySofaJJHCv1jjtVPbhJ8xfDvGVM5bQYyF1PiraRtAxlhx7a6c1PSE3Zk
3hVrYcPZo8I1ed8HxXvUNBCrQNOCdw5AOKbSMqVS0Q6EFo9lUSd8/mId6Ni0dwTQ
798vzZt6/hzjCLyHRIvXmfi2HzRFwYpAh+C7noNrPd0uDeQg1VFC8xIINIQSiY7R
c4EeJkTWSwhWp1nxsz+hEV97M4vJVuEl8GJps4TDRqXbLGsYSA5eQ7NYA2b/vLcc
KnIw11suc4RTgU7XrjYX8XBDO/CcXVEPXJL/dk671p9/lLLeFn1fMr2GoFOScoE/
Thh4J2lSTQ/LVRC7LBkGZ1salVplWLbM/Yv1i/AnqRbsmSTjBoSxOdqrHZBhoj45
fPXkQL/6mMg=
=Pdv/
-----END PGP SIGNATURE-----

--=-mn4i7ABJKE/A5J9ziXZ7--
