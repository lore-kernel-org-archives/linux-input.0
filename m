From: Meng Xu <meng.xu@gatech.edu>
Subject: Re: [PATCH] hid/uhid: fix a double-fetch bug when copying event from
 user
Date: Tue, 19 Sep 2017 17:54:29 -0400
Message-ID: <4703026b-a8ea-20f3-ac8c-93bee6cba8dd@gatech.edu>
References: <1505798497-22436-1-git-send-email-mengxu.gatech@gmail.com>
 <CAKdAkRRqdwzzbUJ7jKYeZWB4oqu0vXbyWn5UiWrytiqexysYbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-cys01nam02on0103.outbound.protection.outlook.com ([104.47.37.103]:38592
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751503AbdISVyg (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 19 Sep 2017 17:54:36 -0400
In-Reply-To: <CAKdAkRRqdwzzbUJ7jKYeZWB4oqu0vXbyWn5UiWrytiqexysYbQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Meng Xu <mengxu.gatech@gmail.com>
Cc: dh.herrmann@googlemail.com, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, sanidhya@gatech.edu, taesoo@gatech.edu



On 09/19/2017 05:31 PM, Dmitry Torokhov wrote:
> On Mon, Sep 18, 2017 at 10:21 PM, Meng Xu <mengxu.gatech@gmail.com> wrote:
>> When in_compat_syscall(), a user could make type != UHID_CREATE when
>> get_user(type, buffer) [first fetch] and later make event->type ==
>> UHID_CREATE in copy_from_user(event, buffer, ...) [second fetch].
>>
>> By doing so, an attacker might circumvent the specific logic to handle
>> the type == UHID_CREATE case and later cause undefined behaviors.
>>
>> This patch enforces that event->type is overriden to the type value
>> copied in the first fetch and thus, mitigate this race condition attack.
> I do not believe this mitigates anything, as copy_form_user() is not
> an atomic operation and we can have 2nd thread "scrambling" the memory
> while 1st does the ioctl.
Yes, what you described is the root cause of this double-fetch situation
and that is why I am proposing this patch.
>
> We also should not expect that we always get consistent data from
> userspace and the rest of the driver should be able to cope with
> (reject) such data.
Yes, that is also true and we should never assume to get consistent
data from userspace. That is why in this case, we can have user
started with UHID_INPUT just to skip the large chunk of code in
if (type == UHID_CREATE) {} and then replace it with UHID_CREATE
and take the function uhid_dev_create(uhid, &uhid->input_buf).
This is exactly what this patch tries to mitigate.
>> Signed-off-by: Meng Xu <mengxu.gatech@gmail.com>
>> ---
>>   drivers/hid/uhid.c | 15 ++++++++++++---
>>   1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
>> index 7f8ff39..4bbfd8a 100644
>> --- a/drivers/hid/uhid.c
>> +++ b/drivers/hid/uhid.c
>> @@ -448,11 +448,20 @@ static int uhid_event_from_user(const char __user *buffer, size_t len,
>>                          kfree(compat);
>>                          return 0;
>>                  }
>> +
>>                  /* All others can be copied directly */
>> -       }
>> +               if (copy_from_user(event, buffer, min(len, sizeof(*event))))
>> +                       return -EFAULT;
>>
>> -       if (copy_from_user(event, buffer, min(len, sizeof(*event))))
>> -               return -EFAULT;
>> +               /*
>> +                * Override type in case the user process rushes to change it
>> +                * between two fetches
>> +                * */
>> +               event->type = type;
> So if we started with UHID_INPUT, userspace replaced it with
> UHID_FEATURE, we clobber the type UHID_INPUT leaving the rest of the
> structure holding the new data and call it a day? That does not make
> any sense to me.
I am not a maintainer so I am not in a position to judge which
function should do the input validation. But to me, given how
uhid_char_write() and uhid_event_from_user() are structured,
If we started with UHID_INPUT and later userspace replaced
it with UHID_FEATURE, it should be validated by uhid_dev_input.

If this patch, i.e., overriding event->type = type, is not
satisfactory to you, how about we change it to a sanity check?
Like if (event->type != type) return -EFAULT

By doing so, we make sure that if there is another thread
"scrambling" the memory, we simply do not proceed.
>
>> +       } else {
>> +               if (copy_from_user(event, buffer, min(len, sizeof(*event))))
>> +                       return -EFAULT;
>> +       }
>>
>>          return 0;
>>   }
>> --
>> 2.7.4
>>
> Thanks.
>

