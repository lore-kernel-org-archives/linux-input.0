From: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v1 04/12] input: matrix-keypad: push/pull, separate
 polarity
Date: Fri, 28 Jun 2013 10:33:54 +0200
Message-ID: <20130628083354.GW24305@book.gsilab.sittig.org>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
 <1371838198-7327-5-git-send-email-gsi@denx.de>
 <51C4C6C9.6030000@wwwdotorg.org>
 <20130622093649.GF24305@book.gsilab.sittig.org>
 <51C8D2BC.9010507@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:43703 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755055Ab3F1IeC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jun 2013 04:34:02 -0400
Content-Disposition: inline
In-Reply-To: <51C8D2BC.9010507@wwwdotorg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Detlev Zundel <dzu@denx.de>, Sekhar Nori <nsekhar@ti.com>, Marek Vasut <marek.vasut@gmail.com>, Ralf Baechle <ralf@linux-mips.org>

On Mon, Jun 24, 2013 at 17:14 -0600, Stephen Warren wrote:
> 
> [ active low pins, individually for sets or even single pins ]
> 
> Can't you add this enhancement as follows:
> 
> Update the driver to look at the per-pin GPIO flags in all cases.
> Presumably in any existing cases, those flags all say "active high"
> anyway, since specifying anything else was useless. In the very unlikely
> case this isn't true, one could always add a quirk based on the
> HW-specific compatible value.

Maybe I missed something, but
- is "the 'active low' property of a GPIO pin" something platform
  specific? (maybe ARM inspired, introduced with pinctrl features)
- is it only available for specific GPIO controller drivers
  ("chips" or "banks"), or is it in some layer on top of gpiolib?
- is it in some other tree or branch than mainline?

Documentation/gpio.txt suggests and eyeballing the gpiolib.c
source supports (v3.10-rc7) that the in-kernel API doesn't have
an 'active-low' for pins.  There is one for the sysfs API and
pins that were exported to user space, but not for in-kernel use.

This fits with my observation that application drivers on top of
gpiolib often take care of such a property which actually looks
like it would belong to the physical attachment.

I understand that a chip's driver will hide when a SoC's pin is
inverted, but I cannot see where gpiolib provides a means to hide
an externally connected inverting driver.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
