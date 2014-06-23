From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH v2 2/2] Input: uinput - add new UINPUT_DEV_SETUP ioctl
Date: Mon, 23 Jun 2014 11:50:32 +0200
Message-ID: <CANq1E4TktFM6fEFOcSqxApqaY1bddnXyq9Z2Jf=WKztz=dPE9A@mail.gmail.com>
References: <1403263600-24736-1-git-send-email-dh.herrmann@gmail.com>
	<1403263600-24736-2-git-send-email-dh.herrmann@gmail.com>
	<20140623025357.GA13743@jelly.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:63539 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752962AbaFWJud (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Jun 2014 05:50:33 -0400
Received: by mail-ig0-f179.google.com with SMTP id uq10so2748707igb.0
        for <linux-input@vger.kernel.org>; Mon, 23 Jun 2014 02:50:32 -0700 (PDT)
In-Reply-To: <20140623025357.GA13743@jelly.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

Hi

On Mon, Jun 23, 2014 at 4:53 AM, Peter Hutterer
<peter.hutterer@who-t.net> wrote:
> On Fri, Jun 20, 2014 at 01:26:40PM +0200, David Herrmann wrote:
>> This adds a new ioctl UINPUT_DEV_SETUP that replaces the old device setup
>> method (by write()'ing "struct uinput_user_dev" to the node). The old
>> method is not easily extendable and requires huge payloads. Furthermore,
>> overloading write() without properly versioned objects is error-prone.
>>
>> Therefore, we introduce a new ioctl to replace the old method. The ioctl
>> supports all features of the old method, plus a "resolution" field for
>> absinfo. Furthermore, it's properly forward-compatible to new ABS codes
>> and a growing "struct input_absinfo" structure.
>>
>> The ioctl also allows user-space to skip unknown axes if not set. The
>> payload-size can now be specified by the caller. There is no need to copy
>> the whole array temporarily into the kernel, but instead we can iterate
>> over it and copy each value manually.
>>
>> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
>> ---
>> v2:
>>  - drop "version" field
>>  - drop "size" field
>>  - only copy absinfo if UI_SET_ABSBIT was called for the axis
>>  - minor linguistic changes
>>
>>  drivers/input/misc/uinput.c | 67 +++++++++++++++++++++++++++++++++++++++++++--
>>  include/uapi/linux/uinput.h | 55 +++++++++++++++++++++++++++++++++++--
>>  2 files changed, 116 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
>> index a2a3895..5c125e8 100644
>> --- a/drivers/input/misc/uinput.c
>> +++ b/drivers/input/misc/uinput.c
>> @@ -371,8 +371,65 @@ static int uinput_allocate_device(struct uinput_device *udev)
>>       return 0;
>>  }
>>
>> -static int uinput_setup_device(struct uinput_device *udev,
>> -                            const char __user *buffer, size_t count)
>> +static int uinput_dev_setup(struct uinput_device *udev,
>> +                         struct uinput_setup __user *arg)
>> +{
>> +     struct uinput_setup setup;
>> +     struct input_dev *dev;
>> +     int i, retval;
>
> don't you want to a check for udev->state != UIST_CREATED here?

Nice catch, added!

>> +
>> +     if (copy_from_user(&setup, arg, sizeof(setup)))
>> +             return -EFAULT;
>> +     if (!setup.name[0])
>> +             return -EINVAL;
>> +     /* So far we only support the original "struct input_absinfo", but be
>> +      * forward compatible and allow larger payloads. */
>> +     if (setup.absinfo_size < sizeof(struct input_absinfo))
>> +             return -EINVAL;
>> +
>> +     dev = udev->dev;
>> +     dev->id = setup.id;
>> +     udev->ff_effects_max = setup.ff_effects_max;
>> +
>> +     kfree(dev->name);
>> +     dev->name = kstrndup(setup.name, UINPUT_MAX_NAME_SIZE, GFP_KERNEL);
>> +     if (!dev->name)
>> +             return -ENOMEM;
>> +
>> +     if (setup.abs_cnt > ABS_CNT)
>> +             setup.abs_cnt = ABS_CNT;
>> +
>> +     if (setup.abs_cnt > 0) {
>> +             u8 __user *p = (u8 __user*)arg->abs;
>> +
>> +             input_alloc_absinfo(dev);
>> +             if (!dev->absinfo)
>> +                     return -ENOMEM;
>> +
>> +             for (i = 0; i < setup.abs_cnt; ++i, p += setup.absinfo_size) {
>> +                     struct input_absinfo absinfo;
>> +
>> +                     if (!test_bit(i, dev->absbit))
>> +                             continue;
>> +
>> +                     if (copy_from_user(&absinfo, p, sizeof(absinfo)))
>> +                             return -EFAULT;
>> +
>> +                     dev->absinfo[i] = absinfo;
>> +             }
>> +     }
>> +
>> +     retval = uinput_validate_absbits(dev);
>> +     if (retval < 0)
>> +             return retval;
>> +
>> +     udev->state = UIST_SETUP_COMPLETE;
>> +     return 0;
>> +}
>> +
>> +/* legacy setup via write() */
>> +static int uinput_setup_device_legacy(struct uinput_device *udev,
>> +                                   const char __user *buffer, size_t count)
>>  {
>>       struct uinput_user_dev  *user_dev;
>>       struct input_dev        *dev;
>> @@ -475,7 +532,7 @@ static ssize_t uinput_write(struct file *file, const char __user *buffer,
>>
>>       retval = udev->state == UIST_CREATED ?
>>                       uinput_inject_events(udev, buffer, count) :
>> -                     uinput_setup_device(udev, buffer, count);
>> +                     uinput_setup_device_legacy(udev, buffer, count);
>>
>>       mutex_unlock(&udev->mutex);
>>
>> @@ -736,6 +793,10 @@ static long uinput_ioctl_handler(struct file *file, unsigned int cmd,
>>                       uinput_destroy_device(udev);
>>                       goto out;
>>
>> +             case UI_DEV_SETUP:
>> +                     retval = uinput_dev_setup(udev, p);
>> +                     goto out;
>> +
>>               case UI_SET_EVBIT:
>>                       retval = uinput_set_bit(arg, evbit, EV_MAX);
>>                       goto out;
>> diff --git a/include/uapi/linux/uinput.h b/include/uapi/linux/uinput.h
>> index 19339cf..982144d 100644
>> --- a/include/uapi/linux/uinput.h
>> +++ b/include/uapi/linux/uinput.h
>> @@ -20,6 +20,8 @@
>>   * Author: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
>>   *
>>   * Changes/Revisions:
>> + *   5       06/20/2014 (David Herrmann <dh.herrmann@gmail.com>
>> + *           - add UI_DEV_SETUP ioctl
>>   *   0.4     01/09/2014 (Benjamin Tissoires <benjamin.tissoires@redhat.com>)
>>   *           - add UI_GET_SYSNAME ioctl
>>   *   0.3     24/05/2006 (Anssi Hannula <anssi.hannulagmail.com>)
>
> hm, I think you misunderstood my comment. I was hoping to fix all up in one
> go, I had noticed that the others were 0.x as well :)
>
> With the extra check, both patches Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>

Not sure I like doing that in this patch. I think I will keep 0.5 and
send a followup to fix all of these.

Thanks for reviewing!
David
