From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH v2] HID: wacom: ask for a in-prox report when it was missed
Date: Mon, 16 Mar 2015 11:53:58 -0700
Message-ID: <CANRwn3R7nBPxPynexP+yU43puxgNmj=35ghh01ioUqmNjdTy+g@mail.gmail.com>
References: <1425595014-23048-1-git-send-email-benjamin.tissoires@redhat.com>
	<alpine.LNX.2.00.1503161549020.25438@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:33873 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935026AbbCPSyA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Mar 2015 14:54:00 -0400
In-Reply-To: <alpine.LNX.2.00.1503161549020.25438@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Ping Cheng <pinglinux@gmail.com>, Linux Input <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org

On 3/16/2015 7:50 AM, Jiri Kosina wrote:
> On Thu, 5 Mar 2015, Benjamin Tissoires wrote:
>
>> If noone listens to the input device when a tool comes in proximity,
>> the tablet does not send the in-prox event when a client becomes ava=
ilable.
>> That means that no events will be sent until the tool is taken out o=
f
>> proximity.
>>
>> In this situation, ask for the report WACOM_REPORT_INTUOSREAD which =
will
>> read the corresponding feature and generate an in-prox event.
>> To make some generation of hardware working, we need to unset the
>> quirk NO_GET set by hid-core because the interfaces are seen as "boo=
t
>> mouse".
>>
>> We don't schedule this read in a worker while we are in an IO interr=
upt.
>> We know that usbhid will do it asynchronously. If this is triggered =
by
>> uhid, then this is obviously a client side bug :)
>>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> Ping, Jason, I'd like to get your Ack on this before pushing this thr=
ough
> if possible.
>
> Thanks.
>

This update seems to have solved the issue I was having earlier. I do
still see some weird behavior with the Intuos3 though. For whatever
reason, if a tool is in prox and no client is connected, the device
will repeatedly connect and disconnect from the bus. For example,
while sitting at a VT after connecting the device:

[  209.890431] usb 2-1.5.4: new full-speed USB device number 10 using e=
hci-pci
[  209.992189] input: Wacom Intuos3 6x8 as
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.5/2-1.5.4/2-1.5.4:1.0/000=
3:056A:00B1.0009/input/input26
[  209.992475] input: Wacom Intuos3 6x8 Pad as
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.5/2-1.5.4/2-1.5.4:1.0/000=
3:056A:00B1.0009/input/input27
[  209.992846] wacom 0003:056A:00B1.0009: hidraw4: USB HID v1.00 Mouse
[Tablet PTZ-630] on usb-0000:00:1d.0-1.5.4/input0
[  213.022545] usb 2-1.5.4: USB disconnect, device number 10
[  213.344055] usb 2-1.5.4: new full-speed USB device number 11 using e=
hci-pci
[  213.445779] input: Wacom Intuos3 6x8 as
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.5/2-1.5.4/2-1.5.4:1.0/000=
3:056A:00B1.000A/input/input28
[  213.446185] input: Wacom Intuos3 6x8 Pad as
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.5/2-1.5.4/2-1.5.4:1.0/000=
3:056A:00B1.000A/input/input29
[  213.446703] wacom 0003:056A:00B1.000A: hidraw4: USB HID v1.00 Mouse
[Tablet PTZ-630] on usb-0000:00:1d.0-1.5.4/input0
[  214.815925] usb 2-1.5.4: USB disconnect, device number 11
[  215.246142] usb 2-1.5.4: new full-speed USB device number 12 using e=
hci-pci

[ ... and so on ...]

It makes using the device from a VT difficult (e.g. for debugging),
but in the typical case where X is started shortly after boot and
hotplugs devices as soon as they're available it shouldn't pose a
problem. If Benjamin has any ideas I'd like to hear them, but in the
meantime I'm comfortable seeing this go upstream:

Acked-by: Jason Gerecke <killertofu@gmail.com>

--=20
Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one /
(That is to say, eight) to the two, /
But you can=E2=80=99t take seven from three, /
So you look at the sixty-fours....
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
