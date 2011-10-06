From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH 1/9] Input: serio-raw - use kref instead of rolling out
 its own refcounting
Date: Thu, 06 Oct 2011 14:05:18 +0800
Message-ID: <4E8D451E.6000800@cn.fujitsu.com>
References: <1317877696-7719-1-git-send-email-dmitry.torokhov@gmail.com>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:61691 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752705Ab1JFGG0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 6 Oct 2011 02:06:26 -0400
In-Reply-To: <1317877696-7719-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Thomas Tuttle <ttuttle@chromium.org>

On 10/06/2011 01:08 PM, Dmitry Torokhov wrote:

> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

All the 9 patches.

Thanks

> ---
>  drivers/input/serio/serio_raw.c |   28 +++++++++++++---------------
>  1 files changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/input/serio/serio_raw.c b/drivers/input/serio/serio_raw.c
> index b7ba459..ef3a69c 100644
> --- a/drivers/input/serio/serio_raw.c
> +++ b/drivers/input/serio/serio_raw.c
> @@ -9,6 +9,7 @@
>   * the Free Software Foundation.
>   */
>  
> +#include <linux/kref.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/poll.h>
> @@ -33,7 +34,7 @@ struct serio_raw {
>  	unsigned int tail, head;
>  
>  	char name[16];
> -	unsigned int refcnt;
> +	struct kref kref;
>  	struct serio *serio;
>  	struct miscdevice dev;
>  	wait_queue_head_t wait;
> @@ -104,7 +105,7 @@ static int serio_raw_open(struct inode *inode, struct file *file)
>  	list->serio_raw = serio_raw;
>  	file->private_data = list;
>  
> -	serio_raw->refcnt++;
> +	kref_get(&serio_raw->kref);
>  	list_add_tail(&list->node, &serio_raw->list);
>  
>  out:
> @@ -112,17 +113,14 @@ out:
>  	return retval;
>  }
>  
> -static int serio_raw_cleanup(struct serio_raw *serio_raw)
> +static void serio_raw_cleanup(struct kref *kref)
>  {
> -	if (--serio_raw->refcnt == 0) {
> -		misc_deregister(&serio_raw->dev);
> -		list_del_init(&serio_raw->node);
> -		kfree(serio_raw);
> +	struct serio_raw *serio_raw =
> +			container_of(kref, struct serio_raw, kref);
>  
> -		return 1;
> -	}
> -
> -	return 0;
> +	misc_deregister(&serio_raw->dev);
> +	list_del_init(&serio_raw->node);
> +	kfree(serio_raw);
>  }
>  
>  static int serio_raw_release(struct inode *inode, struct file *file)
> @@ -132,7 +130,7 @@ static int serio_raw_release(struct inode *inode, struct file *file)
>  
>  	mutex_lock(&serio_raw_mutex);
>  
> -	serio_raw_cleanup(serio_raw);
> +	kref_put(&serio_raw->kref, serio_raw_cleanup);
>  
>  	mutex_unlock(&serio_raw_mutex);
>  	return 0;
> @@ -283,7 +281,7 @@ static int serio_raw_connect(struct serio *serio, struct serio_driver *drv)
>  	mutex_lock(&serio_raw_mutex);
>  
>  	snprintf(serio_raw->name, sizeof(serio_raw->name), "serio_raw%d", serio_raw_no++);
> -	serio_raw->refcnt = 1;
> +	kref_init(&serio_raw->kref);
>  	serio_raw->serio = serio;
>  	INIT_LIST_HEAD(&serio_raw->list);
>  	init_waitqueue_head(&serio_raw->wait);
> @@ -357,8 +355,8 @@ static void serio_raw_disconnect(struct serio *serio)
>  	serio_set_drvdata(serio, NULL);
>  
>  	serio_raw->serio = NULL;
> -	if (!serio_raw_cleanup(serio_raw))
> -		wake_up_interruptible(&serio_raw->wait);
> +	wake_up_interruptible(&serio_raw->wait);
> +	kref_put(&serio_raw->kref, serio_raw_cleanup);
>  
>  	mutex_unlock(&serio_raw_mutex);
>  }


