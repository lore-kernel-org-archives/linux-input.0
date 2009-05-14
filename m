From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch 3/9] input: ads7846.c sparse lock annotation
Date: Wed, 13 May 2009 20:24:06 -0700
Message-ID: <20090514032404.GC12778@dtor-d630.eng.vmware.com>
References: <200905122102.n4CL2L95006887@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:34631 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628AbZENDYQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 May 2009 23:24:16 -0400
Received: by wf-out-1314.google.com with SMTP id 26so652727wfd.4
        for <linux-input@vger.kernel.org>; Wed, 13 May 2009 20:24:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200905122102.n4CL2L95006887@imap1.linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-input@vger.kernel.org, harvey.harrison@gmail.com

On Tue, May 12, 2009 at 01:43:06PM -0700, akpm@linux-foundation.org wrote:
> From: Harvey Harrison <harvey.harrison@gmail.com>
> 
> Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> Cc: Dmitry Torokhov <dtor@mail.ru>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/input/touchscreen/ads7846.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff -puN drivers/input/touchscreen/ads7846.c~input-ads7846c-sparse-lock-annotation drivers/input/touchscreen/ads7846.c
> --- a/drivers/input/touchscreen/ads7846.c~input-ads7846c-sparse-lock-annotation
> +++ a/drivers/input/touchscreen/ads7846.c
> @@ -769,6 +769,8 @@ static irqreturn_t ads7846_irq(int irq, 
>  
>  /* Must be called with ts->lock held */
>  static void ads7846_disable(struct ads7846 *ts)
> +__releases(&ts->lock)
> +__acquires(&ts->lock)
>  {

I still haven't gotten any explanation why this is needed and also I am
still getting sparce warnings with this patch applied. Please drop.

-- 
Dmitry
