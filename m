From: Peter Olson <peter.olson@gmail.com>
Subject: Re: [PATCH] HID: wiimote: add Nintendo-Wii-Remote-Plus IDs
Date: Mon, 22 Oct 2012 21:42:42 -0700
Message-ID: <CAEfj2kDDyXbLcJTrhmbrG2MedVcu9u5q6ZmfcRB-86Cc1Rm+Sw@mail.gmail.com>
References: <1350895071-4017-1-git-send-email-dh.herrmann@googlemail.com> <alpine.LNX.2.00.1210221134580.12268@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:43912 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885Ab2JWEnP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Oct 2012 00:43:15 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so1821636wey.19
        for <linux-input@vger.kernel.org>; Mon, 22 Oct 2012 21:43:13 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1210221134580.12268@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: David Herrmann <dh.herrmann@googlemail.com>, linux-input@vger.kernel.org

I didn't feel up to reinstalling my entire kernel, so I just rebuilt
the kernel and insmod'd the hid ko files.

Before the new module was loaded, dmesg gave:
[335678.959554] hid-generic 0005:057E:0330.0005: unknown main item tag 0x0
[335678.959749] input: Nintendo RVL-CNT-01-TR as
/devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1.1/3-1.1.1:1.0/bluetooth/hci0/hci0:11/input38
[335678.959995] hid-generic 0005:057E:0330.0005: input,hidraw4:
BLUETOOTH HID v0.01 Gamepad [Nintendo RVL-CNT-01-TR] on
09:B2:62:50:84:91
[335746.899830] hid-generic 0005:057E:0330.0006: unknown main item tag 0x0
[335746.899965] input: Nintendo RVL-CNT-01-TR as
/devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1.1/3-1.1.1:1.0/bluetooth/hci0/hci0:12/input39
[335746.900067] hid-generic 0005:057E:0330.0006: input,hidraw4:
BLUETOOTH HID v0.01 Gamepad [Nintendo RVL-CNT-01-TR] on
09:B2:62:50:84:91

Then I reloaded the kernel modules:
$ sudo rmmod hid_wiimote
$ sudo rmmod usbhid
$ sudo rmmod hidp
$ sudo rmmod hid_generic
$ sudo insmod ./hid.ko
$ sudo insmod ./hid-generic.ko
$ sudo insmod ./usbhid/usbhid.ko
$ sudo insmod ./hid-wiimote.ko
$ sudo modprobe hidp

Afterward dmesg said:
[335937.601486] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[335957.615400] wiimote 0005:057E:0330.000B: unknown main item tag 0x0
[335957.615525] wiimote 0005:057E:0330.000B: hidraw4: BLUETOOTH HID
v0.01 Gamepad [Nintendo RVL-CNT-01-TR] on 09:B2:62:50:84:91
[335957.615578] input: Nintendo Wii Remote Accelerometer as
/devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1.1/3-1.1.1:1.0/bluetooth/hci0/hci0:12/0005:057E:0330.000B/input/input44
[335957.615724] input: Nintendo Wii Remote IR as
/devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1.1/3-1.1.1:1.0/bluetooth/hci0/hci0:12/0005:057E:0330.000B/input/input45
[335957.615822] input: Nintendo Wii Remote as
/devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1.1/3-1.1.1:1.0/bluetooth/hci0/hci0:12/0005:057E:0330.000B/input/input46
[335958.612615] power_supply wiimote_battery: driver failed to report
`capacity' property: -5
[335958.612688] Registered led device: 0005:057E:0330.000B:blue:p0
[335958.612713] Registered led device: 0005:057E:0330.000B:blue:p1
[335958.612734] Registered led device: 0005:057E:0330.000B:blue:p2
[335958.612755] Registered led device: 0005:057E:0330.000B:blue:p3
[335958.612812] input: Nintendo Wii Remote Extension as
/devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1.1/3-1.1.1:1.0/bluetooth/hci0/hci0:12/0005:057E:0330.000B/input/input47
[335958.613495] input: Nintendo Wii Remote Motion+ as
/devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1.1/3-1.1.1:1.0/bluetooth/hci0/hci0:12/0005:057E:0330.000B/input/input48
[335958.613648] wiimote 0005:057E:0330.000B: New device registered
[335960.612211] power_supply wiimote_battery: driver failed to report
`capacity' property: -5
[335978.686281] wiimote 0005:057E:0330.000B: Device removed
[335980.695131] power_supply wiimote_battery: driver failed to report
`capacity' property: -5

(Note, This has the motion plus built in, and I had the numchuck connected)

However, xwiishow still doesn't recognize the device:
$ xwiishow list
Listing connected Wii Remote devices:
End of device list

Please let me know if you need further testing for the kernel patch.
I'll reply to the github post for xwiimote to follow up on that issue.

Peter

P.S. Sorry Jiri for sending you two emails, but I realized I hadn't
replied to all before.

On Mon, Oct 22, 2012 at 2:36 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Mon, 22 Oct 2012, David Herrmann wrote:
>
>> The newest revision of the Nintendo Wii Remote Plus uses new VID/PIDs. We
>> already support these devices so we can simply add the IDs.
>>
>> Reported-by: Peter Olson <peter.olson@gmail.com>
>> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
>> ---
>> Hi Jiri
>>
>> I am actually not sure why Nintendo changed the VID/PID for the newest
>> revisions. I have a WiimotePlus which uses the old IDs and works fine. However,
>> the Windows WiiMote driver developers reported to me that the protocol stayed
>> the same so I just added the IDs.
>> Please wait before applying this until I get a "Tested-by" from Peter (CC'ed).
>
> Sure, thanks, waiting for the Tested-by: tag.
>
> But I guess you also need the device id added to
> hid_have_special_driver[], which is missing in the patch ...
>
>>
>> Thanks
>> David
>>
>>  drivers/hid/hid-ids.h          | 1 +
>>  drivers/hid/hid-wiimote-core.c | 2 ++
>>  2 files changed, 3 insertions(+)
>>
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index 753f3d6..b5c2231 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -583,6 +583,7 @@
>>
>>  #define USB_VENDOR_ID_NINTENDO               0x057e
>>  #define USB_DEVICE_ID_NINTENDO_WIIMOTE       0x0306
>> +#define USB_DEVICE_ID_NINTENDO_WIIMOTE_2 0x0330
>>
>>  #define USB_VENDOR_ID_NOVATEK                0x0603
>>  #define USB_DEVICE_ID_NOVATEK_PCT    0x0600
>> diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
>> index 84e2fbe..c8a4325 100644
>> --- a/drivers/hid/hid-wiimote-core.c
>> +++ b/drivers/hid/hid-wiimote-core.c
>> @@ -1283,6 +1283,8 @@ static void wiimote_hid_remove(struct hid_device *hdev)
>>  static const struct hid_device_id wiimote_hid_devices[] = {
>>       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_NINTENDO,
>>                               USB_DEVICE_ID_NINTENDO_WIIMOTE) },
>> +     { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_NINTENDO,
>> +                             USB_DEVICE_ID_NINTENDO_WIIMOTE_2) },
>>       { }
>>  };
>>  MODULE_DEVICE_TABLE(hid, wiimote_hid_devices);
>> --
>> 1.7.12.4
>>
>
> --
> Jiri Kosina
> SUSE Labs
