From: Arek Burdach <arek.burdach@gmail.com>
Subject: Re: Missing release event for Synaptics touchscreen
Date: Tue, 9 May 2017 11:20:24 +0200
Message-ID: <4a35fbdc-b79f-dfc4-835d-f1339506c1c5@gmail.com>
References: <708339c2-2b70-81ae-a939-ac122e5fd6f2@gmail.com>
 <CAN+gG=FxbBc78Aw+WUxSFBfhTxbgGRJWTftgoRYYR-+1-OMioQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36790 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752815AbdEIJU1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 9 May 2017 05:20:27 -0400
Received: by mail-wr0-f196.google.com with SMTP id v42so12043908wrc.3
        for <linux-input@vger.kernel.org>; Tue, 09 May 2017 02:20:27 -0700 (PDT)
In-Reply-To: <CAN+gG=FxbBc78Aw+WUxSFBfhTxbgGRJWTftgoRYYR-+1-OMioQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: =?UTF-8?Q?St=c3=a9phane_Chatty?= <chatty@enac.fr>, Andrew Duggan <aduggan@synaptics.com>, linux-input <linux-input@vger.kernel.org>

Hi,

Thank you for response.

On 09.05.2017 10:35, Benjamin Tissoires wrote:
> On Sat, May 6, 2017 at 9:28 PM, Arek Burdach <arek.burdach@gmail.com> wrote:
>> Hi,
>>
>> A week ago I've reported a bug:
>> https://bugzilla.kernel.org/show_bug.cgi?id=195625 Is there anybody that can
>> help me with it?
> I can have a look at it.
> Please attach the full outputs of hid-recorder and evemu-record in the
> bugs, or it'll be difficult for us to debug it.
I've attached full logs for two situations. More details in the issue.


>> I found out that some touchpads (and possible touchscreens?) are handled by
>> both hid-multitouch and hid-rmi drivers. Is there a way to verify how the
>> touchscreen would work on hid-rmi drivers? I've tested it with kernel
>> 4.11.0-rc1 version where was this change:
>> 279967a65b320d174a507498aea7d44db3fee7f4 HID: rmi: Handle all Synaptics
>> touchpads using hid-rmi
>> which was reverted in later kernel's version. On this version, only my
>> touchpad was handled by hid-rmi, touchscreen was still handled by
>> hid-multitouch. Maybe I should change something in code or in compilation
>> configuration to force hid-rmi?
> Well, with 279967a65 applied, the system would know if the device can
> be handled through hid-rmi or not. If hid-multitouch was still used,
> that means that the device was not designed to be used as a rmi device
> at all (i.e. hid-rmi will not be able to talk to it).
In this patch, there is verified if hid group is 
HID_GROUP_MULTITOUCH_WIN_8. Maybe this touchscreen is in group with 
greater priority during recognition. Can I verify it somehow?

Also HID_GROUP_MULTITOUCH_WIN_8 recognition is done by this:
> usage == 0xff0000c5 && parser->global.report_count == 256 && 
> parser->global.report_size == 8
I assume that it is correct way to verify that. I wonder if it is 
possible that something changed for a new devices.

Cheers,
Arek

> Cheers,
> Benjamin
>
>> Or it is a wrong way to go? I would be grateful for your help.
>>
>> Regards,
>> Arek

