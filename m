From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Inactive keyboard on Acer Aspire Switch 11
Date: Fri, 27 Feb 2015 08:58:55 -0500
Message-ID: <CAN+gG=EgysAhgOcwa9nweWrW3HR6ceK6SYhRDJfz=RzrhiVw4A@mail.gmail.com>
References: <54EFA9CF.6000100@butterbrot.org>
	<CAN+gG=Fsu5rPFGMtKyOtQsCazL4MZgYX6bx1WsybH5Zj-Hg=ZQ@mail.gmail.com>
	<54F0540C.9000509@butterbrot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:45211 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbbB0N64 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2015 08:58:56 -0500
Received: by mail-qg0-f42.google.com with SMTP id z107so14106016qgd.1
        for <linux-input@vger.kernel.org>; Fri, 27 Feb 2015 05:58:56 -0800 (PST)
In-Reply-To: <54F0540C.9000509@butterbrot.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-input <linux-input@vger.kernel.org>

On Fri, Feb 27, 2015 at 6:25 AM, Florian Echtler <floe@butterbrot.org> wrote:
> Hello Benjamin,
>
> On 27.02.2015 01:46, Benjamin Tissoires wrote:
>> On Thu, Feb 26, 2015 at 6:18 PM, Florian Echtler <floe@butterbrot.org> wrote:
>>> The device in question has two endpoints:
>>>
>>> T:  Bus=02 Lev=02 Prnt=04 Port=02 Cnt=01 Dev#=  7 Spd=12  MxCh= 0
>>> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
>>> P:  Vendor=06cb ProdID=2991 Rev=00.06
>>> S:  Manufacturer=ITE Tech. Inc.
>>> S:  Product=ITE Device(8595)
>>> C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
>>> I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
>>> I:  If#= 1 Alt= 0 #EPs= 2 Cls=03(HID  ) Sub=01 Prot=02 Driver=usbhid
>>>
>>> According to lsusb, the second one is a mouse (= touchpad), while the
>>> first one is a keyboard (see attached lsusb.txt). Judging from the
>>> dmesg, this is also the one which fails to initialize. Can anyone
>>> suggest any quirks/fixes to try here?
>>
>> Hi Florian,
>>
>> This was a known bug which has been fixed in a more recent kernel than
>> 3.16. I think a 3.17 might work, but I think a 3.18 would be a better
>> choice.
>> cf: e19ff99f256aeeff6c07b373e01883b72e049552 in Linus' tree
>
> thanks for the quick reply. I've tried both 3.18.7 and 3.19.0 kernels,
> but still get (slightly different) error messages:
>
> [    2.550306] hidraw: raw HID events driver (C) Jiri Kosina
> [    2.877672] hid (null): usage index exceeded
> [    2.927474] usbcore: registered new interface driver usbhid
> [    2.927476] usbhid: USB HID core driver
> [    3.135496] i2c_hid i2c-ITE8380:00: error in i2c_hid_init_report
> size:19 / ret_size:18
> [    3.150002] hid-multitouch 0018:06CB:77B2.0002: input,hidraw0:
> <UNKNOWN> HID v1.00 Mouse [SYNA7508:00 06CB:77B2] on
> [    3.150784] hid-multitouch 0003:06CB:2991.0004:
> input,hiddev0,hidraw1: USB HID v1.10 Mouse [ITE Tech. Inc. ITE
> Device(8595)] on usb-0000:00:14.0-4.3/input1
> [    3.153892] hid-generic 0003:06CB:2991.0003: usage index exceeded
> [    3.153896] hid-generic 0003:06CB:2991.0003: item 0 2 2 2 parsing failed
> [    3.153921] hid-generic: probe of 0003:06CB:2991.0003 failed with
> error -22

Ouch. Now that I can see that, I remember that there was a half-backed
solution here:
https://patchwork.kernel.org/patch/5737231/

>
> After a bit of digging through the kernel code, could it be that the
> 06CB:2991 device needs to be added to the hid_have_special_driver list
> (which AFAICT will only appear in 4.0)?
>

If you just add the VID/PID to hid_have_special_driver, and nowhere
else, your device will not work at all, nor the touchpad which shares
the same VID/PID (see Andrew's answer).
So this won't do :(

Cheers,
Benjamin

> Best regards, Florian
> --
> SENT FROM MY DEC VT50 TERMINAL
>
