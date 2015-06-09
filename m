From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/3] Switch input leds over to standard LED class devices
Date: Tue, 9 Jun 2015 13:28:09 +0200
Message-ID: <20150609112809.GA26267@amd>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
 <20150609105421.GA15814@amd>
 <20150609111242.GA21235@amd>
 <20150609112221.GB31071@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35896 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbbFIL2L (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 07:28:11 -0400
Content-Disposition: inline
In-Reply-To: <20150609112221.GB31071@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Tue 2015-06-09 13:22:21, Pali Roh=E1r wrote:
> On Tuesday 09 June 2015 13:12:42 Pavel Machek wrote:
> > On Tue 2015-06-09 12:54:21, Pavel Machek wrote:
> > > I did echo kbd-capslock > trigger, but still no luck. (That might=
 be
> > > bug in Debian, IIRC?)
> >=20
> > I tried rebooting with stock Debian kernel, and the bug is there, t=
oo.
> >=20
> > Best regards,
> > 									Pavel
>=20
> Is not trigger only kernel part? If yes, then replacing kernel should
> not cause any Debian related bug, right?

I'm not input expert, but when the LED light does not work with kernel
debian ships, I don't expect it to work with patched 4.1.

(And someone mentioned Debian being broken in that regard.)
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
