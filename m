From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: hidraw: replace printk() with corresponding pr_xx()
 variant
Date: Thu, 12 Sep 2019 21:31:19 +0100
Message-ID: <20190912203119.GC636@penguin>
References: <1566492232-13590-1-git-send-email-gupt21@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1566492232-13590-1-git-send-email-gupt21@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rishi Gupta <gupt21@gmail.com>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Rishi,

On Thu, Aug 22, 2019 at 10:13:52PM +0530, Rishi Gupta wrote:
> This commit replaces direct invocations of printk with
> their appropriate pr_info/warn() variant.
> 
> Signed-off-by: Rishi Gupta <gupt21@gmail.com>
> ---
>  drivers/hid/hidraw.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
> index 006bd6f..67b652b 100644
> --- a/drivers/hid/hidraw.c
> +++ b/drivers/hid/hidraw.c
> @@ -197,14 +197,14 @@ static ssize_t hidraw_get_report(struct file *file, char __user *buffer, size_t
>  	}
>  
>  	if (count > HID_MAX_BUFFER_SIZE) {
> -		printk(KERN_WARNING "hidraw: pid %d passed too large report\n",
> +		pr_warn("hidraw: pid %d passed too large report\n",
>  				task_pid_nr(current));

If you are doing this, you should also look into pr_fmt() so that we do
not need to manually add "hidraw: " prefix to the messages.

>  		ret = -EINVAL;
>  		goto out;
>  	}
>  
>  	if (count < 2) {
> -		printk(KERN_WARNING "hidraw: pid %d passed too short report\n",
> +		pr_warn("hidraw: pid %d passed too short report\n",
>  				task_pid_nr(current));
>  		ret = -EINVAL;
>  		goto out;
> @@ -597,7 +597,7 @@ int __init hidraw_init(void)
>  	if (result < 0)
>  		goto error_class;
>  
> -	printk(KERN_INFO "hidraw: raw HID events driver (C) Jiri Kosina\n");
> +	pr_info("hidraw: raw HID events driver (C) Jiri Kosina\n");
>  out:
>  	return result;
>  
> -- 
> 2.7.4
> 

Thanks.

-- 
Dmitry
