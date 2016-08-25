From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: pegasus_notetaker - directly include workqueue
 header
Date: Thu, 25 Aug 2016 09:42:11 -0700
Message-ID: <20160825164211.GC11206@dtor-ws>
References: <1472032325-11432-1-git-send-email-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1472032325-11432-1-git-send-email-martink@posteo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Kepplinger <martink@posteo.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Aug 24, 2016 at 11:52:05AM +0200, Martin Kepplinger wrote:
> According to the kernel's guidelines, let's directly include the
> workqueue functions we use.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> ---
> I don't know if it's worth it, but I should have included this according to
> the guidelines :)

It won't hurt.

Applied, thank you.

> 
> 
>  drivers/input/tablet/pegasus_notetaker.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
> index 949dacc..47de5a8 100644
> --- a/drivers/input/tablet/pegasus_notetaker.c
> +++ b/drivers/input/tablet/pegasus_notetaker.c
> @@ -40,6 +40,7 @@
>  #include <linux/input.h>
>  #include <linux/usb/input.h>
>  #include <linux/slab.h>
> +#include <linux/workqueue.h>
>  
>  /* USB HID defines */
>  #define USB_REQ_GET_REPORT		0x01
> -- 
> 2.1.4
> 

-- 
Dmitry
