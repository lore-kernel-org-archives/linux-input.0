From: "Daniil V. Kolpakov" <dan@riga.lv>
Subject: Re: evdev and Trust TB-5300 tablet: wrong axis labels
Date: Sun, 13 Dec 2009 23:36:27 +0200
Message-ID: <200912132336.28284.dan@riga.lv>
References: <200912130058.46220.dan@riga.lv> <200912131825.03872.dan@riga.lv> <200912132323.36619.dan@riga.lv>
Reply-To: "Daniil V. Kolpakov" <dan@riga.lv>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from dan.tet.rtu.lv ([217.195.52.165]:43216 "HELO dan.tet.rtu.lv"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753308AbZLMVgb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Dec 2009 16:36:31 -0500
In-Reply-To: <200912132323.36619.dan@riga.lv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: xorg@lists.freedesktop.org, Matthew Helsley <matt.helsley@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org

=F7 =D3=CF=CF=C2=DD=C5=CE=C9=C9 =CF=D4 13 =C4=C5=CB=C1=C2=D2=D1 2009 Da=
niil V. Kolpakov =CE=C1=D0=C9=D3=C1=CC(a):
> =F7 =D3=CF=CF=C2=DD=C5=CE=C9=C9 =CF=D4 13 =C4=C5=CB=C1=C2=D2=D1 2009 =
Daniil V. Kolpakov =CE=C1=D0=C9=D3=C1=CC(a):
> > I can't find any information on how to enable quirks through sysfs =
(and
> >  where  to get list of available quirks, too). Can you point me to =
some
> >  documentation on this subject?
>=20
> Hmm, it must be /sys/module/usbhid/parameters/quirks file! But what's=
 the
> format, and how do I know the values for enabling "MULTI" quirk?
>=20

$ /sbin/modinfo usbhid | grep quirks
parm:           quirks:Add/modify USB HID quirks by specifying =20
quirks=3DvendorID:productID:quirks where vendorID, productID, and quirk=
s are all=20
in 0x-prefixed hex (array of charp)

I guess reading usbhid source should drop some light on my question :)

--=20
Please avoid sending me Word or PowerPoint attachments.
See http://www.gnu.org/philosophy/no-word-attachments.html

Support open standards! Take a look at this nice presentation:
http://www.dwheeler.com/essays/open-standards-security.pdf
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
