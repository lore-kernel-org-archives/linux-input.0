From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 1/1] HID: hidraw, fix window in hidraw_release
Date: Tue, 19 Oct 2010 11:28:12 +0200
Message-ID: <4CBD64AC.7030207@suse.cz>
References: <20101009144026.c37f8d25.ospite@studenti.unina.it> <1287480285-5335-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1287480285-5335-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Cc: jkosina@suse.cz, alan@signal11.us, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 10/19/2010 11:24 AM, Jiri Slaby wrote:
> There is a window between hidraw_table check and its dereference.
> In that window, the device may be unplugged and removed form the
> system and we will then dereference NULL.
> 
> Lock that place properly so that either we get NULL and jump out or we
> can work with real pointer.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  drivers/hid/hidraw.c |   14 ++++++++++----
>  1 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
> index 925992f..6d81be3 100644
> --- a/drivers/hid/hidraw.c
> +++ b/drivers/hid/hidraw.c
> @@ -218,9 +218,13 @@ static int hidraw_release(struct inode * inode, struct file * file)
>  	unsigned int minor = iminor(inode);
>  	struct hidraw *dev;
>  	struct hidraw_list *list = file->private_data;
> +	int ret;
>  
> -	if (!hidraw_table[minor])
> -		return -ENODEV;
> +	mutex_lock(&minors_lock);
> +	if (!hidraw_table[minor]) {
> +		ret = -ENODEV;
> +		goto unlock;
> +	}
>  
>  	list_del(&list->node);
>  	dev = hidraw_table[minor];
> @@ -233,10 +237,12 @@ static int hidraw_release(struct inode * inode, struct file * file)
>  			kfree(list->hidraw);
>  		}
>  	}
> -
> +	ret = 0;
> +unlock:
> +	mutex_unlock(&minors_lock);
>  	kfree(list);

Actually the kfree cannot be here. The first process to exit would free
it and the others will try to free it again.

Was it supposed to leak memory in the !hidraw_table[minor] case?

regards,
-- 
js
suse labs
