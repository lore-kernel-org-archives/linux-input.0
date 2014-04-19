From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: evdev - add event-mask API
Date: Sat, 19 Apr 2014 14:16:01 -0700
Message-ID: <20140419211601.GB8343@core.coreip.homeip.net>
References: <1397601105-17771-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:55144 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbaDSVQE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Apr 2014 17:16:04 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so2508943pab.10
        for <linux-input@vger.kernel.org>; Sat, 19 Apr 2014 14:16:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1397601105-17771-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Lennart Poettering <lennart@poettering.net>

Hi David,

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

That is something I had in mind for a long time, great job!

> 
> We are heavily forward-compatible to new event-types and event-codes. So
> new user-space will be able to run on an old kernel which doesn't know the
> given event-codes or event event-types.
> 
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

Maybe we need a static array of code->count mapping instead of a switch?

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

So won't this mean that client is still woken up by "empty" packet if we
filter out everything but EV_SYN?

Thanks.

-- 
Dmitry
