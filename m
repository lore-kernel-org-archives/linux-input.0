From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: [PATCH] Input: evdev - add ioctl cmd EVIOCGBUFSIZE to get buffer size
Date: Sat, 9 Jan 2016 01:23:31 +0530
Message-ID: <CADYu30_KWWELgNM4a0Lyd_AoewpmhizuxJxXJSXzoGSF5YFOZg@mail.gmail.com>
References: <1452266588-3139-1-git-send-email-a.mathur@samsung.com>
	<CANq1E4T0UVLijsFivcANtMjknn6bkq7W5nned_hAvRQD=K94Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:36790 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754428AbcAHTxc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jan 2016 14:53:32 -0500
In-Reply-To: <CANq1E4T0UVLijsFivcANtMjknn6bkq7W5nned_hAvRQD=K94Nw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Aniroop Mathur <a.mathur@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Hello Mr. David,

On Fri, Jan 8, 2016 at 8:59 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
> Hi
>
> On Fri, Jan 8, 2016 at 4:23 PM, Aniroop Mathur <a.mathur@samsung.com> wrote:
>> Add ioctl cmd EVIOCGBUFSIZE to get kernel buffer size of device so that
>> clients can accordingly set the size of userspace buffer and can know
>> maximum number of events that they are required to read in worst case.
>
> Why is that needed? What's wrong with resizing your buffers in
> user-space? Exposing this information limits the kernel to never allow
> dynamically sized buffers.
>

It is needed, otherwise user space client would not be able to decide
the proper size of its buffer used to store data on read call.
read(fd, mBuf, num_events * sizeof(input_event));
If mBuf size is chosen more than evdev buf size, it is a waste of user
space memory. So mBuf should always be between 1 and max
evdev buf size and userspace decides it depending on the device
i.e. for slower device it is normally 1 but for for faster device
user space buf size is 2,3...max-size so that if reading is delayed
then it can read all pending data stored in evdev buffer and
prevent buffer overrun as well.

During system boot up, user space buf size is fixed, it cannot be
resized later and we cannot choose by hit&trial.
struct input_event* mBuffer = new input_event[mBuf];

Why it will limit to not allow dynamically sized buffer? Simply, getting
the buf size does not relate to it.

> Furthermore, in user-space you don't have to pre-allocate your
> buffers. It'd be enough to reserve the address space for it.
>

I am not sure what are you referring to here?
We have to fix the the size of buffer before using it like shown above,
otherwise it will lead to data corruption of other memory not allocated
for our user space buffer.

> Could you elaborate on your use-case?
>

Use case is simply to decide the proper size of any user space client
buffer on the basis of evdev buf size which varies from device to
device depending on its capability.

>> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
>> ---
>>  drivers/input/evdev.c      |    3 +++
>>  include/uapi/linux/input.h |    2 ++
>>  2 files changed, 5 insertions(+)
>>
>> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
>> index e9ae3d5..8b16f08 100644
>> --- a/drivers/input/evdev.c
>> +++ b/drivers/input/evdev.c
>> @@ -1103,6 +1103,9 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
>>
>>                 return 0;
>>
>> +       case EVIOCGBUFSIZE:
>> +               return put_user(client->bufsize, (unsigned int __user *)p);
>> +
>>         case EVIOCRMFF:
>>                 return input_ff_erase(dev, (int)(unsigned long) p, file);
>>
>> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
>> index 2758687..51d66aa 100644
>> --- a/include/uapi/linux/input.h
>> +++ b/include/uapi/linux/input.h
>> @@ -114,6 +114,8 @@ struct input_mask {
>>  #define EVIOCSKEYCODE          _IOW('E', 0x04, unsigned int[2])        /* set keycode */
>>  #define EVIOCSKEYCODE_V2       _IOW('E', 0x04, struct input_keymap_entry)
>>
>> +#define EVIOCGBUFSIZE          _IOR('E', 0x05, unsigned int)           /* get device buffer size */
>
> Please document all new ioctls. See EVIOCSMASK for an example.
>

I had a look on EVIOCSMASK but haven't seen it fully. It seems to be a
complex functionality ioctl command for which detailed explanation is
required. But my ioctl cmd EVIOCGBUFSIZE functionality is very simple
i.e. to just return evdev max buf size for which I have added a comment.

Regards,
Aniroop

> Thanks
> David
>
>> +
>>  #define EVIOCGNAME(len)                _IOC(_IOC_READ, 'E', 0x06, len)         /* get device name */
>>  #define EVIOCGPHYS(len)                _IOC(_IOC_READ, 'E', 0x07, len)         /* get physical location */
>>  #define EVIOCGUNIQ(len)                _IOC(_IOC_READ, 'E', 0x08, len)         /* get unique identifier */
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
