From: Benson Leung <bleung-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] HID: usbhid: get/put around clearing needs_remote_wakeup
Date: Mon, 11 Sep 2017 13:02:52 -0700
Message-ID: <20170911200252.GB41615@decatoncale.mtv.corp.google.com>
References: <20170908174337.GA13616@dtor-ws>
 <1504942552.10395.2.camel@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1504942552.10395.2.camel-IBi9RG/b67k@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Guenter Roeck <groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bleung-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
List-Id: linux-input@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Oliver,

On Sat, Sep 09, 2017 at 09:35:52AM +0200, Oliver Neukum wrote:
> Am Freitag, den 08.09.2017, 10:43 -0700 schrieb Dmitry Torokhov:
> > From: Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> >=20
> > usbhid->intf->needs_remote_wakeup is set when a device is opened, and is
> > cleared when a device is closed.
> >=20
> > In usbhid_open, usb_autopm_get_interface is called before setting the
> > needs_remote_wakeup flag, and usb_autopm_put_interface is called after
> > hid_start_in. However, when the device is closed in usbhid_close, we
> > simply reset the flag and the device stays awake even though it could be
> > suspended.
>=20
> Hi,
>=20
> but if the device is asleep, we do not want to wake it just to reset
> the flag. Please use the no resume varieties. They did not exist when this
> code was written and that is the reason behind the current code.
>=20

Thanks for the pointer. I'll respin the patch with the no_resume version of
usb_autopm_get_interface and retest.

Benson

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
Chromium OS Project
bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJZtuvsAAoJEB8J9XsKL+ZY3w8P/1BcsO+P9sB0tMH2rNyDNg9z
kt6vXOA8nXjt9gP1MpPkxWPRTHPRieSr+3lvQaJtp3q/cwfdGH5pwve2fpHRvSiQ
ZafI4Lr0xWjIQ/8c3GJtcK5FPCPBbrS3a9TwhAU/UZWyqN/b2ql1r6jymgQaNnnW
xDlsULT0P1xt+wWSXEBX6r0PM3+667qDZgTXLf+E2FrLqYrd+AsVn+ilOOUZ+ZMU
FS+UJKoLPuC1n3Vwg5lTER4lWYSneqa9/oimZuA1tbL42yyWWVl53topZfOxkqp9
PYWfO7ika1mNN7duAetyF4SV0Z1c/Fk6V53IzH5XUdJEuz744exJ61zKrTn+ntXP
L8pryTZu7Q6bEVA3k1y57p1GkAP/yOckikee+Ty6Xex4iz3xIcO7504xlXuJsOUY
ga9TCA+SSDnVrYe6HMKQXhho2cCaVfLWNAKItiqNPMp/Dd9zF1/W271S0IHZdSnd
WhUl0OyFLyciG0eihRoOCkS8ONV71M3G+NDiQI5LOqc3x+IbByFpDWwWyxTT6WKv
ISkd6C06EUHR1Hz0qcLf+rSt5v9NcbqWfeKXRnkjyv5szMGtfHl4WaD689QItlfs
ouTvC8CM7Gv011IXTPyuZPoAPJlgg3CR63Q72xuUfE7hTfhGuY3HUTGqMzORi0Xx
Hz+wrpNgwSTxL2TWIX8f
=o3z5
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
