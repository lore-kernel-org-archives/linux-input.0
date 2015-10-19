From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] xen: check return value of xenbus_printf
Date: Mon, 19 Oct 2015 09:46:51 -0700
Message-ID: <20151019164651.GA7006@dtor-ws>
References: <1445270571-23890-1-git-send-email-wuninsu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36508 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826AbbJSQqy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Oct 2015 12:46:54 -0400
Content-Disposition: inline
In-Reply-To: <1445270571-23890-1-git-send-email-wuninsu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Insu Yun <wuninsu@gmail.com>
Cc: wei.liu2@citrix.com, david.vrabel@citrix.com, stefano.stabellini@eu.citrix.com, julien.grall@citrix.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, taesoo@gatech.edu, yeongjin.jang@gatech.edu, insu@gatech.edu, changwoo@gatech.edu

On Mon, Oct 19, 2015 at 04:02:51PM +0000, Insu Yun wrote:
> Signed-off-by: Insu Yun <wuninsu@gmail.com>

Applied, thank you. However you still are missing the commit description
on this version of the patch; I had to fish it from your original
posting.

Thanks.

> ---
>  drivers/input/misc/xen-kbdfront.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
> index 23d0549..0a9ad2cf 100644
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
> +				    "request-abs-pointer", "1");
> +		if (ret) {
> +			pr_warning("xenkbd: can't request abs-pointer");
> +			abs = 0;
> +		}
> +	}
>  
>  	/* keyboard */
>  	kbd = input_allocate_device();
> -- 
> 1.9.1
> 

-- 
Dmitry
