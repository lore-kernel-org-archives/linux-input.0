From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [Xen-devel] [PATCH 2/2] xen, input: repair xen-kbdfront
 resolution setting via xenstore
Date: Mon, 10 Apr 2017 17:20:36 +0300
Message-ID: <7ccb928b-a88e-1495-b92d-94642d6a5501@gmail.com>
References: <20170321171905.31584-1-jgross@suse.com>
 <20170321171905.31584-3-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36520 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753633AbdDJOUj (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Apr 2017 10:20:39 -0400
In-Reply-To: <20170321171905.31584-3-jgross@suse.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, stable@vger.kernel.org

On 03/21/2017 07:19 PM, Juergen Gross wrote:
> Setting the pointing device resolution via Xenstore isn't working
> reliably: in case XenbusStateInitWait has been missed the resolution
> settings won't be read. Correct this.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>   drivers/input/misc/xen-kbdfront.c | 32 ++++++++++++++++++++------------
>   1 file changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
> index 2df5678..7585fa4 100644
> --- a/drivers/input/misc/xen-kbdfront.c
> +++ b/drivers/input/misc/xen-kbdfront.c
> @@ -312,11 +312,27 @@ static void xenkbd_disconnect_backend(struct xenkbd_info *info)
>   	info->gref = -1;
>   }
>   
> +static void xenkbd_set_connected(struct xenbus_device *dev)
> +{
> +	struct xenkbd_info *info = dev_get_drvdata(&dev->dev);
> +	int ret;
> +
> +	if (xenbus_read_unsigned(info->xbdev->otherend,
> +				 "feature-abs-pointer", 0)) {
> +		ret = xenbus_write(XBT_NIL, info->xbdev->nodename,
> +				   "request-abs-pointer", "1");
> +		if (ret)
> +			pr_warn("xenkbd: can't request abs-pointer");
> +	}
> +
> +	xenbus_switch_state(dev, XenbusStateConnected);
> +}
> +
>   static void xenkbd_backend_changed(struct xenbus_device *dev,
>   				   enum xenbus_state backend_state)
>   {
>   	struct xenkbd_info *info = dev_get_drvdata(&dev->dev);
> -	int ret, val;
> +	int val;
>   
>   	switch (backend_state) {
>   	case XenbusStateInitialising:
> @@ -327,16 +343,7 @@ static void xenkbd_backend_changed(struct xenbus_device *dev,
>   		break;
>   
>   	case XenbusStateInitWait:
> -InitWait:
> -		if (xenbus_read_unsigned(info->xbdev->otherend,
> -					 "feature-abs-pointer", 0)) {
> -			ret = xenbus_write(XBT_NIL, info->xbdev->nodename,
> -					   "request-abs-pointer", "1");
> -			if (ret)
> -				pr_warning("xenkbd: can't request abs-pointer");
> -		}
> -
> -		xenbus_switch_state(dev, XenbusStateConnected);
> +		xenkbd_set_connected(dev);
>   		break;
>   
>   	case XenbusStateConnected:
> @@ -346,7 +353,8 @@ static void xenkbd_backend_changed(struct xenbus_device *dev,
>   		 * get Connected twice here.
>   		 */
>   		if (dev->state != XenbusStateConnected)
> -			goto InitWait; /* no InitWait seen yet, fudge it */
> +			/* No InitWait seen yet, fudge it. */
> +			xenkbd_set_connected(dev);
>   
>   		/* Set input abs params to match backend screen res */
>   		if (xenbus_scanf(XBT_NIL, info->xbdev->otherend,
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
