From: Taneli =?iso-8859-1?Q?V=E4h=E4kangas?=
	<taneli.vahakangas@welho.com>
Subject: Re: support for Logitech Wave
Date: Thu, 17 Jan 2008 21:52:48 +0200
Message-ID: <20080117195248.GA8304@localhost>
References: <alpine.OSF.0.99.0801151541290.326334@replicant.hut.fi> <20080116110244.ZZRA012@mailhub.coreip.homeip.net> <20080116215824.GA3797@localhost> <Pine.LNX.4.64.0801162259350.15647@twin.jikos.cz> <20080116231536.GA3844@localhost> <Pine.LNX.4.64.0801171403230.15647@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6.pp.htv.fi ([213.243.153.40]:43489 "EHLO smtp6.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751046AbYAQTwu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Jan 2008 14:52:50 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0801171403230.15647@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@jikos.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Timo Aaltonen <tjaalton@cc.hut.fi>, linux-input@vger.kernel.org


Hello!

On Thu, Jan 17, 2008 at 02:07:03PM +0100, Jiri Kosina wrote:
> On Thu, 17 Jan 2008, Taneli V=E4h=E4kangas wrote:
>=20
> > Thanks for prompt reply Jiri. Now I get some information for extra=20
> > function keys at the top row, but still nothing for the "piano" key=
s.=20
>=20
> That's strange. Could you please try to snoop the traffic on USB, to =
see=20
> if the keys that don't produce any HID debugging output at all at lea=
st=20
> produce some USB traffic?
>=20
> See Documentation/usb/usbmon.txt for details.

I did that and there are no usbmon messages at all for the "piano" keys=
,
so this is most likely not linux-input or HID issue.

> > Here's the output for two previously non-functioning keys:
> > Jan 17 00:27:13 newer kernel: drivers/hid/hid-core.c: report (size =
4)
> > (numbered)
> > Jan 17 00:27:13 newer kernel: drivers/hid/hid-core.c: report 4 (siz=
e 3) =3D  02 00 00
> > Jan 17 00:27:13 newer kernel: hid-debug: input ff00.0001 =3D 0
> > Jan 17 00:27:13 newer kernel: hid-debug: input ff00.0001 =3D 1
> > Jan 17 00:27:13 newer kernel: hid-debug: input ff00.0001 =3D 0
> > Jan 17 00:27:13 newer last message repeated 13 times
> > Jan 17 00:27:13 newer kernel: drivers/hid/hid-core.c: report (size =
4) (numbered)
> > Jan 17 00:27:13 newer kernel: drivers/hid/hid-core.c: report 4 (siz=
e 3) =3D  00 00 00
> > Jan 17 00:27:13 newer kernel: hid-debug: input ff00.0001 =3D 0
> > Jan 17 00:27:13 newer last message repeated 15 times
>=20
> Hmm, this looks only like output for on key, is it really for two?

I'll check again later, I was quite confident last night that it was tw=
o
keypresses, but I was also quite tired ...

> > BTW, here's a picture of the keyboard in question ... just in case =
my
> > descriptions don't seem to make sense:
> > http://images.tw.creative.com/images/corporate/artwork/hires_prodik=
eyspcmidiusb.jpg
>=20
> Could it be that the keyboard is a totally separate device? Does alsa=
=20
> report anything, when you connect it, for example?

Unfortunately alsa notices nothing (that was also my first guess, so I
tried that even before reporting the problem here).

Could it be that hid steals the device and that's why alsa doesn't see
it?

Maybe the keyboard expects some kind of trigger from the host side to
enable the missing functionality. It apparently requires a separate
driver in windows and doesn't work in Mac OS X (that's why my sister
borrowed the keyboard to me, it didn't work with a Mac ...)

Thanks a lot for your time and responses Jiri.

Cheers,

	Taneli

-
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
