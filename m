From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch] Input: wacom - fix a check for WACOM_24HDT
Date: Tue, 30 Oct 2012 22:57:18 -0700
Message-ID: <20121031055718.GF31983@core.coreip.homeip.net>
References: <20121029084956.GA7506@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:46500 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419Ab2JaF5W (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Oct 2012 01:57:22 -0400
Content-Disposition: inline
In-Reply-To: <20121029084956.GA7506@elgon.mountain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jason Gerecke <killertofu@gmail.com>, Chris Bagwell <chris@cnpbagwell.com>, Ping Cheng <pingc@wacom.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

On Mon, Oct 29, 2012 at 11:49:56AM +0300, Dan Carpenter wrote:
> The current condition is always true.  From the context, it looks like
> we should be checking if ->type == WACOM_24HDT.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thank you Dan, however I already have a patch from Jason Gerecke
addressing this issue.

> 
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
> index 2c1e12b..858ad44 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -391,7 +391,7 @@ static int wacom_parse_hid(struct usb_interface *intf,
>  							features->pktlen = WACOM_PKGLEN_TPC2FG;
>  						}
>  
> -						if (features->type == MTSCREEN || WACOM_24HDT)
> +						if (features->type == MTSCREEN || features->type == WACOM_24HDT)
>  							features->pktlen = WACOM_PKGLEN_MTOUCH;
>  
>  						if (features->type == BAMBOO_PT) {

-- 
Dmitry
