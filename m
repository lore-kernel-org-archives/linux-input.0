From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH RESEND RESEND] Input: evdev - add event-mask API
Date: Fri, 10 Oct 2014 10:28:53 +0200
Message-ID: <CANq1E4QgrmN7QYUQLQxKX4_dfMi2AhXF08j5WnV2xt6Vy-QK+Q@mail.gmail.com>
References: <1407914195-2797-1-git-send-email-dh.herrmann@gmail.com>
	<CANq1E4Q2S6vmpN=My8DXSPMti-pNQD24Hb0V9hqD=9TfND_mrg@mail.gmail.com>
	<20141009225256.GA8583@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:44393 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbaJJI25 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Oct 2014 04:28:57 -0400
Received: by mail-ig0-f178.google.com with SMTP id h3so1763743igd.17
        for <linux-input@vger.kernel.org>; Fri, 10 Oct 2014 01:28:53 -0700 (PDT)
In-Reply-To: <20141009225256.GA8583@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

Hi

On Fri, Oct 10, 2014 at 12:52 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi David,
>
> On Sun, Sep 28, 2014 at 12:19:39PM +0200, David Herrmann wrote:
>> Ping?
>
> Sorry for the delay.
>
>>
>> On Wed, Aug 13, 2014 at 9:16 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
>> > Hardware manufacturers group keys in the weirdest way possible. This may
>> > cause a power-key to be grouped together with normal keyboard keys and
>> > thus be reported on the same kernel interface.
>> >
>> > However, user-space is often only interested in specific sets of events.
>> > For instance, daemons dealing with system-reboot (like systemd-logind)
>> > listen for KEY_POWER, but are not interested in any main keyboard keys.
>> > Usually, power keys are reported via separate interfaces, however,
>> > some i8042 boards report it in the AT matrix. To avoid waking up those
>> > system daemons on each key-press, we had two ideas:
>> >  - split off KEY_POWER into a separate interface unconditionally
>> >  - allow filtering a specific set of events on evdev FDs
>> >
>> > Splitting of KEY_POWER is a rather weird way to deal with this and may
>> > break backwards-compatibility. It is also specific to KEY_POWER and might
>> > be required for other stuff, too. Moreover, we might end up with a huge
>> > set of input-devices just to have them properly split.
>> >
>> > Hence, this patchset implements the second idea: An event-mask to specify
>> > which events you're interested in. Two ioctls allow setting this mask for
>> > each event-type. If not set, all events are reported. The type==0 entry is
>> > used same as in EVIOCGBIT to set the actual EV_* mask of filtered events.
>> > This way, you have a two-level filter.
>> >
>> > We are heavily forward-compatible to new event-types and event-codes. So
>> > new user-space will be able to run on an old kernel which doesn't know the
>> > given event-codes or event-types.
>> >
>> > Acked-by: Peter Hutterer <peter.hutterer@who-t.net>
>> > Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
>> > ---
>> > Hi Dmitry
>> >
>> > We could really make use of this for SUSPEND/POWER key handling. We keep getting
>> > reports from people where those keys are reported as part of the main keyboard.
>> > It's really annoying if we have to wake up those processes for *every*
>> > key-press.
>> >
>> > In case you just need time to review it, let me know. Otherwise, I will keep
>> > resending it as people ask me for it all the time.
>> >
>> > Thanks
>> > David
>> >
>> >  drivers/input/evdev.c      | 156 ++++++++++++++++++++++++++++++++++++++++++++-
>> >  include/uapi/linux/input.h |  56 ++++++++++++++++
>> >  2 files changed, 210 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
>> > index fd325ec..6386882 100644
>> > --- a/drivers/input/evdev.c
>> > +++ b/drivers/input/evdev.c
>> > @@ -51,10 +51,130 @@ struct evdev_client {
>> >         struct list_head node;
>> >         int clkid;
>> >         bool revoked;
>> > +       unsigned long *evmasks[EV_CNT];
>> >         unsigned int bufsize;
>> >         struct input_event buffer[];
>> >  };
>> >
>> > +static size_t evdev_get_mask_cnt(unsigned int type)
>> > +{
>> > +       static size_t counts[EV_CNT] = {
>> > +               /* EV_SYN==0 is EV_CNT, _not_ SYN_CNT, see EVIOCGBIT */
>> > +               [EV_SYN] = EV_CNT,
>> > +               [EV_KEY] = KEY_CNT,
>> > +               [EV_REL] = REL_CNT,
>> > +               [EV_ABS] = ABS_CNT,
>> > +               [EV_MSC] = MSC_CNT,
>> > +               [EV_SW] = SW_CNT,
>> > +               [EV_LED] = LED_CNT,
>> > +               [EV_SND] = SND_CNT,
>> > +               [EV_FF] = FF_CNT,
>> > +       };
>> > +
>> > +       return (type < EV_CNT) ? counts[type] : 0;
>> > +}
>> > +
>> > +/* must be called with evdev-mutex held */
>> > +static int evdev_set_mask(struct evdev_client *client,
>> > +                         unsigned int type,
>> > +                         const void __user *codes,
>> > +                         u32 codes_size)
>> > +{
>> > +       unsigned long flags, *mask, *oldmask;
>> > +       size_t cnt, size;
>> > +
>> > +       /* unknown masks are simply ignored for forward-compat */
>> > +       cnt = evdev_get_mask_cnt(type);
>> > +       if (!cnt)
>> > +               return 0;
>> > +
>> > +       /* we allow 'codes_size > size' for forward-compat */
>> > +       size = sizeof(unsigned long) * BITS_TO_LONGS(cnt);
>> > +
>> > +       mask = kzalloc(size, GFP_KERNEL);
>> > +       if (!mask)
>> > +               return -ENOMEM;
>> > +
>> > +       if (copy_from_user(mask, codes, min_t(size_t, codes_size, size))) {
>> > +               kfree(mask);
>> > +               return -EFAULT;
>> > +       }
>> > +
>> > +       spin_lock_irqsave(&client->buffer_lock, flags);
>> > +       oldmask = client->evmasks[type];
>> > +       client->evmasks[type] = mask;
>> > +       spin_unlock_irqrestore(&client->buffer_lock, flags);
>> > +
>> > +       kfree(oldmask);
>> > +
>> > +       return 0;
>> > +}
>> > +
>> > +/* must be called with evdev-mutex held */
>> > +static int evdev_get_mask(struct evdev_client *client,
>> > +                         unsigned int type,
>> > +                         void __user *codes,
>> > +                         u32 codes_size)
>> > +{
>> > +       unsigned long *mask;
>> > +       size_t cnt, size, min, i;
>> > +       u8 __user *out;
>> > +
>> > +       /* we allow unknown types and 'codes_size > size' for forward-compat */
>> > +       cnt = evdev_get_mask_cnt(type);
>> > +       size = sizeof(unsigned long) * BITS_TO_LONGS(cnt);
>> > +       min = min_t(size_t, codes_size, size);
>> > +
>> > +       if (cnt > 0) {
>> > +               mask = client->evmasks[type];
>> > +               if (mask) {
>> > +                       if (copy_to_user(codes, mask, min))
>> > +                               return -EFAULT;
>
> I do not think this will work on big-endian setups with 64 bit kernel
> and 32 bits userspace. We already have bits_to_user(), we shoudl use
> them here. And I guess we need bits_from_user() to fetch bits from
> userspace into kernel.

Nice catch. You're right, I will switch to bits_to_user().

I fixed some typos in your changes below and merged them. Will send v2
after I booted it.

Thanks!
David

> I also tried changing verbage on the ioctls, see if you agree with the
> changes and if so please incorporate in your next version.
>
> Thanks.
>
> --
> Dmitry
>
> diff -u b/drivers/input/evdev.c b/drivers/input/evdev.c
> --- b/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -71,7 +71,7 @@
>                 [EV_FF] = FF_CNT,
>         };
>
> -       return (type < EV_CNT) ? counts[type] : 0;
> +       return type < EV_CNT ? counts[type] : 0;
>  }
>
>  /* must be called with evdev-mutex held */
> @@ -132,7 +132,7 @@
>                                 return -EFAULT;
>                 } else {
>                         /* fake mask with all bits set */
> -                       out = (u8 __user*)codes;
> +                       out = (u8 __user *)codes;
>                         for (i = 0; i < min; ++i) {
>                                 if (put_user((u8)0xff,  out + i))
>                                         return -EFAULT;
> diff -u b/include/uapi/linux/input.h b/include/uapi/linux/input.h
> --- b/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -161,53 +161,59 @@
>  #define EVIOCREVOKE            _IOW('E', 0x91, int)                    /* Revoke device access */
>
>  /**
> - * EVIOCGMASK - Retrieve current event-mask
> + * EVIOCGMASK - Retrieve current event mask
>   *
> - * This retrieves the current event-mask for a specific event-type. The
> - * argument must be of type "struct input_mask" and specifies the event-type to
> - * query, the receive buffer and the size of the receive buffer.
> - *
> - * The event-mask is a per-client mask that specifies which events are forwarded
> - * to the client. Each event-code is represented by a single bit in the
> - * event-mask. If the bit is set, the event is passed to the client normally.
> - * Otherwise, the event is filtered and and will never be queued on the
> - * client's receive buffer.
> - * Event-masks do not affect global state of an input-device. They only affect
> - * the open-file they're applied on. Each open-file (i.e, file-description) can
> - * have a different event-mask.
> - *
> - * The default event-mask for a client has all bits set, i.e. all events are
> - * forwarded to the client. If a kernel is queried for an unknown event-type
> - * or if the receive buffer is larger than the number of event-codes known to
> - * the kernel, the kernel returns all zeroes for those codes.
> + * This ioctl allows user to retrieve the current event mask for specific
> + * event type. The argument must be of type "struct input_mask" and
> + * specifies the event type to query, the address of the receive buffer and
> + * the size of the receive buffer.
> + *
> + * The event mask is a per-client mask that specifies which events are
> + * forwarded to the client. Each event code is represented by a single bit
> + * in the event mask. If the bit is set, the event is passed to the client
> + * normally. Otherwise, the event is filtered and will never be queued on
> + * the client's receive buffer.
> + *
> + * Event masks do not affect global state of the input device. They only
> + * affect the file descriptor they are applied to.
> + *
> + * The default event mask for a client has all bits set, i.e. all events
> + * are forwarded to the client. If kernel is queried for an unknown
> + * event type or if the receive buffer is larger than the number of
> + * event codes known to the kernel, the kernel returns all zeroes for those
> + * codes.
>   *
>   * At maximum, codes_size bytes are copied.
>   *
> - * This ioctl may fail with ENODEV in case the file is revoked, EFAULT
> - * if the receive-buffer points to invalid memory, or EINVAL if the kernel
> - * does not implement the ioctl.
> + * This ioctl may fail with ENODEV in case the descriptor is revoked,
> + * EFAULT if the receive buffer points to invalid memory, or EINVAL if the
> + * kernel does not implement the ioctl.
>   */
> +
>  #define EVIOCGMASK             _IOR('E', 0x92, struct input_mask)      /* Get event-masks */
>
>  /**
> - * EVIOCSMASK - Set event-mask
> + * EVIOCSMASK - Set event mask
>   *
> - * This is the counterpart to EVIOCGMASK. Instead of receiving the current
> - * event-mask, this changes the client's event-mask for a specific type. See
> - * EVIOCGMASK for a description of event-masks and the argument-type.
> - *
> - * This ioctl provides full forward-compatibility. If the passed event-type is
> - * unknown to the kernel, or if the number of codes is bigger than known to the
> - * kernel, the ioctl is still accepted and applied. However, any unknown codes
> - * are left untouched and stay cleared. That means, the kernel always filters
> - * unknown codes regardless of what the client requests.
> - * If the new mask doesn't cover all known event-codes, all remaining codes are
> - * automatically cleared and thus filtered.
> + * This ioctl is the counterpart to EVIOCGMASK. Instead of receiving the
> + * current event mask, this changes the client's event mask for a specific
> + * type.  See EVIOCGMASK for a description of event-masks and the
> + * argument-type.
> + *
> + * This ioctl provides full forward compatibility. If the passed event type
> + * is unknown to the kernel, or if the number of event codes specified in
> + * the mask is bigger than what is known to the kernel, the ioctl is still
> + * accepted and applied. However, any unknown codes are left untouched and
> + * stay cleared. That means, the kernel always filters unknown codes
> + * regardless of what the client requests.  If the new mask doesn't cover
> + * all known event-codes, all remaining codes are automatically cleared and
> + * thus filtered.
>   *
>   * This ioctl may fail with ENODEV in case the file is revoked. EFAULT is
> - * returned if the receive-buffer points to invalid memory. EINVAL is returned
> - * if the kernel does not implement the ioctl.
> + * returned if the receive-buffer points to invalid memory. EINVAL is
> + * returned if the kernel does not implement the ioctl.
>   */
> +
>  #define EVIOCSMASK             _IOW('E', 0x93, struct input_mask)      /* Set event-masks */
>
>  #define EVIOCSCLOCKID          _IOW('E', 0xa0, int)                    /* Set clockid to be used for timestamps */
