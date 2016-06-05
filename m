From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v7 1/4] i2c: add a protocol parameter to the alert
 callback
Date: Sun, 5 Jun 2016 09:17:28 +0200
Message-ID: <20160605071728.GC2722@katana>
References: <1464688985-19102-1-git-send-email-benjamin.tissoires@redhat.com>
 <1464688985-19102-2-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YD3LsXFS42OYHhNZ"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:41685 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559AbcFEHRv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 5 Jun 2016 03:17:51 -0400
Content-Disposition: inline
In-Reply-To: <1464688985-19102-2-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Corey Minyard <minyard@acm.org>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org


--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 31, 2016 at 12:03:02PM +0200, Benjamin Tissoires wrote:
> .alert() is meant to be generic, but there is currently no way
> for the device driver to know which protocol generated the alert.
> Add a parameter in .alert() to help the device driver to understand
> what is given in data.
>=20
> This patch is required to have the support of SMBus Host Notify protocol
> through .alert().
>=20
> Tested-by: Andrew Duggan <aduggan@synaptics.com

Checkpatch gives an error on this broken email address!


--YD3LsXFS42OYHhNZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXU9IIAAoJEBQN5MwUoCm2CmAP/2ko5eBWEUZ0/et+N+wQkRkO
XrvfF3inYM9HWQ+Uvw+ioFTXFJrYFOoq1tMZzd8nGJzg+ywFPpauNzSJdIeoGwBX
dHW++X8Ao2Mqlr7O3nOfhQND2D9EYY0uvO2UGlILHqNNRTc3pEkqOgctbkG2Mw8v
Let94aDa+2jZdeFG/yxTW/OdU/T+Y9aiuY6jYWLwVYupMJI8S8Ck51Z6We0YMEpl
uT+5mfp9hhWo7fe+EQbRLmpTvoRobok6MinvzHCBRC+yDMQrBKQMNd/i5KntQSlE
ZOv4Vc5tC1TriQUxc96FRtjXnqfOEoo9wUCa6fklLQ0HiwB9lf+2MruLMqofD1lq
6lIcMDno7S/KBLIIPhLcGND3dWcKrXZYkKcpcxCTk++HtDYauLVK5clysKUZOxOZ
1tkkF+6f+ZUqjROkDV5bgxwaCjP9zoG7RjIRBO0L7RDFA0ODzefNK9cUtnwtRTm5
hZpKEhX3GWqLB/zfLzkkyc8isb0oOpbJ57Bc345JDa5YddfBs5d8JTnZUfSu94cd
5ya+gNgtt108vtIzo0YpoQ5MyvE8RlUNfL3IOiJ62cA7f/O2PBnfairNJnuz6UIs
VV2wwtERep6kbvidzWPIa65/SN0dtz+1Td+RiBKTHny19mtP/yvY+KtS94L/nnZV
RaHYyOrqFuWt5p6xH+/H
=az6o
-----END PGP SIGNATURE-----

--YD3LsXFS42OYHhNZ--
