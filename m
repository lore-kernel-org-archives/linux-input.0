From: Peter Olson <peter.olson@gmail.com>
Subject: Re: [PATCH] HID: wiimote: add Nintendo-Wii-Remote-Plus IDs
Date: Sun, 11 Nov 2012 22:19:44 -0800
Message-ID: <CAEfj2kBfjzVp7+Zw+Cn2QfD_eCNz=Z5c1j-ku5vHxL5W-Zb_QA@mail.gmail.com>
References: <1350895071-4017-1-git-send-email-dh.herrmann@googlemail.com>
 <alpine.LNX.2.00.1210221134580.12268@pobox.suse.cz> <CAEfj2kDDyXbLcJTrhmbrG2MedVcu9u5q6ZmfcRB-86Cc1Rm+Sw@mail.gmail.com>
 <CANq1E4TJPs0nHVmECkQU7pth6a7Dj7G6Pan00w+12FmhiVPpeA@mail.gmail.com> <CAEfj2kBMzvSF7XswQC7s_AuKJFnhtwAyXeM77wtRmKSM89UR6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:35996 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab2KLGUQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Nov 2012 01:20:16 -0500
Received: by mail-ea0-f174.google.com with SMTP id o11so109113eaa.19
        for <linux-input@vger.kernel.org>; Sun, 11 Nov 2012 22:20:15 -0800 (PST)
In-Reply-To: <CAEfj2kBMzvSF7XswQC7s_AuKJFnhtwAyXeM77wtRmKSM89UR6Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

(If I'm over-documenting my process, sorry, just wanted it as a record
for myself as well) Summary at bottom, oneline is progress but not
complete success yet.

Ok, now built bluez with the patch from "[PATCH bluez] wiimote: add
Wii-Remote-Plus ID and name detection" with one modification to fit
with the current code that I have (bluez-4.101):
-+       memcpy(pinbuf, adapter_get_address(adapter), 6);
++       memcpy(pinbuf, &sba, 6);
I grabbed bluez-4.101 from the Archlinux ABS, pulled the sources
"makepkg -o", applied the patch (change to plugins/wiimote.c) with the
change from {adapter_get_address(adapter) => &sba}, then had ABS
finish making and installing with "makepkg -ei".

As my desktop system has been updated since last time I tested this
(moved to systemd, new linux kernel and more) I decided to re-grab the
kernel and rebuild the hid modules. Grabbed base/linux from Arch ABS,
pulled sources, applied the patch to the two files
(drivers/hid/hid-ids.h and drivers/hid/hid-wiimote-core.c), and then
built the kernel "makepkg -e". I then reloaded all of the hid modules
to make sure I had the latest versions loaded.

$ sudo modprobe hid-wiimote (to make sure all dependencies were loaded)
$ sudo rmmod hid_wiimote
$ sudo rmmod usbhid
$ sudo rmmod hid_generic
$ sudo rmmod hid
$ sudo insmod ./hid.ko
$ sudo insmod ./hid-generic.ko
$ sudo insmod ./usbhid/usbhid.ko
$ sudo insmod ./hid-wiimote.ko

Then I plugged in my USB bluetooth module, and started the bluetooth
service (systemctl start bluetooth).
Then I started blueman-applet, had it search, and it saw the wiimote.
I clicked pair, and it properly connected with the Wiimote. I clicked
Setup, (*) Connect to Input Service, => Forward, and it said it
properly connected.

Checking dmesg:
[247627.881346] hid-generic 0005:057E:0330.0005: unknown main item tag 0x0
[247627.881478] input: Nintendo RVL-CNT-01-TR as
/devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1:1.0/bluetooth/hci0/hci0:12/input21
[247627.881725] hid-generic 0005:057E:0330.0005: input,hidraw4:
BLUETOOTH HID v0.01 Gamepad [Nintendo RVL-CNT-01-TR] on
00:02:72:1A:BD:94

Ok, something had issues from the kernel side of things connecting to
the correct input device. Now going to add:
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_NINTENDO,
USB_DEVICE_ID_NINTENDO_WIIMOTE_2) },
to the hid_have_special_driver[] array in drivers/hid/hid-core.c. This
doesn't seem like it should make a difference, as for some reason it
was recognizing the hid-wiimote device in my email on 10/22 without
this change.

