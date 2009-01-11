From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch 01/17] drivers/input/touchscreen/ucb1400_ts.c needs GPIO
Date: Sun, 11 Jan 2009 00:05:49 -0800
Message-ID: <20090111000401.ZZRA012@mailhub.coreip.homeip.net>
References: <200901092019.n09KJfo3017101@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:36178 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbZAKIGk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 11 Jan 2009 03:06:40 -0500
Received: by an-out-0708.google.com with SMTP id d40so3324427and.1
        for <linux-input@vger.kernel.org>; Sun, 11 Jan 2009 00:06:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200901092019.n09KJfo3017101@imap1.linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-input@vger.kernel.org, david-b@pacbell.net, marek.vasut@gmail.com, nico@marvell.com, rmk+kernel@arm.linux.org.uk, vsauder@inhand.com

On Fri, Jan 09, 2009 at 12:19:40PM -0800, akpm@linux-foundation.org wrote:
> From: Andrew Morton <akpm@linux-foundation.org>
> 
> ia64 allmodconfig:
> 
> include/asm-generic/gpio.h: In function `gpio_get_value_cansleep':
> include/asm-generic/gpio.h:147: error: implicit declaration of function `gpio_get_value'
> include/asm-generic/gpio.h: In function `gpio_set_value_cansleep':
> include/asm-generic/gpio.h:153: error: implicit declaration of function `gpio_set_value'
> 
> recent linux-next breakage.  Not sure what caused it..
> 

Andrew, this patch is not needed anymore since dependency on GPIOLIB has
been added to TC1400_CORE on which UCB1400 depends.

-- 
Dmitry
