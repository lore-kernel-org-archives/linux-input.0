From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH] Route kbd LEDs through the generic LEDs layer (5th version)
Date: Sun, 21 Mar 2010 22:16:53 +0100
Message-ID: <20100321211653.GS12469@const.famille.thibault.fr>
References: <20100307200250.GA9340@const.famille.thibault.fr> <20100310133004.GM5127@const.bordeaux.inria.fr> <20100321210938.GB2057@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from solo.fdn.fr ([80.67.169.19]:55523 "EHLO solo.fdn.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752739Ab0CUVQ5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Mar 2010 17:16:57 -0400
Content-Disposition: inline
In-Reply-To: <20100321210938.GB2057@elf.ucw.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, mgarski@post.pl, linux-input@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>, Richard Purdie <rpurdie@rpsys.net>

Pavel Machek, le Sun 21 Mar 2010 22:09:38 +0100, a =E9crit :
> Now, minor comments:
>=20
> sometimes it uses "numl" (led name), sometimes it uses "numlock"
> trigger name.

Yes, I preferred to stick to the existing names: numl like LED_NUML, an=
d
numlock like VC_NUMLOCK.  I don't have any opinion on this however.

> root@amd:/sys/class/leds/input5::numl# echo heartbeat > trigger
>=20
> did not do the trick on my thinkpad. It still acts as numlock led. Is
> it driven by hw? input5::capsl works as expected.

If it is a laptop, it is likely, depending on the BIOS & such.
On my laptop, doing this works fine.

Samuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
