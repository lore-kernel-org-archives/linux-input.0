From: Julien Grall <julien.grall@citrix.com>
Subject: Re: [PATCH] xen: check return value of xenbus_printf
Date: Mon, 19 Oct 2015 15:30:45 +0100
Message-ID: <5624FE95.2080001@citrix.com>
References: <1445263840-21187-1-git-send-email-wuninsu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp02.citrix.com ([66.165.176.63]:22139 "EHLO
	SMTP02.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbbJSOcJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Oct 2015 10:32:09 -0400
In-Reply-To: <1445263840-21187-1-git-send-email-wuninsu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Insu Yun <wuninsu@gmail.com>, dmitry.torokhov@gmail.com, stefano.stabellini@eu.citrix.com, david.vrabel@citrix.com, wei.liu2@citrix.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: taesoo@gatech.edu, yeongjin.jang@gatech.edu, insu@gatech.edu, changwoo@gatech.edu

Hi,

On 19/10/15 15:10, Insu Yun wrote:
> Internally, xenbus_printf uses memory allocation, so it can be failed in
> memory pressure.Therefore, xenbus_printf's return should be checked
> and properly handled.
> 
> Signed-off-by: Insu Yun <wuninsu@gmail.com>
> ---
>  drivers/input/misc/xen-kbdfront.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
> index 23d0549..9d465d7 100644
> --- a/drivers/input/misc/xen-kbdfront.c
> +++ b/drivers/input/misc/xen-kbdfront.c
> @@ -129,8 +129,14 @@ static int xenkbd_probe(struct xenbus_device *dev,
>  
>  	if (xenbus_scanf(XBT_NIL, dev->otherend, "feature-abs-pointer", "%d", &abs) < 0)
>  		abs = 0;
> -	if (abs)
> -		xenbus_printf(XBT_NIL, dev->nodename, "request-abs-pointer", "1");
> +	if (abs) {
> +		ret = xenbus_printf(XBT_NIL, dev->nodename,
> +					"request-abs-pointer", "1");

The second line of arguments should be aligned to the first parameter. I.e:

xenbus_printf(XBT_NIL, dev->nodename,
              "request-abs-pointer", "1");

See an example in xenkbd_backend_changed.

With that fixed:

Reviewed-by: Julien Grall <julien.grall@citrix.com>

> +		if (ret) {
> +			pr_warning("xenkbd: can't request abs-pointer");

Note that checkpatch.pl will print a warning here:

WARNING: Prefer pr_warn(... to pr_warning(...
#27: FILE: drivers/input/misc/xen-kbdfront.c:136:
+                       pr_warning("xenkbd: can't request abs-pointer");


Although, I'm fine if you don't fix this one.

> +			abs = 0;
> +		}
> +	}
>  
>  	/* keyboard */
>  	kbd = input_allocate_device();
> 

Regards,

-- 
Julien Grall
