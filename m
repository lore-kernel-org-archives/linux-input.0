From: Peter Olson <peter.olson@gmail.com>
Subject: Re: [PATCH] HID: wiimote: add Nintendo-Wii-Remote-Plus IDs
Date: Mon, 12 Nov 2012 18:53:01 -0800
Message-ID: <CAEfj2kC7hFeTpCSz+w9=HWG1qKrSY6x5FSo9kHwcqkWoEca+pQ@mail.gmail.com>
References: <1350895071-4017-1-git-send-email-dh.herrmann@googlemail.com>
 <alpine.LNX.2.00.1210221134580.12268@pobox.suse.cz> <CAEfj2kDDyXbLcJTrhmbrG2MedVcu9u5q6ZmfcRB-86Cc1Rm+Sw@mail.gmail.com>
 <CANq1E4TJPs0nHVmECkQU7pth6a7Dj7G6Pan00w+12FmhiVPpeA@mail.gmail.com>
 <CAEfj2kBMzvSF7XswQC7s_AuKJFnhtwAyXeM77wtRmKSM89UR6Q@mail.gmail.com>
 <CAEfj2kBfjzVp7+Zw+Cn2QfD_eCNz=Z5c1j-ku5vHxL5W-Zb_QA@mail.gmail.com> <CANq1E4T+s4igeAj-YN7nW=37UKcprmU_V9JgyML+H5E8eL3fLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:44679 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465Ab2KMCxd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Nov 2012 21:53:33 -0500
Received: by mail-we0-f174.google.com with SMTP id t9so3100153wey.19
        for <linux-input@vger.kernel.org>; Mon, 12 Nov 2012 18:53:31 -0800 (PST)
In-Reply-To: <CANq1E4T+s4igeAj-YN7nW=37UKcprmU_V9JgyML+H5E8eL3fLg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

RE: flashing LEDs, the LEDs are always flashing every connect. I
haven't had them once switch from all-flashing to having only LED1 (or
just any single LED) lit. Also, I've never heard of / used the sysfs
API, so I don't know how to test controlling the LEDs directly.

RE: dolphin-emu, Ok, after we have all the kinks worked out here, I'll
approach them separately to try and get their code updated.

RE: xwiishow, I use it by executing [xwiishow list] as a regular user.
I tried it as root once, just out of curiosity, but that made no
difference.

$ ls -l /sys/bus/hid/devices/
total 0
lrwxrwxrwx 1 root root 0 Nov 11 22:00 0003:046D:C068.0003 ->
../../../devices/pci0000:00/0000:00:1d.0/usb4/4-1/4-1.8/4-1.8:1.0/0003:046D:C068.0003
lrwxrwxrwx 1 root root 0 Nov 11 22:00 0003:046D:C068.0004 ->
../../../devices/pci0000:00/0000:00:1d.0/usb4/4-1/4-1.8/4-1.8:1.1/0003:046D:C068.0004
lrwxrwxrwx 1 root root 0 Nov 11 22:00 0003:046D:C31C.0001 ->
../../../devices/pci0000:00/0000:00:1d.0/usb4/4-1/4-1.5/4-1.5:1.0/0003:046D:C31C.0001
lrwxrwxrwx 1 root root 0 Nov 11 22:00 0003:046D:C31C.0002 ->
../../../devices/pci0000:00/0000:00:1d.0/usb4/4-1/4-1.5/4-1.5:1.1/0003:046D:C31C.0002
lrwxrwxrwx 1 root root 0 Nov 12 18:27 0005:057E:0330.0009 ->
../../../devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1:1.0/bluetooth/hci0/hci0:11/0005:057E:0330.0009

$ xwiishow /sys/bus/hid/devices/0005:057E:0330.0009
Cannot open core iface '/sys/bus/hid/devices/0005:057E:0330.0009' err:-13
$ sudo xwiishow /sys/bus/hid/devices/0005:057E:0330.0009
Cannot open core iface '/sys/bus/hid/devices/0005:057E:0330.0009' err:-22

Note that <dev> here isn't the bluetooth address of the device, but I
chose the one that was a symlink with /bluetooth/ in the path. Let me
know if I should try one of the other devices.

RE: dmesg looks fine, The part that I thought might be of note is the
"unknown main item", the wiimote_battery "failed to report" and
wiimote "Remote error" lines.

