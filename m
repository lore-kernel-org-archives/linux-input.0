From: Phil Hannent <phil@hannent.co.uk>
Subject: Re: [PATCH] Input: add mmio xi driver
Date: Tue, 25 Nov 2008 09:48:15 +0000
Message-ID: <492BC9DF.2@hannent.co.uk>
References: <20080925232237.GA22938@suse.de> <20080925182055.f12f5d0b.randy.dunlap@oracle.com> <20080926031918.GA10083@suse.de> <48DCBEC3.2020904@hannent.co.uk> <20080926174607.GA700@suse.de> <Pine.LNX.4.64.0811242028360.15284@gremlin.cs.nmsu.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="------------enigB856ADC6129C24C814B3C08F"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from vm.orbit.me.uk ([89.16.177.134]:46641 "EHLO mail.orbit.me.uk"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752456AbYKYJ5b (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Nov 2008 04:57:31 -0500
In-Reply-To: <Pine.LNX.4.64.0811242028360.15284@gremlin.cs.nmsu.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: mwilder <mwilder@cs.nmsu.edu>
Cc: Greg KH <gregkh@suse.de>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB856ADC6129C24C814B3C08F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

mwilder wrote:
> What _is_ wrong with the driver?  I am guessing that phil@hannet.co.uk =
is=20
> just struggling with creating X bindings for the module, but I would li=
ke=20
> to hear some elaboration on what is actually happening here.  Enlighten=
=20
> me.
>  =20
Hello,

The driver is great, however I have been given the Mimio Xi protocol
documentation and it describes what all of the hex is doing.=20
Unfortunately I am not at liberty to share the documentation with
anybody due to an NDA, however I would hope that the code will be fairly
clear as to what's happening as a lot of the protocol hex I have setup
as defines.

The initialisation sequence in the current driver is just a series of
hex codes which I am reimplementing as per the Xi protocol.  Also the
board has on-board flash for the boards layout, dpi and firmware based
upgrade methods.  I am going to implement access to these.

I am also, as you state, working on the X side of things.=20

I certainly would not want to tread on your toes with regard to the
development of this driver, however as you had mentioned to me in the
past that you did not have the time to devote to this I decided to move
ahead with it myself.  Are you planing on making changes to the existing
driver?

Regards
Phil Hannent


--------------enigB856ADC6129C24C814B3C08F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (MingW32)

iEYEAREKAAYFAkkryd8ACgkQIdVDbqU9AOTtlwCgzDF0oWvlhHVcH1WmPZ55AbfM
ksYAn18b/5MTYM85GeiLEF8QcEQnN/v2
=JIBP
-----END PGP SIGNATURE-----

--------------enigB856ADC6129C24C814B3C08F--
