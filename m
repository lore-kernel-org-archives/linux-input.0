From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH RESEND] HID: wacom: Remove comparison of u8 mode with
 zero and simplify.
Date: Wed, 12 Jul 2017 09:39:17 +0200
Message-ID: <20170712073917.GE22282@mail.corp.redhat.com>
References: <1499541948-3392-1-git-send-email-chris.gekas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35416 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756657AbdGLHjW (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 12 Jul 2017 03:39:22 -0400
Content-Disposition: inline
In-Reply-To: <1499541948-3392-1-git-send-email-chris.gekas@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christos Gkekas <chris.gekas@gmail.com>
Cc: Joe Perches <joe@perches.com>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Jul 08 2017 or thereabouts, Christos Gkekas wrote:
> Variable mode in method wacom_show_remote_mode() is defined as u8, thus
> statement (mode >= 0) is always true and should be removed, simplifying
> the logic.
> 
> Signed-off-by: Christos Gkekas <chris.gekas@gmail.com>
> ---

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

>  drivers/hid/wacom_sys.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 838c1eb..ae2408d 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -1671,10 +1671,7 @@ static ssize_t wacom_show_remote_mode(struct kobject *kobj,
>  	u8 mode;
>  
>  	mode = wacom->led.groups[index].select;
> -	if (mode >= 0 && mode < 3)
> -		return snprintf(buf, PAGE_SIZE, "%d\n", mode);
> -	else
> -		return snprintf(buf, PAGE_SIZE, "%d\n", -1);
> +	return sprintf(buf, "%d\n", mode < 3 ? mode : -1);
>  }
>  
>  #define DEVICE_EKR_ATTR_GROUP(SET_ID)					\
> -- 
> 2.7.4
> 
