From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] cy8ctmg110: capacitive touchscreen support
Date: Fri, 9 Jul 2010 09:27:05 -0700
Message-ID: <20100709162704.GB19827@core.coreip.homeip.net>
References: <20100709153546.31399.14995.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:36540 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757803Ab0GIQ1N (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Jul 2010 12:27:13 -0400
Received: by pxi14 with SMTP id 14so901797pxi.19
        for <linux-input@vger.kernel.org>; Fri, 09 Jul 2010 09:27:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100709153546.31399.14995.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-input@vger.kernel.org

On Fri, Jul 09, 2010 at 04:36:32PM +0100, Alan Cox wrote:
> From: Samuli Konttila <samuli.konttila@aavamobile.com>
> 
> Add support for the cy8ctmg110 capacitive touchscreen used on some embedded
> devices.
> 
> (Some clean up by Alan Cox)
> 
> - Moved the hardcoded GPIO lines into platform data
> 

I still see GPIO lines hardcoded. Wrong changeset description?

> +
> +	hrtimer_init(&ts->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	ts->timer.function = cy8ctmg110_timer;
> +

I doubt it compiles since you seem to have removed cy8ctmg110_timer().

-- 
Dmitry
