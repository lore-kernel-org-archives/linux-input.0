From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Fix tosakbd suspend
Date: Mon, 31 Mar 2008 23:49:03 -0400
Message-ID: <20080401034903.GB18041@anvil.corenet.prv>
References: <20080331213801.GA9372@doriath.ww600.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:43152 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbYDADtJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 31 Mar 2008 23:49:09 -0400
Received: by py-out-1112.google.com with SMTP id u52so2778877pyb.10
        for <linux-input@vger.kernel.org>; Mon, 31 Mar 2008 20:49:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080331213801.GA9372@doriath.ww600.siemens.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Dmitry,

On Tue, Apr 01, 2008 at 01:38:01AM +0400, Dmitry Baryshkov wrote:
> Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
> ---
>  drivers/input/keyboard/tosakbd.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/keyboard/tosakbd.c b/drivers/input/keyboard/tosakbd.c
> index 3884d1e..306cbe8 100644
> --- a/drivers/input/keyboard/tosakbd.c
> +++ b/drivers/input/keyboard/tosakbd.c
> @@ -210,6 +210,9 @@ static int tosakbd_suspend(struct platform_device *dev, pm_message_t state)
>  
>  	del_timer_sync(&tosakbd->timer);
>  

What if interrupt comes here? The whole suspend path seems racy with
interrup handler/timer.

> +	PGSR1 = (PGSR1 & ~TOSA_GPIO_LOW_STROBE_BIT);
> +	PGSR2 = (PGSR2 & ~TOSA_GPIO_HIGH_STROBE_BIT);
> +
>  	return 0;
>  }
>  

-- 
Dmitry
