From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH v2] HID: wacom: ask for a in-prox report when it was missed
Date: Mon, 16 Mar 2015 13:51:05 -0700
Message-ID: <55074239.4070407@gmail.com>
References: <1425595014-23048-1-git-send-email-benjamin.tissoires@redhat.com> <alpine.LNX.2.00.1503161549020.25438@pobox.suse.cz> <CANRwn3R7nBPxPynexP+yU43puxgNmj=35ghh01ioUqmNjdTy+g@mail.gmail.com> <20150316192733.GD4053@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150316192733.GD4053@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Linux Input <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 3/16/2015 12:27 PM, Benjamin Tissoires wrote:
> On Mar 16 2015 or thereabouts, Jason Gerecke wrote:
>> On 3/16/2015 7:50 AM, Jiri Kosina wrote:
>>> On Thu, 5 Mar 2015, Benjamin Tissoires wrote:
>>>
>>>> If noone listens to the input device when a tool comes in proximit=
y,
>>>> the tablet does not send the in-prox event when a client becomes a=
vailable.
>>>> That means that no events will be sent until the tool is taken out=
 of
>>>> proximity.
>>>>
>>>> In this situation, ask for the report WACOM_REPORT_INTUOSREAD whic=
h will
>>>> read the corresponding feature and generate an in-prox event.
>>>> To make some generation of hardware working, we need to unset the
>>>> quirk NO_GET set by hid-core because the interfaces are seen as "b=
oot
>>>> mouse".
>>>>
>>>> We don't schedule this read in a worker while we are in an IO inte=
rrupt.
>>>> We know that usbhid will do it asynchronously. If this is triggere=
d by
>>>> uhid, then this is obviously a client side bug :)
>>>>
>>>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>>>
>>> Ping, Jason, I'd like to get your Ack on this before pushing this t=
hrough
>>> if possible.
>>>
>>> Thanks.
>>>
>>
>> This update seems to have solved the issue I was having earlier. I d=
o
>> still see some weird behavior with the Intuos3 though. For whatever
>> reason, if a tool is in prox and no client is connected, the device
>> will repeatedly connect and disconnect from the bus. For example,
>> while sitting at a VT after connecting the device:
>>
>> [  209.890431] usb 2-1.5.4: new full-speed USB device number 10 usin=
g ehci-pci
>> [  209.992189] input: Wacom Intuos3 6x8 as
>> /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.5/2-1.5.4/2-1.5.4:1.0/=
0003:056A:00B1.0009/input/input26
>> [  209.992475] input: Wacom Intuos3 6x8 Pad as
>> /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.5/2-1.5.4/2-1.5.4:1.0/=
0003:056A:00B1.0009/input/input27
>> [  209.992846] wacom 0003:056A:00B1.0009: hidraw4: USB HID v1.00 Mou=
se
>> [Tablet PTZ-630] on usb-0000:00:1d.0-1.5.4/input0
>> [  213.022545] usb 2-1.5.4: USB disconnect, device number 10
>> [  213.344055] usb 2-1.5.4: new full-speed USB device number 11 usin=
g ehci-pci
>> [  213.445779] input: Wacom Intuos3 6x8 as
>> /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.5/2-1.5.4/2-1.5.4:1.0/=
0003:056A:00B1.000A/input/input28
>> [  213.446185] input: Wacom Intuos3 6x8 Pad as
>> /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.5/2-1.5.4/2-1.5.4:1.0/=
0003:056A:00B1.000A/input/input29
>> [  213.446703] wacom 0003:056A:00B1.000A: hidraw4: USB HID v1.00 Mou=
se
>> [Tablet PTZ-630] on usb-0000:00:1d.0-1.5.4/input0
>> [  214.815925] usb 2-1.5.4: USB disconnect, device number 11
>> [  215.246142] usb 2-1.5.4: new full-speed USB device number 12 usin=
g ehci-pci
>>
>> [ ... and so on ...]
>>
>> It makes using the device from a VT difficult (e.g. for debugging),
>> but in the typical case where X is started shortly after boot and
>> hotplugs devices as soon as they're available it shouldn't pose a
>> problem. If Benjamin has any ideas I'd like to hear them, but in the
>> meantime I'm comfortable seeing this go upstream:
>
> HID_QUIRK_ALWAYS_POLL :)
>
> Some usb devices do not like to not be polled and keep
> disconnecting/reconnecting. Looks like the Intuos 3 is one of them.
> The only cons are that the device won't save power when no one is rea=
ding
> the inputs. Not sure if that is a requirement for Wacom tablets thoug=
h.
>
> Note that HID_QUIRK_ALWAYS_POLL should make this patch useless in the=
se
> cases, the kernel will keep track of the current device because it wi=
ll
> receive the events.
>
>>
>> Acked-by: Jason Gerecke <killertofu@gmail.com>
>
> Thanks!
>
> Cheers,
> Benjamin
>

That does indeed seem to solve the Intuos3 weirdness :)

Saving power is a big deal for ISDv4/5 sensors where it has a direct=20
impact on runtime. If setting HID_QURIK_ALWAYS_POLL e.g. disables USB=20
selective suspend then that'd be an issue. However, if it simply causes=
=20
the kernel to respond to events even if nobody is listening then it'd=20
probably be similar to the situation when we were under drivers/input.

I'm inclined to say we should target that quirk at only those devices=20
that need it since I know tablet PC manufacturers go to quite some=20
lengths to minimize every mA of unnecessary current draw from the batte=
ries.

--=20
Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one /
(That is to say, eight) to the two, /
But you can=E2=80=99t take seven from three, /
So you look at the sixty-fours....
