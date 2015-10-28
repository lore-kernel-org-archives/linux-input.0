From: Michael Welling <mwelling@ieee.org>
Subject: Re: [PATCH v2] Input: tsc2005 - Add support for tsc2004
Date: Wed, 28 Oct 2015 00:38:31 -0500
Message-ID: <20151028053831.GA10851@deathstar>
References: <1445991421-29938-1-git-send-email-mwelling@ieee.org>
 <201510281243.NRL3sM6Y%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34224 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686AbbJ1Fim (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Oct 2015 01:38:42 -0400
Content-Disposition: inline
In-Reply-To: <201510281243.NRL3sM6Y%fengguang.wu@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, Roger Quadros <rogerq@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, Oct 28, 2015 at 12:37:35PM +0800, kbuild test robot wrote:
> Hi Michael,
> 
> [auto build test ERROR on input/next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]
> 
> url:    https://github.com/0day-ci/linux/commits/Michael-Welling/Input-tsc2005-Add-support-for-tsc2004/20151028-082017
> config: x86_64-randconfig-s1-10281141 (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/built-in.o: In function `tsc2005_cmd':
>    tsc2005.c:(.text+0x21a352): undefined reference to `i2c_smbus_write_byte'
>    drivers/built-in.o: In function `tsc200x_probe_common':
> >> tsc2005.c:(.text+0x21b554): undefined reference to `__devm_regmap_init_i2c'
>    drivers/built-in.o: In function `tsc2005_modinit':
>    tsc2005.c:(.init.text+0xe2b2): undefined reference to `i2c_register_driver'
>    drivers/built-in.o: In function `tsc2005_exit':
>    tsc2005.c:(.exit.text+0xf4c): undefined reference to `i2c_del_driver'
>

Sorry Mr. Robot but this configuration does not make sense.

How is CONFIG_REGMAP_I2C=m set without CONFIG_I2C being selected?
CONFIG_REGMAP_I2C depends on CONFIG_I2C.

> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


