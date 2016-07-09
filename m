From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] xen-kbdfront: correct return value checks on
 xenbus_scanf()
Date: Fri, 8 Jul 2016 17:33:29 -0700
Message-ID: <20160709003329.GJ28589@dtor-ws>
References: <577E26A402000078000FBE93@prv-mh.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36646 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756299AbcGIAdc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jul 2016 20:33:32 -0400
Received: by mail-pa0-f67.google.com with SMTP id ib6so8948239pad.3
        for <linux-input@vger.kernel.org>; Fri, 08 Jul 2016 17:33:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <577E26A402000078000FBE93@prv-mh.provo.novell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jan Beulich <JBeulich@suse.com>
Cc: david.vrabel@citrix.com, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, Juergen Gross <JGross@suse.com>, linux-input@vger.kernel.org

On Thu, Jul 07, 2016 at 01:53:40AM -0600, Jan Beulich wrote:
> Only a positive return value indicates success.

If I am reading this correctly xenbus_scanf() guarantees that it will
not return 0. From include/xen/xenbus.h:

/* Single read and scanf: returns -errno or num scanned if > 0. */
__scanf(4, 5)
int xenbus_scanf(struct xenbus_transaction t,
		 const char *dir, const char *node, const char *fmt, ...);

and the code matches:

	...
	/* Distinctive errno. */
	if (ret == 0)
		return -ERANGE;
	return ret;

> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> ---
>  drivers/input/misc/xen-kbdfront.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> --- 4.7-rc6-xenbus_scanf.orig/drivers/input/misc/xen-kbdfront.c
> +++ 4.7-rc6-xenbus_scanf/drivers/input/misc/xen-kbdfront.c
> @@ -127,7 +127,8 @@ static int xenkbd_probe(struct xenbus_de
>  	if (!info->page)
>  		goto error_nomem;
>  
> -	if (xenbus_scanf(XBT_NIL, dev->otherend, "feature-abs-pointer", "%d", &abs) < 0)
> +	if (xenbus_scanf(XBT_NIL, dev->otherend,
> +			 "feature-abs-pointer", "%d", &abs) <= 0)
>  		abs = 0;
>  	if (abs) {
>  		ret = xenbus_printf(XBT_NIL, dev->nodename,
> @@ -324,7 +325,7 @@ static void xenkbd_backend_changed(struc
>  InitWait:
>  		ret = xenbus_scanf(XBT_NIL, info->xbdev->otherend,
>  				   "feature-abs-pointer", "%d", &val);
> -		if (ret < 0)
> +		if (ret <= 0)
>  			val = 0;
>  		if (val) {
>  			ret = xenbus_printf(XBT_NIL, info->xbdev->nodename,
> 
> 

Thanks.

-- 
Dmitry
