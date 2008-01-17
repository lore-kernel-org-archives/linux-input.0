From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: support for Logitech Wave
Date: Thu, 17 Jan 2008 14:07:03 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801171403230.15647@twin.jikos.cz>
References: <alpine.OSF.0.99.0801151541290.326334@replicant.hut.fi>
 <20080116110244.ZZRA012@mailhub.coreip.homeip.net> <20080116215824.GA3797@localhost>
 <Pine.LNX.4.64.0801162259350.15647@twin.jikos.cz> <20080116231536.GA3844@localhost>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1747641777-1742669626-1200575223=:15647"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:48062 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751238AbYAQNHN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Jan 2008 08:07:13 -0500
In-Reply-To: <20080116231536.GA3844@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Taneli =?iso-8859-1?Q?V=E4h=E4kangas?= <taneli.vahakangas@welho.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Timo Aaltonen <tjaalton@cc.hut.fi>, linux-input@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1747641777-1742669626-1200575223=:15647
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 17 Jan 2008, Taneli V=E4h=E4kangas wrote:

> Thanks for prompt reply Jiri. Now I get some information for extra=20
> function keys at the top row, but still nothing for the "piano" keys.=20

That's strange. Could you please try to snoop the traffic on USB, to see=20
if the keys that don't produce any HID debugging output at all at least=20
produce some USB traffic?

See Documentation/usb/usbmon.txt for details.

> Here's the output for two previously non-functioning keys:
> Jan 17 00:27:13 newer kernel: drivers/hid/hid-core.c: report (size 4)
> (numbered)
> Jan 17 00:27:13 newer kernel: drivers/hid/hid-core.c: report 4 (size 3) =
=3D  02 00 00
> Jan 17 00:27:13 newer kernel: hid-debug: input ff00.0001 =3D 0
> Jan 17 00:27:13 newer kernel: hid-debug: input ff00.0001 =3D 1
> Jan 17 00:27:13 newer kernel: hid-debug: input ff00.0001 =3D 0
> Jan 17 00:27:13 newer last message repeated 13 times
> Jan 17 00:27:13 newer kernel: drivers/hid/hid-core.c: report (size 4) (nu=
mbered)
> Jan 17 00:27:13 newer kernel: drivers/hid/hid-core.c: report 4 (size 3) =
=3D  00 00 00
> Jan 17 00:27:13 newer kernel: hid-debug: input ff00.0001 =3D 0
> Jan 17 00:27:13 newer last message repeated 15 times

Hmm, this looks only like output for on key, is it really for two?

> Is this the information you asked? I can make you the full mapping of
> non-working keys to log messages. However, I don't think that's very
> useful if the "piano" keys don't work, as they're the main reason for
> having such a keyboard in the first place.

Yes, we'll need to figure out where the data from these keys are getting=20
lost.

> (I think all the log entries after 00:23:59 are key presses, but
> couldn't tell for sure.)

Yes, they are.

> BTW, here's a picture of the keyboard in question ... just in case my
> descriptions don't seem to make sense:
> http://images.tw.creative.com/images/corporate/artwork/hires_prodikeyspcm=
idiusb.jpg

Could it be that the keyboard is a totally separate device? Does alsa=20
report anything, when you connect it, for example?

--=20
Jiri Kosina
---1747641777-1742669626-1200575223=:15647--
