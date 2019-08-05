From: Jiri Kosina <jikos@kernel.org>
Subject: Re: KASAN: use-after-free Read in hiddev_release
Date: Mon, 5 Aug 2019 14:24:18 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1908051423440.5899@cbobk.fhfr.pm>
References: <20190805081212.3144-1-hdanton@sina.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190805081212.3144-1-hdanton@sina.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+62a1e04fd3ec2abf099e@syzkaller.appspotmail.com>, andreyknvl@google.com, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
List-Id: linux-input@vger.kernel.org

On Mon, 5 Aug 2019, Hillf Danton wrote:

> 1, no dev no open.
> 
> --- a/drivers/hid/usbhid/hiddev.c
> +++ b/drivers/hid/usbhid/hiddev.c
> @@ -284,6 +284,10 @@ static int hiddev_open(struct inode *ino
>  	spin_unlock_irq(&list->hiddev->list_lock);
>  
>  	mutex_lock(&hiddev->existancelock);
> +	if (!list->hiddev->exist) {
> +		res = -ENODEV;
> +		goto bail_unlock;
> +	}
>  	if (!list->hiddev->open++)
>  		if (list->hiddev->exist) {
>  			struct hid_device *hid = hiddev->hid;
> --
> 
> 2, list_del before vfree.
> 
> --- a/drivers/hid/usbhid/hiddev.c
> +++ b/drivers/hid/usbhid/hiddev.c
> @@ -300,6 +304,9 @@ bail_normal_power:
>  	hid_hw_power(hid, PM_HINT_NORMAL);
>  bail_unlock:
>  	mutex_unlock(&hiddev->existancelock);
> +	spin_lock_irq(&list->hiddev->list_lock);
> +	list_del(&list->node);
> +	spin_unlock_irq(&list->hiddev->list_lock);
>  bail:
>  	file->private_data = NULL;
>  	vfree(list);

Hilf,

both patches look good to me. Could you please resend them properly so 
that I could apply them? Thanks,

-- 
Jiri Kosina
SUSE Labs
