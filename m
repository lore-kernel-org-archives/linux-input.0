From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] HID: support i2c write-read and large transfers in
 hid-cp2112
Date: Thu, 18 Jun 2015 10:26:24 +0200
Message-ID: <20150618082624.GB1519@katana>
References: <1434183990-2324-1-git-send-email-ellen@cumulusnetworks.com>
 <CAAj6DX0w2p0h_wS2_T2+kU-zLEDo+adCmosPaUHWPVJeEpsaTw@mail.gmail.com>
 <55821717.2000609@cumulusnetworks.com>
 <CAAj6DX3aFvTdaE8GTh3YvFsnadbtszkyeArnFCuuhbtQnGu9kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:45843 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752545AbbFRI0a (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Jun 2015 04:26:30 -0400
Content-Disposition: inline
In-Reply-To: <CAAj6DX3aFvTdaE8GTh3YvFsnadbtszkyeArnFCuuhbtQnGu9kw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Borneo <borneo.antonio@gmail.com>
Cc: Ellen Wang <ellen@cumulusnetworks.com>, David Barksdale <dbarksdale@uplogix.com>, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, linux-i2c@vger.kernel.org


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Mine is rev 1 !!!
> Found also that in the datasheet chapter 12 reports the differences
> between the two revisions.
> In 12.1 it states that revision 1 does not implement repeated start. Perfect!
> I will try to replace my device with a newer one.

Can this be checked in the code?


--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVgoCwAAoJEBQN5MwUoCm2VJkQAKLS/ziCCxf8JPKFjslyUrB2
qQ6pu4HOCxqPw994uhTFPCB7rnnwYu8MzOWhwZFWiGbOIOOoaJaEJGN3mWAgDriw
kwByAJ8Rbt/ZJNF16PObpsfuBiOPM18HVgOm8YaBLbFQcQx7MZlMijTnJgY0Zhas
A02WH5fqfUq1fMMz+3zWBv1WzNvrqi43QOwRtHVwz+0PUt5JsZHzUMKxOAlvfmpu
4WVEXbenEL4VBElW/+8FZny7K+HlVrbNXsHirub/rOqzVGugYw1V1sYWME+1bEWU
44+fBQI5XHrSVqOSNARTju6rbaHJg88KckH+2N24UHzVlJTSNHK4rVKvi17Rp3UU
NS2ErLsyNW9ePJCexKL8L2Cjg+UBJgXxiLxXVqOYwOnzJ/0fIbxR2lUmZ6xWwUyf
ZaLfZqTx9nQEeaML77kzZYC3e2DW/N26V4H7GP6DxxVNo6ettUVDL/yQBlPYRI5+
GXFR+SWWhFJItF63ZbE0KgzO4bdKi5xEEljWXqQgp1yaZ+T0G7REe8DRsEdfEJfa
MTTesKyP7kJcIRyXyHAYWvP/Ve2hFRr05RP8ghR2/FOaGZ3TZIa5ZnErotFM0t80
3RFJGweLDzFlA/sYNq0TQVANltod77er35twTG87rekdGFZ4jDFs9S2iymtyoaZs
7OInAWNC88P2CeZgcI5G
=lRT8
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
