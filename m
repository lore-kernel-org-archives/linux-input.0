From: Samuel Thibault <sthibault@debian.org>
Subject: Re: Bug#514464: caps lock led does not show up
Date: Thu, 11 Jun 2015 10:08:09 +0200
Message-ID: <20150611080809.GD3184@type.bordeaux.inria.fr>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
 <20090205113908.GA14224@const.inria.fr>
 <20150609141723.GE3045@type>
 <20150609160339.GB26687@logic.fmi.uni-sofia.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:36217 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750999AbbFKIIM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Jun 2015 04:08:12 -0400
Content-Disposition: inline
In-Reply-To: <20150609160339.GB26687@logic.fmi.uni-sofia.bg>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anton Zinoviev <anton@lml.bas.bg>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 514464@bugs.debian.org

Hello,

Anton Zinoviev, le Tue 09 Jun 2015 19:03:39 +0300, a =E9crit :
> On Tue, Jun 09, 2015 at 04:17:23PM +0200, Samuel Thibault wrote:
> >=20
> > Dmitry Torokhov, le Mon 08 Jun 2015 14:43:07 -0700, a =E9crit :
> > > If user wants all keyboards to light up CapsLock LED when VT stat=
e locks
> > > CtrlL modifier they need to write a udev rule or similar to set u=
p
> > > "kbd-ctrlllock" trigger for all appearing "input%::capslock" LED =
class
> > > devices.
> >=20
> > Anton, this is the interface proposed by the input maintainer, Dmit=
ry,
> > to change which modifiers gets to light the keyboard LEDs (the exac=
t
> > names may change, but the principle should be firm).  I know this i=
s
> > inconvenient for console-setup for handling hotplugged keyboards,
>=20
> Ok, the inconvenience is not a problem.  The problem is I don't=20
> understant the meaning of this. :)
>=20
> Is there some documentation or a sample code I can read?

Putting

SUBSYSTEM=3D=3D"leds", ENV{DEVPATH}=3D=3D"*/input*::capslock", ATTR{tri=
gger}=3D"kbd-ctrlllock"

in /etc/udev/rules.d/50-leds.rules seems to be doing the work. It'd be
good to include this in the documentation along the patch.

Samuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
