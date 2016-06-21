From: Allen Hung <allen_hung@dell.com>
Subject: Re: [PATCH 1/1] HID: multitouch: enable palm rejection if device
 implements confidence usage
Date: Tue, 21 Jun 2016 17:20:17 +0800
Message-ID: <576906D1.5090609@dell.com>
References: <1448014866-25348-1-git-send-email-allen_hung@dell.com>
 <alpine.LNX.2.00.1511261521350.20111@pobox.suse.cz>
 <CAN+gG=Ga92-UPbbcjiL0p2b4gO0iQE_-U6wXiq_x3=39z+edSg@mail.gmail.com>
 <5677CA23.9050008@dell.com>
 <CAN+gG=EzUADfseJQ_bY9KXQ_+YNrpS8B6B9eRK_gcyD6aZpg9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from AUSXIPPC110.us.dell.com ([143.166.85.200]:43381 "EHLO
	ausxippc110.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbcFUJUb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2016 05:20:31 -0400
In-Reply-To: <CAN+gG=EzUADfseJQ_bY9KXQ_+YNrpS8B6B9eRK_gcyD6aZpg9w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>

Hi Benjamin,

On 01/04/2016 04:35 PM, Benjamin Tissoires wrote:
> Hi Allen,
> 
> On Mon, Dec 21, 2015 at 10:45 AM, Allen Hung <allen_hung@dell.com> wrote:
>> On 12/18/2015 05:52 AM, Benjamin Tissoires wrote:
>>> On Thu, Nov 26, 2015 at 3:21 PM, Jiri Kosina <jikos@kernel.org> wrote:
>>>> On Fri, 20 Nov 2015, Allen Hung wrote:
>>>>
>>>>> The usage Confidence is mandary to Windows Precision Touchpad devices. The
>>>>> appearance of this usage is checked in hidinput_connect but the quirk
>>>>> MT_QUIRK_VALID_IS_CONFIDENCE is not applied to device accordingly.
>>>>> Apply this quirk and also remove quirk MT_QUIRK_ALWAYS_VALID to enable palm
>>>>> rejection for the WIN 8 touchpad devices which have implemented usage
>>>>> Confidence in its input reports.
>>>>>
>>>>> Tested on Dell XPS 13 laptop.
>>>>>
>>>>> Signed-off-by: Allen Hung <allen_hung@dell.com>
>>>> Applied to for-4.5/multitouch. Thanks,
>>>>
>>> Allen, looks like the Dell XPS13 2015 (or was it the 2014?) has
>>> problems with your patch:
>>> https://bugzilla.redhat.com/show_bug.cgi?id=1292583 (we backported
>>> this change in the Fedora kernel 4.2.7).
>>>
>>> Would you mind checking that this patch does not create regressions on
>>> older series of laptops?
>>>
>>> Thanks in advance.
>>>
>>> Cheers,
>>> Benjamin
>> Hi Benjamin,
>>
>> It looks like a XPS13 2014 but I can confirm this with my colleagues who are in charge of this product line. I don't mind checking this patch with more older series of laptops. I will do it and let you know the status. Should I also test the machines with Fedora 23, or just go with Ubuntu OS? The XPS machines are shipped with Ubuntu.
>> Btw, the issue reporter said she/he cannot reproduce the issue (posted on Dec. 18).
>>
> 
> [Sorry for the late answer, but you guessed the holiday season did not help :)]
> 
> I think I'll just ask the reporter to confirm he can not reproduce and
> then close the downstream bug.
> Unless other people complains, I think we can just keep the current
> state and wait :)
> 
> Cheers,
> Benjamin
> 
My this patch 25a84db15b3f3a24d3ea7d2baf90693bcff34b0c (HID: multitouch: enable 
palm rejection if device implements confidence usage) brings side effect as
someone reported it on https://bugzilla.kernel.org/show_bug.cgi?id=112791
My fix is attached in the thread and please have a look at it and my reply in
comment #5 as the root cause.
Let me try to explain my fix here - the quirk MT_QUIRK_VALID_IS_CONFIDENCE 
is implemented in hid-multitouch and I see it was only applied to some
particular touchpad devices (see my list in the end) before my earlier patch
applies it to Windows 8 precision touchpad. I believe the quirk is working 
very well for the devices in list, and it must have some stories behind that
made the quirk designed in this way - simply dropped the reports with
[confidence = 0]. 
However, this quirk isn't working very properly for the Win8 precise touchpad.
I think when a touch is initially detected as finger then
later detected as a palm, the driver has to send the latter detections
to input/mt as calling input_mt_report_slot_state(input, MT_TOOL_FINGER, 
active=0). In order not to break the devices in list, I add a new quirk
MT_QUIRK_CONFIDENCE to do the work. Please provide your comments :)

Device list: 
MT_USB_DEVICE(USB_VENDOR_ID_3M,	USB_DEVICE_ID_3M1968)			
MT_USB_DEVICE(USB_VENDOR_ID_3M,	USB_DEVICE_ID_3M2256) 
MT_USB_DEVICE(USB_VENDOR_ID_3M,	USB_DEVICE_ID_3M3266) 
MT_USB_DEVICE(USB_VENDOR_ID_ASUS, USB_DEVICE_ID_ASUS_T91MT)
MT_USB_DEVICE(USB_VENDOR_ID_ASUS, USB_DEVICE_ID_ASUSTEK_MULTITOUCH_YFO) 
MT_USB_DEVICE(USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_TURBOX_TOUCHSCREEN_MOSART) 
MT_USB_DEVICE(USB_VENDOR_ID_QUANTA,	USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3001) 
MT_USB_DEVICE(USB_VENDOR_ID_STANTUM_STM, USB_DEVICE_ID_MTP_STM)

Regards,
Allen Hung
