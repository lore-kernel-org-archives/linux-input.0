From: Taneli =?iso-8859-1?Q?V=E4h=E4kangas?=
	<taneli.vahakangas@welho.com>
Subject: Re: support for Logitech Wave
Date: Thu, 17 Jan 2008 01:15:36 +0200
Message-ID: <20080116231536.GA3844@localhost>
References: <alpine.OSF.0.99.0801151541290.326334@replicant.hut.fi> <20080116110244.ZZRA012@mailhub.coreip.homeip.net> <20080116215824.GA3797@localhost> <Pine.LNX.4.64.0801162259350.15647@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp4.pp.htv.fi ([213.243.153.38]:47636 "EHLO smtp4.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755134AbYAPXPi (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Jan 2008 18:15:38 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0801162259350.15647@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@jikos.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Timo Aaltonen <tjaalton@cc.hut.fi>, linux-input@vger.kernel.org

On Wed, Jan 16, 2008 at 11:00:48PM +0100, Jiri Kosina wrote:
> On Wed, 16 Jan 2008, Taneli V=E4h=E4kangas wrote:
>=20
> > I tried the same on a Creative Prodikeys keyboard, but can't see an=
y=20
> > events for some keys (most notably none of the "piano" keys work). =
Is=20
> > there anything that can be done to make it work?
>=20
> Hi Taneli,
>=20
> yes. Could you please grab reasonably recent kernel (2.6.24-rc<anythi=
ng>=20
> would be ok), compile it with CONFIG_HID_DEBUG, modprobe the 'hid' mo=
dule=20
> with 'debug=3D1' parameter, and send me the output from the time you =
connect=20
> the keyboard and from pressing the non-working keys? It should be tri=
vial=20
> to fix then.

Thanks for prompt reply Jiri. Now I get some information for extra
function keys at the top row, but still nothing for the "piano" keys.
Here's the output for two previously non-functioning keys:


Jan 17 00:27:13 newer kernel: drivers/hid/hid-core.c: report (size 4)
(numbered)
Jan 17 00:27:13 newer kernel: drivers/hid/hid-core.c: report 4 (size 3)=
 =3D  02 00 00
Jan 17 00:27:13 newer kernel: hid-debug: input ff00.0001 =3D 0
Jan 17 00:27:13 newer kernel: hid-debug: input ff00.0001 =3D 1
Jan 17 00:27:13 newer kernel: hid-debug: input ff00.0001 =3D 0
Jan 17 00:27:13 newer last message repeated 13 times
Jan 17 00:27:13 newer kernel: drivers/hid/hid-core.c: report (size 4) (=
numbered)
Jan 17 00:27:13 newer kernel: drivers/hid/hid-core.c: report 4 (size 3)=
 =3D  00 00 00
Jan 17 00:27:13 newer kernel: hid-debug: input ff00.0001 =3D 0
Jan 17 00:27:13 newer last message repeated 15 times


Is this the information you asked? I can make you the full mapping of
non-working keys to log messages. However, I don't think that's very
useful if the "piano" keys don't work, as they're the main reason for
having such a keyboard in the first place.

There was a great deal of log messages at the time of plugging in the
keyboard. I didn't feel comfortable spamming the list with it, so it is
available at:
http://www.cs.helsinki.fi/u/vahakang/hid-dbg.txt

(I think all the log entries after 00:23:59 are key presses, but
couldn't tell for sure.)

BTW, here's a picture of the keyboard in question ... just in case my
descriptions don't seem to make sense:
http://images.tw.creative.com/images/corporate/artwork/hires_prodikeysp=
cmidiusb.jpg

Cheers,

	Taneli
-
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
