From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: hidraw: switch to using memdup_user
Date: Thu, 17 Mar 2016 09:08:10 +0100
Message-ID: <20160317080810.GS22340@mail.corp.redhat.com>
References: <20160316235938.GA23827@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54412 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754508AbcCQIIP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Mar 2016 04:08:15 -0400
Content-Disposition: inline
In-Reply-To: <20160316235938.GA23827@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mar 16 2016 or thereabouts, Dmitry Torokhov wrote:
> Instead of open-coding memory allocation and copying form user memory
> sequence let's use memdup_user().
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Works for me:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/hid/hidraw.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
> index 9c2d7c2..b9a76e3 100644
> --- a/drivers/hid/hidraw.c
> +++ b/drivers/hid/hidraw.c
> @@ -34,6 +34,7 @@
>  #include <linux/hid.h>
>  #include <linux/mutex.h>
>  #include <linux/sched.h>
> +#include <linux/string.h>
>  
>  #include <linux/hidraw.h>
>  
> @@ -123,7 +124,6 @@ static ssize_t hidraw_send_report(struct file *file, const char __user *buffer,
>  
>  	dev = hidraw_table[minor]->hid;
>  
> -
>  	if (count > HID_MAX_BUFFER_SIZE) {
>  		hid_warn(dev, "pid %d passed too large report\n",
>  			 task_pid_nr(current));
> @@ -138,17 +138,12 @@ static ssize_t hidraw_send_report(struct file *file, const char __user *buffer,
>  		goto out;
>  	}
>  
> -	buf = kmalloc(count * sizeof(__u8), GFP_KERNEL);
> -	if (!buf) {
> -		ret = -ENOMEM;
> +	buf = memdup_user(buffer, count);
> +	if (IS_ERR(buf)) {
> +		ret = PTR_ERR(buf);
>  		goto out;
>  	}
>  
> -	if (copy_from_user(buf, buffer, count)) {
> -		ret = -EFAULT;
> -		goto out_free;
> -	}
> -
>  	if ((report_type == HID_OUTPUT_REPORT) &&
>  	    !(dev->quirks & HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP)) {
>  		ret = hid_hw_output_report(dev, buf, count);
> -- 
> 2.7.0.rc3.207.g0ac5344
> 
> 
> -- 
> Dmitry
