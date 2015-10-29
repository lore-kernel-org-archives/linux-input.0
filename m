From: Michael Welling <mwelling@ieee.org>
Subject: Re: [PATCH v3] Input: tsc2005 - Add support for tsc2004
Date: Thu, 29 Oct 2015 09:22:37 -0500
Message-ID: <20151029142237.GA11531@qwerty.qwertyembedded>
References: <1446077554-19684-1-git-send-email-mwelling@ieee.org>
 <201510291514.OprNyiZf%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33240 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbbJ2OWv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Oct 2015 10:22:51 -0400
Content-Disposition: inline
In-Reply-To: <201510291514.OprNyiZf%fengguang.wu@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, Roger Quadros <rogerq@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Thu, Oct 29, 2015 at 03:25:34PM +0800, kbuild test robot wrote:
> Hi Michael,
> 
> [auto build test ERROR on input/next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]
> 
> url:    https://github.com/0day-ci/linux/commits/Michael-Welling/Input-tsc2005-Add-support-for-tsc2004/20151029-081504
> config: x86_64-randconfig-s1-10291412 (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/built-in.o: In function `tsc2005_cmd':
> >> tsc200x-core.c:(.text+0x2ae07f): undefined reference to `i2c_smbus_write_byte'

Argh!

How do I fix this one?

> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


