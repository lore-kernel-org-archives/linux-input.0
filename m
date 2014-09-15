From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] Handle spurious backslash key repeats on some keyboards
Date: Mon, 15 Sep 2014 16:52:36 +0200
Message-ID: <CANq1E4Q_1pJzpV9Ut8sBXytpWB5-muAq7Ox+u9nccu6fKmB40Q@mail.gmail.com>
References: <1407664566-5303-1-git-send-email-megahallon@gmail.com>
	<CANq1E4RVV1nEbtiAkiePtSF-K8CdnS7hmts_8hqDOi=mWsE4MA@mail.gmail.com>
	<CAN+gG=FDkWc+uzm8RgKBJbeWfFRiO4TDR0202VbDoKBxpJ=oRg@mail.gmail.com>
	<CAN+gG=HX-5RioEx+BG=S1eOm8OGRc2e7cck-neLSVeq0kyc4hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:45430 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360AbaIOOwh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Sep 2014 10:52:37 -0400
Received: by mail-ie0-f177.google.com with SMTP id rd18so4442334iec.8
        for <linux-input@vger.kernel.org>; Mon, 15 Sep 2014 07:52:37 -0700 (PDT)
In-Reply-To: <CAN+gG=HX-5RioEx+BG=S1eOm8OGRc2e7cck-neLSVeq0kyc4hA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Fredrik Hallenberg <megahallon@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi

On Mon, Sep 15, 2014 at 4:47 PM, Benjamin Tissoires
<benjamin.tissoires@gmail.com> wrote:
> On Mon, Sep 15, 2014 at 10:39 AM, Benjamin Tissoires
> <benjamin.tissoires@gmail.com> wrote:
>> On Sun, Sep 14, 2014 at 12:45 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
>>> Hi
>>>
>>> On Sun, Aug 10, 2014 at 11:56 AM, Fredrik Hallenberg
>>> <megahallon@gmail.com> wrote:
>>>> Here is my attempt on a fix for bug 70181, please review it. It is
>>>> tested on my nordic Corsair K70, if this solution is deemed acceptable
>>>> I can ask some people with other problematic keyboards to test it.
>>>>
>>>> Signed-off-by: Fredrik Hallenberg <megahallon@gmail.com>
>>>> ---
>>>>  drivers/hid/hid-input.c | 14 ++++++++++++++
>>>>  include/linux/hid.h     |  1 +
>>>>  2 files changed, 15 insertions(+)
>>>>
>>>> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
>>>> index 2619f7f..56429c0 100644
>>>> --- a/drivers/hid/hid-input.c
>>>> +++ b/drivers/hid/hid-input.c
>>>> @@ -1085,6 +1085,20 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
>>>>                 return;
>>>>         }
>>>>
>>>> +       /*
>>>> +        * Some keyboards will report both HID keys 0x31 (\ and |) and
>>>> +        * 0x32 (Non-US # and ~) which are both mapped to
>>>> +        * KEY_BACKSLASH. This will cause spurious events causing
>>>> +        * repeated backslash key presses. Handle this by tracking the
>>>> +        * active HID code and ignoring the other one.
>>>> +        */
>>>> +       if (usage->type == EV_KEY && usage->code == KEY_BACKSLASH) {
>>>> +               if (value)
>>>> +                       field->hidinput->backslash_usage = usage->hid;
>>>> +               else if (field->hidinput->backslash_usage != usage->hid)
>>>> +                       return;
>>>> +       }
>>>> +
>>>
>>> Ok, I have looked through some more reports and at a bunch of AT
>>> keyboards and how the HID standard maps them. The backslash/pipe key
>>> is the only key affected by this. There _might_ be some similar
>>> overlap with Korean 106 and Japanese 109 layouts, but as there haven't
>>> been any reports, we probably don't care right now.
>>>
>>> And indeed, I'm kinda reluctant to add an hwdb entry for the reported
>>> keyboards as I couldn't find anyone with non-105 keyboards to compare
>>> VID/PID. Furthermore, similar issues will probably show up again in
>>> the future. However, I still dislike the quick hack in this patch. I
>>> especially dislike matching on KEY_BACKSLASH while we really want to
>>> match on 0x31 and 0x32. If users use setkeycode() to change a mapping,
>>> this should not trigger our quirk. We could easily change the patch to
>>> match on usage, but I think there's a better way:
>>>
>>> hid-core.c: hid_input_field()
>>> This is the main entry point for data that is matched on HID fields.
>>> We already have a RollOver quirk in there, which is extremely bad
>>> documented and I have no idea what it does.. However, this function
>>> saves the reported values so we can retrieve them on a following
>>> report. Why don't we skip events that have the same value reported as
>>> before? Obviously, we should do this only for absolute data, not
>>> relative. So I think something like this should work (sorry for
>>> line-wraps):
>>>
>>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>>> index 12b6e67..000a768 100644
>>> --- a/drivers/hid/hid-core.c
>>> +++ b/drivers/hid/hid-core.c
>>> @@ -1220,7 +1220,10 @@
>>>         for (n = 0; n < count; n++) {
>>>
>>>                 if (HID_MAIN_ITEM_VARIABLE & field->flags) {
>>> -                       hid_process_event(hid, field,
>>> &field->usage[n], value[n], interrupt);
>>> +                       /* ignore absolute values if they didn't change */
>>> +                       if (HID_MAIN_ITEM_RELATIVE & field->flags ||
>>> +                           value[n] != field->value[n])
>>> +                               hid_process_event(hid, field,
>>> &field->usage[n], value[n], interrupt);
>>>                         continue;
>>>                 }
>>>
>>>
>>> @Jiri: Any comments on this? I now agree with Fredrik that this is
>>> better solved in HID core. It is a generic problem..
>>
>> Jumping in the conversation here, but this is a strong NACK.
>>
>> The multitouch handling sometimes suppose that there is a keep alive
>> on each touch, and when the keep alive stops in the report, then the
>> mt library releases the touch. If you stop sending these events, the
>> tip switch will not be sent twice, and then the slot will be
>> considered as released, and you broke many touchscreens.
>>
>
> To be fair, this will not impact hid-multitouch actually. This driver
> does not uses the mt_event directly, so it should be fine. Still,
> changing this behaviour is IMO likely to introduce regressions, unless
> you conduct a very thorough audit of all the hid drivers and check
> that they are not relying on the fact that they get all the events in
> each report.

I'm fine with reducing this to a minimum (like matching on
HID_UP_KEYBOARD). I haven't sent a patch, yet, as I'm looking for
exactly those cases. So thanks for pointing it out.

Anything going though the input layer is already discarded if it
doesn't change (and is absolute data). So it's really just about
quirks and special HID drivers. We could move this comparison into
hid-input.c *after* any driver quirk has been called?

Thanks
David
