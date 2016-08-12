From: Stefan Seidel <lkml@stefanseidel.info>
Subject: Re: Sony Vaio Duo 11: getting middle mouse button to work
Date: Fri, 12 Aug 2016 22:02:17 +0200
Message-ID: <20160812220217.Horde.Qy2drCv8u1ERyS6ncKEFQx9@horde.stefanseidel.info>
References: <20160811232759.Horde.nOLGcvRFRNEDDDHWRQr1nXw@horde.stefanseidel.info>
 <20160812092907.GP17850@mail.corp.redhat.com>
 <20160812214125.Horde.1mqVDGLUmEhibnpDhJx6D4r@horde.stefanseidel.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.teration.net ([213.136.64.78]:59844 "EHLO
	mail.teration.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbcHLUCW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Aug 2016 16:02:22 -0400
In-Reply-To: <20160812214125.Horde.1mqVDGLUmEhibnpDhJx6D4r@horde.stefanseidel.info>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: smueller@chronox.de, jkosina@suse.cz, linux-input@vger.kernel.org

Hi,

after a little trial an error, I found out that the hidraw interface  
simplifies/abstracts a couple of things, and that the USB report  
return data included the report number (02), so all that is needed to  
switch between middle button = scroll and middle button = button2 is

echo -ne "\x02\x03\x00\x00\x00" | sudo tee /dev/hidraw1
and
echo -ne "\x02\x03\x01\x00\x00" | sudo tee /dev/hidraw1

Same would be

echo -ne "\x02\x06\x00\x00\x00" | sudo tee /dev/hidraw1
and
echo -ne "\x02\x06\x01\x00\x00" | sudo tee /dev/hidraw1

to toggle between tap-to-click and not. The device /dev/hidraw1 is from
dmesg | grep Crucialtek | grep hid

Thanks!!!

Stefan

On Fri 12 Aug 2016 09:41:25 PM CEST, Stefan Seidel  
<lkml@stefanseidel.info> wrote:


> Hi Benjamin,
>
> thanks.
>
>> The answer is different in the first case and 7 seconds after (I assume
>> you toggled the setting there) -> frame 16 and 33 in the first log.
>>
>> I'd say the first log would be:
>> - 1.  -> SET_IDLE (you can ignore it)
>> - 3.  -> SET_REPORT on OUTPUT 2, length 5 no data
>>      -> answer in 4.  -> 02 04 02 00 00
>> - 5.  -> SET CONFIGURATION Status (ignore this as well I think)
>> - 6.  -> SET_REPORT on OUTPUT 2, length 5 no data
>>      -> answer in 7.  -> 02 06 00 00 00
>> - 9.  -> SET_REPORT on OUTPUT 2, length 5 no data
>>      -> answer in 10. -> 02 05 01 00 00
>> - 12. -> SET_REPORT on OUTPUT 2, length 5 no data
>>      -> answer in 13. -> 02 02 01 00 00
>> - 16. -> SET_REPORT on OUTPUT 2, length 5 no data
>>      -> answer in 14. -> 02 03 01 00 00
>>
>> The second sequence (frames 18 to 34) provides the same output except
>> for the last answer 02 03 00 00 00.
>
> Yes, that was my analysis as well. Thanks for confirming this.
>
>> The "no data" part seems weird, but there is a chance if you output a
>> report with 02 03 00 00 00 or 02 03 01 00 00, this toggles the behavior.
>
> Yes, I was wondering about exactly that, maybe I need to read up on  
> the limitations of USBPcap to find out why apparently no outgoing  
> data is reported. But I will try sending it as you suggest.
>
>> If you start working in kernel space, start with a small hid driver and
>> in .probe() try accessing the device with the event sequences you got.
>>
>> If you start working with hidraw, there is an example in the kernel
>> tree: samples/hidraw/hid-example.c.
>
> Thanks for these hints! I realized I already did work on HID stuff  
> once when I amended a userspace program for a USB FM transmitter  
> that registered as HID device. I will try your suggestions.
>
> Stefan



