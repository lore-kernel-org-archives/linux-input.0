From: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Subject: Re: [PATCH] HID: Add Support for Setting and Getting Feature
 Reports from hidraw
Date: Tue, 8 Jun 2010 08:32:26 +0200
Message-ID: <20100608083226.2dac88d2.ospite@studenti.unina.it>
References: <1275969108-14948-1-git-send-email-alan@signal11.us>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__8_Jun_2010_08_32_26_+0200_4eITh4doWcuCJKD0"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1275969108-14948-1-git-send-email-alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Alexey Dobriyan <adobriyan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Stephane Chatty <chatty-rXV5z7KbLFk@public.gmane.org>, Michael Poole <mdpoole-IZmAEv5cUt1AfugRpC6u6w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

--Signature=_Tue__8_Jun_2010_08_32_26_+0200_4eITh4doWcuCJKD0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon,  7 Jun 2010 23:51:48 -0400
Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org> wrote:

> Per the HID Specification, Feature reports must be sent and received on
> the Configuration endpoint (EP 0) through the Set_Report/Get_Report
> interfaces.  This patch adds two ioctls to hidraw to set and get feature
> reports to and from the device.  Modifications were made to hidraw and
> usbhid.
>=20
> New hidraw ioctls:
>   HIDIOCSFEATURE - Perform a Set_Report transfer of a Feature report.
>   HIDIOCGFEATURE - Perform a Get_Report transfer of a Feature report.
>=20
> Signed-off-by: Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>
> ---

Thanks Alan, I am going to test this quite soon.

TBH, when I was thinking about how to extend hidraw I thought we could
have added a new report_type field to struct hidraw_report_descriptor,
in order to re-use the HIDIOCGRDESC ioctl handler itself, adding then a
HIDIOCSRDESC for setting the report. This looked cleaner to my eyes,
but I didn't actually implement this, so I don't know if it was
feasible, for instance one problem I didn't investigate further was
about the default value of the aforementioned report_type field in
order to keep the current behavior of HIDIOCGRDESC.

Regards,
   Antonio.

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

--Signature=_Tue__8_Jun_2010_08_32_26_+0200_4eITh4doWcuCJKD0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkwN4/oACgkQ5xr2akVTsAHaxwCgnbHHaDzQfJp3CE3MLkQiUGUh
biUAnR9QWfMf79hgN5Hv9tHu7A44V0xH
=ibSj
-----END PGP SIGNATURE-----

--Signature=_Tue__8_Jun_2010_08_32_26_+0200_4eITh4doWcuCJKD0--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
