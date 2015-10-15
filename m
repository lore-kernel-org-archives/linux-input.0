From: David Vrabel <david.vrabel@citrix.com>
Subject: Re: [PATCH] xen: check return value of xenbus_printf
Date: Thu, 15 Oct 2015 17:40:55 +0100
Message-ID: <561FD717.9090807@citrix.com>
References: <1444926315-29106-1-git-send-email-wuninsu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.citrix.com ([66.165.176.89]:41659 "EHLO SMTP.CITRIX.COM"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752266AbbJOQlD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Oct 2015 12:41:03 -0400
In-Reply-To: <1444926315-29106-1-git-send-email-wuninsu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Insu Yun <wuninsu@gmail.com>, dmitry.torokhov@gmail.com, wei.liu2@citrix.com, julien.grall@citrix.com, stefano.stabellini@eu.citrix.com, huaixin.chx@alibaba-inc.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: taesoo@gatech.edu, yeongjin.jang@gatech.edu, insu@gatech.edu

On 15/10/15 17:25, Insu Yun wrote:
> Internally, xenbus_printf uses memory allocation, so it can be failed in
> memory pressure.Therefore, xenbus_printf's return should be checked 
> and properly handled.
[...]
> --- a/drivers/input/misc/xen-kbdfront.c
> +++ b/drivers/input/misc/xen-kbdfront.c
> @@ -129,8 +129,11 @@ static int xenkbd_probe(struct xenbus_device *dev,
>  
>  	if (xenbus_scanf(XBT_NIL, dev->otherend, "feature-abs-pointer", "%d", &abs) < 0)
>  		abs = 0;
> -	if (abs)
> -		xenbus_printf(XBT_NIL, dev->nodename, "request-abs-pointer", "1");
> +	if (abs) {
> +		ret = xenbus_printf(XBT_NIL, dev->nodename, "request-abs-pointer", "1");
> +		if (ret)
> +			pr_warning("xenkbd: can't request abs-pointer");

I think you want abs = 0 here or input device will be configured as
absolute but the backend will supply relative coordinates.

David
