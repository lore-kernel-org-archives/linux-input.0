From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH] Route kbd leds through the generic leds layer (3rd version)
Date: Sun, 7 Mar 2010 13:06:04 +0100
Message-ID: <20100307120604.GE5203@const.famille.thibault.fr>
References: <20100224012010.GA4062@const> <20100225013840.GA5519@const.homenet.telecomitalia.it> <20100225102056.GG10823@core.coreip.homeip.net> <20100225214403.GB9378@const.homenet.telecomitalia.it> <20100226035448.GA16797@core.coreip.homeip.net> <20100226103505.GB3992@const.homenet.telecomitalia.it> <20100306065457.GE28759@elf.ucw.cz> <20100306123058.GE5203@const.famille.thibault.fr> <20100307082519.GC1987@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from solo.fdn.fr ([80.67.169.19]:40893 "EHLO solo.fdn.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618Ab0CGMGN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 7 Mar 2010 07:06:13 -0500
Content-Disposition: inline
In-Reply-To: <20100307082519.GC1987@elf.ucw.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, mgarski@post.pl, linux-input@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>, Richard Purdie <rpurdie@rpsys.net>

Pavel Machek, le Sun 07 Mar 2010 09:25:19 +0100, a =E9crit :
> But you mentioned having per-keyboard led would be quite easy, it doe=
s
> not seem to be controversial, so perhaps that's way to go, first?

Thinking more about it, what about the following:

keyboard numlock trigger -> input numlock led -> input numlock trigger =
-> input keyboard led

Userland applications which want to redirect leds for (a priori) all
keyboards change the trigger used by the input numlock led. Userland
applications which want to redirect leds for a particular keyboard can
change the trigger user by the particular input keyboard led.

Samuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
