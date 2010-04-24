From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [PATCH 00/15] ir-core: Several improvements to allow adding
 LIRC  and decoder plugins
Date: Sat, 24 Apr 2010 07:22:54 +0200
Message-ID: <20100424052254.GB3101@hardeman.nu>
References: <20100401145632.5631756f@pedra>
 <t2z9e4733911004011844pd155bbe8g13e4cbcc1a5bf1f6@mail.gmail.com>
 <20100402102011.GA6947@hardeman.nu>
 <p2ube3a4a1004051349y11e3004bk1c71e3ab38d3f669@mail.gmail.com>
 <20100407093205.GB3029@hardeman.nu>
 <z2hbe3a4a1004231040uce51091fnf24b97de215e3ef1@mail.gmail.com>
 <o2l9e4733911004231106te8b727e9nfa75bfd9c73e9506@mail.gmail.com>
 <1272061228.3089.8.camel@palomino.walls.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:55607 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296Ab0DXFW7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Apr 2010 01:22:59 -0400
Content-Disposition: inline
In-Reply-To: <1272061228.3089.8.camel@palomino.walls.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Walls <awalls@md.metrocast.net>
Cc: Jon Smirl <jonsmirl@gmail.com>, Jarod Wilson <jarod@wilsonet.com>, Mauro Carvalho Chehab <mchehab@redhat.com>, linux-input@vger.kernel.org, Linux Media Mailing List <linux-media@vger.kernel.org>

On Fri, Apr 23, 2010 at 06:20:28PM -0400, Andy Walls wrote:
> Not that my commit rate has been > 0 LOC lately, but I'd like to see
> lirc_dev, just to get transmit worked out for the CX23888 chip and
> cx23885 driver.
>=20
> I think this device will bring to light some assumptions LIRC current=
ly
> makes about transmit that don't apply to the CX23888 (i.e. LIRC havin=
g
> to perform the pulse timing).  The cx23888-ir implementation has a kf=
ifo
> for holding outgoing pulse data and the hardware itself has an 8 puls=
e
> measurement deep fifo.

I think we're eventually going to want to let rc-core create a chardev=20
per rc device to allow for things like reading out scancodes (when=20
creating keymaps for new and unknown remotes), raw timings (for=20
debugging in-kernel decoders and writing new ones), possibly also=20
ioctl's (for e.g. setting all RX parameters in one go or to=20
create/destroy additional keymaps, though I'm sure some will want all o=
f=20
that to go through sysfs).

That same chardev could also be used to implement TX, once a suitable=20
interface has been fleshed out. The end result might not look exactly=20
like lirc...

--=20
David H=E4rdeman
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
