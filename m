From: Marcelo Ricardo Leitner <mleitner@redhat.com>
Subject: Re: [RFC PATCH] hid-sony: fix troubles with Sony remote clones
Date: Tue, 18 Dec 2012 10:33:44 -0200
Message-ID: <50D062A8.3080503@redhat.com>
References: <20121214205734.7d1ab9d8@redhat.com> <alpine.LNX.2.00.1212162136250.27319@pobox.suse.cz>
Reply-To: mleitner@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:65393 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754738Ab2LRMe2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Dec 2012 07:34:28 -0500
In-Reply-To: <alpine.LNX.2.00.1212162136250.27319@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, linux-input@vger.kernel.org

Em 16-12-2012 18:37, Jiri Kosina escreveu:
> On Fri, 14 Dec 2012, Mauro Carvalho Chehab wrote:
>
>> There are some Sony clone gamepads that are incompatible
>> with PS3 since firmware 3.50, as they decided to prevent those
>> devices to work, without any good technical reason. I was one of those
>> 'blessed' people affected by their niceness with their customers.
>>
>> Marcelo also has another device with a similar problem.
>>
>> Perhaps due to Sony's way to block the device, damaging the device's
>> eeprom, or perhaps because they just have a different, broken Report
>> descriptor, there are 3 buttons that don't work on both devices
>> (the ones equivalent to square, round and X).
>>
>> What it happens is that the descriptor generate weird EV_ABS events
>> to those buttons, instead of EV_MSC/EV_KEY.
>>
>> A fix that seems to be enough for them is to return the original
>> sixaxis table instead of the broken one. That's what this patch
>> does.
>>
>> Yet, there are some missing entries at the used keytable. On my
>> tests, all keys are now producing the right events, but the reported
>> keycodes look weird:
>>
>> "square" key: (Button.0010 = 1)
>>
>> 1355524363.460835: event type EV_MSC(0x04): scancode = 0x90010
>> 1355524363.460835: event type EV_KEY(0x01) key_up: BTN_DEAD(0x0001)
>>
>> "round" key: (Button.000e = 1)
>>
>> 1355524410.908705: event type EV_MSC(0x04): scancode = 0x9000e
>> 1355524410.908705: event type EV_KEY(0x01) key_down: (0x0001)
>> 1355524410.971788: event type EV_MSC(0x04): scancode = 0x9000e
>> 1355524410.971788: event type EV_KEY(0x01) key_up: (0x0001)
>>
>> "X" key: (Button.000f = 1)
>> 1355524384.880813: event type EV_MSC(0x04): scancode = 0x9000f
>> 1355524384.880813: event type EV_KEY(0x01) key_down: (0x0001)
>> 1355524384.979815: event type EV_MSC(0x04): scancode = 0x9000f
>> 1355524384.979815: event type EV_KEY(0x01) key_up: (0x0001)
>>
>> The rationale is likely due to those entries at rdesc table, where the
>> Kernel were not likely able to parse:
>>
>> Button.000d ---> Key.?
>> Button.000e ---> Key.?
>> Button.000f ---> Key.?
>> Button.0010 ---> Key.BtnDead
>> Button.0011 ---> Key.?
>> Button.0012 ---> Key.?
>> Button.0013 ---> Key.?
>>
>> As a reference, this is the rdisc used on my clone (a Mad Catz
>> model 8846):
>>
>> 05 01 09 04 a1 01 a1 02 85 01 75 08 95 01 15 00 26 ff 00 81 03 75 01 95 0d 15 00 25 01 35 00 45 01 05 09 19 01 29 0d 81 02 75 01 95 03 06 00 ff 81 03 05 01 25 07 46 3b 01 75 04 95 01 65 14 09 39 81 42 65 00 75 01 95 0c 06 00 ff 81 03 15 00 26 ff 00 05 01 09 01 a1 00 75 08 95 04 15 00 15 00 15 00 35 00 35 00 46 ff 00 09 30 09 31 09 32 09 35 81 02 c0 05 01 75 08 95 27 09 01 81 02 75 08 95 30 09 01 91 02 75 08 95 30 09 01 b1 02 c0 a1 02 85 02 75 08 95 30 09 01 b1 02 c0 a1 02 85 ee 75 08 95 30 09 01 b1 02 c0 a1 02 85 ef 75 08 95 30 09 01 b1 02 c0 c0
>>
>> This is what's returned on Marcelo's device (not sure what is
>> the brand name of his device):
>>
>> 05 01 09 04 a1 01 a1 02 85 01 75 08 95 01 15 00 26 ff 00 81 03 75 01 95 13 15 00 25 01 35 00 45 01 05 09 19 01 29 13 81 02 75 01 95 0d 06 00 ff 81 03 15 00 26 ff 00 05 01 09 01 a1 00 75 08 95 04 35 00 46 ff 00 09 30 09 31 09 32 09 35 81 02 c0 05 01 95 13 09 01 81 02 95 0c 81 01 75 10 95 04 26 ff 03 46 ff 03 09 01 81 02 c0 a1 02 85 02 75 08 95 30 09 01 b1 02 c0 a1 02 85 ee 75 08 95 30 09 01 b1 02 c0 a1 02 85 ef 75 08 95 30 09 01 b1 02 c0 c0
>>
>> Reported-by: Marcelo Leitner <mleitner@redhat.com>
>> Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
>
> Yeah, this is the way I'd like to have it fixed.
>
> Waiting for Marcelo's Tested-by: before merging it.

Hey, this patch works very nice, in the sense that now all buttons 
generate KEY events although some with weird meanings.. but that is 
topic for the next patch.

So I'm happy with the results of this one. Any report I should present 
for confirmation or not needed?

My dmesg output:
 

Dec 18 10:30:43 localhost kernel: [ 2908.370116] usb 2-1.1: new 
full-speed USB device number 5 using ehci_hcd 

Dec 18 10:30:43 localhost kernel: [ 2908.458218] usb 2-1.1: New USB 
device found, idVendor=054c, idProduct=0268 

Dec 18 10:30:43 localhost kernel: [ 2908.458225] usb 2-1.1: New USB 
device strings: Mfr=1, Product=2, SerialNumber=0 

Dec 18 10:30:43 localhost kernel: [ 2908.458229] usb 2-1.1: Product: PC 
USB Controller 

Dec 18 10:30:43 localhost kernel: [ 2908.458233] usb 2-1.1: 
Manufacturer: Gamepad 

Dec 18 10:30:43 localhost kernel: [ 2908.460529] sony 
0003:054C:0268.0004: Sony Sixaxis clone detected. Using original report 
descriptor (size: 184 clone; 148 new)
Dec 18 10:30:43 localhost kernel: [ 2908.461973] input: Gamepad PC USB 
Controller as 
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.1/2-1.1:1.0/input/input19
Dec 18 10:30:43 localhost kernel: [ 2908.462675] sony 
0003:054C:0268.0004: input,hiddev0,hidraw1: USB HID v1.11 Joystick 
[Gamepad PC USB Controller] on usb-0000:00:1d.0-1.1/input0

Previously there was no Sixaxis quirk being loaded for this one.

And /sys/kernel/debug/hid/<ID>/rdesc now is identical to the original 
Sixaxis.

Thanks Mauro, great job in there!

Marcelo.

