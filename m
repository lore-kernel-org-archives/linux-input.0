From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: hidp_output_raw_report, HID_OUTPUT_REPORT and Sixaxis
Date: Wed, 1 Dec 2010 22:06:35 +0100
Message-ID: <20101201220635.ccba6b58.ospite@studenti.unina.it>
References: <20101130145405.d8142bc3.ospite@studenti.unina.it>
	<id3cua$12v$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__1_Dec_2010_22_06_35_+0100_ZsBi4JkdLLQ.mr+G"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp204.alice.it ([82.57.200.100]:33095 "EHLO smtp204.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757224Ab0LAVGo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 1 Dec 2010 16:06:44 -0500
In-Reply-To: <id3cua$12v$2@dough.gmane.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "pascal@pabr.org" <pascal@pabr.org>
Cc: linux-input@vger.kernel.org

--Signature=_Wed__1_Dec_2010_22_06_35_+0100_ZsBi4JkdLLQ.mr+G
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Nov 2010 18:40:03 +0100
"pascal@pabr.org" <pascal@pabr.org> wrote:

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

Hi Pascal,

I'll check with the specification you pointed at, and try to come up
with a meaningful commit message then.

> Note that usbhid_output_raw_report() seems to send OUTPUT
> reports as USB interrupt messages and FEATURE reports as
> USB SET_REPORT control messages, which makes sense too.

Well, but that does not work for sixaxis, it only accepts output
reports on the control endpoint, look at a recent hid-sony.c
overriding usbhid_output_raw_report().

> It would be nice if hidraw behaved the same over USB and
> over Bluetooth.  Unfortunately I don't think you can drive
> the sixaxis leds with DATA on the Bluetooth interrupt channel.
>

The non-standard USB behavior made me think that the patch proposed
could not be an actual fix but another non-standard sixaxis quirk; as I
said, I'll need to check this assumption against the document in [1].

> Pascal
>=20
> [1] http://www.bluetooth.com/Specification%20Documents/HID_SPEC_V10.pdf
>=20

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Wed__1_Dec_2010_22_06_35_+0100_ZsBi4JkdLLQ.mr+G
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkz2uNsACgkQ5xr2akVTsAGnPACfYbU8HTTm5koJ+CNg08UaNUgH
scUAn01clcgd2ljxkP5NVFxIGyBYelfB
=Lij6
-----END PGP SIGNATURE-----

--Signature=_Wed__1_Dec_2010_22_06_35_+0100_ZsBi4JkdLLQ.mr+G--
