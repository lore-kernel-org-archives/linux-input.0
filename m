From: Pascal Wichmann <pascal.wichmann@pa-w.de>
Subject: Re: [4.12 regression] Thinkpad X250 Touchpad and Trackpoint not
 recognized anymore; commit e839ffa: "Input: synaptics - add support for
 Intertouch devices"
Date: Sat, 20 May 2017 07:47:08 +0200
Message-ID: <59adce69-743d-98f1-ece7-1197c49e1b5e@pa-w.de>
References: <41de7f92-8d98-3266-5d28-28ba48c5da38@pa-w.de>
 <C88AA3FF-8943-417D-AFC5-57CFFB3CA74E@gmail.com>
 <d9419ab0-8b77-7902-b048-c3eaab559c32@pa-w.de>
 <20170519202303.GA19281@dtor-ws>
 <a345b319-5d8c-e9ac-a9ef-dd4fdd45047a@pa-w.de>
 <20170519204914.GD19281@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oKO4sutGBENMTPw8EpF6b5cXLUvpRsrw0"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from web02.pwsrv.de ([188.68.38.65]:33968 "EHLO web02.pwsrv.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751910AbdETFrQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 20 May 2017 01:47:16 -0400
In-Reply-To: <20170519204914.GD19281@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oKO4sutGBENMTPw8EpF6b5cXLUvpRsrw0
Content-Type: multipart/mixed; boundary="6wc0RxPQTkuKCdBSNNjfN1pMIkPnkKurN";
 protected-headers="v1"
From: Pascal Wichmann <pascal.wichmann@pa-w.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <59adce69-743d-98f1-ece7-1197c49e1b5e@pa-w.de>
Subject: Re: [4.12 regression] Thinkpad X250 Touchpad and Trackpoint not
 recognized anymore; commit e839ffa: "Input: synaptics - add support for
 Intertouch devices"
References: <41de7f92-8d98-3266-5d28-28ba48c5da38@pa-w.de>
 <C88AA3FF-8943-417D-AFC5-57CFFB3CA74E@gmail.com>
 <d9419ab0-8b77-7902-b048-c3eaab559c32@pa-w.de>
 <20170519202303.GA19281@dtor-ws>
 <a345b319-5d8c-e9ac-a9ef-dd4fdd45047a@pa-w.de>
 <20170519204914.GD19281@dtor-ws>
In-Reply-To: <20170519204914.GD19281@dtor-ws>

--6wc0RxPQTkuKCdBSNNjfN1pMIkPnkKurN
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

> Looks like you running your patched kernel?
That's right.


>>> CONFIG_RMI4_CORE=3Dm
>>> CONFIG_RMI4_I2C=3Dm
>>> CONFIG_RMI4_SPI=3Dm
>>> # CONFIG_RMI4_SMB is not set
>
> This is your issue I believe.

Indeed, enabling that configuration solves that issue.

However, I think it is quite unintuitive that a module (psmouse) chooses
a default mode which requires another driver which is not necessarily
included; though it would probably be not a very clean solution to
explicitly check that as well.

Is this behaviour, that one module requires another without
communicating that clearly, wanted?

Thanks,
Pascal



--6wc0RxPQTkuKCdBSNNjfN1pMIkPnkKurN--

--oKO4sutGBENMTPw8EpF6b5cXLUvpRsrw0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE/gJ8Tpn0OtJz8hxD6+YIa34W/zYFAlkf2GAACgkQ6+YIa34W
/zbXqw/6A6h64nQ+wikU3B4/8BbE117PkNzsTZOqsZfgkbJ3RGYFrqJOr+Xf6Z4h
GvvorBGHQT8kywp5hAFtdYxCBWSx5D1T9hMKT09xXjVMILbjuufKk+8msXO8MhIE
KgcNkXjAqlOFLl8yUd1rTWcFIldAF5cwy2xO1+O9J22WRY2j6cKRwZl01UXXeJsY
CtDRU9qOPjI1jXzFRzWOjlrqxFyQQN3LHe4xCKPU5TRkjmu/p7Bno+7nnXZbUvYh
GsGiFa4EJ3UEdbDu0mg+9ZhbFABfCJReTGQW4dPBp4COB6SqfIhpT4ih14FHKaEs
u3v3jItiOL0v4cRt3/S5gg45tG9UGwEF+KHayYs9JamnntbDELI3iEGZBWTu4CmI
FdHHpOpgQawAxLc502+4tuO1VeYxYXu3VJmKXvq62YCUPghbYloQteOGDgdwhXxY
b4PHbgDULwfp0CjOtDaOtAfr1bZeuG5td00M27cw6ikodD89cFBjW/IyIFUjimdS
28x/z3qWbny24khRg2Nxfd8ErrKXMTEQY5sz9nMUyKlYx/Va6r1UQGJmKPB4ifbm
fcG960wxzEJnIWn+wOKcio+FYq8XOukX3fxFhcKUiw+MLIZPnhU08BhlCW/N5kAp
4UHGWJ6IiJ9AWu/WELIgIU4vyHlcKVfwB0WTVJ5i5XQhc3r50fA=
=JdXY
-----END PGP SIGNATURE-----

--oKO4sutGBENMTPw8EpF6b5cXLUvpRsrw0--
