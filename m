From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH] Input: evdev - add event-mask API
Date: Tue, 22 Apr 2014 14:29:47 +1000
Message-ID: <20140422042947.GB10735@yabbi.redhat.com>
References: <1397601105-17771-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:28008 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbaDVE3f (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Apr 2014 00:29:35 -0400
Content-Disposition: inline
In-Reply-To: <1397601105-17771-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Lennart Poettering <lennart@poettering.net>

On Wed, Apr 16, 2014 at 12:31:45AM +0200, David Herrmann wrote:
> Hardware manufacturers group keys in the weirdest way possible. This may
> cause a power-key to be grouped together with normal keyboard keys and
> thus be reported on the same kernel interface.
> 
> However, user-space is often only interested in specific sets of events.
> For instance, daemons dealing with system-reboot (like systemd-logind)
> listen for KEY_POWER, but are not interested in any main keyboard keys.
> Usually, power keys are reported via separate interfaces, however,
> some i8042 boards report it in the AT matrix. To avoid waking up those
> system daemons on each key-press, we had two ideas:
>  - split off KEY_POWER into a separate interface unconditionally
>  - allow masking a specific set of events on evdev FDs
> 
> Splitting of KEY_POWER is a rather weird way to deal with this and may
> break backwards-compatibility. It is also specific to KEY_POWER and might
> be required for other stuff, too. Moreover, we might end up with a huge
> set of input-devices just to have them properly split.
> 
> Hence, this patchset implements the second idea: An event-mask to specify
> which events you're interested in. Two ioctls allow setting this mask for
> each event-type. If not set, all events are reported. The type==0 entry is
> used same as in EVIOCGBIT to set the actual EV_* mask of masked events.
> This way, you have a two-level filter.
> 
> We are heavily forward-compatible to new event-types and event-codes. So
> new user-space will be able to run on an old kernel which doesn't know the
> given event-codes or event event-types.

Looks good in principle, a couple of nitpicks below but on the whole
Acked-by: Peter Hutterer <peter.hutterer@who-t.net>

> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---
>  drivers/input/evdev.c      | 155 +++++++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/input.h |   8 +++
>  2 files changed, 163 insertions(+)
> 
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index 398648b..86778c3 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -51,10 +51,139 @@ struct evdev_client {
>  	struct list_head node;
>  	int clkid;
>  	bool revoked;
> +	unsigned long *evmasks[EV_CNT];
>  	unsigned int bufsize;
>  	struct input_event buffer[];
>  };
>  
> +static size_t evdev_get_mask_cnt(unsigned int type)
> +{
> +	switch (type) {
> +	case 0:
> +		/* 0 is special (EV-bits instead of EV_SYN) like EVIOCGBIT */
> +		return EV_CNT;
> +	case EV_KEY:
> +		return KEY_CNT;
> +	case EV_REL:
> +		return REL_CNT;
> +	case EV_ABS:
> +		return ABS_CNT;
> +	case EV_MSC:
> +		return MSC_CNT;
> +	case EV_SW:
> +		return SW_CNT;
> +	case EV_LED:
> +		return LED_CNT;
> +	case EV_SND:
> +		return SND_CNT;
> +	case EV_FF:
> +		return FF_CNT;
> +	}
> +
> +	return 0;
> +}
> +
> +/* must be called with evdev-mutex held */
> +static int evdev_set_mask(struct evdev_client *client,
> +			  unsigned int type,
> +			  const void __user *codes,
> +			  u32 codes_size)
> +{
> +	unsigned long flags, *mask, *oldmask;
> +	size_t cnt, size;
> +
> +	/* unknown masks are simply ignored for forward-compat */
> +	cnt = evdev_get_mask_cnt(type);
> +	if (!cnt)
> +		return 0;
> +
> +	/* we allow 'codes_size > size' for forward-compat */
> +	size = sizeof(unsigned long) * BITS_TO_LONGS(cnt);
> +
> +	mask = kzalloc(size, GFP_KERNEL);
> +	if (!mask)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(mask, codes, min_t(size_t, codes_size, size))) {
> +		kfree(mask);
> +		return -EFAULT;
> +	}
> +
> +	spin_lock_irqsave(&client->buffer_lock, flags);
> +	oldmask = client->evmasks[type];
> +	client->evmasks[type] = mask;
> +	spin_unlock_irqrestore(&client->buffer_lock, flags);
> +
> +	kfree(oldmask);
> +
> +	return 0;
> +}
> +
> +/* must be called with evdev-mutex held */
> +static int evdev_get_mask(struct evdev_client *client,
> +			  unsigned int type,
> +			  void __user *codes,
> +			  u32 codes_size)
> +{
> +	unsigned long *mask;
> +	size_t cnt, size, min, i;
> +	u8 __user *out;
> +
> +	/* we allow unknown types and 'codes_size > size' for forward-compat */
> +	cnt = evdev_get_mask_cnt(type);
> +	size = sizeof(unsigned long) * BITS_TO_LONGS(cnt);
> +	min = min_t(size_t, codes_size, size);
> +
> +	if (cnt > 0) {
> +		mask = client->evmasks[type];
> +		if (mask) {
> +			if (copy_to_user(codes, mask, min))
> +				return -EFAULT;
> +		} else {
> +			/* fake mask with all bits set */
> +			out = (u8 __user*)codes;
> +			for (i = 0; i < min; ++i) {
> +				if (put_user((u8)0xff,  out + i))
> +					return -EFAULT;
> +			}
> +		}
> +	}
> +
> +	codes = (u8 __user*)codes + min;
> +	codes_size -= min;
> +
> +	if (codes_size > 0 && clear_user(codes, codes_size))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +/* requires the buffer lock to be held */
> +static bool __evdev_is_masked(struct evdev_client *client,
> +			      unsigned int type,
> +			      unsigned int code)
> +{
> +	unsigned long *mask;
> +	size_t cnt;
> +
> +	/* EV_SYN and unknown codes are never masked */
> +	if (!type || type >= EV_CNT)

why not use type == EV_SYN?

> +		return false;
> +
> +	/* first test whether the type is masked */
> +	mask = client->evmasks[0];

if mask is NULL, you already know it's not mask, you can return early.

> +	if (mask && !test_bit(type, mask))
> +		return true;
> +
> +	/* unknown values are never masked */
> +	cnt = evdev_get_mask_cnt(type);
> +	if (!cnt || code >= cnt)
> +		return false;
> +
> +	mask = client->evmasks[type];
> +	return mask && !test_bit(code, mask);
> +}
> +
>  /* Flush queued events of given type @type and code @code. A negative code
>   * is interpreted as catch-all. Caller must hold client->buffer_lock. */
>  static void __evdev_flush_queue(struct evdev_client *client,
> @@ -137,6 +266,9 @@ static void evdev_queue_syn_dropped(struct evdev_client *client)
>  static void __pass_event(struct evdev_client *client,
>  			 const struct input_event *event)
>  {
> +	if (__evdev_is_masked(client, event->type, event->code))
> +		return;
> +
>  	client->buffer[client->head++] = *event;
>  	client->head &= client->bufsize - 1;
>  
> @@ -368,6 +500,7 @@ static int evdev_release(struct inode *inode, struct file *file)
>  {
>  	struct evdev_client *client = file->private_data;
>  	struct evdev *evdev = client->evdev;
> +	unsigned int i;
>  
>  	mutex_lock(&evdev->mutex);
>  	evdev_ungrab(evdev, client);
> @@ -375,6 +508,9 @@ static int evdev_release(struct inode *inode, struct file *file)
>  
>  	evdev_detach_client(evdev, client);
>  
> +	for (i = 0; i < EV_CNT; ++i)
> +		kfree(client->evmasks[i]);
> +
>  	if (is_vmalloc_addr(client))
>  		vfree(client);
>  	else
> @@ -866,6 +1002,7 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
>  	struct evdev *evdev = client->evdev;
>  	struct input_dev *dev = evdev->handle.dev;
>  	struct input_absinfo abs;
> +	struct input_mask mask;
>  	struct ff_effect effect;
>  	int __user *ip = (int __user *)p;
>  	unsigned int i, t, u, v;
> @@ -927,6 +1064,24 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
>  		else
>  			return evdev_revoke(evdev, client, file);
>  
> +	case EVIOCGMASK:
> +		if (copy_from_user(&mask, p, sizeof(mask)))
> +			return -EFAULT;
> +
> +		return evdev_get_mask(client,
> +				      mask.type,
> +				      (void*)(long)mask.codes_ptr,
> +				      mask.codes_size);
> +
> +	case EVIOCSMASK:
> +		if (copy_from_user(&mask, p, sizeof(mask)))
> +			return -EFAULT;
> +
> +		return evdev_set_mask(client,
> +				      mask.type,
> +				      (const void*)(long)mask.codes_ptr,
> +				      mask.codes_size);
> +
>  	case EVIOCSCLOCKID:
>  		if (copy_from_user(&i, p, sizeof(unsigned int)))
>  			return -EFAULT;
> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index bd24470..5b73712 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -97,6 +97,12 @@ struct input_keymap_entry {
>  	__u8  scancode[32];
>  };
>  
> +struct input_mask {
> +	u32 type;
> +	u32 codes_size;
> +	u64 codes_ptr;
> +};
> +
>  #define EVIOCGVERSION		_IOR('E', 0x01, int)			/* get driver version */
>  #define EVIOCGID		_IOR('E', 0x02, struct input_id)	/* get device ID */
>  #define EVIOCGREP		_IOR('E', 0x03, unsigned int[2])	/* get repeat settings */
> @@ -153,6 +159,8 @@ struct input_keymap_entry {
>  
>  #define EVIOCGRAB		_IOW('E', 0x90, int)			/* Grab/Release device */
>  #define EVIOCREVOKE		_IOW('E', 0x91, int)			/* Revoke device access */
> +#define EVIOCGMASK		_IOR('E', 0x92, struct input_mask)	/* Get event-masks */
> +#define EVIOCSMASK		_IOW('E', 0x93, struct input_mask)	/* Set event-masks */

This is missing from all other ioctls but while you're adding a new one
anyway: please add documentation on what the ioctl does, the input and
return value/output expected, side-effects etc. right now, understanding the
evdev ioctls requires either reading the kernel code or existing user-space
code, with the usual risk of getting it wrong.

Cheers,
   Peter

>  
>  #define EVIOCSCLOCKID		_IOW('E', 0xa0, int)			/* Set clockid to be used for timestamps */
>  
> -- 
> 1.9.2
> 
