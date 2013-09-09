From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 11/14] HID: multitouch: validate feature report details
Date: Mon, 9 Sep 2013 15:50:01 +0200
Message-ID: <CAN+gG=HH2hDfTyDdpTXdK5PwZtQGT7_5Mm4r733TavVqZ=4YVw@mail.gmail.com>
References: <alpine.LNX.2.00.1308282221440.22181@pobox.suse.cz>
	<521F0D5F.7040108@redhat.com>
	<CAGXu5jKkzWmMZeckmO6BeKnJs-AjrFuZvqWNxDa6Rjb7UzAeyw@mail.gmail.com>
	<CAN+gG=EvuO4R2d=bj=_9aWo1e96ee_i0sqSDJNd=3h+dVf=oWQ@mail.gmail.com>
	<CAGXu5jKAob5s1vs5s974QsJWdje2rQgyz=PVACxW3aWiJWiEEA@mail.gmail.com>
	<CAGXu5j+LHg-kFBXRzXfpLmztHjVCn6jiKkX5w1x3-a4is_RLqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:40936 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545Ab3IINuD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Sep 2013 09:50:03 -0400
Received: by mail-la0-f47.google.com with SMTP id eo20so4936666lab.34
        for <linux-input@vger.kernel.org>; Mon, 09 Sep 2013 06:50:01 -0700 (PDT)
In-Reply-To: <CAGXu5j+LHg-kFBXRzXfpLmztHjVCn6jiKkX5w1x3-a4is_RLqw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>

On Wed, Sep 4, 2013 at 6:31 PM, Kees Cook <keescook@chromium.org> wrote:
> On Fri, Aug 30, 2013 at 11:27 AM, Kees Cook <keescook@chromium.org> wrote:
>> On Fri, Aug 30, 2013 at 8:27 AM, Benjamin Tissoires
>> <benjamin.tissoires@gmail.com> wrote:
>>> On Thu, Aug 29, 2013 at 9:41 PM, Kees Cook <keescook@chromium.org> wrote:
>>>> On Thu, Aug 29, 2013 at 1:59 AM, Benjamin Tissoires
>>>> <benjamin.tissoires@redhat.com> wrote:
>>>>> Hi Kees,
>>>>>
>>>>> I would be curious to have the HID report descriptors (maybe off list)
>>>>> to understand how things can be that bad.
>>>>
>>>> Certainly! I'll send them your way. I did have to get pretty creative
>>>> to tickle these conditions.
>>>>
>>>>> On overall, I'd prefer all those checks to be in hid-core so that we
>>>>> have the guarantee that we don't have to open a new CVE each time a
>>>>> specific hid driver do not check for these ranges.
>>>>
>>>> I pondered doing this, but it seemed like something that needed wider
>>>> discussion, so I thought I'd start with just the dump of fixes. It
>>>> seems like the entire HID report interface should use access functions
>>>> to enforce range checking -- perhaps further enforced by making the
>>>> structure opaque to the drivers.
>>>
>>> The problem with access functions with range checking is when they are
>>> used at each input report. This will overload the kernel processing
>>> for static checks.
>>>
>>>>
>>>>> More specific comments inlined:
>>>>>
>>>>> On 28/08/13 22:31, Jiri Kosina wrote:
>>>>>> From: Kees Cook <keescook@chromium.org>
>>>>>>
>>>>>> When working on report indexes, always validate that they are in bounds.
>>>>>> Without this, a HID device could report a malicious feature report that
>>>>>> could trick the driver into a heap overflow:
>>>>>>
>>>>>> [  634.885003] usb 1-1: New USB device found, idVendor=0596, idProduct=0500
>>>>>> ...
>>>>>> [  676.469629] BUG kmalloc-192 (Tainted: G        W   ): Redzone overwritten
>>>>>>
>>>>>> CVE-2013-2897
>>>>>>
>>>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>>>> Cc: stable@kernel.org
>>>>>> ---
>>>>>>  drivers/hid/hid-multitouch.c |   25 ++++++++++++++++++++-----
>>>>>>  1 file changed, 20 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
>>>>>> index cb0e361..2aa275e 100644
>>>>>> --- a/drivers/hid/hid-multitouch.c
>>>>>> +++ b/drivers/hid/hid-multitouch.c
>>>>>> @@ -330,9 +330,18 @@ static void mt_feature_mapping(struct hid_device *hdev,
>>>>>>                               break;
>>>>>>                       }
>>>>>>               }
>>>>>> +             /* Ignore if value index is out of bounds. */
>>>>>> +             if (td->inputmode_index < 0 ||
>>>>>
>>>>> td->inputmode_index can not be less than 0
>>>>
>>>> Well, it certainly _shouldn't_ be less than zero. :) However, it is
>>>> defined as s8, and gets set from an int:
>>>>
>>>>                 for (i=0; i < field->maxusage; i++) {
>>>>                         if (field->usage[i].hid == usage->hid) {
>>>>                                 td->inputmode_index = i;
>>>>                                 break;
>>>>                         }
>>>>                 }
>>>>
>>>> Both "i" and "maxusage" are int, and I can generate a large maxusage
>>>> and usage array where the first matching hid equality happens when i
>>>> is >127, causing inputmode_index to wrap.
>>>
>>> ouch. Sorry. This piece of code (the current code) is junk. We should
>>> switch to usage->usage_index and change from __s8 to __s16 the
>>> declaration ASAP.
>>>
>>>>
>>>>>> +                 td->inputmode_index >= field->report_count) {
>>>>>
>>>>> if this is really required, we could just change the for loop above to
>>>>> go from 0 to field->report_count instead.
>>>>
>>>> That's certainly true, but since usage count and report count are not
>>>> directly associated, I don't know if there are devices that will freak
>>>> out with this restriction.
>>>
>>> Actually, I just again another long time understanding all the mess of
>>> having usage count and report count different in hid-core.
>>>
>>> I think it is a bug at some point (but it looks like I tend to be
>>> wrong on a lot of things recently :-P ), because when you look at the
>>> actual code of hid_input_field() in hid-core.c, we never go further
>>> than field->report_count when dealing with input report.
>>> So my guess is that we are declaring extra usages that are never used
>>> to parse incoming data.
>>>
>>>>
>>>>> However, I think we could just rely on usage->usage_index to get the
>>>>> actual index.
>>>>> I'll do more tests today and tell you later.
>>>>>
>>>>>> +                     dev_err(&hdev->dev, "HID_DG_INPUTMODE out of range\n");
>>>>>> +                     td->inputmode = -1;
>>>>>> +             }
>>>>>>
>>>>>>               break;
>>>>>>       case HID_DG_CONTACTMAX:
>>>>>> +             /* Ignore if value count is out of bounds. */
>>>>>> +             if (field->report_count < 1)
>>>>>> +                     break;
>>>>>
>>>>> If you can trigger this, I would say that the fix should be in hid-core,
>>>>> not in every driver. A null report_count should not be allowed by the
>>>>> HID protocol.
>>>>
>>>> Again, I have no problem with that idea, but there seem to be lots of
>>>> general cases where this may not be possible (i.e. a HID with 0 OUTPUT
>>>> or FEATURE reports). I didn't see a sensible way to approach this in
>>>> core without declaring a "I require $foo many OUTPUT reports, $bar
>>>> many INPUT, and $baz many FEATURE" for each driver. I instead opted
>>>> for the report validation function instead.
>>>>
>>>
>>> I think we can just add this check in both hidinput_configure_usage()
>>> and report_features() (both in hid-input.c) so that we don't call the
>>> *_mapping() callbacks with non sense fields.
>
> Can you suggest a patch for this? (And please include reference to
> CVE-2013-2897 in the commit.)

