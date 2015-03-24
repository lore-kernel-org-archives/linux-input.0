From: =?UTF-8?B?U2ltb24gV8O2cm5lcg==?= <linux@simon-woerner.de>
Subject: Re: [PATCH] HID: Add driver for acer keybard with broken rdesc
Date: Tue, 24 Mar 2015 17:03:26 +0100
Message-ID: <55118ACE.9090309@simon-woerner.de>
References: <54C85FB5.9050404@simon-woerner.de>	<1422492195-11492-1-git-send-email-linux@simon-woerner.de>	<alpine.LNX.2.00.1502171329340.2279@pobox.suse.cz>	<54E3F287.3040900@synaptics.com> <CAN+gG=F=aGvK85zpAHKSeaHrNtytsuiDBUDPWx1MkrBq3DyU6w@mail.gmail.com> <54F07F0F.9040408@butterbrot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from brief.guru ([5.9.209.54]:35631 "EHLO brief.guru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753867AbbCXQKn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Mar 2015 12:10:43 -0400
In-Reply-To: <54F07F0F.9040408@butterbrot.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Andrew Duggan <aduggan@synaptics.com>
Cc: Jiri Kosina <jkosina@suse.cz>, =?UTF-8?B?U2ltb24gV8O2cm5lcg==?= <linux@simon-woerner.de>, linux-input <linux-input@vger.kernel.org>, Andrew Duggan <andrew.duggan@gmail.com>

On 27.02.2015 15:28, Florian Echtler wrote:
> Just as a quick side note, Simon's "hack" compiled as a standalone
> module fixes the issue for me on stock kernel 3.16.0 - keyboard works
> perfectly now. So device 06CB:2991 has exactly the same broken
> descriptor and should probably included in any future solution.
Okay, i will include it.
> Many thanks to everyone involved!
>
> Best, Florian
>
> On 27.02.2015 15:16, Benjamin Tissoires wrote:
>> [adding Florian to the thread, he is also affected by this]
>>
>> On Tue, Feb 17, 2015 at 9:01 PM, Andrew Duggan<aduggan@synaptics.com=
>  wrote:
>>> On 02/17/2015 04:30 AM, Jiri Kosina wrote:
>>>> On Thu, 29 Jan 2015,linux@simon-woerner.de  wrote:
>>>>
>>>>> From: Simon W=C3=B6rner<mail@simon-woerner.de>
>>>>>
>>>>> HID: Add driver for acer keybard with broken rdesc
>>>> Hi Simon,
>>>>
>>>> to make sure proper device <-> driver binding is performed, you al=
so have
>>>> to add device ID to the hid_have_special_driver[] array.
>>>>
>> To the cost of an error in the kernel log, the proper binding will b=
e
>> done even if if there is no entry in hid_have_special_driver :)
>>
>> See Florian's log:
>> [    3.153892] hid-generic 0003:06CB:2991.0003: usage index exceeded
>> [    3.153896] hid-generic 0003:06CB:2991.0003: item 0 2 2 2 parsing=
 failed
>> [    3.153921] hid-generic: probe of 0003:06CB:2991.0003 failed with=
 error -22
>>
>> So hid-generic will fail to bind the device, so normally hid-acer
>> should bind it, fix the report descriptor and the keyboard should be
>> working.
>>
>> Not very clean, but it should work :)
The other solutions looks like more work and at least some other proble=
ms.
So this "best" and preferred solution, or did i got any thing wrong?
>>> I have been meaning to respond to this patch. Unfortunately, simply=
 adding
>>> this driver to the hid_have_special_driver[] list will prevent
>>> hid-multitouch from binding to the touchpad which shares the same v=
id and
>>> pid. My suggestion would be to create a new scan_flag for GD_KEYBOA=
RD and to
>>> add to the code in hid_scan_collection() which scans the GENDESK us=
ages.
>>> Similar to the code which is searching for HID_GD_POINTER. Then in
>>> hid_scan_report() we could assign a group for this driver based on =
the pid
>>> and the GD_KEYBOARD scan flag in the vendor handling code.
>> This could work, but that means that the list of special quirks afte=
r
>> the parsing is going to explode :(
>>
>> Plus we have to be sure that the scan_report doesn't fail or we will
>> not be able to tag the device correctly.
>>
>>> I can help out with implementing this part of the patch if there ar=
en't any
>>> other suggestions. Adding a new group and more code to the hid_scan=
_report()
>>> vendor handling code is definately not ideal. But, I am not sure of=
 a better
>>> way of binding different sub drivers to devices with the same vid a=
nd pid.
>>>
>>> An alternative would be to have hid-rmi handle all Synaptics touchp=
ads, even
>>> the ones which currently use hid-multitouch. Then the keyboard repo=
rt
>>> descriptor fixup could just be handled in hid-rmi. Accessing the fi=
nger data
>>> via rmi mode would also have the benefit of being able to report ev=
ents
>>> which are currently not supported by the PTP collection (ie ABS_MT_=
PRESSURE,
>>> ABS_MT_TOUCH_MAJOR/MINOR). The touchpads which currently use hid-mu=
ltitouch
>>> report finger data a little differently then the ones currently usi=
ng
>>> hid-rmi so there is some work which would need to be done to add su=
pport for
>>> them in hid-rmi.
>>>
>> I am not sure we want to do that. Because we don't want hid-rmi to f=
ix
>> all crappy keyboards around when the OEM reuses the synaptics PID.
>>
>> Maybe a better way of handling such situation is to provide a generi=
c
>> mechanism to overwrite/patch the report descriptor so that we could
>> get rid of the drivers which just fix the report descriptor.
>> I have on a branch a version where I look into /lib/firmware/hid if
>> there is a matching device and a matching report descriptor. Then, I
>> read this firmware dynamically and patch the report descriptor.
>> This however requires that the hid modules are not included directly
>> in the kernel, or the /lib/firmware dir is not available and the
>> device doesn't bind.
>>
>> Cheers,
>> Benjamin
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-inpu=
t" in
>> the body of a message tomajordomo@vger.kernel.org
>> More majordomo info athttp://vger.kernel.org/majordomo-info.html
>>

Is there any point i missed or we're good to go now? (expect the new=20
device id)

Greets,
Simon
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
