From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch 9/9] serios: async shutdown
Date: Wed, 13 May 2009 20:20:56 -0700
Message-ID: <20090514032055.GA12778@dtor-d630.eng.vmware.com>
References: <200905122102.n4CL2RUY006919@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:51639 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762227AbZENDVe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 May 2009 23:21:34 -0400
Received: by rv-out-0506.google.com with SMTP id f9so612774rvb.1
        for <linux-input@vger.kernel.org>; Wed, 13 May 2009 20:21:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200905122102.n4CL2RUY006919@imap1.linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-input@vger.kernel.org, shaohua.li@intel.com, arjan@infradead.org

Hi,

On Tue, May 12, 2009 at 01:43:11PM -0700, akpm@linux-foundation.org wrote:
> From: Shaohua Li <shaohua.li@intel.com>
> 
> serio shutdown is quite slow. It sometimes will take 0.2s for each port.
> 

This depends on the other patch you sent to Greg, I think these should
go together. But I am uncomfortable at the ide of blasting all ports on
i8042 simultaneously during shutdown. I'd be more comfortable if we were
taking serio_mutex in serio_cleanup() so only one port is being worked
on at a time.

> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> Cc: Arjan van de Ven <arjan@infradead.org>
> Cc: Dmitry Torokhov <dtor@mail.ru>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/input/serio/serio.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff -puN drivers/input/serio/serio.c~serios-async-shutdown drivers/input/serio/serio.c
> --- a/drivers/input/serio/serio.c~serios-async-shutdown
> +++ a/drivers/input/serio/serio.c
> @@ -36,6 +36,7 @@
>  #include <linux/kthread.h>
>  #include <linux/mutex.h>
>  #include <linux/freezer.h>
> +#include <linux/async.h>
>  
>  MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
>  MODULE_DESCRIPTION("Serio abstraction core");
> @@ -792,11 +793,17 @@ static void serio_cleanup(struct serio *
>  	mutex_unlock(&serio->drv_mutex);
>  }
>  
> +static void serio_async_shutdown(void *data, async_cookie_t cookie)
> +{
> +	struct serio *serio = data;
> +	serio_cleanup(serio);
> +}
> +
>  static void serio_shutdown(struct device *dev)
>  {
>  	struct serio *serio = to_serio_port(dev);
>  
> -	serio_cleanup(serio);
> +	async_schedule(serio_async_shutdown, serio);
>  }
>  
>  static void serio_attach_driver(struct serio_driver *drv)
> _
> 

-- 
Dmitry
