From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: caps lock led does not show up
Date: Tue, 9 Jun 2015 16:17:23 +0200
Message-ID: <20150609141723.GE3045@type>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sonata.ens-lyon.org ([140.77.166.138]:50711 "EHLO
	sonata.ens-lyon.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbbFIORd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 10:17:33 -0400
Content-Disposition: inline
In-Reply-To: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
 <20090205113908.GA14224@const.inria.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 514464@bugs.debian.org, anton@lml.bas.bg

Hello,

Samuel Thibault, le Thu 05 Feb 2009 12:39:08 +0100, a =E9crit :
> And about the led issue, we need to ask the kernel for an interface t=
o
> be able to configure which lock should drive which led.

Dmitry Torokhov, le Mon 08 Jun 2015 14:43:07 -0700, a =E9crit :
> If user wants all keyboards to light up CapsLock LED when VT state lo=
cks
> CtrlL modifier they need to write a udev rule or similar to set up
> "kbd-ctrlllock" trigger for all appearing "input%::capslock" LED clas=
s
> devices.

Anton, this is the interface proposed by the input maintainer, Dmitry,
to change which modifiers gets to light the keyboard LEDs (the exact
names may change, but the principle should be firm).  I know this is
inconvenient for console-setup for handling hotplugged keyboards, but
Dmitry prefers to avoid introducing a virtual multiplexer as explained
below:

> Having such virtual multiplexing object just adds complexity and is
> hard to untange (see /dev/input/mice and all the issues we had with
> synaptics driver trying to exclude it's data stream from it).

Samuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
