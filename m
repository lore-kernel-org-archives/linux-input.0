From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH] Route kbd leds through the generic leds layer (3rd version)
Date: Thu, 25 Feb 2010 22:47:59 +0100
Message-ID: <20100225214759.GC9378@const.homenet.telecomitalia.it>
References: <20100224012010.GA4062@const> <20100225013840.GA5519@const.homenet.telecomitalia.it> <20100225102056.GG10823@core.coreip.homeip.net> <1267100600.4243.13.camel@rex>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from toccata.ens-lyon.fr ([140.77.166.68]:44553 "EHLO
	toccata.ens-lyon.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934033Ab0BYVsE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Feb 2010 16:48:04 -0500
Content-Disposition: inline
In-Reply-To: <1267100600.4243.13.camel@rex>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>, Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, mgarski@post.pl, linux-input@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>

Richard Purdie, le Thu 25 Feb 2010 12:23:20 +0000, a =E9crit :
> The first would be the triggers themselves which are independent in
> their own right and shouldn't be too controversial.

One issue is that keyboard.c has to know whether to send input events
itself as it does now (e.g. because triggers are not compiled), or to
rely on triggers to do it for him.

> The second part would be the input LEDs themselves. My input susbsyst=
em
> memory is fuzzy, I assume this sets a set of LEDs per input device an=
d
> attaches the appropriate default triggers?

I would rather say that it sets a set of input devices per LED and
attaches them the appropriate default trigger.

> Is there a set of states we can detect (like raw mode) when we could
> just know to disconnect the default triggers?

What for?

Samuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
