From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] ep93xx_keypad.c: update driver to new core support
Date: Wed, 9 Dec 2009 19:11:30 -0800
Message-ID: <20091210031130.GG10138@core.coreip.homeip.net>
References: <BD79186B4FD85F4B8E60E381CAEE190901FB0DB6@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:39281 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758515AbZLJDL1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Dec 2009 22:11:27 -0500
Received: by pzk1 with SMTP id 1so364543pzk.33
        for <linux-input@vger.kernel.org>; Wed, 09 Dec 2009 19:11:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901FB0DB6@mi8nycmail19.Mi8.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: linux-input@vger.kernel.org

On Wed, Dec 09, 2009 at 05:20:53PM -0500, H Hartley Sweeten wrote:
> ep93xx_keypad.c: update driver to new core support
> 
> This driver was merged before the ep93xx core support was added
> for the keypad clock and acquiring/releasing the necessary gpio's.
> Now that the proper support is in the ep93xx core this driver
> needs to be updated to work correctly.
> 
> Summary of changes:
>   1) Remove some unused members from the platform data.
>   2) Remove the custom KEY macro and use the ones available in
>      <linux/input/matrix_keypad.h>
>   3) Remove the keypad_{readl/writel} macros and just use
>      __raw_{readl/writel} directly.
>   4) Update the clk_set_rate() call to work with the core support.
>   5) Cleanup the probe routine and remove some unneeded messages.
>   6) Use the ep93xx core functions to acquire and release the gpio's.
>   7) Fix the clk_get() call to get the keypad clock.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Thank you Hartley. I will change 'enabled' to bool while we are at it
and apply for the next pull.

-- 
Dmitry
