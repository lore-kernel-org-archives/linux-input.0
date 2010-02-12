From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH 3/4] hid-ntrig.c Split multi and single touch.
Date: Fri, 12 Feb 2010 14:56:20 -0500
Message-ID: <4B75B264.3010106@seas.upenn.edu>
References: <1265933946-8318-1-git-send-email-rafi@seas.upenn.edu> <1265933946-8318-2-git-send-email-rafi@seas.upenn.edu> <1265933946-8318-3-git-send-email-rafi@seas.upenn.edu> <20100212004247.GB6394@core.coreip.homeip.net> <4B74C6AB.1010704@seas.upenn.edu> <20100212080928.GA7777@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.seas.upenn.edu ([158.130.12.194]:56778 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756710Ab0BLT4a (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Feb 2010 14:56:30 -0500
In-Reply-To: <20100212080928.GA7777@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, chatty@enac.fr

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> Ah, these are 2 different devices... I need to increase my coffee
> intake.
> 
> OK, so I re-read the patch again and it you are splittig the one
> physical device in 2 - one legacy single tap and another multi-touch.
> If I understand it correctly that means that the same gesture can be
> potentially sent through bnoth devices. So in this case how system
> should decide which device to use and which device to ignore?

Though I can't say for sure that the pen and capacitive touch sensors are
separate circuitry, it certainly looks that way to the kernel.  The part
I find particularly strange is that there is a second hid device that does
nothing and it puts both physicals on a single hid.

Anyway, the physical pen and finger sensors do not interact.  Events from
tapping the screen with a finger end up going to one device, and using the
pen on the screen goes to the other.  From what I've seen userspace tools
recognize which is which by the tools supported (PEN and DOUBLETAP).


The third input is a logical multi touch device.  Yes there is definitely
potential for confusion when both MT X and normal ABS_X are sent.  That's
an ongoing discussion on the input list and I'm mostly trying to follow
the current preference which is to send both and let the user space
programs decide which they care about.  I'm not sure if the consensus was
to use separate input devices, but since one was already being allocated
by hid I decided to use it.

The two touch devices do not get the same output events.  ABS_X goes only
to the single touch and ABS_MT_POSITION_X to the multi.  The mt device
gets only details about the contact: id, x, y, and size.  It also sends
no touch or other tool up/down or on/off events.

Rafi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkt1sl8ACgkQwuRiAT9o609hugCdHIqF30DTTXSZraCTICKSZ9C3
6jgAmwYGfVxUMFnQZw7n02lF8o5zdED8
=ERtj
-----END PGP SIGNATURE-----
