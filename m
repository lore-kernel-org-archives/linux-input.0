From: Pascal Wichmann <pascal.wichmann@pa-w.de>
Subject: Re: [4.12 regression] Thinkpad X250 Touchpad and Trackpoint not
 recognized anymore; commit e839ffa: "Input: synaptics - add support for
 Intertouch devices"
Date: Fri, 19 May 2017 21:37:32 +0200
Message-ID: <d9419ab0-8b77-7902-b048-c3eaab559c32@pa-w.de>
References: <41de7f92-8d98-3266-5d28-28ba48c5da38@pa-w.de>
 <C88AA3FF-8943-417D-AFC5-57CFFB3CA74E@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3GmkKKW82AUA9P9pIM0l2cGuK0CWuIK6J"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from web02.pwsrv.de ([188.68.38.65]:52750 "EHLO web02.pwsrv.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750748AbdESThf (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 May 2017 15:37:35 -0400
In-Reply-To: <C88AA3FF-8943-417D-AFC5-57CFFB3CA74E@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3GmkKKW82AUA9P9pIM0l2cGuK0CWuIK6J
Content-Type: multipart/mixed; boundary="Pl5wG7FhGWoU31AdeF0GP5hKSbT2N5GMp";
 protected-headers="v1"
From: Pascal Wichmann <pascal.wichmann@pa-w.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <d9419ab0-8b77-7902-b048-c3eaab559c32@pa-w.de>
Subject: Re: [4.12 regression] Thinkpad X250 Touchpad and Trackpoint not
 recognized anymore; commit e839ffa: "Input: synaptics - add support for
 Intertouch devices"
References: <41de7f92-8d98-3266-5d28-28ba48c5da38@pa-w.de>
 <C88AA3FF-8943-417D-AFC5-57CFFB3CA74E@gmail.com>
In-Reply-To: <C88AA3FF-8943-417D-AFC5-57CFFB3CA74E@gmail.com>

--Pl5wG7FhGWoU31AdeF0GP5hKSbT2N5GMp
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

> Do you have i801_smbus driver enabled and loaded?

I have the following line in my kernel configuration:

> CONFIG_I2C_I801=3Dm

Following i2c/smbus-related modules are loaded:

> lsmod | grep i2c
                                                                :(
> i2c_smbus              16384  0
> i2c_i801               24576  0
> i2c_algo_bit           16384  1 i915

lshw has the following output specifying i801_smbus as driver:

> *-serial
>      description: SMBus
>      product: Wildcat Point-LP SMBus Controller
>      vendor: Intel Corporation
>      physical id: 1f.3
>      bus info: pci@0000:00:1f.3
>      version: 03
>      width: 64 bits
>      clock: 33MHz
>      configuration: driver=3Di801_smbus latency=3D0
>      resources: irq:18 memory:f1238000-f12380ff ioport:efa0(size=3D32)


Thanks,
Pascal



--Pl5wG7FhGWoU31AdeF0GP5hKSbT2N5GMp--

--3GmkKKW82AUA9P9pIM0l2cGuK0CWuIK6J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE/gJ8Tpn0OtJz8hxD6+YIa34W/zYFAlkfSXwACgkQ6+YIa34W
/zZf2xAAltwqiuDh9fhsxRRGih7vJTYJ5Sn4TiBota/jcJdi3hWclUc/T+uS1kGV
NkrEJE2b10j4Ty/8ZvZ1bLRWofIQ0aHsGQvMroIlmqavzsmJyFD29OxNr0zxX8TF
fUqQXcStKUuOKX3MZg8oZI7+d7t1KRNOvd5L0IKkbTTapZBSmpR+wqiPdaT/GmkC
JN48dnDCaMyr9g78g+QpLwZNbh/W9oObiQvckZQKsyTFi76/+j0o6Eq4tnONISOe
viTlUo6l8NMG1ecRm1jIQjlN1G8NlzeLZuvd9r4XqKXcWdtNptabKoirx+ZyRaf0
DOK3NNygLShJWHq+OB92BQIBQgA72tCnRhFlZMWpwAJeRjAETY+6wxuEKWI7w/dK
WI/3E8MTMuGRsDpXY6Ow/UDcJ4U1/hw6gxoyT1w0V5H0uueEjTzMqntoO5OsJcRu
rAL0ttE5GlqJliCqkLJsK87A6EmIGl3C4AYhDm/5U9jUhZkBxNkmw9CqXwiyldZF
s44jcR2D6rs/IBD1dJImrWB1brxY7/mCJ5TBblE152Lb1wsr97xLRABFW2Du5nsL
8Hj7mGjAsGlVES9y8YDKxdNjXJ0oNO3JBZ/D8Myu8yxp/grHRGoa8/h8aymrwO+4
+KrU6aP03dFJzpGLWm1QQXRN7XJUZW3UbDZFkMbdCe100L/2e58=
=HcK5
-----END PGP SIGNATURE-----

--3GmkKKW82AUA9P9pIM0l2cGuK0CWuIK6J--
