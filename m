From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH] Route kbd leds through the generic leds layer (3rd version)
Date: Thu, 25 Feb 2010 22:44:03 +0100
Message-ID: <20100225214403.GB9378@const.homenet.telecomitalia.it>
References: <20100224012010.GA4062@const> <20100225013840.GA5519@const.homenet.telecomitalia.it> <20100225102056.GG10823@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from toccata.ens-lyon.fr ([140.77.166.68]:44460 "EHLO
	toccata.ens-lyon.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933970Ab0BYVoH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Feb 2010 16:44:07 -0500
Content-Disposition: inline
In-Reply-To: <20100225102056.GG10823@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>, Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, mgarski@post.pl, linux-input@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>, Richard Purdie <rpurdie@rpsys.net>

Dmitry Torokhov, le Thu 25 Feb 2010 02:20:56 -0800, a =E9crit :
> I am aunsure about this patch. It ties all LEDs together

=46or now, yes.  There could be an additional per-device layer that the
user could select instead, but my patch doesn't prevent that.

> whereas currently it is possible to operate keyboards and their leds
> independently

You mean through the input layer?  Technically, yes, but at least my
patch is an improvement over what exists right now: at first read of
your sentence I thought "of course not! keyboard.c does it for all
devices!", so it's not a regression in that concern.  On the contrary,
it fixes the problem of proper caps lock with led feedback.

Being able to assign only some of the devices to the linux console
would indeed probably be good, but to me it's just a refinement. Users
a priori assume all keyboards get their leds updated, so my patch
makes sense.  And it won't prevent a further patch that, in addition
to input::<led> leds, adds per-device leds, which the user could use
instead of input::<led>.

Samuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
