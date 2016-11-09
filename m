From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 05/12] xen: make use of xenbus_read_unsigned() in
 xen-kbdfront
Date: Tue, 8 Nov 2016 16:29:16 -0800
Message-ID: <20161109002916.GF8719@dtor-ws>
References: <1477932510-28594-1-git-send-email-jgross@suse.com>
 <1477932510-28594-6-git-send-email-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35190 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751564AbcKIA3T (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 8 Nov 2016 19:29:19 -0500
Content-Disposition: inline
In-Reply-To: <1477932510-28594-6-git-send-email-jgross@suse.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xen.org, david.vrabel@citrix.com, boris.ostrovsky@oracle.com, linux-input@vger.kernel.org

On Mon, Oct 31, 2016 at 05:48:23PM +0100, Juergen Gross wrote:
> Use xenbus_read_unsigned() instead of xenbus_scanf() when possible.
> This requires to change the type of the reads from int to unsigned,
> but these cases have been wrong before: negative values are not allowed
> for the modified cases.
> 
> Cc: dmitry.torokhov@gmail.com
> Cc: linux-input@vger.kernel.org
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/input/misc/xen-kbdfront.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
> index 227fbd2..3900875 100644
> --- a/drivers/input/misc/xen-kbdfront.c
> +++ b/drivers/input/misc/xen-kbdfront.c
> @@ -108,7 +108,8 @@ static irqreturn_t input_handler(int rq, void *dev_id)
>  static int xenkbd_probe(struct xenbus_device *dev,
>  				  const struct xenbus_device_id *id)
>  {
> -	int ret, i, abs;
> +	int ret, i;
> +	unsigned int abs;
>  	struct xenkbd_info *info;
>  	struct input_dev *kbd, *ptr;
>  
> @@ -127,8 +128,7 @@ static int xenkbd_probe(struct xenbus_device *dev,
>  	if (!info->page)
>  		goto error_nomem;
>  
> -	if (xenbus_scanf(XBT_NIL, dev->otherend, "feature-abs-pointer", "%d", &abs) < 0)
> -		abs = 0;
> +	abs = xenbus_read_unsigned(dev->otherend, "feature-abs-pointer", 0);
>  	if (abs) {
>  		ret = xenbus_write(XBT_NIL, dev->nodename,
>  				   "request-abs-pointer", "1");
> @@ -322,11 +322,8 @@ static void xenkbd_backend_changed(struct xenbus_device *dev,
>  
>  	case XenbusStateInitWait:
>  InitWait:
> -		ret = xenbus_scanf(XBT_NIL, info->xbdev->otherend,
> -				   "feature-abs-pointer", "%d", &val);
> -		if (ret < 0)
> -			val = 0;
> -		if (val) {
> +		if (xenbus_read_unsigned(info->xbdev->otherend,
> +					 "feature-abs-pointer", 0)) {
>  			ret = xenbus_write(XBT_NIL, info->xbdev->nodename,
>  					   "request-abs-pointer", "1");
>  			if (ret)
> -- 
> 2.6.6
> 

-- 
Dmitry