SIDE NOTE: All throughout this issue with the kernel module changes,
the bluez changes seem to be working. I connected the wiimote by
pressing the red button in the battery compartment, and now if I shut
down the wiimote (hold power button) and turn it back on,
blueman-applet pops up a dialog asking if I want to reconnect. Also,
the four LEDs on the bottom of the wiimote have kept flashing
continuously for minutes, rather then just the 30 seconds or so that
it usually blinks for when trying to connect. Finally, the
blueman-applet icon has stayed green during this time, also indicating
that the computer thinks that it's remaining connected as well. All of
this leads me to believe that the bluez patch is working as intended.
Neither xwiishow nor dolphin-emu detect a wiimote connected, but that
could be the kernel module's fault.

Back to the kernel module. The addition to hid_have_special_driver[]
has been made as well as the previous patch. Kernel rebuild and
rmmod/insmod all hid modules.

dmesg success! (Note that I don't have the numchuck plugged in in these tests)
[254328.057515] wiimote 0005:057E:0330.0005: unknown main item tag 0x0
[254328.057682] wiimote 0005:057E:0330.0005: hidraw4: BLUETOOTH HID
v0.01 Gamepad [Nintendo RVL-CNT-01-TR] on 00:02:72:1A:BD:94
[254328.057786] input: Nintendo Wii Remote Accelerometer as
/devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1:1.0/bluetooth/hci0/hci0:11/0005:057E:0330.0005/input/input35
[254328.058005] input: Nintendo Wii Remote IR as
/devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1:1.0/bluetooth/hci0/hci0:11/0005:057E:0330.0005/input/input36
[254328.058113] input: Nintendo Wii Remote as
/devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1:1.0/bluetooth/hci0/hci0:11/0005:057E:0330.0005/input/input37
[254329.055694] power_supply wiimote_battery: driver failed to report
`capacity' property: -5
[254329.055768] Registered led device: 0005:057E:0330.0005:blue:p0
[254329.055793] Registered led device: 0005:057E:0330.0005:blue:p1
[254329.055813] Registered led device: 0005:057E:0330.0005:blue:p2
[254329.055832] Registered led device: 0005:057E:0330.0005:blue:p3
[254329.055887] input: Nintendo Wii Remote Extension as
/devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1:1.0/bluetooth/hci0/hci0:11/0005:057E:0330.0005/input/input38
[254329.056025] input: Nintendo Wii Remote Motion+ as
/devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1:1.0/bluetooth/hci0/hci0:11/0005:057E:0330.0005/input/input39
[254329.056176] wiimote 0005:057E:0330.0005: New device registered
[254329.074105] wiimote 0005:057E:0330.0005: Remote error 2 on req 17
[254329.102911] wiimote 0005:057E:0330.0005: Remote error 2 on req 18
[254329.109150] wiimote 0005:057E:0330.0005: Remote error 2 on req 18

However, there are some errors reported, and xwiishow still does not
report any wiimotes found. Does xwiishow need to be updated as well?

After playing for a bit trying to get any response, I shut down the
wiimote by the power button, and dmesg reported the change:
[254578.785557] wiimote 0005:057E:0330.0005: Device removed
[254580.787965] power_supply wiimote_battery: driver failed to report
`capacity' property: -5


One more time I powered on the wiimote, clicked Accept on the
Bluetooth Authentication dialog from blueman-applet, waited a few
seconds, and then powered down the wiimote. Below is the dmesg log
from start to finish.
[254639.813654] wiimote 0005:057E:0330.0006: unknown main item tag 0x0
[254639.813714] wiimote 0005:057E:0330.0006: hidraw4: BLUETOOTH HID
v0.01 Gamepad [Nintendo RVL-CNT-01-TR] on 00:02:72:1A:BD:94
[254639.813738] input: Nintendo Wii Remote Accelerometer as
/devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1:1.0/bluetooth/hci0/hci0:11/0005:057E:0330.0006/input/input40
[254639.813779] input: Nintendo Wii Remote IR as
/devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1:1.0/bluetooth/hci0/hci0:11/0005:057E:0330.0006/input/input41
[254639.813821] input: Nintendo Wii Remote as
/devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1:1.0/bluetooth/hci0/hci0:11/0005:057E:0330.0006/input/input42
[254640.813251] power_supply wiimote_battery: driver failed to report
`capacity' property: -5
[254640.813323] Registered led device: 0005:057E:0330.0006:blue:p0
[254640.813348] Registered led device: 0005:057E:0330.0006:blue:p1
[254640.813358] Registered led device: 0005:057E:0330.0006:blue:p2
[254640.813367] Registered led device: 0005:057E:0330.0006:blue:p3
[254640.813396] input: Nintendo Wii Remote Extension as
/devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1:1.0/bluetooth/hci0/hci0:11/0005:057E:0330.0006/input/input43
[254640.813746] input: Nintendo Wii Remote Motion+ as
/devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1:1.0/bluetooth/hci0/hci0:11/0005:057E:0330.0006/input/input44
[254640.813817] wiimote 0005:057E:0330.0006: New device registered
[254640.848031] wiimote 0005:057E:0330.0006: Remote error 2 on req 17
[254640.871769] wiimote 0005:057E:0330.0006: Remote error 2 on req 18
[254640.879275] wiimote 0005:057E:0330.0006: Remote error 2 on req 18
[254678.447402] wiimote 0005:057E:0330.0006: Device removed
[254680.452375] power_supply wiimote_battery: driver failed to report
`capacity' property: -5


Summary, with the bluez patch (plus one change), and the kernel module
patch (plus hid_have_special_driver[] change) I now have the wiimote
connecting to the computer when I hit any button on the Wiimote. The
computer recognizes the wiimote as shown in dmesg. However, there are
some errors, and xwiishow still does not detect that any wiimote has
been connected with the computer.

Please let me know if there's anything further I can test, I believe
that more changes are needed before I can actually use the wiimote
with dolphin-emu or anything else.

Peter


On Wed, Oct 31, 2012 at 9:46 PM, Peter Olson <peter.olson@gmail.com> wrote:
> Apologies for the long delay and fairly content-less reply here. I am
> planning on continuing testing this, but we're in the middle of a
> sprint/scrum at work, and I've not had much time to play with
> programming outside of work. The sprint should be wrapping up Friday,
> and hopefully this weekend / next week I'll be able to get back to
> this and test it with the BlueZ patch.
>
> I did not modify the "hid_have_special_driver[]" array at all, I
> simply changed the two lines in the original patch (files
> drivers/hid/hid-ids.h and drivers/hid/hid-wiimote-core.c). It did not
> identify the bluetooth device when I simply (re)loaded the newly built
> hid-wiimote.ko. But when I reloaded all of the newly built hid*.ko
> files as I indicated before, then it showed that it properly
> identified the Nintendo Wiimote in dmesg.
>
> I tried re-connecting the wiimote and running xwiishow immediately
> after blueman said it was connected, but it didn't work then either.
> Looking back at dmesg it appeared that it lost the device quicker then
> that original connection showed.
>
> Anyhow, I hope to get you more detailed results in about a week.
> Please let me know if you have any specific logs I should get or tests
> I should perform. Otherwise I'll continue with the plan of
> patching/building/installing BlueZ with your changes.
>
> Peter
>
> On Wed, Oct 24, 2012 at 11:42 AM, David Herrmann
> <dh.herrmann@googlemail.com> wrote:
>> Hi Peter
>>
>> On Tue, Oct 23, 2012 at 6:42 AM, Peter Olson <peter.olson@gmail.com> wrote:
>>> I didn't feel up to reinstalling my entire kernel, so I just rebuilt
>>> the kernel and insmod'd the hid ko files.
>>>
>>> Before the new module was loaded, dmesg gave:
>>> [335678.959554] hid-generic 0005:057E:0330.0005: unknown main item tag 0x0
>>> [335678.959749] input: Nintendo RVL-CNT-01-TR as
>>> /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1.1/3-1.1.1:1.0/bluetooth/hci0/hci0:11/input38
>>> [335678.959995] hid-generic 0005:057E:0330.0005: input,hidraw4:
>>> BLUETOOTH HID v0.01 Gamepad [Nintendo RVL-CNT-01-TR] on
>>> 09:B2:62:50:84:91
>>> [335746.899830] hid-generic 0005:057E:0330.0006: unknown main item tag 0x0
>>> [335746.899965] input: Nintendo RVL-CNT-01-TR as
>>> /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1.1/3-1.1.1:1.0/bluetooth/hci0/hci0:12/input39
>>> [335746.900067] hid-generic 0005:057E:0330.0006: input,hidraw4:
>>> BLUETOOTH HID v0.01 Gamepad [Nintendo RVL-CNT-01-TR] on
>>> 09:B2:62:50:84:91
>>>
>>> Then I reloaded the kernel modules:
>>> $ sudo rmmod hid_wiimote
>>> $ sudo rmmod usbhid
>>> $ sudo rmmod hidp
>>> $ sudo rmmod hid_generic
>>> $ sudo insmod ./hid.ko
>>> $ sudo insmod ./hid-generic.ko
>>> $ sudo insmod ./usbhid/usbhid.ko
>>> $ sudo insmod ./hid-wiimote.ko
>>> $ sudo modprobe hidp
>>>
>>> Afterward dmesg said:
>>> [335937.601486] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
>>> [335957.615400] wiimote 0005:057E:0330.000B: unknown main item tag 0x0
>>> [335957.615525] wiimote 0005:057E:0330.000B: hidraw4: BLUETOOTH HID
>>> v0.01 Gamepad [Nintendo RVL-CNT-01-TR] on 09:B2:62:50:84:91
>>> [335957.615578] input: Nintendo Wii Remote Accelerometer as
>>> /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1.1/3-1.1.1:1.0/bluetooth/hci0/hci0:12/0005:057E:0330.000B/input/input44
>>> [335957.615724] input: Nintendo Wii Remote IR as
>>> /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1.1/3-1.1.1:1.0/bluetooth/hci0/hci0:12/0005:057E:0330.000B/input/input45
>>> [335957.615822] input: Nintendo Wii Remote as
>>> /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1.1/3-1.1.1:1.0/bluetooth/hci0/hci0:12/0005:057E:0330.000B/input/input46
>>> [335958.612615] power_supply wiimote_battery: driver failed to report
>>> `capacity' property: -5
>>> [335958.612688] Registered led device: 0005:057E:0330.000B:blue:p0
>>> [335958.612713] Registered led device: 0005:057E:0330.000B:blue:p1
>>> [335958.612734] Registered led device: 0005:057E:0330.000B:blue:p2
>>> [335958.612755] Registered led device: 0005:057E:0330.000B:blue:p3
>>> [335958.612812] input: Nintendo Wii Remote Extension as
>>> /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1.1/3-1.1.1:1.0/bluetooth/hci0/hci0:12/0005:057E:0330.000B/input/input47
>>> [335958.613495] input: Nintendo Wii Remote Motion+ as
>>> /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1.1/3-1.1.1:1.0/bluetooth/hci0/hci0:12/0005:057E:0330.000B/input/input48
>>> [335958.613648] wiimote 0005:057E:0330.000B: New device registered
>>> [335960.612211] power_supply wiimote_battery: driver failed to report
>>> `capacity' property: -5
>>> [335978.686281] wiimote 0005:057E:0330.000B: Device removed
>>> [335980.695131] power_supply wiimote_battery: driver failed to report
>>> `capacity' property: -5
>>
>> This is weird. Why does that patch work for you? Did you add the ID to
>> the "hid_have_special_driver[]" array? Because without it this
>> shouldn't work at all.
>>
>> The log shows that the device is properly connected. And it takes 20
>> seconds until the device is automatically removed. So if you call
>> "xwiishow" in between these 20s then it should show up.
>>
>> 20s is actually the timeout that the Wii Remote uses during discovery.
>> Maybe this is really because the device isn't bonded. Can you try the
>> bluez patch I posted and connect _with_ bonding/authentication. So
>> don't select "without PIN" during connection.
>> With the bluez patch bluez will automatically generate the PIN and you
>> shouldn't be prompted for PIN input anymore.
>>
>>> (Note, This has the motion plus built in, and I had the numchuck connected)
>>>
>>> However, xwiishow still doesn't recognize the device:
>>> $ xwiishow list
>>> Listing connected Wii Remote devices:
>>> End of device list
>>>
>>> Please let me know if you need further testing for the kernel patch.
>>> I'll reply to the github post for xwiimote to follow up on that issue.
>>>
>>> Peter
>>
>> Thanks a lot for testing this!
>> David
