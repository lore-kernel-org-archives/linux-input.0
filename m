From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Mouse and keyboard freeze on Ivy Bridge platform
Date: Fri, 5 Oct 2012 10:23:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1210051011030.1541-100000@iolanthe.rowland.org>
References: <20121004213606.GA8409@dinot.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:57282 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754012Ab2JEOXE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Oct 2012 10:23:04 -0400
In-Reply-To: <20121004213606.GA8409@dinot.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?Q?S=C3=A9bastien?= Dinot <sebastien.dinot@free.fr>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, 689368@bugs.debian.org

On Thu, 4 Oct 2012, S=C3=A9bastien Dinot wrote:

> Alan Stern a =C3=A9crit :
> > The log file shows lots and lots of low-level communication errors.
> > They could be caused by bad cabling or by bad USB hardware in your
> > computer. It's unlikely that they were caused by the mouse or
> > keyboard, because the log shows errors for both of them starting at
> > exactly the same times.
>=20
> In my humble opinion, this issue is not caused by a bad USB hardware
> because I am encountering it with two different motherboards (MSI
> Z77A-G43 and ASUS P8Z77-V LX), both with an uptodate BIOS.

Maybe they have something in common.  I don't know.  All I can do is
explain to you what your kernel log indicates -- and it strongly
indicates a hardware error.  Didn't you notice all those "detected=20
XactErr" lines in the log?  There were more than 70000 of them!

> May be it is caused by a bad cabling but my mouse and my keyboard wor=
ked
> fine with my previous PC. They are connected to USB2 ports in both
> cases. But to clear up this point, I will try new mouse and keyboard.
>=20
> A last question: if it is a cable failure, why does it disappear
> temporarily when I unload then reload the module? I do not have deep
> experience and knowledge of hardware, may be there is a rational
> explanation to it.

That's a good point, and a cable failure indeed seems less likely than
some of the other possibilities (such as a failure of the internal
"rate-matching" hub).

One possible explanation is that an occasional noisy signal (caused by
a slightly faulty cable) triggers a bug in the internal hub, and that
bug causes all communication to fail until the hub is reset when you
reload the module.

> > You could try getting a USB-2 hub and attaching your mouse and
> > keyboard through the hub. That might help ... or it might not.
>=20
> Sorry, I do not understand the aim of this operation. Could you expla=
in
> me it?

In addition to what Sarah said, it's possible that your problem is
related to the fact that the keyboard and mouse operate at low speed. =20
If you connected them through a hub then that hub would communicate
with the internal hub at high speed, not low speed.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
