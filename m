From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Logitech M705 thumb button
Date: Tue, 30 Mar 2010 14:28:30 +0200 (CEST)
Message-ID: <alpine.LRH.2.00.1003301418000.10181@twin.jikos.cz>
References: <hoqak4$m6t$1@dough.gmane.org>  <20100330065625.GC12764@core.coreip.homeip.net> <319012f1003300033k254715dao7f9a807615df36df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:45491 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752546Ab0C3M2g (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Mar 2010 08:28:36 -0400
In-Reply-To: <319012f1003300033k254715dao7f9a807615df36df@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Octoploid <cryptooctoploid@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Tue, 30 Mar 2010, Octoploid wrote:

> >> Just bought a Logitech M705 mouse today and everything is working
> >> fine except the thumb button. I just don't get any events in =BBxe=
v=AB or
> >> =BBxinput test=AB when I press that button.
> >> This mouse comes with the new =BBUnifying USB receiver=AB.
> >>
> >> Any hints on how I could get that button working?
> >>
> >
> > Start with locating "evtest" utility and confirming that the kerenl=
 does
> > not emit any events for the thumb button.
>=20
> Yes, there are no events emitted for the thumb button when running =BB=
evtest=AB.

Could you please provide output of

	cat /sys/kernel/debug/hid/<device>/rdesc

and

	cat /sys/kernel/debug/hid/<device>/events

(the second command should be run when the non-working button is presse=
d=20
on the device).

This works on kernels 2.6.32 an newer -- for older ones you'll have to=20
recompile your kernel with CONFIG_HID_DEBUG, modprobe the hid module wi=
th=20
'debug=3D2' parameter, and look into dmesg output.

--=20
Jiri Kosina
SUSE Labs, Novell Inc.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
