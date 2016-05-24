From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH 1/2] Input: wacom_w8001 - W8001_MAX_LENGTH should be 13
Date: Tue, 24 May 2016 15:01:45 +1000
Message-ID: <20160524050145.GA11910@jelly>
References: <1464059020-6205-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:37876 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbcEXFBw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 May 2016 01:01:52 -0400
Content-Disposition: inline
In-Reply-To: <1464059020-6205-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, benjamin.tissoires@gmail.com, Ping Cheng <pingc@wacom.com>

On Mon, May 23, 2016 at 08:03:40PM -0700, Ping Cheng wrote:
> Somehow the patch that added two-finger touch support forgot to update
> W8001_MAX_LENGTH from 11 to 13.
> 
> Signed-off-by: Ping Cheng <pingc@wacom.com>

whoops, I think that was me.

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>

Cheers,
   Peter

> ---
>  drivers/input/touchscreen/wacom_w8001.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
> index bab3c6a..b1b4127 100644
> --- a/drivers/input/touchscreen/wacom_w8001.c
> +++ b/drivers/input/touchscreen/wacom_w8001.c
> @@ -27,7 +27,7 @@ MODULE_AUTHOR("Jaya Kumar <jayakumar.lkml@gmail.com>");
>  MODULE_DESCRIPTION(DRIVER_DESC);
>  MODULE_LICENSE("GPL");
>  
> -#define W8001_MAX_LENGTH	11
> +#define W8001_MAX_LENGTH	13
>  #define W8001_LEAD_MASK		0x80
>  #define W8001_LEAD_BYTE		0x80
>  #define W8001_TAB_MASK		0x40
> -- 
> 1.9.1
> 
