From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] Input: evdev - add event-mask API
Date: Tue, 22 Apr 2014 08:25:17 +0200
Message-ID: <CANq1E4SM62=DNX8nYp2f0Cw7ikZVGnHFQ9RRDy3=uPSuNDVA=w@mail.gmail.com>
References: <1397601105-17771-1-git-send-email-dh.herrmann@gmail.com>
	<20140419211601.GB8343@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35493 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbaDVGZR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Apr 2014 02:25:17 -0400
Received: by mail-ig0-f169.google.com with SMTP id h18so2521994igc.4
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2014 23:25:17 -0700 (PDT)
In-Reply-To: <20140419211601.GB8343@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Lennart Poettering <lennart@poettering.net>

Hi

On Sat, Apr 19, 2014 at 11:16 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>> +static size_t evdev_get_mask_cnt(unsigned int type)
>> +{
>> +     switch (type) {
>> +     case 0:
>> +             /* 0 is special (EV-bits instead of EV_SYN) like EVIOCGBIT */
>> +             return EV_CNT;
>> +     case EV_KEY:
>> +             return KEY_CNT;
>> +     case EV_REL:
>> +             return REL_CNT;
>> +     case EV_ABS:
>> +             return ABS_CNT;
>> +     case EV_MSC:
>> +             return MSC_CNT;
>> +     case EV_SW:
>> +             return SW_CNT;
>> +     case EV_LED:
>> +             return LED_CNT;
>> +     case EV_SND:
>> +             return SND_CNT;
>> +     case EV_FF:
>> +             return FF_CNT;
>> +     }
>
> Maybe we need a static array of code->count mapping instead of a switch?

Sure, I can change that.

>> +
>> +     return 0;
>> +}
>> +
>> +/* must be called with evdev-mutex held */
>> +static int evdev_set_mask(struct evdev_client *client,
>> +                       unsigned int type,
>> +                       const void __user *codes,
>> +                       u32 codes_size)
>> +{
>> +     unsigned long flags, *mask, *oldmask;
>> +     size_t cnt, size;
>> +
>> +     /* unknown masks are simply ignored for forward-compat */
>> +     cnt = evdev_get_mask_cnt(type);
>> +     if (!cnt)
>> +             return 0;
>> +
>> +     /* we allow 'codes_size > size' for forward-compat */
>> +     size = sizeof(unsigned long) * BITS_TO_LONGS(cnt);
>> +
>> +     mask = kzalloc(size, GFP_KERNEL);
>> +     if (!mask)
>> +             return -ENOMEM;
>> +
>> +     if (copy_from_user(mask, codes, min_t(size_t, codes_size, size))) {
>> +             kfree(mask);
>> +             return -EFAULT;
>> +     }
>> +
>> +     spin_lock_irqsave(&client->buffer_lock, flags);
>> +     oldmask = client->evmasks[type];
>> +     client->evmasks[type] = mask;
>> +     spin_unlock_irqrestore(&client->buffer_lock, flags);
>> +
>> +     kfree(oldmask);
>> +
>> +     return 0;
>> +}
>> +
>> +/* must be called with evdev-mutex held */
>> +static int evdev_get_mask(struct evdev_client *client,
>> +                       unsigned int type,
>> +                       void __user *codes,
>> +                       u32 codes_size)
>> +{
>> +     unsigned long *mask;
>> +     size_t cnt, size, min, i;
>> +     u8 __user *out;
>> +
>> +     /* we allow unknown types and 'codes_size > size' for forward-compat */
>> +     cnt = evdev_get_mask_cnt(type);
>> +     size = sizeof(unsigned long) * BITS_TO_LONGS(cnt);
>> +     min = min_t(size_t, codes_size, size);
>> +
>> +     if (cnt > 0) {
>> +             mask = client->evmasks[type];
>> +             if (mask) {
>> +                     if (copy_to_user(codes, mask, min))
>> +                             return -EFAULT;
>> +             } else {
>> +                     /* fake mask with all bits set */
>> +                     out = (u8 __user*)codes;
>> +                     for (i = 0; i < min; ++i) {
>> +                             if (put_user((u8)0xff,  out + i))
>> +                                     return -EFAULT;
>> +                     }
>> +             }
>> +     }
>> +
>> +     codes = (u8 __user*)codes + min;
>> +     codes_size -= min;
>> +
>> +     if (codes_size > 0 && clear_user(codes, codes_size))
>> +             return -EFAULT;
>> +
>> +     return 0;
>> +}
>> +
>> +/* requires the buffer lock to be held */
>> +static bool __evdev_is_masked(struct evdev_client *client,
>> +                           unsigned int type,
>> +                           unsigned int code)
>> +{
>> +     unsigned long *mask;
>> +     size_t cnt;
>> +
>> +     /* EV_SYN and unknown codes are never masked */
>
> So won't this mean that client is still woken up by "empty" packet if we
> filter out everything but EV_SYN?

Whoops, indeed. I will skip SYN_REPORT events if the queue is empty or
if the previous event was already a SYN_REPORT.

Thanks
David
