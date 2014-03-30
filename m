From: Reyad Attiyat <reyad.attiyat@gmail.com>
Subject: Re: [PATCH] HID: multitouch: add support for Win 8.1 multitouch touchpads
Date: Sat, 29 Mar 2014 20:23:33 -0500
Message-ID: <CA+BWVUQxyM2CkXiQLJi+yrjCEGiFWMur9UQvxV8K1PYTRPpCmQ@mail.gmail.com>
References: <1395261543-3103-1-git-send-email-aduggan@synaptics.com>
 <alpine.LNX.2.00.1403201002260.3690@pobox.suse.cz> <CAN+gG=HtEpKi-bjf-Aq7+Ko8MFnyXyfgL72D3pYo0NE9ZdWBsA@mail.gmail.com>
 <CA+BWVURMCnkt8NtRorj+mifHWEGs=0TZbFAqmusKoXyVQj-QZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:39121 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbaC3BXy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 29 Mar 2014 21:23:54 -0400
Received: by mail-we0-f174.google.com with SMTP id t60so3506634wes.19
        for <linux-input@vger.kernel.org>; Sat, 29 Mar 2014 18:23:53 -0700 (PDT)
In-Reply-To: <CA+BWVURMCnkt8NtRorj+mifHWEGs=0TZbFAqmusKoXyVQj-QZA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hey Benjamin,

I was the one to submit the original Surface 2 patch. I have been
testing the 3.15/multitouch branch with the Surface Pro 2 type cover.
This patch doesn't actual enable the keyboard/mouse to work. This
patch only works when there is a HID_UP_BUTTON and/or HID_DG_TOUCHPAD
in usage, which is not the case on this device. The reason the type
cover is not working with hid-multitouch is mt_input_mapping is
returing -1 to ignore the device. This happens becuase of:

if (!td->mtclass.export_all_inputs &&
   field->application != HID_DG_TOUCHSCREEN &&
   field->application != HID_DG_PEN &&
   field->application != HID_DG_TOUCHPAD)
return -1;


I notice that there is now a mt.export_all_inputs which could allow
the surface type cover keyboard to get handled properly. Is this
something that sould be added to hid-multitouch for this device? The
driver could check for device ID's and set export_all_inputs to true.
It could also check for GenericDesktop application in hid field and
return 0 in mt_input_mapping.

I can submit a patch with one of these changes if you think it would
be better than the current patch for the surface from Derya. I belive
that patch adds hardware ID's to hid core and sets the HID Group to
generic.

On Thu, Mar 20, 2014 at 12:36 PM, Benjamin Tissoires
<benjamin.tissoires@gmail.com> wrote:
> On Thu, Mar 20, 2014 at 5:02 AM, Jiri Kosina <jkosina@suse.cz> wrote:
>> On Wed, 19 Mar 2014, Andrew Duggan wrote:
>>
>>> Multitouch touchpads built for Win 8.1 need to be sent an input mode feature report
>>> in order to start reporting multitouch events. This is the same process sent
>>> to Win 7 multitouch touchscreens except the value of the feature report is 3 for
>>> touchpads.
>>>
>>> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
>>> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>>
>> Applied, thanks.
>
> Thanks Jiri.
>
> Derya, can you test if this also solves the problem with the Surface 2
> touch cover?
> (if you remove the special vendor handling in hid_scan_report)
>
> Cheers,
> Benjamin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
