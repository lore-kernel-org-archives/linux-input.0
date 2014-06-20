From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [RFC] Input: evdev - add new EVIOCGABSRANGE ioctl
Date: Fri, 20 Jun 2014 11:53:52 -0400
Message-ID: <CAN+gG=FLe_gaRUp_ipRBBTNY=7kkScn5-R3b9qrWf03bN7jGbA@mail.gmail.com>
References: <1403273149-29224-1-git-send-email-dh.herrmann@gmail.com>
	<CAN+gG=H9n5Sun2nrVATu79MxS4p4xqdGncWEB-6a+7HCWx_bsA@mail.gmail.com>
	<CANq1E4RPZTj8Y+PrNNzYfEvn-K6fer_ZCxutCeyFVi8cgCr=pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:33893 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934953AbaFTPxx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Jun 2014 11:53:53 -0400
Received: by mail-qg0-f52.google.com with SMTP id f51so3651594qge.11
        for <linux-input@vger.kernel.org>; Fri, 20 Jun 2014 08:53:52 -0700 (PDT)
In-Reply-To: <CANq1E4RPZTj8Y+PrNNzYfEvn-K6fer_ZCxutCeyFVi8cgCr=pw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>

On Fri, Jun 20, 2014 at 10:59 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
> Hi
>
> On Fri, Jun 20, 2014 at 4:49 PM, Benjamin Tissoires
> <benjamin.tissoires@gmail.com> wrote:
>> Hi David,
>>
[stripped]
>>> +
>>> +static int evdev_handle_get_absrange(struct evdev_client *client,
>>> +                                    struct input_dev *dev,
>>> +                                    struct input_absrange __user *p)
>>> +{
>>> +       size_t slots, code, count, i, j;
>>> +       struct input_absrange absbuf;
>>> +       s32 **vals = NULL;
>>> +       ssize_t val_cnt;
>>> +       s32 __user *b;
>>> +       int retval;
>>> +
>>> +       if (!dev->absinfo)
>>> +               return -EINVAL;
>>> +       if (copy_from_user(&absbuf, p, sizeof(absbuf)))
>>> +               return -EFAULT;
>>> +
>>> +       slots = min_t(size_t, dev->mt ? dev->mt->num_slots : 1, absbuf.slots);
>>> +       code = min_t(size_t, absbuf.code, ABS_CNT);
>>> +       count = min_t(size_t, absbuf.count, ABS_CNT);
>>> +
>>> +       /* first fetch data atomically from device */
>>> +
>>> +       if (code + count > ABS_CNT)
>>> +               count = ABS_CNT - code;
>>> +
>>> +       if (!slots || !count) {
>>> +               val_cnt = 0;
>>> +       } else {
>>> +               val_cnt = fetch_absrange(client, dev, code, count,
>>> +                                        slots, &vals);
>>> +               if (val_cnt < 0)
>>> +                       return val_cnt;
>>> +       }
>>> +
>>> +       /* now copy data to user-space */
>>> +
>>> +       b = (void __user*)(unsigned long)absbuf.buffer;
>>
>> What if the user space buffer is not long enough, or if the pointer is
>> invalid? Is there any means from the kernel to guarantee that we are
>> not writing in a restricted memory area or in a buffer not owned by
>> the process?
>
> The buffer is given as pointer in absbuf.buffer, the size of the
> buffer is given as absbuf.slots * absbuf.count. This is the same as
> for the read() syscall, where we get a pointer plus the size.
> I use put_user() to write data into that buffer, so in case it's not
> valid user-memory, this will fail with -EFAULT.
>
> This is no different from other calls that return data, apart from
> splitting the size into two ints "slots" and "count". So I cannot
> follow what you mean? Note that "put_user()" is equivalent to
> "copy_to_user()", maybe you missed that part?

Well, my concern here is not to have a CVE in 2 months time, when the
kernel is out. So I prefer being cautious when dealing with user /
kernel exchanges.

And yes, you are right, put_user will check for the validity of the
pointer for each data you send in it.

>
>>> +       for (i = 0; i < absbuf.count; ++i) {
>>> +               for (j = 0; j < absbuf.slots; ++j, ++b) {
>>> +                       s32 v;
>>> +
>>> +                       if (i >= count || j >= slots)
>>> +                               v = 0;
>>> +                       else
>>> +                               v = *absrange_ptr(vals, val_cnt, slots, i, j);
>>> +
>>> +                       if (put_user(v, b)) {

>From what I read in include/asm-generic/uaccess.h put_user does not change "b".
Aren't you missing a b++ ? (but maybe I should just stop reviewing
this today because I may not have the eyes completely opened today...)

>>> +                               retval = -EFAULT;
>>> +                               goto out;
>>> +                       }
>>> +               }
>>> +       }
>>> +
>>
>> Shouldn't we also call free_absrange(vals, val_cnt); before returning?
>
> I do. There's a fall-through to "out:", so we always free the buffer.
> Otherwise, I would have called it "error:" :)

Oops, my bad, I read the next statement as "return 0" :o)

