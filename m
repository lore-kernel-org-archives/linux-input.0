From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] hid: Remove annoying non-error printk
Date: Wed, 21 Apr 2010 22:17:23 +0100
Message-ID: <1271884643.17421.4098.camel@localhost.localdomain>
References: <1271884104-31884-1-git-send-email-FOSS@AtlasTechnologiesInc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:56861 "EHLO
	relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755156Ab0DUVR3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Apr 2010 17:17:29 -0400
In-Reply-To: <1271884104-31884-1-git-send-email-FOSS@AtlasTechnologiesInc.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cory Fields <FOSS@AtlasTechnologiesInc.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, jkosina@suse.cz

On Wed, 2010-04-21 at 17:08 -0400, Cory Fields wrote:
> This is the only line printed on my "quiet" boot and seems completely
> unnecessary.

Probably left-over from a debug run...

> Signed-off-by: Cory Fields <FOSS@AtlasTechnologiesInc.com>
Signed-off-by: Bastien Nocera <hadess@hadess.net>

> ---
>  drivers/hid/hid-wacom.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
> index f7700cf..f947d83 100644
> --- a/drivers/hid/hid-wacom.c
> +++ b/drivers/hid/hid-wacom.c
> @@ -277,7 +277,6 @@ static int __init wacom_init(void)
>  	ret = hid_register_driver(&wacom_driver);
>  	if (ret)
>  		printk(KERN_ERR "can't register wacom driver\n");
> -	printk(KERN_ERR "wacom driver registered\n");
>  	return ret;
>  }
>  


