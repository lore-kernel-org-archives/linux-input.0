From: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Subject: Re: hidp_output_raw_report, HID_OUTPUT_REPORT and Sixaxis
Date: Thu, 17 Feb 2011 15:19:31 +0100
Message-ID: <20110217151931.d7ee7e29.ospite@studenti.unina.it>
References: <20101130145405.d8142bc3.ospite@studenti.unina.it>
	<id3cua$12v$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__17_Feb_2011_15_19_31_+0100_GHNHvhdWrBsK0iEB"
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <id3cua$12v$2@dough.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "pascal-dXI0m6hRz7k@public.gmane.org" <pascal-dXI0m6hRz7k@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

--Signature=_Thu__17_Feb_2011_15_19_31_+0100_GHNHvhdWrBsK0iEB
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Nov 2010 18:40:03 +0100
"pascal-dXI0m6hRz7k@public.gmane.org" <pascal-dXI0m6hRz7k@public.gmane.org> wrote:

Pascal, you were replying to linux-input only so some of the original
recipients missed your comments.

> Antonio Ospite wrote:
> > +++ b/net/bluetooth/hidp/core.c
> >  	case HID_OUTPUT_REPORT:
> > -		report_type =3D HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUPUT;
> > +		report_type =3D HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_OUPUT;
>=20
> > Is it only the Sixaxis which needs the output report as a SET_REPORT
> > operation, or the change above is an actual fix?
>=20
> My understanding of the Bluetooth HID Profile specification [1],
> section 7.4.9, is that on the control channel DATA is only for
> responding to an incoming GET_REPORT.  Since Linux is the HID
> Host, it will probably never need to reply to a GET_REPORT.
> So your patch looks good.
>

OK, I managed to study [1] a little bit, so yes, I also think my patch
is acceptable right now, but just because as you note in another
message hidp_output_raw_report() is relying only on the control channel.
In section 7.9.1 there's no mention of DATA for Output reports on the
Control channel (see also Figure 11: SET_ Flow Chart).

So I am resending it, it shouldn't hurt.

> Note that usbhid_output_raw_report() seems to send OUTPUT
> reports as USB interrupt messages and FEATURE reports as
> USB SET_REPORT control messages, which makes sense too.
> It would be nice if hidraw behaved the same over USB and
> over Bluetooth.  Unfortunately I don't think you can drive
> the sixaxis leds with DATA on the Bluetooth interrupt channel.
>

However, even if my patch gets is, Output reports on the Sixaxis will
stop working again as soon as someone implements the behavior you are
suggesting, that is:
  Feature Report -> SET_REPORT on the Control channel
  Output Report  -> DATA on the Interrupt channel

So I am going to submit the hidp_output_raw_report() override in
hid-sony.c as well, does this sound OK?

>=20
> [1] http://www.bluetooth.com/Specification%20Documents/HID_SPEC_V10.pdf
>=20

Regards,
  Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Thu__17_Feb_2011_15_19_31_+0100_GHNHvhdWrBsK0iEB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1dLnMACgkQ5xr2akVTsAHGkQCdG2MlsjDWOkrIV16UbZF4WT5a
lMkAnjRFt1dQcD82kUVhmYVZDxTF+r0f
=TNpi
-----END PGP SIGNATURE-----

--Signature=_Thu__17_Feb_2011_15_19_31_+0100_GHNHvhdWrBsK0iEB--
