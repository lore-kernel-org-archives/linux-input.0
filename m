Received: from smtp153-171.sina.com.cn (smtp153-171.sina.com.cn [61.135.153.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF70D3A6B8E
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 22:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782685739; cv=none; b=SmkebXRJSP0NCkufi5+YLLicMuCp6Jv824Rx3r+B3hHrK+42h6zXpzBAnJSwW0RQ291X60piy7E7g678tMWdZYR9tQaejb6Ysjgbr1FL2xXnCpi8tcwNwvY81cHSVPnC/wecTul/eTcwwjvS+TOmdOs78Niw7U1vbsVyF5+cQRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782685739; c=relaxed/simple;
	bh=wGYpFsjex/GCY9A+FuTsvSXCPQg5jHoqyNSdYqZu1WU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvGz/t6ofsQNvbw7s6Wo5DQQ9idKawKihUl4Isznnxt0yYb3NiPdQuZ8Gj4pZ2UEfLu7d+RWARCkUtqJAvzdVGeQBldxvyB/cq6mD1f5dHI1PDO/SuM4pXUjHc3nFyF5qqYbgUlaCyRBKF5Z+a+rr1VyyYuhgYralaBRxSt3wZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=ZtefNvSx; arc=none smtp.client-ip=61.135.153.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="ZtefNvSx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1782685734;
	bh=BAEX8aiOH6dT1GznRr9coicnP9iFd2gwEqT4dY7X+/g=;
	h=From:Subject:Date:Message-ID;
	b=ZtefNvSxyeyzrGvfWlPKVrEHSCbF7P+W7TwDpXMwo9vq12I2nhAdw28fnmI4WQLGC
	 vBhcgAvNtaqZklRDasFj7Cy6yTVYB0Ef7n9nuixaTofq/mNQII9q2R9l2HbBeeJfJV
	 Q5QP81+ddP45l03PwYtNKbRCpCesnKvgeWUrWPoM=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.34) with ESMTP
	id 6A419F8D00003478; Sun, 29 Jun 2026 06:26:24 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7340946292108
X-SMAIL-UIID: 26DF4A2D11AA4ABB93D11DE157D1456F-20260629-062624-1
From: Hillf Danton <hdanton@sina.com>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+563191a4939ddbfe73d4@syzkaller.appspotmail.com
Subject: Re: [PATCH] HID: hiddev: keep state alive through disconnect unlock
Date: Mon, 29 Jun 2026 06:26:15 +0800
Message-ID: <20260628222617.226-1-hdanton@sina.com>
In-Reply-To: <20260628093245.42065-1-alhouseenyousef@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 28 Jun 2026 11:32:45 +0200 Yousef Alhouseen wrote:
> hiddev_disconnect() drops existancelock before freeing the hiddev state,
> but a waiting final file release can run as soon as the mutex becomes
> available. On PREEMPT_RT, that waiter may free hiddev while the disconnect
> thread is still executing the mutex slow-unlock path, causing a
> use-after-free in the mutex implementation.
> 
The root cause is not specified as clearly as expected.

	hiddev_disconnect()	hiddev_release()
	---			---
	mutex_lock(&hiddev->existancelock);
	hiddev->exist = 0;

	if (hiddev->open) {
		hid_hw_close(hiddev->hid);
		wake_up_interruptible(&hiddev->wait);
		mutex_unlock(&hiddev->existancelock);
		__mutex_unlock_slowpath()
		raw_spin_lock_irqsave()   //UAF

				mutex_lock(&list->hiddev->existancelock);
				if (!--list->hiddev->open) {
					if (list->hiddev->exist) {
						hid_hw_close(list->hiddev->hid);
						hid_hw_power(list->hiddev->hid, PM_HINT_NORMAL);
					} else {
						mutex_unlock(&list->hiddev->existancelock);
						kfree(list->hiddev); // free mem
						vfree(list);
						return 0;
					}
				}
				mutex_unlock(&list->hiddev->existancelock);

Given the syzbot report, uaf occured upon acquiring the raw spinlock in
__mutex_unlock_slowpath(), but no mutex waiter could be waken up without
the raw spinlock held, thus the report sounds false positive.

> Give the connection and each open file an explicit reference. Drop each
> reference only after its existancelock critical section has completed, so
> the state cannot be freed from the other unlock path.
> 
> Fixes: 079034073faf ("HID: hiddev cleanup -- handle all error conditions properly")
> Reported-by: syzbot+563191a4939ddbfe73d4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=563191a4939ddbfe73d4
> Cc: stable@vger.kernel.org
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
>  drivers/hid/usbhid/hiddev.c | 37 +++++++++++++++++++------------------
>  include/linux/hiddev.h      |  2 ++
>  2 files changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
> index 6378801b22c6..21396481995b 100644
> --- a/drivers/hid/usbhid/hiddev.c
> +++ b/drivers/hid/usbhid/hiddev.c
> @@ -46,6 +46,12 @@ struct hiddev_list {
>  	struct mutex thread_lock;
>  };
>  
> +static void hiddev_put(struct hiddev *hiddev)
> +{
> +	if (refcount_dec_and_test(&hiddev->refcount))
> +		kfree(hiddev);
> +}
> +
>  /*
>   * Find a report, given the report's type and ID.  The ID can be specified
>   * indirectly by REPORT_ID_FIRST (which returns the first report of the given
> @@ -216,26 +222,21 @@ static int hiddev_fasync(int fd, struct file *file, int on)
>  static int hiddev_release(struct inode * inode, struct file * file)
>  {
>  	struct hiddev_list *list = file->private_data;
> +	struct hiddev *hiddev = list->hiddev;
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&list->hiddev->list_lock, flags);
> +	spin_lock_irqsave(&hiddev->list_lock, flags);
>  	list_del(&list->node);
> -	spin_unlock_irqrestore(&list->hiddev->list_lock, flags);
> +	spin_unlock_irqrestore(&hiddev->list_lock, flags);
>  
> -	mutex_lock(&list->hiddev->existancelock);
> -	if (!--list->hiddev->open) {
> -		if (list->hiddev->exist) {
> -			hid_hw_close(list->hiddev->hid);
> -			hid_hw_power(list->hiddev->hid, PM_HINT_NORMAL);
> -		} else {
> -			mutex_unlock(&list->hiddev->existancelock);
> -			kfree(list->hiddev);
> -			vfree(list);
> -			return 0;
> -		}
> +	mutex_lock(&hiddev->existancelock);
> +	if (!--hiddev->open && hiddev->exist) {
> +		hid_hw_close(hiddev->hid);
> +		hid_hw_power(hiddev->hid, PM_HINT_NORMAL);
>  	}
>  
> -	mutex_unlock(&list->hiddev->existancelock);
> +	mutex_unlock(&hiddev->existancelock);
> +	hiddev_put(hiddev);
>  	vfree(list);
>  
>  	return 0;
> @@ -270,6 +271,7 @@ static int __hiddev_open(struct hiddev *hiddev, struct file *file)
>  	spin_unlock_irq(&hiddev->list_lock);
>  
>  	file->private_data = list;
> +	refcount_inc(&hiddev->refcount);
>  
>  	return 0;
>  
> @@ -897,6 +899,7 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
>  	INIT_LIST_HEAD(&hiddev->list);
>  	spin_lock_init(&hiddev->list_lock);
>  	mutex_init(&hiddev->existancelock);
> +	refcount_set(&hiddev->refcount, 1);
>  	hid->hiddev = hiddev;
>  	hiddev->hid = hid;
>  	hiddev->exist = 1;
> @@ -937,9 +940,7 @@ void hiddev_disconnect(struct hid_device *hid)
>  	if (hiddev->open) {
>  		hid_hw_close(hiddev->hid);
>  		wake_up_interruptible(&hiddev->wait);
> -		mutex_unlock(&hiddev->existancelock);
> -	} else {
> -		mutex_unlock(&hiddev->existancelock);
> -		kfree(hiddev);
>  	}
> +	mutex_unlock(&hiddev->existancelock);
> +	hiddev_put(hiddev);
>  }
> diff --git a/include/linux/hiddev.h b/include/linux/hiddev.h
> index 2164c03d2c72..8e9f8a33e359 100644
> --- a/include/linux/hiddev.h
> +++ b/include/linux/hiddev.h
> @@ -13,6 +13,7 @@
>  #ifndef _HIDDEV_H
>  #define _HIDDEV_H
>  
> +#include <linux/refcount.h>
>  #include <uapi/linux/hiddev.h>
>  
>  
> @@ -24,6 +25,7 @@ struct hiddev {
>  	int minor;
>  	int exist;
>  	int open;
> +	refcount_t refcount;
>  	struct mutex existancelock;
>  	wait_queue_head_t wait;
>  	struct hid_device *hid;
> -- 
> 2.54.0