>
>>> +       retval = 0;
>>
>> Not sure it matters a lot, but returning the size of what has been
>> written is more common. This would make sense if the buffer is not
>> long enough or if it is too big.
>
> This would always be "absbuf.slots * absbuf.count". I don't think
> there's much gain in returning a constant size, is there?
>

With the current code, if the buffer is not long enough, you return
-EFAULT. However, one can argue that we can simply return the current
count of valid written data (especially because the data have been
dropped from the event queue).

Also, returning the actual written data may help in two corner cases
(when the programmer made a mistake, but programmers make mistakes):
- if count or slots is null -> the return value will be 0 (success),
whereas nothing happened
- if the allocated buffer is bigger than what is required -> a lazy
programmer will consider the whole buffer being valid, whereas only
the first bytes have been written (it happened to me, not in this
case, but still).

It's not a matter of returning a constant, it's a matter of notifying
how many data have been forwarded to the user space. But yes, for the
general case, the user space will now which value will be returned.
(this is just my personal taste, and maybe others will prefer the 0)

Cheers,
Benjamin

>
>>
>>> +
>>> +out:
>>> +       free_absrange(vals, val_cnt);
>>> +       if (retval < 0)
>>> +               evdev_queue_syn_dropped(client);
>>> +       return retval;
>>> +}
>>> +
>>>  static int evdev_handle_get_keycode(struct input_dev *dev, void __user *p)
>>>  {
>>>         struct input_keymap_entry ke = {
>>> @@ -889,7 +1058,7 @@ static int evdev_handle_get_val(struct evdev_client *client,
>>>
>>>         spin_unlock(&dev->event_lock);
>>>
>>> -       __evdev_flush_queue(client, type);
>>> +       __evdev_flush_queue(client, type, 0, UINT_MAX);
>>>
>>>         spin_unlock_irq(&client->buffer_lock);
>>>
>>> @@ -1006,6 +1175,9 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
>>>                 else
>>>                         return evdev_revoke(evdev, client, file);
>>>
>>> +       case EVIOCGABSRANGE:
>>> +               return evdev_handle_get_absrange(client, dev, p);
>>> +
>>>         case EVIOCGMASK:
>>>                 if (copy_from_user(&mask, p, sizeof(mask)))
>>>                         return -EFAULT;
>>> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
>>> index f6ace0e..32a6443 100644
>>> --- a/include/uapi/linux/input.h
>>> +++ b/include/uapi/linux/input.h
>>> @@ -210,6 +210,48 @@ struct input_mask {
>>>   */
>>>  #define EVIOCSMASK             _IOW('E', 0x93, struct input_mask)      /* Set event-masks */
>>>
>>> +struct input_absrange {
>>> +       __u16 slots;
>>> +       __u16 code;
>>> +       __u32 count;
>>> +       __u64 buffer;
>>> +};
>>> +
>>> +/**
>>> + * EVIOCGABSRANGE - Fetch range of ABS values
>>> + *
>>> + * This fetches the current values of a range of ABS codes atomically. The range
>>> + * of codes to fetch and the buffer-types are passed as "struct input_absrange",
>>> + * which has the following fields:
>>> + *      slots: Number of MT slots to fetch data for.
>>> + *       code: First ABS axis to query.
>>> + *      count: Number of ABS axes to query starting at @code.
>>> + *     buffer: Pointer to a receive buffer where to store the fetched ABS
>>> + *             values. This buffer must be an array of __s32 with at least
>>> + *             (@slots * @code) elements. The buffer is interpreted as two
>>> + *             dimensional __s32 array, declared as: __s32[slots][codes]
>>> + *
>>> + * Compared to EVIOCGABS this ioctl allows to retrieve a range of ABS codes
>>> + * atomically regarding any concurrent buffer modifications. Furthermore, any
>>> + * pending events for codes that were retrived via this call are flushed from
>>> + * the client's receive buffer. But unlike EVIOCGABS, this ioctl only returns
>>> + * the current value of an axis, rather than the whole "struct input_absinfo"
>>> + * set. All fields of "struct input_absinfo" except for the value are constant,
>>> + * though.
>>> + *
>>> + * The kernel's current view of the ABS axes is copied into the provided buffer.
>>> + * If an ABS axis is not enabled on the device, its value will be zero. Also, if
>>> + * an axis is not a slotted MT-axis, values for all but the first slot will be
>>> + * 0. If @slots is greater than the actual number of slots provided by the
>>> + * device, values for all slots higher than that will be 0.
>>> + *
>>> + * This call may fail with -EINVAL if the kernel doesn't support this call or
>>> + * the arguments are invalid, with -ENODEV if access was revoked, -ENOMEM if the
>>> + * kernel couldn't allocate temporary buffers for data-copy or -EFAULT if the
>>> + * passed pointer was invalid.
>>> + */
>>> +#define EVIOCGABSRANGE         _IOR('E', 0x94, struct input_absrange)
>>> +
>>>  #define EVIOCSCLOCKID          _IOW('E', 0xa0, int)                    /* Set clockid to be used for timestamps */
>>>
>>>  /*
>>> --
>>> 2.0.0
>>>
