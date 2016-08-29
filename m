From: Silvan Jegen <s.jegen@gmail.com>
Subject: Re: [PATCH] HID: roccat: Remove use of the "exist" field
Date: Mon, 29 Aug 2016 13:35:27 +0200
Message-ID: <CAKvUva-6VqDp5ahMb5VhMcwcmTDvjGZ=jqPnsw=7nzu=eE+L7A@mail.gmail.com>
References: <20160821133302.16265-1-s.jegen@gmail.com> <20160829101514.GA21864@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33859 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbcH2LyZ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 29 Aug 2016 07:54:25 -0400
In-Reply-To: <20160829101514.GA21864@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Stefan Achatz <erazor_de@users.sourceforge.net>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

Hi Benjamin

Thanks for the review!

On Mon, Aug 29, 2016 at 12:15 PM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> Hi Silvan,
>
> On Aug 21 2016 or thereabouts, Silvan Jegen wrote:
>> The "exist" field is only checked when "roccat_open" has already been
>> called or when we have made sure that the corresponding roccat_device is
>> not NULL. Since the value of the "open" field has been increased by the
>> "roccat_open" call, instead of checking "exist" we can just check if
>> "open" is equal to zero to the same effect and remove the "exist" field
>> as well as the code that touches it.
>>
>>
>> Signed-off-by: Silvan Jegen <s.jegen@gmail.com>
>
> Well, if you look at the history, since v4.4 this driver is deprecated
> (see https://patchwork.kernel.org/patch/7422131/), so I am not so sure
> you should put a lot of effort in cleaning this up.

Ah, I wasn't aware that this driver has been deprecated. I just looked
at the code out of curiosity and thought I found a (relatively) easy
way to clean up the driver...

I also assumed that the user space roccat-tools use this driver when I
tried to test this patch which does not seem to be the case anymore.
This means I would have to redo the testing but I don't think we
should apply this patch...


>> ---
>> I have tested this patch with the only Roccat hardware I own, a Roccat
>> Kone Pure. Testing the patch with several pieces of Roccat hardware
>> connected at the same time would be desirable.
>>
>>
>>  drivers/hid/hid-roccat.c | 20 +++++++-------------
>>  1 file changed, 7 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
>> index 76d06cf..7552a1e 100644
>> --- a/drivers/hid/hid-roccat.c
>> +++ b/drivers/hid/hid-roccat.c
>> @@ -43,7 +43,6 @@ struct roccat_device {
>>       unsigned int minor;
>>       int report_size;
>>       int open;
>> -     int exist;
>>       wait_queue_head_t wait;
>>       struct device *dev;
>>       struct hid_device *hid;
>> @@ -99,7 +98,7 @@ static ssize_t roccat_read(struct file *file, char __user *buffer,
>>                               retval = -ERESTARTSYS;
>>                               break;
>>                       }
>> -                     if (!device->exist) {
>> +                     if (device->open == 0) {
>
> It feels weird to check for the device we are currently reading to be
> opened (by the caller?).
>
> I think this changes a little bit the way the flag was designed for.
> This flag is controlled when the physical HW is removed/added. But when
> the physical HW is removed, you might have some readers to the special
> chardev. And so it needs to have a way to stop the readers that are
> waiting for incoming data (read or poll).

I assume that would be an issue if a program has opened the sysfs file
and then tries to read from it but the device has been removed in the
meantime. In that case, device->open wouldn't be zero and the program
may block/retry waiting for more data that will never come (because
the device has been removed), correct?


> Stefan might have a deeper look and ACK/NACK it, but to me, the patch
> looks wrong :/

Since the driver seems to be deprecated anyways we can just drop the patch.

The comment at the beginning of hid-roccat.c says that

> [...] The information in these events depends on hid device
> implementation and contains data that is not available in a single hid event
> or else hidraw could have been used.

According to the patchwork link you posted, now hidraw (with special
ioctls) is used instead of this driver. Maybe it would make sense to
update the comment to say that this driver is now obsolete and hidraw
is being used instead?


Cheers,

Silvan
