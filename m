From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v8 2/4] i2c-smbus: add SMBus Host Notify support
Date: Fri, 17 Jun 2016 13:26:30 +0200
Message-ID: <20160617112630.GB6876@tetsubishi>
References: <1465484030-28838-1-git-send-email-benjamin.tissoires@redhat.com>
 <1465484030-28838-3-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465484030-28838-3-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Corey Minyard <minyard@acm.org>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 09, 2016 at 04:53:48PM +0200, Benjamin Tissoires wrote:
> SMBus Host Notify allows a slave device to act as a master on a bus to
> notify the host of an interrupt. On Intel chipsets, the functionality
> is directly implemented in the firmware. We just need to export a
> function to call .alert() on the proper device driver.
>=20
> i2c_handle_smbus_host_notify() behaves like i2c_handle_smbus_alert().
> When called, it schedules a task that will be able to sleep to go through
> the list of devices attached to the adapter.
>=20
> The current implementation allows one Host Notification to be scheduled
> while an other is running.
>=20
> Tested-by: Andrew Duggan <aduggan@synaptics.com>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied to for-next, thanks!


--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXY95kAAoJEBQN5MwUoCm2PksP/1CKxdlsv4CGUsDcB9p1KWAK
2NXvkX8STXB/UDcsk715P9dw4lZ9AWelwikBLE8JgHltIM4J8aKFbmszBjsTEJig
j/23wWsYvEOpODMJXamPVNxLHPA4N64NE9KuiW8JcPiCU+SlNUUoMdSe/jZetgy4
n0q2/ECURS4nMCjg44P8dSj6Orh8huQRnWOkEeptI6BGa7TfxfdUjvQbMl0RDmFk
L9fOIV9X6exFOB1haG1eijwi1ch+o2G2k8s1IYwzIfHk/i0wy2KD2qyzTIGm4IP9
YB52IaVgQnfOAZcRfcb0Yds58sq9OSFgE5W/BRyWYZdXLUQnH9gLO18bdg2cyD46
QI23Gi8xJToaLqgwag4MzeWgCcjkLfc1f3nNEliby2WItM4dzArm/oH669rq5zMP
rVlts0B+esS7sFEDbe88UWG3QaEu9oBwgrpnYV2xzXQlRX8q4MJKfL6V0JDYaR4S
9lCQtqDNqcgwS5iHB0V6aXLI4dVT9Ea5tD5mXkGG/cKnszijYgbyRguoMbEPe3V8
i5/4lIW83x3t6O6JpEYKZ3ha17e/L4N8vXXok372PIUJnGv5VDMxm9G6GP4SpvCV
/OcUhNdIHb8QkyFWIxoN+wCa3xulscCiFUx76+rrnppxJV0EeV4THBKmDnwy2EtK
lBNqxLU5FPwiyLlhF+uQ
=+DYJ
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
