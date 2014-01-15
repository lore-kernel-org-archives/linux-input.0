From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ARM: Kirkwood: Add DT description of QNAP 419
Date: Wed, 15 Jan 2014 17:36:45 +0100
Message-ID: <201401151736.46280.arnd@arndb.de>
References: <1389048557-16364-1-git-send-email-andrew@lunn.ch> <1389174517.12612.87.camel@kazak.uk.xensource.com> <20140111210443.GT9681@lunn.ch>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:52696 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbaAOQhA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jan 2014 11:37:00 -0500
In-Reply-To: <20140111210443.GT9681@lunn.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Andrew Lunn <andrew@lunn.ch>, Ian Campbell <ijc@hellion.org.uk>, devicetree@vger.kernel.org, linux-input@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Gregory Clement <gregory.clement@free-electrons.com>, tbm@cyrius.com

On Saturday 11 January 2014, Andrew Lunn wrote:
> The id of -1 causes platform_device_add() to set the device name to
> plain "gpio-keys".
> 
> When using DT, the device name is created by the function
> of_device_make_bus_id(). It has the following comment:
> 
>  * This routine will first try using either the dcr-reg or the reg property
>  * value to derive a unique name.  As a last resort it will use the node
>  * name followed by a unique number.
> 
> Since the gpio_keys node does not have a reg properties, it gets a
> unique number appended to it. We end up with the device name
> "gpio_keys.3"
> 
> So as it stands, it does not appear i can make the DT system use the
> same device name as a board system.
> 
> But i'm also a little bit concerned by the "unique number" and this
> ending up in /dev/input/by-path/platform-gpio_keys.3-event. Is this
> path supposed to be stable? This unique number is not stable. An
> unwitting change to the DT could cause its value to change. Do we need
> to make it stable?
> 

One possibility would be to create an artificial bus in DT for all
gpio-keys devices, use #address-cells=<1> and #size-cells=<0>
for it, and give each device a unique reg property. Not sure if that
would be considered an elegant solution though.

	Arnd
