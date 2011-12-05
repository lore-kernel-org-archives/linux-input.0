From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: RE: adp5588-keys datasheet and driver question
Date: Mon, 05 Dec 2011 11:06:34 +0100
Message-ID: <1323079594.2989.51.camel@mars>
References: <1322928007.11453.32.camel@mars>
	 <544AC56F16B56944AEC3BD4E3D59177148733EAB39@LIMKCMBX1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40729 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755260Ab1LEKGj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Dec 2011 05:06:39 -0500
Received: by faar15 with SMTP id r15so337733faa.19
        for <linux-input@vger.kernel.org>; Mon, 05 Dec 2011 02:06:37 -0800 (PST)
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177148733EAB39@LIMKCMBX1.ad.analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Sun, 2011-12-04 at 21:12 +0000, Hennerich, Michael wrote:
> Christoph Fritz wrote on 2011-12-03:
> > Hi Michael,
> >
> >  I had a look at the adp5588-keys driver and its datasheet.
> > There are some "slips of the pen" in it (adp5588 Rev.b):
>=20
> Hi Christoph,
>=20
> Good catch - however typos in datasheets shouldn't be discussed here,=
 unless it
> influences the vital state of this driver.
>=20
> >   - Page 8, Table 12, "E4 pressed" refers to binary 1000 instead of=
 100
>=20
> Not only this obvious one - all others are wrong as well...
>=20
> >   - Page 17, Table 22, Register Descriptions are mostly wrong
>=20
> What's wrong with Table 22?

The column "Register Description" says "Key Event Register B [..]" for
register names KEY_EVENTD to KEY_EVENTJ. But for row KEY_EVENTA to
KEY_EVENTC it seems to be correct.

>=20
>=20
> > Another thing I'm curious about is in adp5588_report_events():
> >
> > int key =3D adp5588_read(kpad->client, Key_EVENTA + i); int key_val=
 =3D key
> > & KEY_EV_MASK; [...] input_report_key(kpad->input, kpad->keycode[ke=
y_val
> > - 1], key & KEY_EV_PRESSED);
> >
> > Why is there a -1 for key_val?
>=20
> Key_val =3D=3D 0, is not a valid event code!
> The part emits 1..80 for keys and 97..114 for GPI events.

ah, so mark =B2 below Table 22 is correct :)

> So bottom line - the driver is correct but Table 12 is completely wro=
ng.

Thanks,
 -- Christoph


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
