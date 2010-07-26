From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [RFC 36/36]  [Driver][Qualcomm 1070][VERSION] 0.2.0
Date: Mon, 26 Jul 2010 14:10:09 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E7D0AEE2@dbde02.ent.ti.com>
References: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
 <1280133045-25945-36-git-send-email-wayne.lin@quantatw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41457 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848Ab0GZIkU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 04:40:20 -0400
In-Reply-To: <1280133045-25945-36-git-send-email-wayne.lin@quantatw.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wayne Lin <00601wayne@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: wayne <wayne.lin@quantatw.com>

> -----Original Message-----
> From: linux-input-owner@vger.kernel.org 
> [mailto:linux-input-owner@vger.kernel.org] On Behalf Of Wayne Lin
> Sent: Monday, July 26, 2010 2:01 PM
> To: linux-input@vger.kernel.org
> Cc: wayne
> Subject: [RFC 36/36] [Driver][Qualcomm 1070][VERSION] 0.2.0
> 
> From: wayne <wayne.lin@quantatw.com>
> 

I haven't looked at all the patches, but I see may patches that are
changing only 1 or 2 lines. Do these really need to separated as such?

If you collate patches functionally, having description would also help.

Also, I noticed many changes to the defconfigs. You may want to take
a look at this discussion:
http://amailbox.org/mailarchive/linux-kernel/2010/6/6/4579948

~sanjeev

> ---
>  arch/arm/mach-msm/version.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-msm/version.c b/arch/arm/mach-msm/version.c
> index f665d9f..be21aae 100755
> --- a/arch/arm/mach-msm/version.c
> +++ b/arch/arm/mach-msm/version.c
> @@ -12,7 +12,7 @@
>  #include "smd_private.h"
>  
>  #define KERNEL_VERSION UTS_RELEASE
> -#define IMAGE_VERSION "0.1.2"
> +#define IMAGE_VERSION "0.2.0"
>  
>  static int version_proc_show(struct seq_file *m, void *v)
>  {
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 