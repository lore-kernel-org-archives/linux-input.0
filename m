From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] cy8ctmg110: capacitive touchscreen support
Date: Fri, 9 Jul 2010 09:59:51 -0700
Message-ID: <20100709165951.GB20120@core.coreip.homeip.net>
References: <20100709155259.3798.80408.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55179 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757583Ab0GIQ75 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Jul 2010 12:59:57 -0400
Received: by pzk26 with SMTP id 26so502600pzk.19
        for <linux-input@vger.kernel.org>; Fri, 09 Jul 2010 09:59:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100709155259.3798.80408.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-input@vger.kernel.org

On Fri, Jul 09, 2010 at 04:53:11PM +0100, Alan Cox wrote:
> Correct version this time
> 
> From: Samuli Konttila <samuli.konttila@aavamobile.com>
> 
> Add support for the cy8ctmg110 capacitive touchscreen used on some embedded
> devices.
> 
> (Some clean up by Alan Cox)
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
> 
>  drivers/input/touchscreen/Kconfig         |   14 +
>  drivers/input/touchscreen/Makefile        |    1 
>  drivers/input/touchscreen/cy8ctmg110_ts.c |  393 +++++++++++++++++++++++++++++
>  include/linux/cy8ctmg110_pdata.h          |   10 +

I'll move it into include/linux/input/cy8ctmg110_pdata.h and kill some
useless comments and will apply to next, thanks Alan.

Hmm, I think device_init_wakeup() call is missing as well. And threaded
IRQ being chared is somewhat unusual... But it is not oneshot so should
be OK.

-- 
Dmitry
