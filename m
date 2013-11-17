From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Re: Re: [PATCH] HID: sony: Add force feedback support for Dualshock3 USB
Date: Sun, 17 Nov 2013 18:41:49 +0100
Message-ID: <1630060.CRNYjFIevc@sven-desktop>
References: <1384021557-24106-1-git-send-email-sven@narfation.org> <1567991.TNa7UhjX8Q@sven-desktop> <35271d19bf566dcc8d07fdb07d3c5830.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2002952.az1bVrKFBI"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from narfation.org ([79.140.41.39]:42084 "EHLO v3-1039.vlinux.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751591Ab3KQRlx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Nov 2013 12:41:53 -0500
In-Reply-To: <35271d19bf566dcc8d07fdb07d3c5830.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Colin Leitner <colin.leitner@gmail.com>


--nextPart2002952.az1bVrKFBI
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="iso-8859-1"

On Sunday 17 November 2013 12:38:43 simon@mungewell.org wrote:
> > So it is a bad choice to use hid_output_raw_report (which calls
> > usb_control_msg) in a ff_memless control function. I will just send a
> > revert
> > patch in some minutes.
> 
> Rather than revert, can't we just replace the raw call with
> 'hid_hw_request()' to send the data?

This device doesn't have any report and I had not the time to check how to 
correctly generate the fields manually for the report/check why it doesn't 
have any.

Kind regards,
	Sven
--nextPart2002952.az1bVrKFBI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABCgAGBQJSiP/eAAoJEF2HCgfBJntGLw0QAMwHqv654D8RTqcVqzWRX6tJ
TEhxjLTe5Rtde5oJ8usLERLWqwCyNDl7oGfCUKoKMI9K5zBLnZR41XqXWZ2e6OW7
M9eAYZh+4RCrG8Deb0USpW/NxrZ5bHlQ7lhz+eD3RMJ0uqBslfPp+7pEu6bxbWn4
hEg2dfFtRHlHWg22v1zHGW795U+9FUHiAKTai506dSubPrfvPYq0dJpooZqx11dd
WbMezT9tAb86GiFXhz3rteQNRGesc7aRn0AddmeA6u6m/djXo0Kf9s9TIEFvwfXf
GyKA69yrF/+CGMYIpJ0ZU63KikDnruzkjyIp9rmwY8Q0dbkC1UlwaV6//c6VvbOi
P6GC4sQS+QeXQ77dY7JDmXT6fKvcUwbQE3EMLftM2Tpct7lrYdOP2KB362IkN+xa
7nmr3maKd4YzT5O8eeWS6ZLIylOEdy7ExEZWIzuZqStfzfWs1OHPsySDJc2v4zDt
B58QrQOxuc7gCiXZ+Zx3d3pRIqQfMuEJWbJRohunvyWqBnLC41pbyrZ5vhD4ItJW
2hXuj7fo5oRyLb7EJQWa3DrbT2ZJWOsulN1uJhSLgkw5tHR1Rp6+6vvdvrJSIieZ
XaGbQ6cpHT1PgpWtwFAJJwF0zeoJhSH5/rV3gwSjqTEwJTTRE68CaXqvn5FQ8rwH
u1hP5LDerpDTw6IKoG9J
=LLmo
-----END PGP SIGNATURE-----

--nextPart2002952.az1bVrKFBI--

