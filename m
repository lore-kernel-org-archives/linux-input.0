From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] [PATCH] xen-kbdfront: enable xen-kbdfront for HVM
 guests
Date: Mon, 27 Jun 2011 11:52:52 -0400
Message-ID: <20110627155252.GL6978@dumpdata.com>
References: <alpine.DEB.2.00.1106241730220.12963@kaball-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:35781 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030Ab1F0PxK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jun 2011 11:53:10 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1106241730220.12963@kaball-desktop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefano Stabellini <stefano.stabellini@eu.citrix.com>, linux-input@vger.kernel.org
Cc: xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org

On Fri, Jun 24, 2011 at 05:33:16PM +0100, Stefano Stabellini wrote:
> xen-kbdfront: enable xen-kbdfront for HVM guests too

Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Dmitry, can you pick this up for 3.1 please?

> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> 
> diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
> index 62bae99..ad2e51c 100644
> --- a/drivers/input/misc/xen-kbdfront.c
> +++ b/drivers/input/misc/xen-kbdfront.c
> @@ -373,7 +373,7 @@ static struct xenbus_driver xenkbd_driver = {
>  
>  static int __init xenkbd_init(void)
>  {
> -	if (!xen_pv_domain())
> +	if (!xen_domain())
>  		return -ENODEV;
>  
>  	/* Nothing to do if running in dom0. */
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xensource.com
> http://lists.xensource.com/xen-devel
