From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] wm97xx-core: Only schedule interrupt handler if
	not already scheduled
Date: Mon, 14 Apr 2008 14:10:02 -0400
Message-ID: <20080414140832.ZZRA012@mailhub.coreip.homeip.net>
References: <20080414173841.GA2213@rakim.wolfsonmicro.main> <1208194775-4293-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:18231 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759445AbYDNSKR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Apr 2008 14:10:17 -0400
Received: by ug-out-1314.google.com with SMTP id z38so513797ugc.16
        for <linux-input@vger.kernel.org>; Mon, 14 Apr 2008 11:10:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1208194775-4293-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Mark,

On Mon, Apr 14, 2008 at 06:39:33PM +0100, Mark Brown wrote:
>  static irqreturn_t wm97xx_pen_interrupt(int irq, void *dev_id)
>  {
>  	struct wm97xx *wm = dev_id;
>  
> -	wm->mach_ops->irq_enable(wm, 0);
> -	queue_work(wm->ts_workq, &wm->pen_event_work);
> +	if (!work_pending(&wm->pen_event_work)) {
> +		wm->mach_ops->irq_enable(wm, 0);
> +		queue_work(wm->ts_workq, &wm->pen_event_work);
> +	}

Given the fact that work will not be queued if it is pending anyway
why is this change needed?

-- 
Dmitry