[327837.064631] wiimote 0005:057E:0330.0009: unknown main item tag 0x0
[327837.064675] wiimote 0005:057E:0330.0009: hidraw4: BLUETOOTH HID
v0.01 Gamepad [Nintendo RVL-CNT-01-TR] on 00:02:72:1A:BD:94
[327837.064752] input: Nintendo Wii Remote Accelerometer as
/devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1:1.0/bluetooth/hci0/hci0:11/0005:057E:0330.0009/input/input55
[327837.064851] input: Nintendo Wii Remote IR as
/devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1:1.0/bluetooth/hci0/hci0:11/0005:057E:0330.0009/input/input56
[327837.064929] input: Nintendo Wii Remote as
/devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1:1.0/bluetooth/hci0/hci0:11/0005:057E:0330.0009/input/input57
[327838.062520] power_supply wiimote_battery: driver failed to report
`capacity' property: -5
[327838.062590] Registered led device: 0005:057E:0330.0009:blue:p0
[327838.062614] Registered led device: 0005:057E:0330.0009:blue:p1
[327838.062633] Registered led device: 0005:057E:0330.0009:blue:p2
[327838.062652] Registered led device: 0005:057E:0330.0009:blue:p3
[327838.062706] input: Nintendo Wii Remote Extension as
/devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1:1.0/bluetooth/hci0/hci0:11/0005:057E:0330.0009/input/input58
[327838.063066] input: Nintendo Wii Remote Motion+ as
/devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1:1.0/bluetooth/hci0/hci0:11/0005:057E:0330.0009/input/input59
[327838.063271] wiimote 0005:057E:0330.0009: New device registered
[327838.084053] wiimote 0005:057E:0330.0009: Remote error 2 on req 17
[327838.107769] wiimote 0005:057E:0330.0009: Remote error 2 on req 18
[327838.115268] wiimote 0005:057E:0330.0009: Remote error 2 on req 18
[328766.162283] wiimote 0005:057E:0330.0009: Device removed
[328768.159395] power_supply wiimote_battery: driver failed to report
`capacity' property: -5

Speaking of fun dmesg messages, I got this when I tried re-connecting
my wiimote after connecting and disconnecting it as shown just above:
http://pastebin.com/ehjvfpcf

I get a similar looking dump if I try connecting again, and now
bluetooth is just confused on my machine. I'll have to reboot before
trusting any further output from the computer on this mater.

Hopefully the early part of this email will help you solve the general
issue (with xwiishow and such). Please let me know if I should worry
about the crash-dump in the later part of this email, or if I should
just reboot and ignore it for now.

Thanks for you time trying to get this all working!
Peter


