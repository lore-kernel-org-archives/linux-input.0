From: Anton Zinoviev <anton@lml.bas.bg>
Subject: Re: Bug#514464: caps lock led does not show up
Date: Tue, 9 Jun 2015 19:03:39 +0300
Message-ID: <20150609160339.GB26687@logic.fmi.uni-sofia.bg>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
 <20090205113908.GA14224@const.inria.fr>
 <20150609141723.GE3045@type>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lml.bas.bg ([213.191.204.61]:59713 "EHLO lml.bas.bg"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753893AbbFIQXu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Jun 2015 12:23:50 -0400
Content-Disposition: inline
In-Reply-To: <20150609141723.GE3045@type>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 514464@bugs.debian.org

On Tue, Jun 09, 2015 at 04:17:23PM +0200, Samuel Thibault wrote:
>=20
> Dmitry Torokhov, le Mon 08 Jun 2015 14:43:07 -0700, a =E9crit :
> > If user wants all keyboards to light up CapsLock LED when VT state =
locks
> > CtrlL modifier they need to write a udev rule or similar to set up
> > "kbd-ctrlllock" trigger for all appearing "input%::capslock" LED cl=
ass
> > devices.
>=20
> Anton, this is the interface proposed by the input maintainer, Dmitry=
,
> to change which modifiers gets to light the keyboard LEDs (the exact
> names may change, but the principle should be firm).  I know this is
> inconvenient for console-setup for handling hotplugged keyboards,

Ok, the inconvenience is not a problem.  The problem is I don't=20
understant the meaning of this. :)

Is there some documentation or a sample code I can read?

Anton Zinoviev
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
