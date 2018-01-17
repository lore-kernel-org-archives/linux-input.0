From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/6] Input: remove unneeded MODULE_VERSION usage
Date: Tue, 16 Jan 2018 16:45:51 -0800
Message-ID: <20180117004551.hjkd7ly6u74fj5ki@dtor-ws>
References: <20171122174921.20192-1-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46205 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbeAQApz (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 16 Jan 2018 19:45:55 -0500
Content-Disposition: inline
In-Reply-To: <20171122174921.20192-1-gregkh@linuxfoundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Nov 22, 2017 at 06:49:15PM +0100, Greg Kroah-Hartman wrote:
> Here's a short patch series against linux-next at the moment, that
> removes all of the MODULE_VERSION() usage in drivers/input/ as it's not
> needed at all.
> 
> Greg Kroah-Hartman (6):
>   Input: rmi4: remove unneeded MODULE_VERSION() usage
>   Input: keyboard: pmic8xxx: remove unneeded MODULE_VERSION() usage
>   Input: mouse: elan_i2c: remove unneeded MODULE_VERSION() usage
>   Input: touchscreen: remove unneeded MODULE_VERSION() usage
>   Input: misc: remove unneeded MODULE_VERSION() usage
>   Input: remove remaining unneeded MODULE_VERSION() usage

Applied the lot, thank you Greg.

> 
>  drivers/input/input-polldev.c               | 1 -
>  drivers/input/keyboard/pmic8xxx-keypad.c    | 1 -
>  drivers/input/misc/apanel.c                 | 2 --
>  drivers/input/misc/ati_remote2.c            | 2 --
>  drivers/input/misc/uinput.c                 | 1 -
>  drivers/input/mouse/elan_i2c_core.c         | 2 --
>  drivers/input/rmi4/rmi_bus.c                | 1 -
>  drivers/input/rmi4/rmi_driver.h             | 2 --
>  drivers/input/rmi4/rmi_i2c.c                | 1 -
>  drivers/input/rmi4/rmi_spi.c                | 1 -
>  drivers/input/sparse-keymap.c               | 1 -
>  drivers/input/touchscreen/colibri-vf50-ts.c | 2 --
>  drivers/input/touchscreen/elants_i2c.c      | 2 --
>  drivers/input/touchscreen/melfas_mip4.c     | 1 -
>  drivers/input/touchscreen/wdt87xx_i2c.c     | 2 --
>  15 files changed, 22 deletions(-)
> 
> -- 
> 2.15.0
> 

-- 
Dmitry
