From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] ARM: Kirkwood: Add DT description of QNAP 419
Date: Wed, 15 Jan 2014 18:45:19 +0100
Message-ID: <20140115174519.GE17530@lunn.ch>
References: <1389048557-16364-1-git-send-email-andrew@lunn.ch>
 <1389174517.12612.87.camel@kazak.uk.xensource.com>
 <20140111210443.GT9681@lunn.ch>
 <201401151736.46280.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:52737 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751725AbaAORqz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jan 2014 12:46:55 -0500
Content-Disposition: inline
In-Reply-To: <201401151736.46280.arnd@arndb.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org, Ian Campbell <ijc@hellion.org.uk>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux-input@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, tbm@cyrius.com

> > But i'm also a little bit concerned by the "unique number" and this
> > ending up in /dev/input/by-path/platform-gpio_keys.3-event. Is this
> > path supposed to be stable? This unique number is not stable. An
> > unwitting change to the DT could cause its value to change. Do we need
> > to make it stable?
> > 
> 
> One possibility would be to create an artificial bus in DT for all
> gpio-keys devices, use #address-cells=<1> and #size-cells=<0>
> for it, and give each device a unique reg property. Not sure if that
> would be considered an elegant solution though.

Hi Arnd

Can i imply from your answer that you think 

/dev/input/by-path/platform-gpio_keys.3-event

should be stable?

A quick look at udev rules seems to suggestion this is an issue for
input/gpio-keys and maybe audio and video if there is a top level DT
property collecting the different sub devices together for ASOC and
V4L.

Thanks
	Andrew
