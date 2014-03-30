From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] HID: multitouch: add support for Win 8.1 multitouch touchpads
Date: Sun, 30 Mar 2014 00:07:39 -0400
Message-ID: <CAN+gG=EFTD6aTne9dPNhn=SwjE6fjc1GW_ROiEc0_PyLz20LLQ@mail.gmail.com>
References: <1395261543-3103-1-git-send-email-aduggan@synaptics.com>
	<alpine.LNX.2.00.1403201002260.3690@pobox.suse.cz>
	<CAN+gG=HtEpKi-bjf-Aq7+Ko8MFnyXyfgL72D3pYo0NE9ZdWBsA@mail.gmail.com>
	<CA+BWVURMCnkt8NtRorj+mifHWEGs=0TZbFAqmusKoXyVQj-QZA@mail.gmail.com>
	<CA+BWVUQxyM2CkXiQLJi+yrjCEGiFWMur9UQvxV8K1PYTRPpCmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:34517 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939AbaC3EHl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Mar 2014 00:07:41 -0400
Received: by mail-lb0-f173.google.com with SMTP id p9so4822673lbv.18
        for <linux-input@vger.kernel.org>; Sat, 29 Mar 2014 21:07:39 -0700 (PDT)
In-Reply-To: <CA+BWVUQxyM2CkXiQLJi+yrjCEGiFWMur9UQvxV8K1PYTRPpCmQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Reyad Attiyat <reyad.attiyat@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

Hi Reyad,

Thanks for the tests. I was surprised to hear that this patch did not
work for you. I made some tests too and the touchpad collection does
not appear right now.
This was until I realized that the report descriptor I have regarding
the Surface 2 was completely buggy.
So it seems that either I have a bad one, or the one actually inside
the device is buggy (which would explain why you don't get any
output).

The report descriptor declares all the events regarding the touchpad
as constant, and the hid subsystem ignores them :)

To be able to provide a good solution, I would like you to conduct
some more tests:

- revert commit 117309c51dca42121f70cacec801511b76acf75c (yours
actually :-P ) to handle the touch cover through hid-multitouch (you
should have done it already I think).
- register the touchcover surface 2 as using the class
MT_CLS_EXPORT_ALL_INPUTS (optional step, but you should be able to
have a keyboard with this)
- change mt_set_input_mode() in hid-multitouch.c to actually use "3"
as the td->inputmode_value (just overwite the value before putting it
in the field)
- please download and install hid-replay [1]

run hid-recorder with (and without to check) the 3 as input mode, you
should receive events starting with "E: xxxxx..xxx XX 04 ....." when
playing with the touchpad.
(without the 3 as inputmode_value, you should receive  "E: xxxxx..xxx
XX 02 .....")

Then, send me the recording from hid-recorder of a few keyboard
touches + touchpad events (single touch, dual touch, and more fingers)
so I can test and explain you how to fix the report descriptor in the
kernel.


Cheers,
Benjamin


On Sat, Mar 29, 2014 at 9:23 PM, Reyad Attiyat <reyad.attiyat@gmail.com> wrote:
> Hey Benjamin,
>
> I was the one to submit the original Surface 2 patch. I have been
> testing the 3.15/multitouch branch with the Surface Pro 2 type cover.
> This patch doesn't actual enable the keyboard/mouse to work. This
> patch only works when there is a HID_UP_BUTTON and/or HID_DG_TOUCHPAD
> in usage, which is not the case on this device. The reason the type
> cover is not working with hid-multitouch is mt_input_mapping is
> returing -1 to ignore the device. This happens becuase of:
>
> if (!td->mtclass.export_all_inputs &&
>    field->application != HID_DG_TOUCHSCREEN &&
>    field->application != HID_DG_PEN &&
>    field->application != HID_DG_TOUCHPAD)
> return -1;
>
>
> I notice that there is now a mt.export_all_inputs which could allow
> the surface type cover keyboard to get handled properly. Is this
> something that sould be added to hid-multitouch for this device? The
> driver could check for device ID's and set export_all_inputs to true.
> It could also check for GenericDesktop application in hid field and
> return 0 in mt_input_mapping.
>
> I can submit a patch with one of these changes if you think it would
> be better than the current patch for the surface from Derya. I belive
> that patch adds hardware ID's to hid core and sets the HID Group to
> generic.
>
> On Thu, Mar 20, 2014 at 12:36 PM, Benjamin Tissoires
> <benjamin.tissoires@gmail.com> wrote:
>> On Thu, Mar 20, 2014 at 5:02 AM, Jiri Kosina <jkosina@suse.cz> wrote:
>>> On Wed, 19 Mar 2014, Andrew Duggan wrote:
>>>
>>>> Multitouch touchpads built for Win 8.1 need to be sent an input mode feature report
>>>> in order to start reporting multitouch events. This is the same process sent
>>>> to Win 7 multitouch touchscreens except the value of the feature report is 3 for
>>>> touchpads.
>>>>
>>>> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
>>>> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>>>
>>> Applied, thanks.
>>
>> Thanks Jiri.
>>
>> Derya, can you test if this also solves the problem with the Surface 2
>> touch cover?
>> (if you remove the special vendor handling in hid_scan_report)
>>
>> Cheers,
>> Benjamin
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
