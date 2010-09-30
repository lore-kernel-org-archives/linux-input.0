From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH v4 1/2] HID: Add Support for Setting and Getting Feature
   Reports from hidraw
Date: Fri, 1 Oct 2010 00:03:09 +0200
Message-ID: <20101001000309.9bb53de4.ospite@studenti.unina.it>
References: <1281442367.12579.206.camel@localhost.localdomain>
	<1281990059-3562-2-git-send-email-alan@signal11.us>
	<20100930015104.49fc5acf.ospite@studenti.unina.it>
	<4CA40605.6080800@signal11.us>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__1_Oct_2010_00_03_09_+0200_0FHmAocwcvmXDD/1"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp207.alice.it ([82.57.200.103]:57696 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752122Ab0I3WDU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Sep 2010 18:03:20 -0400
In-Reply-To: <4CA40605.6080800@signal11.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

--Signature=_Fri__1_Oct_2010_00_03_09_+0200_0FHmAocwcvmXDD/1
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Sep 2010 23:37:41 -0400
Alan Ott <alan@signal11.us> wrote:

> On 09/29/2010 07:51 PM, Antonio Ospite wrote:
> > On Mon, 16 Aug 2010 16:20:58 -0400
> > Alan Ott<alan@signal11.us>  wrote:
> >
> >   =20
> >> Per the HID Specification, Feature reports must be sent and received on
> >> the Configuration endpoint (EP 0) through the Set_Report/Get_Report
> >> interfaces.  This patch adds two ioctls to hidraw to set and get featu=
re
> >> reports to and from the device.  Modifications were made to hidraw and
> >> usbhid.
> >>
> >> New hidraw ioctls:
> >>    HIDIOCSFEATURE - Perform a Set_Report transfer of a Feature report.
> >>    HIDIOCGFEATURE - Perform a Get_Report transfer of a Feature report.
> >>
> >> Signed-off-by: Alan Ott<alan@signal11.us>
> >> ---
> >>     =20
> > Some more testing with sixaxis and a question:
> >
> > HIDIOCGFEATURE on report 0xf5 returns:
> > <-- 01 00 00 03 c9 87 34 fd
> >            ^^ a hw addr from here
> >   =20
>=20
> Maybe I'm confused. Shouldn't the first byte of that be 0xf5? The report=
=20
> number should be the first byte of the returned buffer.
>
> There's not a chance you're running an old version of this patch is there?
>

v4 it is. About the first byte, is it very clear now than when _setting_
a report the first byte is the report descriptor even in the payload,
but when we are _getting_ it from the usb device, could a non conformant
device be mangling it?
=20
> > with the latest six octets being a hw addr; now if I wanted to change
> > this, *naively*, I'd send this report with HIDIOCSFEATURE:
> > -->  f5 01 00 66 55 44 33 22 11
> >      ^^ report ID _added_ in front of the whole previous buffer
> >
> > but then when I get the report again to see if the operation succeeded I
> > get:
> > <-- 01 00 00 66 55 44 33 22
> >
> > I can make it work if I send:
> > -->  f5 00 66 55 44 33 22 11
> >      ^^ report ID _replaced_ buf[0]
> >
> > then I get the expected:
> > <-- 01 00 66 55 44 33 22 11
> >
> > Am I missing something about the differences about getting a feature
> > report and setting it?
> >
> >   =20
>=20
> Do you have patches 29129a98e6f and c29771c2d8ce applied? They are in=20
> 2.6.36-rc6 (and some previous, but I'm note certain how far back). Those=
=20
> patches have to do with _sending_ the right bytes (in particular the=20
> report number) on the control endpoint. You seem to be having the=20
> opposite problem though. Let me know to be sure.
>

I confirm I have those changes applied, in fact I am working on top of
2.6.36-rc6, and yes, my doubt is about the buffer returned from a GET
FEATURE REPORT.

> > In the HIDIOCGFEATURE doc I read:
> > 	...
> > 	The report will be returned starting at
> > 	the first byte of the buffer (ie: the report number is not
> > 	returned).
> >
> > Someone (/me whistling, with hands in pockets) could interpret this
> > like a buf++ semantic on a quick read, even if this sentence means
> > "only" that _actual_data_ is from buf[1]; but one question stands: what
> > is that value returned in buf[0]? Is this unspecified?
> >
>=20
> So that was written when I had an incorrect understanding of the=20
> standard. It is wrong. I had originally thought that Report ID's were=20
> not sent on the control endpoint as part of the payload (because it's=20
> redundant, since it's in wValue). I was wrong, and made those two=20
> patches above to correct it.
>

Alan I am still talking about GET_FEATURE here, not SET, the question
here is what value the first byte (buf[0]) is expected to have in a
buffer returned from a GET. If it has to be the report ID then I
suspect my device is changing it behind our backs, maybe a failsafe
measure like the following could do?

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index df80532..83e1b48 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -875,6 +875,9 @@ static int usbhid_output_raw_report(struct hid_device *=
hid, __u8 *buf, size_t co
                        ((report_type + 1) << 8) | report_id,
                        interface->desc.bInterfaceNumber, buf, count,
                        USB_CTRL_SET_TIMEOUT);
+               /* restore report ID into the buffer, some non conformant u=
sb
+                * device could have mangled it */
+               buf[0] =3D report_id;
                /* count also the report id, if this was a numbered report.=
 */
                if (ret > 0 && skipped_report_id)
                        ret++;


But I haven't even taken a look at the HID spec about this, so take it
just for the sake of discussion. Anyone could run some tests with other
devices?

> > Maybe the doc could be made even more explicit about buf[0] to overcame
> > non native speakers deficiencies.
> > And while at it, can we get rid of the ambiguity of "first byte" for
> > "byte 1", the former can even mean buf[0], can't it?
> >   =20
>=20
> Your English is fine, my understanding was wrong :) .
>=20
> Alan.
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

--Signature=_Fri__1_Oct_2010_00_03_09_+0200_0FHmAocwcvmXDD/1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkylCR0ACgkQ5xr2akVTsAE4tQCeOsaTZrKYNewiM1EVZMcWuuWD
M/YAn3PrZc/k8Eq1AK0mIgl2dhpnoflC
=8wWC
-----END PGP SIGNATURE-----

--Signature=_Fri__1_Oct_2010_00_03_09_+0200_0FHmAocwcvmXDD/1--
