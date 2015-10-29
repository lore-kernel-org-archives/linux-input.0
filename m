From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] Input: tsc2005 - Add support for tsc2004
Date: Thu, 29 Oct 2015 22:46:20 +0100
Message-ID: <4152426.STHOuGxqsW@wuerfel>
References: <1446077554-19684-1-git-send-email-mwelling@ieee.org> <201510291514.OprNyiZf%fengguang.wu@intel.com> <20151029142237.GA11531@qwerty.qwertyembedded>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:61746 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756994AbbJ2Vqm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Oct 2015 17:46:42 -0400
In-Reply-To: <20151029142237.GA11531@qwerty.qwertyembedded>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, Roger Quadros <rogerq@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Thursday 29 October 2015 09:22:37 Michael Welling wrote:
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    drivers/built-in.o: In function `tsc2005_cmd':
> > >> tsc200x-core.c:(.text+0x2ae07f): undefined reference to `i2c_smbus_write_byte'
> 
> Argh!
> 
> How do I fix this one?
> 

Move all the I2C specific code into the tsc2004.c file and remove the
#ifdef. The problem is that tsc200x-core.c is used as built-in when
TOUCHSCREEN_TSC2005=y and I2C=m, so it can't call functions that are
defined in i2c-core.c.

	Arnd
