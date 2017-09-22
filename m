From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] hid/uhid: fix a double-fetch bug when copying event from user
Date: Fri, 22 Sep 2017 14:27:53 +0200
Message-ID: <CANq1E4SfvVHaSdjH9jozb1b3PKKWq2RMAVBPr0K4h=h0_Xp6JA@mail.gmail.com>
References: <1505798497-22436-1-git-send-email-mengxu.gatech@gmail.com>
 <CAKdAkRRqdwzzbUJ7jKYeZWB4oqu0vXbyWn5UiWrytiqexysYbQ@mail.gmail.com>
 <4703026b-a8ea-20f3-ac8c-93bee6cba8dd@gatech.edu> <CAKdAkRQS+Def51w5q23-HxZ=o0n3RqCz5cdtMgQHxZppkDtQkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKdAkRQS+Def51w5q23-HxZ=o0n3RqCz5cdtMgQHxZppkDtQkA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Meng Xu <meng.xu@gatech.edu>, Meng Xu <mengxu.gatech@gmail.com>, David Herrmann <dh.herrmann@googlemail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, sanidhya@gatech.edu, taesoo@gatech.edu
List-Id: linux-input@vger.kernel.org

Hey

On Wed, Sep 20, 2017 at 12:12 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, Sep 19, 2017 at 2:54 PM, Meng Xu <meng.xu@gatech.edu> wrote:
>>
>>
>> On 09/19/2017 05:31 PM, Dmitry Torokhov wrote:
>>>
>>> On Mon, Sep 18, 2017 at 10:21 PM, Meng Xu <mengxu.gatech@gmail.com> wrote:
>>>>
>>>> When in_compat_syscall(), a user could make type != UHID_CREATE when
>>>> get_user(type, buffer) [first fetch] and later make event->type ==
>>>> UHID_CREATE in copy_from_user(event, buffer, ...) [second fetch].
>>>>
>>>> By doing so, an attacker might circumvent the specific logic to handle
>>>> the type == UHID_CREATE case and later cause undefined behaviors.
>>>>
>>>> This patch enforces that event->type is overriden to the type value
>>>> copied in the first fetch and thus, mitigate this race condition attack.
>>>
>>> I do not believe this mitigates anything, as copy_form_user() is not
>>> an atomic operation and we can have 2nd thread "scrambling" the memory
>>> while 1st does the ioctl.
>>
>> Yes, what you described is the root cause of this double-fetch situation
>> and that is why I am proposing this patch.
>>>
>>>
>>> We also should not expect that we always get consistent data from
>>> userspace and the rest of the driver should be able to cope with
>>> (reject) such data.
>>
>> Yes, that is also true and we should never assume to get consistent
>> data from userspace. That is why in this case, we can have user
>> started with UHID_INPUT just to skip the large chunk of code in
>> if (type == UHID_CREATE) {} and then replace it with UHID_CREATE
>> and take the function uhid_dev_create(uhid, &uhid->input_buf).
>> This is exactly what this patch tries to mitigate.
>
> OK, so the driver should be able to withstand equivalent of "dd
> if=/dev/random of=/dev/uhid". The point of special handling of
> UHID_CREATE in uhid_event_from_user() is to convert the layout of the
> UHID event from 32 to 64 bit layout because we made a mistake and have
> a pointer data there. We do not really care about contents. We do not
> care it if changes. We do not care of the pointer is valid. If there
> was garbage, or there will be garbage after conversion, it does not
> care one bit. uhid_dev_create() has to validate the input and reject
> invalid input.

I agree.

With current code, worst case scenario is someone shortcutting the
compat-conversion by setting UHID_CREATE after uhid_event_from_user()
copied it. However, this does no harm, as Dmitry explained. If
user-space wants to shortcut the conversion, let them do so...

Thanks
David