Sure, I'll do that.

Cheers,
Benjamin

>
> I'll send a v2 of the rest of the series.
>
> Thanks!
>
> -Kees
>
>>> This way, the specific hid drivers will know only the correct fields,
>>> and don't need to check this. So patches 9, 11 and 13 can be amended.
>>>
>>> It looks to me that you mismatched field->report_count and the actual
>>> report_count in your answer: field->report_count is the number of
>>> consecutive fields of field->report_size that are present for the
>>> parsing of the report. It has nothing to do with the total report
>>> count.
>>>
>>>>>>               td->maxcontact_report_id = field->report->id;
>>>>>>               td->maxcontacts = field->value[0];
>>>>>>               if (!td->maxcontacts &&
>>>>>> @@ -743,15 +752,21 @@ static void mt_touch_report(struct hid_device *hid, struct hid_report *report)
>>>>>>       unsigned count;
>>>>>>       int r, n;
>>>>>>
>>>>>> +     if (report->maxfield == 0)
>>>>>> +             return;
>>>>>> +
>>>>>>       /*
>>>>>>        * Includes multi-packet support where subsequent
>>>>>>        * packets are sent with zero contactcount.
>>>>>>        */
>>>>>> -     if (td->cc_index >= 0) {
>>>>>> -             struct hid_field *field = report->field[td->cc_index];
>>>>>> -             int value = field->value[td->cc_value_index];
>>>>>> -             if (value)
>>>>>> -                     td->num_expected = value;
>>>>>> +     if (td->cc_index >= 0 && td->cc_index < report->maxfield) {
>>>>>> +             field = report->field[td->cc_index];
>>>>>
>>>>> looks like we previously overwrote the definition of field :(
>>>>>
>>>>>> +             if (td->cc_value_index >= 0 &&
>>>>>> +                 td->cc_value_index < field->report_count) {
>>>>>> +                     int value = field->value[td->cc_value_index];
>>>>>> +                     if (value)
>>>>>> +                             td->num_expected = value;
>>>>>> +             }
>>>>>
>>>>> I can not see why td->cc_index and td->cc_value_index could have bad
>>>>> values. They are initially created by hid-core, and are not provided by
>>>>> the device.
>>>>> Anyway, if you are able to produce bad values with them, I'd rather have
>>>>> those checks during the assignment of td->cc_index (in
>>>>> mt_touch_input_mapping()), instead of checking them for each report.
>>>>
>>>> Well, the problem comes again from there not being a hard link between
>>>> the usage array and the value array:
>>>>
>>>>                         td->cc_value_index = usage->usage_index;
>>>> ...
>>>>                         int value = field->value[td->cc_value_index];
>>>>
>>>> And all of this would be irrelevant if there was an access function
>>>> for field->value[].
>>>
>>> True, with the current implementation, td->cc_value_index can be
>>> greater than field->report_count. Still, moving this check in
>>> mt_touch_input_mapping() will allow us to make it only once.
>>>
>>>>
>>>> Thanks for the review!
>>>
>>> you are welcome :)
>>
>> Okay, so, where does the whole patch series stand? It seems like the
>> checks are all worth adding; and my fixes are, I think, "minimal" so
>> having them go into the tree (so that they land in stable) seems like
>> a good idea. The work beyond that could be done on top of the existing
>> patches? There seems to be a lot of redesign ideas, but those probably
>> aren't so great for stable, and I'm probably not the best person to
>> write them, since everything I know about HID code I learned two weeks
>> ago. :)
>>
>> Given the 12 flaws, what do you see as the best way forward?
>
> --
> Kees Cook
> Chrome OS Security