On Mon, Nov 12, 2012 at 4:41 AM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> Hi Peter
>
> On Mon, Nov 12, 2012 at 7:19 AM, Peter Olson <peter.olson@gmail.com> wrote:
>> (If I'm over-documenting my process, sorry, just wanted it as a record
>> for myself as well) Summary at bottom, oneline is progress but not
>> complete success yet.
>>
>> Ok, now built bluez with the patch from "[PATCH bluez] wiimote: add
>> Wii-Remote-Plus ID and name detection" with one modification to fit
>> with the current code that I have (bluez-4.101):
>> -+       memcpy(pinbuf, adapter_get_address(adapter), 6);
>> ++       memcpy(pinbuf, &sba, 6);
>> I grabbed bluez-4.101 from the Archlinux ABS, pulled the sources
>> "makepkg -o", applied the patch (change to plugins/wiimote.c) with the
>> change from {adapter_get_address(adapter) => &sba}, then had ABS
>> finish making and installing with "makepkg -ei".
>>
>> As my desktop system has been updated since last time I tested this
>> (moved to systemd, new linux kernel and more) I decided to re-grab the
>> kernel and rebuild the hid modules. Grabbed base/linux from Arch ABS,
>> pulled sources, applied the patch to the two files
>> (drivers/hid/hid-ids.h and drivers/hid/hid-wiimote-core.c), and then
>> built the kernel "makepkg -e". I then reloaded all of the hid modules
>> to make sure I had the latest versions loaded.
>>
>> $ sudo modprobe hid-wiimote (to make sure all dependencies were loaded)
>> $ sudo rmmod hid_wiimote
>> $ sudo rmmod usbhid
>> $ sudo rmmod hid_generic
>> $ sudo rmmod hid
>> $ sudo insmod ./hid.ko
>> $ sudo insmod ./hid-generic.ko
>> $ sudo insmod ./usbhid/usbhid.ko
>> $ sudo insmod ./hid-wiimote.ko
>>
>> Then I plugged in my USB bluetooth module, and started the bluetooth
>> service (systemctl start bluetooth).
>> Then I started blueman-applet, had it search, and it saw the wiimote.
>> I clicked pair, and it properly connected with the Wiimote. I clicked
>> Setup, (*) Connect to Input Service, => Forward, and it said it
>> properly connected.
>
> Yeah, that's how it is supposed to work. Seems like the new Wii
> Remotes require Authentication. I will push the changes to
> bluez-upstream so bluez-5.0 (the next release) will include them.
> Thanks for testing!
>
>> Checking dmesg:
>> [247627.881346] hid-generic 0005:057E:0330.0005: unknown main item tag 0x0
>> [247627.881478] input: Nintendo RVL-CNT-01-TR as
>> /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1:1.0/bluetooth/hci0/hci0:12/input21
>> [247627.881725] hid-generic 0005:057E:0330.0005: input,hidraw4:
>> BLUETOOTH HID v0.01 Gamepad [Nintendo RVL-CNT-01-TR] on
>> 00:02:72:1A:BD:94
>
> Yeah, that means the device isn't listed in "hid_have_special_driver".
> Therefore, the generic driver picks up the device.
>
>> Ok, something had issues from the kernel side of things connecting to
>> the correct input device. Now going to add:
>> +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_NINTENDO,
>> USB_DEVICE_ID_NINTENDO_WIIMOTE_2) },
>> to the hid_have_special_driver[] array in drivers/hid/hid-core.c. This
>> doesn't seem like it should make a difference, as for some reason it
>> was recognizing the hid-wiimote device in my email on 10/22 without
>> this change.
>
> I really wonder why that worked. Maybe there is some user-space code
> that rewrites the PID/VID under some circumstances to the old Wii
> Remote values or your Wii Remote uses occasionally the old values when
> using auto-reconnect. I have no idea, but I actually don't care that
> much, since as long as we add all IDs, we are on the safe side.
>
> Anyway, if you see any pattern in the VID/PID selection, feel free to
> report these. All the Wii Remote protocol/behavior was
> reverse-engineered so we can never be sure that we got it right.
>
>> SIDE NOTE: All throughout this issue with the kernel module changes,
>> the bluez changes seem to be working. I connected the wiimote by
>> pressing the red button in the battery compartment, and now if I shut
>> down the wiimote (hold power button) and turn it back on,
>> blueman-applet pops up a dialog asking if I want to reconnect. Also,
>> the four LEDs on the bottom of the wiimote have kept flashing
>> continuously for minutes, rather then just the 30 seconds or so that
>> it usually blinks for when trying to connect. Finally, the
>> blueman-applet icon has stayed green during this time, also indicating
>> that the computer thinks that it's remaining connected as well. All of
>> this leads me to believe that the bluez patch is working as intended.
>
> The flashing of the LEDs is a bug. Normally, after connection
> establishment only LED1 should be on. You can then change the LEDs via
> the sysfs API. Anyway, sometimes LEDs just keep flashing, in which
> case I simply reconnect the devices and it works.
>
>> Neither xwiishow nor dolphin-emu detect a wiimote connected, but that
>> could be the kernel module's fault.
>
> dolphin-emu doesn't use this driver. They use their own
> implementation, see here:
> http://code.google.com/p/dolphin-emu/source/browse/Source/Core/Core/Src/HW/WiimoteReal/IONix.cpp
>
> If it is not working, please report a bug to their bugtracker. I have
> never used dolphin-emu, so I cannot help you here, sorry.
>
>> Back to the kernel module. The addition to hid_have_special_driver[]
>> has been made as well as the previous patch. Kernel rebuild and
>> rmmod/insmod all hid modules.
>>
>> dmesg success! (Note that I don't have the numchuck plugged in in these tests)
>> [254328.057515] wiimote 0005:057E:0330.0005: unknown main item tag 0x0
>> [254328.057682] wiimote 0005:057E:0330.0005: hidraw4: BLUETOOTH HID
>> v0.01 Gamepad [Nintendo RVL-CNT-01-TR] on 00:02:72:1A:BD:94
>> [254328.057786] input: Nintendo Wii Remote Accelerometer as
>> /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1:1.0/bluetooth/hci0/hci0:11/0005:057E:0330.0005/input/input35
>> [254328.058005] input: Nintendo Wii Remote IR as
>> /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1:1.0/bluetooth/hci0/hci0:11/0005:057E:0330.0005/input/input36
>> [254328.058113] input: Nintendo Wii Remote as
>> /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1:1.0/bluetooth/hci0/hci0:11/0005:057E:0330.0005/input/input37
>> [254329.055694] power_supply wiimote_battery: driver failed to report
>> `capacity' property: -5
>> [254329.055768] Registered led device: 0005:057E:0330.0005:blue:p0
>> [254329.055793] Registered led device: 0005:057E:0330.0005:blue:p1
>> [254329.055813] Registered led device: 0005:057E:0330.0005:blue:p2
>> [254329.055832] Registered led device: 0005:057E:0330.0005:blue:p3
>> [254329.055887] input: Nintendo Wii Remote Extension as
>> /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1:1.0/bluetooth/hci0/hci0:11/0005:057E:0330.0005/input/input38
>> [254329.056025] input: Nintendo Wii Remote Motion+ as
>> /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1:1.0/bluetooth/hci0/hci0:11/0005:057E:0330.0005/input/input39
>> [254329.056176] wiimote 0005:057E:0330.0005: New device registered
>> [254329.074105] wiimote 0005:057E:0330.0005: Remote error 2 on req 17
>> [254329.102911] wiimote 0005:057E:0330.0005: Remote error 2 on req 18
>> [254329.109150] wiimote 0005:057E:0330.0005: Remote error 2 on req 18
>>
>> However, there are some errors reported, and xwiishow still does not
>> report any wiimotes found. Does xwiishow need to be updated as well?
>
> How do you invoke xwiishow? If it does not work, please try using:
>
> ls -l /sys/bus/hid/devices/
>
> This should list all connected Wii Remotes. xwiishow just tries to
> read these values.
> Your system-log looks fine, nothing wrong there. The device is
> detected and initialized properly and the sysfs attributes are
> created.
>
>> After playing for a bit trying to get any response, I shut down the
>> wiimote by the power button, and dmesg reported the change:
>> [254578.785557] wiimote 0005:057E:0330.0005: Device removed
>> [254580.787965] power_supply wiimote_battery: driver failed to report
>> `capacity' property: -5
>
> That seems fine, too.
>
>> One more time I powered on the wiimote, clicked Accept on the
>> Bluetooth Authentication dialog from blueman-applet, waited a few
>> seconds, and then powered down the wiimote. Below is the dmesg log
>> from start to finish.
>> [254639.813654] wiimote 0005:057E:0330.0006: unknown main item tag 0x0
>> [254639.813714] wiimote 0005:057E:0330.0006: hidraw4: BLUETOOTH HID
>> v0.01 Gamepad [Nintendo RVL-CNT-01-TR] on 00:02:72:1A:BD:94
>> [254639.813738] input: Nintendo Wii Remote Accelerometer as
>> /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1:1.0/bluetooth/hci0/hci0:11/0005:057E:0330.0006/input/input40
>> [254639.813779] input: Nintendo Wii Remote IR as
>> /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1:1.0/bluetooth/hci0/hci0:11/0005:057E:0330.0006/input/input41
>> [254639.813821] input: Nintendo Wii Remote as
>> /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1:1.0/bluetooth/hci0/hci0:11/0005:057E:0330.0006/input/input42
>> [254640.813251] power_supply wiimote_battery: driver failed to report
>> `capacity' property: -5
>> [254640.813323] Registered led device: 0005:057E:0330.0006:blue:p0
>> [254640.813348] Registered led device: 0005:057E:0330.0006:blue:p1
>> [254640.813358] Registered led device: 0005:057E:0330.0006:blue:p2
>> [254640.813367] Registered led device: 0005:057E:0330.0006:blue:p3
>> [254640.813396] input: Nintendo Wii Remote Extension as
>> /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1:1.0/bluetooth/hci0/hci0:11/0005:057E:0330.0006/input/input43
>> [254640.813746] input: Nintendo Wii Remote Motion+ as
>> /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1:1.0/bluetooth/hci0/hci0:11/0005:057E:0330.0006/input/input44
>> [254640.813817] wiimote 0005:057E:0330.0006: New device registered
>> [254640.848031] wiimote 0005:057E:0330.0006: Remote error 2 on req 17
>> [254640.871769] wiimote 0005:057E:0330.0006: Remote error 2 on req 18
>> [254640.879275] wiimote 0005:057E:0330.0006: Remote error 2 on req 18
>> [254678.447402] wiimote 0005:057E:0330.0006: Device removed
>> [254680.452375] power_supply wiimote_battery: driver failed to report
>> `capacity' property: -5
>>
>>
>> Summary, with the bluez patch (plus one change), and the kernel module
>> patch (plus hid_have_special_driver[] change) I now have the wiimote
>> connecting to the computer when I hit any button on the Wiimote. The
>> computer recognizes the wiimote as shown in dmesg. However, there are
>> some errors, and xwiishow still does not detect that any wiimote has
>> been connected with the computer.
>>
>> Please let me know if there's anything further I can test, I believe
>> that more changes are needed before I can actually use the wiimote
>> with dolphin-emu or anything else.
>
> Your logs all look fine. If "xwiishow list" doesn't show anything,
> then please try:
>
> ./xwiishow /sys/bus/hid/devices/<dev>
>
> Where <dev> is the bluetooth address of your device. You should be
> able to find this with bash-tab-completion.
>
> Thanks a lot for testing this! It really looks like everything is
> working, except xwiishow seems to be unable to find the device via
> sysfs, which is odd. The content of /sys/bus/hid/devices/ while a Wii
> Remote is connected would really help.
>
> Thanks
> David
