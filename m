From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Help writing a custom HID driver
Date: Thu, 6 Nov 2014 15:22:00 -0500
Message-ID: <CAN+gG=EZDBsRMgm7gmw3f0N88wPJEp2xADCwpcQivK88eiJthg@mail.gmail.com>
References: <545BBF05.9030203@mediacru.sh>
	<CAN+gG=HmEvPz0R5+tXJdVaUWyms1pd=LgnO+L+0owYRo2Jx4Uw@mail.gmail.com>
	<545BCBE9.6040309@mediacru.sh>
	<545BD794.7090002@mediacru.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:64263 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbaKFUWC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Nov 2014 15:22:02 -0500
Received: by mail-qc0-f179.google.com with SMTP id o8so1433448qcw.24
        for <linux-input@vger.kernel.org>; Thu, 06 Nov 2014 12:22:00 -0800 (PST)
In-Reply-To: <545BD794.7090002@mediacru.sh>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jose Diez <jose@mediacru.sh>
Cc: linux-input <linux-input@vger.kernel.org>

On Thu, Nov 6, 2014 at 3:18 PM, Jose Diez <jose@mediacru.sh> wrote:
> Okay, so I've solved the watchdog issue, and now I want the driver to be
> loaded automatically. I've copied the module to /lib/modules/<kernel>/ and
> run depmod -a, and I can see it in modules.alias, but it looks like
> hid_generic grabs it first upon boot - my module is loaded correctly, but it
> doesn't grab the HID device.
>
> If I `modprobe -r hid_generic` and then load my module, everything works
> correctly.

Yep. You need to add your device VendorID/ProductID in
hid_have_special_driver[] in hid-core.c.
This will tell hid-generic not to grab your device, and your custom
module will take over.

Cheers,
Benjamin

>
> On 06/11/14 19:28, Jose Diez wrote:
>>
>> Thanks Benjamin. That fixed the issue. Have a great day.
>>
>> On 06/11/14 18:57, Benjamin Tissoires wrote:
>>>
>>> Hi Jose,
>>>
>>> On Thu, Nov 6, 2014 at 1:33 PM, Jose Diez <jose@mediacru.sh> wrote:
>>>>
>>>> Hello linux-input,
>>>>
>>>> I'm trying to write a custom HID driver. It works fine, and I can send
>>>> reports just fine, but one of the requirements of this device is that I
>>>> have
>>>> to reply to reports with code 62 with another report with code 62, which
>>>> resets a watchdog in the device.
>>>>
>>>> This is my code so far: http://codepad.org/m4QiWhDt
>>>>
>>>> The problem is in line 40. It seems like I'm not allowed to call
>>>> hid_hw_output_report from the raw_event callback handler. I've tried
>>>> surrounding the call with spin_locks, but I still get the "scheduling
>>>> while
>>>> atomic" error.
>>>
>>> Yeah, when you are in the .event callback, you are basically called by
>>> an IRQ, so you can not schedule a potentially blocking operation.
>>>
>>>> I'm not sure how to approach this - can someone help? It would be much
>>>> appreciated. Thanks.
>>>
>>> I would use a worker to do what you are trying to do. You can have a
>>> look at the reset_worker we have in drivers/hid/hid-rmi.c.
>>> When the event is not one we expected, we schedule a worker thread
>>> which then sends an output report to the device. This way, the
>>> blocking operation is sent from a different thread than the IRQ one.
>>> It is kind of what you are willing to do.
>>> There are many other examples of workers in the hid subtree, or you
>>> can refer to the doc to find out more.
>>>
>>> Cheers,
>>> Benjamin
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
