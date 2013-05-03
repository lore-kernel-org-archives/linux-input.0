From: majianpeng <majianpeng@gmail.com>
Subject: Re: [BUG] suspicious RCU usage
Date: Fri, 03 May 2013 18:35:42 +0800
Message-ID: <518392FE.4000302@gmail.com>
References: <51835EFD.2070403@gmail.com> <CAN+gG=F5O_EAr8P2Zgy7w39JcBJwWVzUSUaj0s6U0C6SRP6tYA@mail.gmail.com> <alpine.LNX.2.00.1305031022260.11002@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:51273 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453Ab3ECKfu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 May 2013 06:35:50 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl13so859615pab.20
        for <linux-input@vger.kernel.org>; Fri, 03 May 2013 03:35:50 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1305031022260.11002@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>

On 05/03/2013 04:23 PM, Jiri Kosina wrote:
> On Fri, 3 May 2013, Benjamin Tissoires wrote:
>
>> Thanks for reporting it.
>>
>> Jiri, we had a similar bug in the RH bugzilla:
>> https://bugzilla.redhat.com/show_bug.cgi?id=958935
>>
>> Are these two reports potentially fixed by your patch "HID: protect
>> hid_debug_list" (https://patchwork.kernel.org/patch/2453931/)
>> If so, maybe we should send it to stable as well...
> I actually believe this bug is *introduced* by that patch :) All the 
> reports were with the kernel containing it, right?
>
> Does the patch below fix it, please?
>
>
>
>
>  drivers/hid/hid-core.c  |    2 +-
>  drivers/hid/hid-debug.c |   14 ++++++++------
>  include/linux/hid.h     |    2 +-
>  3 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 1e51159..264f550 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2342,7 +2342,7 @@ struct hid_device *hid_allocate_device(void)
>  
>  	init_waitqueue_head(&hdev->debug_wait);
>  	INIT_LIST_HEAD(&hdev->debug_list);
> -	mutex_init(&hdev->debug_list_lock);
> +	spin_lock_init(&hdev->debug_list_lock);
>  	sema_init(&hdev->driver_lock, 1);
>  	sema_init(&hdev->driver_input_lock, 1);
>  
> diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
> index 7e56cb3..572572c 100644
> --- a/drivers/hid/hid-debug.c
> +++ b/drivers/hid/hid-debug.c
> @@ -580,14 +580,14 @@ void hid_debug_event(struct hid_device *hdev, char *buf)
>  	int i;
>  	struct hid_debug_list *list;
>  
> -	mutex_lock(&hdev->debug_list_lock);
> +	spin_lock(&hdev->debug_list_lock);
>  	list_for_each_entry(list, &hdev->debug_list, node) {
>  		for (i = 0; i < strlen(buf); i++)
>  			list->hid_debug_buf[(list->tail + i) % HID_DEBUG_BUFSIZE] =
>  				buf[i];
>  		list->tail = (list->tail + i) % HID_DEBUG_BUFSIZE;
>          }
> -	mutex_unlock(&hdev->debug_list_lock);
> +	spin_unlock(&hdev->debug_list_lock);
>  
>  	wake_up_interruptible(&hdev->debug_wait);
>  }
> @@ -977,6 +977,7 @@ static int hid_debug_events_open(struct inode *inode, struct file *file)
>  {
>  	int err = 0;
>  	struct hid_debug_list *list;
> +	unsigned long flags;
>  
>  	if (!(list = kzalloc(sizeof(struct hid_debug_list), GFP_KERNEL))) {
>  		err = -ENOMEM;
> @@ -992,9 +993,9 @@ static int hid_debug_events_open(struct inode *inode, struct file *file)
>  	file->private_data = list;
>  	mutex_init(&list->read_mutex);
>  
> -	mutex_lock(&list->hdev->debug_list_lock);
> +	spin_lock_irqsave(&list->hdev->debug_list_lock, flags);
>  	list_add_tail(&list->node, &list->hdev->debug_list);
> -	mutex_unlock(&list->hdev->debug_list_lock);
> +	spin_unlock_irqrestore(&list->hdev->debug_list_lock, flags);
>  
>  out:
>  	return err;
> @@ -1088,10 +1089,11 @@ static unsigned int hid_debug_events_poll(struct file *file, poll_table *wait)
>  static int hid_debug_events_release(struct inode *inode, struct file *file)
>  {
>  	struct hid_debug_list *list = file->private_data;
> +	unsigned long flags;
>  
> -	mutex_lock(&list->hdev->debug_list_lock);
> +	spin_lock_irqsave(&list->hdev->debug_list_lock, flags);
>  	list_del(&list->node);
> -	mutex_unlock(&list->hdev->debug_list_lock);
> +	spin_unlock_irqrestore(&list->hdev->debug_list_lock, flags);
>  	kfree(list->hid_debug_buf);
>  	kfree(list);
>  
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index af1b86d..0c48991 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -515,7 +515,7 @@ struct hid_device {							/* device report descriptor */
>  	struct dentry *debug_rdesc;
>  	struct dentry *debug_events;
>  	struct list_head debug_list;
> -	struct mutex debug_list_lock;
> +	spinlock_t  debug_list_lock;
>  	wait_queue_head_t debug_wait;
>  };
>  
Add your patch.Found the following message:
[  150.908051] ======================================================
[  150.908053] [ INFO: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected ]
[  150.908056] 3.9.0+ #102 Not tainted
[  150.908057] ------------------------------------------------------
[  150.908060] Xorg/5473 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
[  150.908062]  (&(&hdev->debug_list_lock)->rlock){+.+...}, at: [<ffffffff8155a172>] hid_debug_event+0x32/0x100
[  150.908072]
[  150.908072] and this task is already holding:
[  150.908074]  (&(&usbhid->lock)->rlock){-.....}, at: [<ffffffff8156b799>] usb_hidinput_input_event+0x89/0x120
[  150.908081] which would create a new lock dependency:
[  150.908082]  (&(&usbhid->lock)->rlock){-.....} -> (&(&hdev->debug_list_lock)->rlock){+.+...}
[  150.908089]
[  150.908089] but this new dependency connects a HARDIRQ-irq-safe lock:
[  150.908091]  (&(&usbhid->lock)->rlock){-.....}
[  150.908091] ... which became HARDIRQ-irq-safe at:
[  150.908094]   [<ffffffff810b08ff>] __lock_acquire+0x91f/0x1d80
[  150.908098]   [<ffffffff810b2437>] lock_acquire+0x97/0x1d0
[  150.908101]   [<ffffffff81700e66>] _raw_spin_lock+0x46/0x80
[  150.908105]   [<ffffffff8156b505>] hid_ctrl+0x45/0x1a0
[  150.908108]   [<ffffffff814db295>] usb_hcd_giveback_urb+0x65/0xf0
[  150.908112]   [<ffffffff814f4050>] ehci_urb_done+0x80/0xc0
[  150.908115]   [<ffffffff814f50a7>] qh_completions+0x367/0x570
[  150.908118]   [<ffffffff814f85fb>] ehci_work+0xdb/0x8d0
[  150.908122]   [<ffffffff814f9568>] ehci_irq+0x2d8/0x4c0
[  150.908125]   [<ffffffff814da577>] usb_hcd_irq+0x37/0x70
[  150.908127]   [<ffffffff810e3a75>] handle_irq_event_percpu+0x75/0x380
[  150.908131]   [<ffffffff810e3dc8>] handle_irq_event+0x48/0x70
[  150.908134]   [<ffffffff810e6fba>] handle_fasteoi_irq+0x5a/0x100
[  150.908138]   [<ffffffff8100453f>] handle_irq+0xbf/0x150
[  150.908141]   [<ffffffff8170c33a>] do_IRQ+0x5a/0xe0
[  150.908145]   [<ffffffff81701d6f>] ret_from_intr+0x0/0x13
[  150.908148]   [<ffffffff8106df68>] __kernel_text_address+0x58/0x80
[  150.908152]   [<ffffffff81005a1f>] print_context_stack+0x8f/0xf0
[  150.908155]   [<ffffffff8100483f>] dump_trace+0x1af/0x2d0
[  150.908157]   [<ffffffff8100fd1b>] save_stack_trace+0x2b/0x50
[  150.908162]   [<ffffffff81181e24>] create_object+0x144/0x310
[  150.908167]   [<ffffffff816e41db>] kmemleak_alloc+0x5b/0xc0
[  150.908170]   [<ffffffff8117aee6>] kmem_cache_alloc+0x106/0x290
[  150.908174]   [<ffffffff812051d9>] sysfs_new_dirent+0x59/0x140
[  150.908177]   [<ffffffff8120433b>] sysfs_add_file_mode+0x6b/0x110
[  150.908180]   [<ffffffff81207700>] internal_create_group+0xd0/0x230
[  150.908183]   [<ffffffff81207893>] sysfs_create_group+0x13/0x20
[  150.908186]   [<ffffffff814604b8>] device_add_groups+0x48/0xa0
[  150.908190]   [<ffffffff81461be7>] device_add+0x407/0x6b0
[  150.908193]   [<ffffffff81512d80>] input_register_device+0x200/0x5b0
[  150.908196]   [<ffffffff81560691>] hidinput_connect+0x15b1/0x2900
[  150.908199]   [<ffffffff8155e5ad>] hid_connect+0x2dd/0x350
[  150.908202]   [<ffffffff8155e774>] hid_device_probe+0x154/0x170
[  150.908206]   [<ffffffff81464a8f>] driver_probe_device+0x7f/0x370
[  150.908209]   [<ffffffff81464e7b>] __device_attach+0x4b/0x60
[  150.908213]   [<ffffffff8146294e>] bus_for_each_drv+0x4e/0xa0
[  150.908216]   [<ffffffff81464998>] device_attach+0x98/0xb0
[  150.908219]   [<ffffffff81463cb0>] bus_probe_device+0xa0/0xc0
[  150.908222]   [<ffffffff81461d8e>] device_add+0x5ae/0x6b0
[  150.908225]   [<ffffffff8155e0d4>] hid_add_device+0x174/0x370
[  150.908228]   [<ffffffff8156a974>] usbhid_probe+0x394/0x4d0
[  150.908231]   [<ffffffff814e2015>] usb_probe_interface+0xf5/0x240
[  150.908234]   [<ffffffff81464a8f>] driver_probe_device+0x7f/0x370
[  150.908238]   [<ffffffff81464e7b>] __device_attach+0x4b/0x60
[  150.908241]   [<ffffffff8146294e>] bus_for_each_drv+0x4e/0xa0
[  150.908244]   [<ffffffff81464998>] device_attach+0x98/0xb0
[  150.908247]   [<ffffffff81463cb0>] bus_probe_device+0xa0/0xc0
[  150.908250]   [<ffffffff81461d8e>] device_add+0x5ae/0x6b0
[  150.908253]   [<ffffffff814e0bcb>] usb_set_configuration+0x4db/0x820
[  150.908256]   [<ffffffff814ea6a7>] generic_probe+0x37/0x90
[  150.908260]   [<ffffffff814e1162>] usb_probe_device+0x32/0x60
[  150.908263]   [<ffffffff81464a8f>] driver_probe_device+0x7f/0x370
[  150.908266]   [<ffffffff81464e7b>] __device_attach+0x4b/0x60
[  150.908269]   [<ffffffff8146294e>] bus_for_each_drv+0x4e/0xa0
[  150.908272]   [<ffffffff81464998>] device_attach+0x98/0xb0
[  150.908275]   [<ffffffff81463cb0>] bus_probe_device+0xa0/0xc0
[  150.908278]   [<ffffffff81461d8e>] device_add+0x5ae/0x6b0
[  150.908281]   [<ffffffff814d6b68>] usb_new_device+0x1c8/0x320
[  150.908285]   [<ffffffff814d7f89>] hub_thread+0x5d9/0x1570
[  150.908288]   [<ffffffff810717fb>] kthread+0xdb/0xe0
[  150.908292]   [<ffffffff8170a8dc>] ret_from_fork+0x7c/0xb0
[  150.908295]
[  150.908295] to a HARDIRQ-irq-unsafe lock:
[  150.908297]  (&(&hdev->debug_list_lock)->rlock){+.+...}
[  150.908297] ... which became HARDIRQ-irq-unsafe at:
[  150.908301] ...  [<ffffffff810b0603>] __lock_acquire+0x623/0x1d80
[  150.908304]   [<ffffffff810b2437>] lock_acquire+0x97/0x1d0
[  150.908307]   [<ffffffff81700e66>] _raw_spin_lock+0x46/0x80
[  150.908310]   [<ffffffff8155a172>] hid_debug_event+0x32/0x100
[  150.908313]   [<ffffffff8155a647>] hid_dump_input+0x67/0xa0
[  150.908316]   [<ffffffff8155c940>] hid_set_field+0x50/0x120
[  150.908319]   [<ffffffff8156c284>] usbhid_set_leds+0x84/0xc0
[  150.908322]   [<ffffffff8156cbf8>] usbhid_start+0x528/0x5f0
[  150.908325]   [<ffffffff8155e760>] hid_device_probe+0x140/0x170
[  150.908328]   [<ffffffff81464a8f>] driver_probe_device+0x7f/0x370
[  150.908331]   [<ffffffff81464e7b>] __device_attach+0x4b/0x60
[  150.908335]   [<ffffffff8146294e>] bus_for_each_drv+0x4e/0xa0
[  150.908337]   [<ffffffff81464998>] device_attach+0x98/0xb0
[  150.908340]   [<ffffffff81463cb0>] bus_probe_device+0xa0/0xc0
[  150.908344]   [<ffffffff81461d8e>] device_add+0x5ae/0x6b0
[  150.908346]   [<ffffffff8155e0d4>] hid_add_device+0x174/0x370
[  150.908350]   [<ffffffff8156a974>] usbhid_probe+0x394/0x4d0
[  150.908353]   [<ffffffff814e2015>] usb_probe_interface+0xf5/0x240
[  150.908356]   [<ffffffff81464a8f>] driver_probe_device+0x7f/0x370
[  150.908359]   [<ffffffff81464e7b>] __device_attach+0x4b/0x60
[  150.908362]   [<ffffffff8146294e>] bus_for_each_drv+0x4e/0xa0
[  150.908365]   [<ffffffff81464998>] device_attach+0x98/0xb0
[  150.908368]   [<ffffffff81463cb0>] bus_probe_device+0xa0/0xc0
[  150.908371]   [<ffffffff81461d8e>] device_add+0x5ae/0x6b0
[  150.908373]   [<ffffffff814e0bcb>] usb_set_configuration+0x4db/0x820
[  150.908376]   [<ffffffff814ea6a7>] generic_probe+0x37/0x90
[  150.908380]   [<ffffffff814e1162>] usb_probe_device+0x32/0x60
[  150.908383]   [<ffffffff81464a8f>] driver_probe_device+0x7f/0x370
[  150.908386]   [<ffffffff81464e7b>] __device_attach+0x4b/0x60
[  150.908389]   [<ffffffff8146294e>] bus_for_each_drv+0x4e/0xa0
[  150.908392]   [<ffffffff81464998>] device_attach+0x98/0xb0
[  150.908395]   [<ffffffff81463cb0>] bus_probe_device+0xa0/0xc0
[  150.908398]   [<ffffffff81461d8e>] device_add+0x5ae/0x6b0
[  150.908401]   [<ffffffff814d6b68>] usb_new_device+0x1c8/0x320
[  150.908404]   [<ffffffff814d7f89>] hub_thread+0x5d9/0x1570
[  150.908408]   [<ffffffff810717fb>] kthread+0xdb/0xe0
[  150.908411]   [<ffffffff8170a8dc>] ret_from_fork+0x7c/0xb0
[  150.908414]
[  150.908414] other info that might help us debug this:
[  150.908414]
[  150.908417]  Possible interrupt unsafe locking scenario:
[  150.908417]
[  150.908419]        CPU0                    CPU1
[  150.908420]        ----                    ----
[  150.908422]   lock(&(&hdev->debug_list_lock)->rlock);
[  150.908425]                                local_irq_disable();
[  150.908426]                                lock(&(&usbhid->lock)->rlock);
[  150.908429]                                lock(&(&hdev->debug_list_lock)->rlock);
[  150.908432]   <Interrupt>
[  150.908433]     lock(&(&usbhid->lock)->rlock);
[  150.908436]
[  150.908436]  *** DEADLOCK ***
[  150.908436]
[  150.908439] 4 locks held by Xorg/5473:
[  150.908441]  #0:  (&evdev->mutex){+.+...}, at: [<ffffffff8151914d>] evdev_write+0x6d/0x160
[  150.908448]  #1:  (&(&dev->event_lock)->rlock#2){-.-...}, at: [<ffffffff815142ab>] input_inject_event+0x5b/0x230
[  150.908455]  #2:  (rcu_read_lock){.+.+..}, at: [<ffffffff81514292>] input_inject_event+0x42/0x230
[  150.908461]  #3:  (&(&usbhid->lock)->rlock){-.....}, at: [<ffffffff8156b799>] usb_hidinput_input_event+0x89/0x120
[  150.908468]
[  150.908468] the dependencies between HARDIRQ-irq-safe lock and the holding lock:
[  150.908473] -> (&(&usbhid->lock)->rlock){-.....} ops: 11 {
[  150.908478]    IN-HARDIRQ-W at:
[  150.908480]                     [<ffffffff810b08ff>] __lock_acquire+0x91f/0x1d80
[  150.908483]                     [<ffffffff810b2437>] lock_acquire+0x97/0x1d0
[  150.908486]                     [<ffffffff81700e66>] _raw_spin_lock+0x46/0x80
[  150.908489]                     [<ffffffff8156b505>] hid_ctrl+0x45/0x1a0
[  150.908492]                     [<ffffffff814db295>] usb_hcd_giveback_urb+0x65/0xf0
[  150.908495]                     [<ffffffff814f4050>] ehci_urb_done+0x80/0xc0
[  150.908498]                     [<ffffffff814f50a7>] qh_completions+0x367/0x570
[  150.908501]                     [<ffffffff814f85fb>] ehci_work+0xdb/0x8d0
[  150.908504]                     [<ffffffff814f9568>] ehci_irq+0x2d8/0x4c0
[  150.908507]                     [<ffffffff814da577>] usb_hcd_irq+0x37/0x70
[  150.908510]                     [<ffffffff810e3a75>] handle_irq_event_percpu+0x75/0x380
[  150.908513]                     [<ffffffff810e3dc8>] handle_irq_event+0x48/0x70
[  150.908516]                     [<ffffffff810e6fba>] handle_fasteoi_irq+0x5a/0x100
[  150.908519]                     [<ffffffff8100453f>] handle_irq+0xbf/0x150
[  150.908522]                     [<ffffffff8170c33a>] do_IRQ+0x5a/0xe0
[  150.908525]                     [<ffffffff81701d6f>] ret_from_intr+0x0/0x13
[  150.908528]                     [<ffffffff8106df68>] __kernel_text_address+0x58/0x80
[  150.908531]                     [<ffffffff81005a1f>] print_context_stack+0x8f/0xf0
[  150.908534]                     [<ffffffff8100483f>] dump_trace+0x1af/0x2d0
[  150.908537]                     [<ffffffff8100fd1b>] save_stack_trace+0x2b/0x50
[  150.908540]                     [<ffffffff81181e24>] create_object+0x144/0x310
[  150.908543]                     [<ffffffff816e41db>] kmemleak_alloc+0x5b/0xc0
[  150.908546]                     [<ffffffff8117aee6>] kmem_cache_alloc+0x106/0x290
[  150.908549]                     [<ffffffff812051d9>] sysfs_new_dirent+0x59/0x140
[  150.908553]                     [<ffffffff8120433b>] sysfs_add_file_mode+0x6b/0x110
[  150.908555]                     [<ffffffff81207700>] internal_create_group+0xd0/0x230
[  150.908558]                     [<ffffffff81207893>] sysfs_create_group+0x13/0x20
[  150.908561]                     [<ffffffff814604b8>] device_add_groups+0x48/0xa0
[  150.908564]                     [<ffffffff81461be7>] device_add+0x407/0x6b0
[  150.908567]                     [<ffffffff81512d80>] input_register_device+0x200/0x5b0
[  150.908570]                     [<ffffffff81560691>] hidinput_connect+0x15b1/0x2900
[  150.908573]                     [<ffffffff8155e5ad>] hid_connect+0x2dd/0x350
[  150.908576]                     [<ffffffff8155e774>] hid_device_probe+0x154/0x170
[  150.908579]                     [<ffffffff81464a8f>] driver_probe_device+0x7f/0x370
[  150.908583]                     [<ffffffff81464e7b>] __device_attach+0x4b/0x60
[  150.908586]                     [<ffffffff8146294e>] bus_for_each_drv+0x4e/0xa0
[  150.908589]                     [<ffffffff81464998>] device_attach+0x98/0xb0
[  150.908592]                     [<ffffffff81463cb0>] bus_probe_device+0xa0/0xc0
[  150.908595]                     [<ffffffff81461d8e>] device_add+0x5ae/0x6b0
[  150.908598]                     [<ffffffff8155e0d4>] hid_add_device+0x174/0x370
[  150.908602]                     [<ffffffff8156a974>] usbhid_probe+0x394/0x4d0
[  150.908605]                     [<ffffffff814e2015>] usb_probe_interface+0xf5/0x240
[  150.908608]                     [<ffffffff81464a8f>] driver_probe_device+0x7f/0x370
[  150.908611]                     [<ffffffff81464e7b>] __device_attach+0x4b/0x60
[  150.908614]                     [<ffffffff8146294e>] bus_for_each_drv+0x4e/0xa0
[  150.908617]                     [<ffffffff81464998>] device_attach+0x98/0xb0
[  150.908620]                     [<ffffffff81463cb0>] bus_probe_device+0xa0/0xc0
[  150.908623]                     [<ffffffff81461d8e>] device_add+0x5ae/0x6b0
[  150.908626]                     [<ffffffff814e0bcb>] usb_set_configuration+0x4db/0x820
[  150.908629]                     [<ffffffff814ea6a7>] generic_probe+0x37/0x90
[  150.908633]                     [<ffffffff814e1162>] usb_probe_device+0x32/0x60
[  150.908635]                     [<ffffffff81464a8f>] driver_probe_device+0x7f/0x370
[  150.908638]                     [<ffffffff81464e7b>] __device_attach+0x4b/0x60
[  150.908641]                     [<ffffffff8146294e>] bus_for_each_drv+0x4e/0xa0
[  150.908644]                     [<ffffffff81464998>] device_attach+0x98/0xb0
[  150.908647]                     [<ffffffff81463cb0>] bus_probe_device+0xa0/0xc0
[  150.908650]                     [<ffffffff81461d8e>] device_add+0x5ae/0x6b0
[  150.908653]                     [<ffffffff814d6b68>] usb_new_device+0x1c8/0x320
[  150.908656]                     [<ffffffff814d7f89>] hub_thread+0x5d9/0x1570
[  150.908659]                     [<ffffffff810717fb>] kthread+0xdb/0xe0
[  150.908662]                     [<ffffffff8170a8dc>] ret_from_fork+0x7c/0xb0
[  150.908665]    INITIAL USE at:
[  150.908667]                    [<ffffffff810b02f6>] __lock_acquire+0x316/0x1d80
[  150.908670]                    [<ffffffff810b2437>] lock_acquire+0x97/0x1d0
[  150.908673]                    [<ffffffff81701038>] _raw_spin_lock_irqsave+0x58/0xa0
[  150.908676]                    [<ffffffff8156c180>] usbhid_submit_report+0x40/0x80
[  150.908679]                    [<ffffffff8156c600>] usbhid_init_reports+0x40/0x110
[  150.908682]                    [<ffffffff8156cbe3>] usbhid_start+0x513/0x5f0
[  150.908685]                    [<ffffffff8155e760>] hid_device_probe+0x140/0x170
[  150.908688]                    [<ffffffff81464a8f>] driver_probe_device+0x7f/0x370
[  150.908691]                    [<ffffffff81464e7b>] __device_attach+0x4b/0x60
[  150.908694]                    [<ffffffff8146294e>] bus_for_each_drv+0x4e/0xa0
[  150.908697]                    [<ffffffff81464998>] device_attach+0x98/0xb0
[  150.908700]                    [<ffffffff81463cb0>] bus_probe_device+0xa0/0xc0
[  150.908703]                    [<ffffffff81461d8e>] device_add+0x5ae/0x6b0
[  150.908706]                    [<ffffffff8155e0d4>] hid_add_device+0x174/0x370
[  150.908710]                    [<ffffffff8156a974>] usbhid_probe+0x394/0x4d0
[  150.908712]                    [<ffffffff814e2015>] usb_probe_interface+0xf5/0x240
[  150.908716]                    [<ffffffff81464a8f>] driver_probe_device+0x7f/0x370
[  150.908719]                    [<ffffffff81464e7b>] __device_attach+0x4b/0x60
[  150.908722]                    [<ffffffff8146294e>] bus_for_each_drv+0x4e/0xa0
[  150.908725]                    [<ffffffff81464998>] device_attach+0x98/0xb0
[  150.908728]                    [<ffffffff81463cb0>] bus_probe_device+0xa0/0xc0
[  150.908731]                    [<ffffffff81461d8e>] device_add+0x5ae/0x6b0
[  150.908734]                    [<ffffffff814e0bcb>] usb_set_configuration+0x4db/0x820
[  150.908737]                    [<ffffffff814ea6a7>] generic_probe+0x37/0x90
[  150.908740]                    [<ffffffff814e1162>] usb_probe_device+0x32/0x60
[  150.908743]                    [<ffffffff81464a8f>] driver_probe_device+0x7f/0x370
[  150.908746]                    [<ffffffff81464e7b>] __device_attach+0x4b/0x60
[  150.908749]                    [<ffffffff8146294e>] bus_for_each_drv+0x4e/0xa0
[  150.908752]                    [<ffffffff81464998>] device_attach+0x98/0xb0
[  150.908755]                    [<ffffffff81463cb0>] bus_probe_device+0xa0/0xc0
[  150.908758]                    [<ffffffff81461d8e>] device_add+0x5ae/0x6b0
[  150.908761]                    [<ffffffff814d6b68>] usb_new_device+0x1c8/0x320
[  150.908764]                    [<ffffffff814d7f89>] hub_thread+0x5d9/0x1570
[  150.908767]                    [<ffffffff810717fb>] kthread+0xdb/0xe0
[  150.908771]                    [<ffffffff8170a8dc>] ret_from_fork+0x7c/0xb0
[  150.908774]  }
[  150.908775]  ... key      at: [<ffffffff82986238>] __key.28245+0x0/0x8
[  150.908780]  ... acquired at:
[  150.908782]    [<ffffffff810afb9b>] check_irq_usage+0x5b/0xe0
[  150.908784]    [<ffffffff810b0e7b>] __lock_acquire+0xe9b/0x1d80
[  150.908787]    [<ffffffff810b2437>] lock_acquire+0x97/0x1d0
[  150.908790]    [<ffffffff81700e66>] _raw_spin_lock+0x46/0x80
[  150.908792]    [<ffffffff8155a172>] hid_debug_event+0x32/0x100
[  150.908796]    [<ffffffff8155a647>] hid_dump_input+0x67/0xa0
[  150.908799]    [<ffffffff8155c940>] hid_set_field+0x50/0x120
[  150.908802]    [<ffffffff8156b7aa>] usb_hidinput_input_event+0x9a/0x120
[  150.908805]    [<ffffffff81513dae>] input_handle_event+0x8e/0x530
[  150.908808]    [<ffffffff81514420>] input_inject_event+0x1d0/0x230
[  150.908820]    [<ffffffff815191be>] evdev_write+0xde/0x160
[  150.908825]    [<ffffffff81186978>] vfs_write+0xc8/0x1f0
[  150.908831]    [<ffffffff81186e75>] SyS_write+0x55/0xa0
[  150.908837]    [<ffffffff8170a982>] system_call_fastpath+0x16/0x1b
[  150.908843]
[  150.908846]
[  150.908846] the dependencies between the lock to be acquired and HARDIRQ-irq-unsafe lock:
[  150.908863] -> (&(&hdev->debug_list_lock)->rlock){+.+...} ops: 2 {
[  150.908881]    HARDIRQ-ON-W at:
[  150.908885]                     [<ffffffff810b0603>] __lock_acquire+0x623/0x1d80
[  150.908891]                     [<ffffffff810b2437>] lock_acquire+0x97/0x1d0
[  150.908897]                     [<ffffffff81700e66>] _raw_spin_lock+0x46/0x80
[  150.908903]                     [<ffffffff8155a172>] hid_debug_event+0x32/0x100
[  150.908909]                     [<ffffffff8155a647>] hid_dump_input+0x67/0xa0
[  150.908916]                     [<ffffffff8155c940>] hid_set_field+0x50/0x120
[  150.908923]                     [<ffffffff8156c284>] usbhid_set_leds+0x84/0xc0
[  150.908929]                     [<ffffffff8156cbf8>] usbhid_start+0x528/0x5f0
[  150.908936]                     [<ffffffff8155e760>] hid_device_probe+0x140/0x170
[  150.908943]                     [<ffffffff81464a8f>] driver_probe_device+0x7f/0x370
[  150.908950]                     [<ffffffff81464e7b>] __device_attach+0x4b/0x60
[  150.908956]                     [<ffffffff8146294e>] bus_for_each_drv+0x4e/0xa0
[  150.908963]                     [<ffffffff81464998>] device_attach+0x98/0xb0
[  150.908969]                     [<ffffffff81463cb0>] bus_probe_device+0xa0/0xc0
[  150.908975]                     [<ffffffff81461d8e>] device_add+0x5ae/0x6b0
[  150.908981]                     [<ffffffff8155e0d4>] hid_add_device+0x174/0x370
[  150.908989]                     [<ffffffff8156a974>] usbhid_probe+0x394/0x4d0
[  150.908995]                     [<ffffffff814e2015>] usb_probe_interface+0xf5/0x240
[  150.909001]                     [<ffffffff81464a8f>] driver_probe_device+0x7f/0x370
[  150.909008]                     [<ffffffff81464e7b>] __device_attach+0x4b/0x60
[  150.909015]                     [<ffffffff8146294e>] bus_for_each_drv+0x4e/0xa0
[  150.909021]                     [<ffffffff81464998>] device_attach+0x98/0xb0
[  150.909027]                     [<ffffffff81463cb0>] bus_probe_device+0xa0/0xc0
[  150.909034]                     [<ffffffff81461d8e>] device_add+0x5ae/0x6b0
[  150.909040]                     [<ffffffff814e0bcb>] usb_set_configuration+0x4db/0x820
[  150.909046]                     [<ffffffff814ea6a7>] generic_probe+0x37/0x90
[  150.909053]                     [<ffffffff814e1162>] usb_probe_device+0x32/0x60
[  150.909059]                     [<ffffffff81464a8f>] driver_probe_device+0x7f/0x370
[  150.909065]                     [<ffffffff81464e7b>] __device_attach+0x4b/0x60
[  150.909072]                     [<ffffffff8146294e>] bus_for_each_drv+0x4e/0xa0
[  150.909078]                     [<ffffffff81464998>] device_attach+0x98/0xb0
[  150.909084]                     [<ffffffff81463cb0>] bus_probe_device+0xa0/0xc0
[  150.909091]                     [<ffffffff81461d8e>] device_add+0x5ae/0x6b0
[  150.909097]                     [<ffffffff814d6b68>] usb_new_device+0x1c8/0x320
[  150.909104]                     [<ffffffff814d7f89>] hub_thread+0x5d9/0x1570
[  150.909111]                     [<ffffffff810717fb>] kthread+0xdb/0xe0
[  150.909117]                     [<ffffffff8170a8dc>] ret_from_fork+0x7c/0xb0
[  150.909124]    SOFTIRQ-ON-W at:
[  150.909128]                     [<ffffffff810b0638>] __lock_acquire+0x658/0x1d80
[  150.909134]                     [<ffffffff810b2437>] lock_acquire+0x97/0x1d0
[  150.909140]                     [<ffffffff81700e66>] _raw_spin_lock+0x46/0x80
[  150.909146]                     [<ffffffff8155a172>] hid_debug_event+0x32/0x100
[  150.909152]                     [<ffffffff8155a647>] hid_dump_input+0x67/0xa0
[  150.909159]                     [<ffffffff8155c940>] hid_set_field+0x50/0x120
[  150.909166]                     [<ffffffff8156c284>] usbhid_set_leds+0x84/0xc0
[  150.909172]                     [<ffffffff8156cbf8>] usbhid_start+0x528/0x5f0
[  150.909178]                     [<ffffffff8155e760>] hid_device_probe+0x140/0x170
[  150.909185]                     [<ffffffff81464a8f>] driver_probe_device+0x7f/0x370
[  150.909192]                     [<ffffffff81464e7b>] __device_attach+0x4b/0x60
[  150.909198]                     [<ffffffff8146294e>] bus_for_each_drv+0x4e/0xa0
[  150.909205]                     [<ffffffff81464998>] device_attach+0x98/0xb0
[  150.909211]                     [<ffffffff81463cb0>] bus_probe_device+0xa0/0xc0
[  150.909218]                     [<ffffffff81461d8e>] device_add+0x5ae/0x6b0
[  150.909224]                     [<ffffffff8155e0d4>] hid_add_device+0x174/0x370
[  150.909231]                     [<ffffffff8156a974>] usbhid_probe+0x394/0x4d0
[  150.909237]                     [<ffffffff814e2015>] usb_probe_interface+0xf5/0x240
[  150.909244]                     [<ffffffff81464a8f>] driver_probe_device+0x7f/0x370
[  150.909250]                     [<ffffffff81464e7b>] __device_attach+0x4b/0x60
[  150.909257]                     [<ffffffff8146294e>] bus_for_each_drv+0x4e/0xa0
[  150.909263]                     [<ffffffff81464998>] device_attach+0x98/0xb0
[  150.909270]                     [<ffffffff81463cb0>] bus_probe_device+0xa0/0xc0
[  150.909276]                     [<ffffffff81461d8e>] device_add+0x5ae/0x6b0
[  150.909282]                     [<ffffffff814e0bcb>] usb_set_configuration+0x4db/0x820
[  150.909288]                     [<ffffffff814ea6a7>] generic_probe+0x37/0x90
[  150.909296]                     [<ffffffff814e1162>] usb_probe_device+0x32/0x60
[  150.909301]                     [<ffffffff81464a8f>] driver_probe_device+0x7f/0x370
[  150.909308]                     [<ffffffff81464e7b>] __device_attach+0x4b/0x60
[  150.909315]                     [<ffffffff8146294e>] bus_for_each_drv+0x4e/0xa0
[  150.909321]                     [<ffffffff81464998>] device_attach+0x98/0xb0
[  150.909327]                     [<ffffffff81463cb0>] bus_probe_device+0xa0/0xc0
[  150.909334]                     [<ffffffff81461d8e>] device_add+0x5ae/0x6b0
[  150.909340]                     [<ffffffff814d6b68>] usb_new_device+0x1c8/0x320
[  150.909347]                     [<ffffffff814d7f89>] hub_thread+0x5d9/0x1570
[  150.909354]                     [<ffffffff810717fb>] kthread+0xdb/0xe0
[  150.909361]                     [<ffffffff8170a8dc>] ret_from_fork+0x7c/0xb0
[  150.909367]    INITIAL USE at:
[  150.909371]                    [<ffffffff810b02f6>] __lock_acquire+0x316/0x1d80
[  150.909377]                    [<ffffffff810b2437>] lock_acquire+0x97/0x1d0
[  150.909382]                    [<ffffffff81700e66>] _raw_spin_lock+0x46/0x80
[  150.909388]                    [<ffffffff8155a172>] hid_debug_event+0x32/0x100
[  150.909395]                    [<ffffffff8155a647>] hid_dump_input+0x67/0xa0
[  150.909401]                    [<ffffffff8155c940>] hid_set_field+0x50/0x120
[  150.909408]                    [<ffffffff8156c284>] usbhid_set_leds+0x84/0xc0
[  150.909414]                    [<ffffffff8156cbf8>] usbhid_start+0x528/0x5f0
[  150.909420]                    [<ffffffff8155e760>] hid_device_probe+0x140/0x170
[  150.909427]                    [<ffffffff81464a8f>] driver_probe_device+0x7f/0x370
[  150.909433]                    [<ffffffff81464e7b>] __device_attach+0x4b/0x60
[  150.909440]                    [<ffffffff8146294e>] bus_for_each_drv+0x4e/0xa0
[  150.909446]                    [<ffffffff81464998>] device_attach+0x98/0xb0
[  150.909453]                    [<ffffffff81463cb0>] bus_probe_device+0xa0/0xc0
[  150.909459]                    [<ffffffff81461d8e>] device_add+0x5ae/0x6b0
[  150.909465]                    [<ffffffff8155e0d4>] hid_add_device+0x174/0x370
[  150.909471]                    [<ffffffff8156a974>] usbhid_probe+0x394/0x4d0
[  150.909477]                    [<ffffffff814e2015>] usb_probe_interface+0xf5/0x240
[  150.909484]                    [<ffffffff81464a8f>] driver_probe_device+0x7f/0x370
[  150.909490]                    [<ffffffff81464e7b>] __device_attach+0x4b/0x60
[  150.909496]                    [<ffffffff8146294e>] bus_for_each_drv+0x4e/0xa0
[  150.909503]                    [<ffffffff81464998>] device_attach+0x98/0xb0
[  150.909509]                    [<ffffffff81463cb0>] bus_probe_device+0xa0/0xc0
[  150.909515]                    [<ffffffff81461d8e>] device_add+0x5ae/0x6b0
[  150.909521]                    [<ffffffff814e0bcb>] usb_set_configuration+0x4db/0x820
[  150.909528]                    [<ffffffff814ea6a7>] generic_probe+0x37/0x90
[  150.909535]                    [<ffffffff814e1162>] usb_probe_device+0x32/0x60
[  150.909540]                    [<ffffffff81464a8f>] driver_probe_device+0x7f/0x370
[  150.909547]                    [<ffffffff81464e7b>] __device_attach+0x4b/0x60
[  150.909554]                    [<ffffffff8146294e>] bus_for_each_drv+0x4e/0xa0
[  150.909560]                    [<ffffffff81464998>] device_attach+0x98/0xb0
[  150.909566]                    [<ffffffff81463cb0>] bus_probe_device+0xa0/0xc0
[  150.909572]                    [<ffffffff81461d8e>] device_add+0x5ae/0x6b0
[  150.909578]                    [<ffffffff814d6b68>] usb_new_device+0x1c8/0x320
[  150.909585]                    [<ffffffff814d7f89>] hub_thread+0x5d9/0x1570
[  150.909592]                    [<ffffffff810717fb>] kthread+0xdb/0xe0
[  150.909598]                    [<ffffffff8170a8dc>] ret_from_fork+0x7c/0xb0
[  150.909605]  }
[  150.909607]  ... key      at: [<ffffffff82985f04>] __key.25753+0x0/0x8
[  150.909613]  ... acquired at:
[  150.909616]    [<ffffffff810afb9b>] check_irq_usage+0x5b/0xe0
[  150.909622]    [<ffffffff810b0e7b>] __lock_acquire+0xe9b/0x1d80
[  150.909627]    [<ffffffff810b2437>] lock_acquire+0x97/0x1d0
[  150.909633]    [<ffffffff81700e66>] _raw_spin_lock+0x46/0x80
[  150.909638]    [<ffffffff8155a172>] hid_debug_event+0x32/0x100
[  150.909645]    [<ffffffff8155a647>] hid_dump_input+0x67/0xa0
[  150.909651]    [<ffffffff8155c940>] hid_set_field+0x50/0x120
[  150.909658]    [<ffffffff8156b7aa>] usb_hidinput_input_event+0x9a/0x120
[  150.909664]    [<ffffffff81513dae>] input_handle_event+0x8e/0x530
[  150.909670]    [<ffffffff81514420>] input_inject_event+0x1d0/0x230
[  150.909676]    [<ffffffff815191be>] evdev_write+0xde/0x160
[  150.909682]    [<ffffffff81186978>] vfs_write+0xc8/0x1f0
[  150.909687]    [<ffffffff81186e75>] SyS_write+0x55/0xa0
[  150.909693]    [<ffffffff8170a982>] system_call_fastpath+0x16/0x1b
[  150.909698]
[  150.909701]
[  150.909701] stack backtrace:
[  150.909708] CPU: 1 PID: 5473 Comm: Xorg Not tainted 3.9.0+ #102
[  150.909712] Hardware name: Dell Inc. OptiPlex 390/0M5DCD, BIOS A09 07/24/2012
[  150.909716]  ffffffff82213570 ffff88006c279a70 ffffffff816f89af ffff88006c279b68
[  150.909726]  ffffffff810afb34 0000000000000000 ffff880000000000 ffff880000000001
[  150.909736]  ffff88006c279ac0 ffffffff81a083a5 ffff88006c279b00 ffff88006c279ac0
[  150.909745] Call Trace:
[  150.909753]  [<ffffffff816f89af>] dump_stack+0x19/0x1b
[  150.909760]  [<ffffffff810afb34>] check_usage+0x4e4/0x4f0
[  150.909768]  [<ffffffff810afb9b>] check_irq_usage+0x5b/0xe0
[  150.909774]  [<ffffffff810b0e7b>] __lock_acquire+0xe9b/0x1d80
[  150.909783]  [<ffffffff810ac95d>] ? trace_hardirqs_off+0xd/0x10
[  150.909791]  [<ffffffff81086c7f>] ? local_clock+0x4f/0x60
[  150.909798]  [<ffffffff810ad1bf>] ? lock_release_holdtime.part.24+0xf/0x190
[  150.909807]  [<ffffffff81313faa>] ? string.isra.3+0x3a/0xd0
[  150.909814]  [<ffffffff810b2437>] lock_acquire+0x97/0x1d0
[  150.909821]  [<ffffffff8155a172>] ? hid_debug_event+0x32/0x100
[  150.909827]  [<ffffffff81700e66>] _raw_spin_lock+0x46/0x80
[  150.909835]  [<ffffffff8155a172>] ? hid_debug_event+0x32/0x100
[  150.909842]  [<ffffffff8155a172>] hid_debug_event+0x32/0x100
[  150.909849]  [<ffffffff8155a647>] hid_dump_input+0x67/0xa0
[  150.909857]  [<ffffffff8155c940>] hid_set_field+0x50/0x120
[  150.909864]  [<ffffffff8156b7aa>] usb_hidinput_input_event+0x9a/0x120
[  150.909871]  [<ffffffff81513dae>] input_handle_event+0x8e/0x530
[  150.909878]  [<ffffffff81514420>] input_inject_event+0x1d0/0x230
[  150.909884]  [<ffffffff81514292>] ? input_inject_event+0x42/0x230
[  150.909891]  [<ffffffff815191be>] evdev_write+0xde/0x160
[  150.909898]  [<ffffffff81186978>] vfs_write+0xc8/0x1f0
[  150.909904]  [<ffffffff81186e75>] SyS_write+0x55/0xa0
[  150.909911]  [<ffffffff8170a982>] system_call_fastpath+0x16/0x1b

