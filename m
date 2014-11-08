From: Maximilien Levesque <maximilien.levesque@gmail.com>
Subject: Re: Aorus X3+ touchpad not working
Date: Sat, 8 Nov 2014 14:55:46 +0100
Message-ID: <CAJdy7pLP5x1b7Lt3Zj4q2Krs1C2uXw6T95_7eTsy0FwKVubBuA@mail.gmail.com>
References: <CAJdy7pJpbyYHuOg3AWnDJap=T9z0bUCZkM+DRuuTLUFj129H_w@mail.gmail.com>
 <CAN+gG=F7d+37kKF=s-_jLVd+=oqCjaNNQW084eKnYBREEZF14w@mail.gmail.com>
 <545B7C0D.8020401@redhat.com> <CAJdy7pL0NMYKtUA5JpxZ8M9kJwfZffaZ1gh-PyC9OY6dRf8Kvw@mail.gmail.com>
 <545B8B04.8070706@redhat.com> <20141108084125.GF21475@dtor-ws> <545DEC92.10903@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:52265 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716AbaKHN42 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 8 Nov 2014 08:56:28 -0500
Received: by mail-la0-f46.google.com with SMTP id gm9so5655038lab.5
        for <linux-input@vger.kernel.org>; Sat, 08 Nov 2014 05:56:26 -0800 (PST)
In-Reply-To: <545DEC92.10903@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>

Hi,

Thanks for the analysis and the advice.
I tested i8042.reset=1 and touchpad's still dead.

Best,
Max

On Sat, Nov 8, 2014 at 11:12 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 11/08/2014 09:41 AM, Dmitry Torokhov wrote:
>> On Thu, Nov 06, 2014 at 03:51:48PM +0100, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 11/06/2014 03:13 PM, Maximilien Levesque wrote:
>>>> Hi,
>>>> Thanks for your time!
>>>> Below is the output of dmesg with kernel boot parameter i8042.debug=1
>>>> All the best,
>>>
>>> Thanks, I'm afraid reading raw i8042 is not my forte though, Dmitry, can
>>> you take a look, and do you see why no ps/2 mouse (or touchpad) is seen ?
>>
>> ...
>>
>>>> [    1.901600] input: AT Translated Set 2 keyboard as
>>>> /devices/platform/i8042/serio0/input/input4
>>>> [    1.901749] i8042: [3] d4 -> i8042 (command)
>>>> [    1.901809] i8042: [3] f2 -> i8042 (parameter)
>>
>> ...
>> No ACK to GET_ID
>>
>>>> [    2.101556] i8042: [53] d4 -> i8042 (command)
>>>> [    2.101622] i8042: [53] ed -> i8042 (parameter)
>>
>> Trying LEDs - no response - not a keyboard, atkbd signs out
>>
>>>> [    2.165646] usb 1-2: new low-speed USB device number 2 using xhci_hcd
>>>> [    2.185660] usb 3-1: new high-speed USB device number 2 using ehci-pci
>>>> [    2.205674] usb 4-1: new high-speed USB device number 2 using ehci-pci
>>>> [    2.301725] i8042: [103] 60 -> i8042 (command)
>>>> [    2.301796] i8042: [103] 45 -> i8042 (parameter)
>>
>> Close AUX port
>>
>>>> [    2.301911] i8042: [103] 60 -> i8042 (command)
>>>> [    2.302025] i8042: [103] 47 -> i8042 (parameter)
>>
>> Enables AUX port again (to clear state - needed on some boxes)
>>
>>>> [    2.302094] i8042: [103] d4 -> i8042 (command)
>>>> [    2.302212] i8042: [103] f2 -> i8042 (parameter)
>>
>> psmouse - GET_ID - silence. So we decide there is no mouse.
>
> Dmitry, thanks for the analysis.
>
> So if I understand things correctly, then the aux port also gets
> probed for it having a second keyboard attached ? I did not know
> that, could it be that this confuses the touchpad?
>
>> Have we tried i8042.reset?
>
> No not yet. Maximilien, can you try booting with
> i8042.reset=1 on the kernel commandline ?
>
> Regards,
>
> Hans
