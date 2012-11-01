From: Peter Olson <peter.olson@gmail.com>
Subject: Re: [PATCH] HID: wiimote: add Nintendo-Wii-Remote-Plus IDs
Date: Wed, 31 Oct 2012 21:46:16 -0700
Message-ID: <CAEfj2kBMzvSF7XswQC7s_AuKJFnhtwAyXeM77wtRmKSM89UR6Q@mail.gmail.com>
References: <1350895071-4017-1-git-send-email-dh.herrmann@googlemail.com>
 <alpine.LNX.2.00.1210221134580.12268@pobox.suse.cz> <CAEfj2kDDyXbLcJTrhmbrG2MedVcu9u5q6ZmfcRB-86Cc1Rm+Sw@mail.gmail.com>
 <CANq1E4TJPs0nHVmECkQU7pth6a7Dj7G6Pan00w+12FmhiVPpeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:62445 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263Ab2KAEqs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Nov 2012 00:46:48 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so1082425eek.19
        for <linux-input@vger.kernel.org>; Wed, 31 Oct 2012 21:46:46 -0700 (PDT)
In-Reply-To: <CANq1E4TJPs0nHVmECkQU7pth6a7Dj7G6Pan00w+12FmhiVPpeA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Apologies for the long delay and fairly content-less reply here. I am
planning on continuing testing this, but we're in the middle of a
sprint/scrum at work, and I've not had much time to play with
programming outside of work. The sprint should be wrapping up Friday,
and hopefully this weekend / next week I'll be able to get back to
this and test it with the BlueZ patch.

I did not modify the "hid_have_special_driver[]" array at all, I
simply changed the two lines in the original patch (files
drivers/hid/hid-ids.h and drivers/hid/hid-wiimote-core.c). It did not
identify the bluetooth device when I simply (re)loaded the newly built
hid-wiimote.ko. But when I reloaded all of the newly built hid*.ko
files as I indicated before, then it showed that it properly
identified the Nintendo Wiimote in dmesg.

I tried re-connecting the wiimote and running xwiishow immediately
after blueman said it was connected, but it didn't work then either.
Looking back at dmesg it appeared that it lost the device quicker then
that original connection showed.

Anyhow, I hope to get you more detailed results in about a week.
Please let me know if you have any specific logs I should get or tests
I should perform. Otherwise I'll continue with the plan of
patching/building/installing BlueZ with your changes.

Peter

On Wed, Oct 24, 2012 at 11:42 AM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> Hi Peter
>
> On Tue, Oct 23, 2012 at 6:42 AM, Peter Olson <peter.olson@gmail.com> wrote:
>> I didn't feel up to reinstalling my entire kernel, so I just rebuilt
>> the kernel and insmod'd the hid ko files.
>>
>> Before the new module was loaded, dmesg gave:
>> [335678.959554] hid-generic 0005:057E:0330.0005: unknown main item tag 0x0
>> [335678.959749] input: Nintendo RVL-CNT-01-TR as
>> /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1.1/3-1.1.1:1.0/bluetooth/hci0/hci0:11/input38
>> [335678.959995] hid-generic 0005:057E:0330.0005: input,hidraw4:
>> BLUETOOTH HID v0.01 Gamepad [Nintendo RVL-CNT-01-TR] on
>> 09:B2:62:50:84:91
>> [335746.899830] hid-generic 0005:057E:0330.0006: unknown main item tag 0x0
>> [335746.899965] input: Nintendo RVL-CNT-01-TR as
>> /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1.1/3-1.1.1:1.0/bluetooth/hci0/hci0:12/input39
>> [335746.900067] hid-generic 0005:057E:0330.0006: input,hidraw4:
>> BLUETOOTH HID v0.01 Gamepad [Nintendo RVL-CNT-01-TR] on
>> 09:B2:62:50:84:91
>>
>> Then I reloaded the kernel modules:
>> $ sudo rmmod hid_wiimote
>> $ sudo rmmod usbhid
>> $ sudo rmmod hidp
>> $ sudo rmmod hid_generic
>> $ sudo insmod ./hid.ko
>> $ sudo insmod ./hid-generic.ko
>> $ sudo insmod ./usbhid/usbhid.ko
>> $ sudo insmod ./hid-wiimote.ko
>> $ sudo modprobe hidp
>>
>> Afterward dmesg said:
>> [335937.601486] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
>> [335957.615400] wiimote 0005:057E:0330.000B: unknown main item tag 0x0
>> [335957.615525] wiimote 0005:057E:0330.000B: hidraw4: BLUETOOTH HID
>> v0.01 Gamepad [Nintendo RVL-CNT-01-TR] on 09:B2:62:50:84:91
>> [335957.615578] input: Nintendo Wii Remote Accelerometer as
>> /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1.1/3-1.1.1:1.0/bluetooth/hci0/hci0:12/0005:057E:0330.000B/input/input44
>> [335957.615724] input: Nintendo Wii Remote IR as
>> /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1.1/3-1.1.1:1.0/bluetooth/hci0/hci0:12/0005:057E:0330.000B/input/input45
>> [335957.615822] input: Nintendo Wii Remote as
>> /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1.1/3-1.1.1:1.0/bluetooth/hci0/hci0:12/0005:057E:0330.000B/input/input46
>> [335958.612615] power_supply wiimote_battery: driver failed to report
>> `capacity' property: -5
>> [335958.612688] Registered led device: 0005:057E:0330.000B:blue:p0
>> [335958.612713] Registered led device: 0005:057E:0330.000B:blue:p1
>> [335958.612734] Registered led device: 0005:057E:0330.000B:blue:p2
>> [335958.612755] Registered led device: 0005:057E:0330.000B:blue:p3
>> [335958.612812] input: Nintendo Wii Remote Extension as
>> /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1.1/3-1.1.1:1.0/bluetooth/hci0/hci0:12/0005:057E:0330.000B/input/input47
>> [335958.613495] input: Nintendo Wii Remote Motion+ as
>> /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1.1/3-1.1.1:1.0/bluetooth/hci0/hci0:12/0005:057E:0330.000B/input/input48
>> [335958.613648] wiimote 0005:057E:0330.000B: New device registered
>> [335960.612211] power_supply wiimote_battery: driver failed to report
>> `capacity' property: -5
>> [335978.686281] wiimote 0005:057E:0330.000B: Device removed
>> [335980.695131] power_supply wiimote_battery: driver failed to report
>> `capacity' property: -5
>
> This is weird. Why does that patch work for you? Did you add the ID to
> the "hid_have_special_driver[]" array? Because without it this
> shouldn't work at all.
>
> The log shows that the device is properly connected. And it takes 20
> seconds until the device is automatically removed. So if you call
> "xwiishow" in between these 20s then it should show up.
>
> 20s is actually the timeout that the Wii Remote uses during discovery.
> Maybe this is really because the device isn't bonded. Can you try the
> bluez patch I posted and connect _with_ bonding/authentication. So
> don't select "without PIN" during connection.
> With the bluez patch bluez will automatically generate the PIN and you
> shouldn't be prompted for PIN input anymore.
>
>> (Note, This has the motion plus built in, and I had the numchuck connected)
>>
>> However, xwiishow still doesn't recognize the device:
>> $ xwiishow list
>> Listing connected Wii Remote devices:
>> End of device list
>>
>> Please let me know if you need further testing for the kernel patch.
>> I'll reply to the github post for xwiimote to follow up on that issue.
>>
>> Peter
>
> Thanks a lot for testing this!
> David
