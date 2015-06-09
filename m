From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH 0/3] Switch input leds over to standard LED class devices
Date: Tue, 9 Jun 2015 14:22:21 +0200
Message-ID: <20150609122221.GC7999@type.lan>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
 <20150609105421.GA15814@amd>
 <20150609111242.GA21235@amd>
 <20150609112221.GB31071@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sonata.ens-lyon.org ([140.77.166.138]:49016 "EHLO
	sonata.ens-lyon.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753702AbbFIM1i (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 08:27:38 -0400
Content-Disposition: inline
In-Reply-To: <20150609112221.GB31071@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Pali Roh=E1r, le Tue 09 Jun 2015 13:22:21 +0200, a =E9crit :
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
>=20
> Is not trigger only kernel part?

Yes, but depending on the keyboard layout configuration, the capslock
key will toggle a different modifier, and only the capslock modifier
modifies the capslock LED by default.

Whether it's a Debian kernel or a pristine kernel does not matter,
though, as you said.

Samuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
