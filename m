From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH v2] HID: wacom: ask for a in-prox report when it was missed
Date: Mon, 16 Mar 2015 15:36:36 -0700
Message-ID: <55075AF4.1000807@gmail.com>
References: <1425595014-23048-1-git-send-email-benjamin.tissoires@redhat.com> <alpine.LNX.2.00.1503161549020.25438@pobox.suse.cz> <CANRwn3R7nBPxPynexP+yU43puxgNmj=35ghh01ioUqmNjdTy+g@mail.gmail.com> <20150316192733.GD4053@mail.corp.redhat.com> <55074239.4070407@gmail.com> <20150316210417.GE4053@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150316210417.GE4053@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Linux Input <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 3/16/2015 2:04 PM, Benjamin Tissoires wrote:
> On Mar 16 2015 or thereabouts, Jason Gerecke wrote:
>> On 3/16/2015 12:27 PM, Benjamin Tissoires wrote:
>>> On Mar 16 2015 or thereabouts, Jason Gerecke wrote:
>>>> On 3/16/2015 7:50 AM, Jiri Kosina wrote:
>>>>> On Thu, 5 Mar 2015, Benjamin Tissoires wrote:
>>>>>
>>>>>> If noone listens to the input device when a tool comes in proxim=
ity,
>>>>>> the tablet does not send the in-prox event when a client becomes=
 available.
>>>>>> That means that no events will be sent until the tool is taken o=
ut of
>>>>>> proximity.
>>>>>>
>>>>>> In this situation, ask for the report WACOM_REPORT_INTUOSREAD wh=
ich will
>>>>>> read the corresponding feature and generate an in-prox event.
>>>>>> To make some generation of hardware working, we need to unset th=
e
>>>>>> quirk NO_GET set by hid-core because the interfaces are seen as =
"boot
>>>>>> mouse".
>>>>>>
>>>>>> We don't schedule this read in a worker while we are in an IO in=
terrupt.
>>>>>> We know that usbhid will do it asynchronously. If this is trigge=
red by
>>>>>> uhid, then this is obviously a client side bug :)
>>>>>>
>>>>>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com=
>
>>>>>
>>>>> Ping, Jason, I'd like to get your Ack on this before pushing this=
 through
>>>>> if possible.
>>>>>
>>>>> Thanks.
>>>>>
>>>>
>>>> This update seems to have solved the issue I was having earlier. I=
 do
>>>> still see some weird behavior with the Intuos3 though. For whateve=
r
>>>> reason, if a tool is in prox and no client is connected, the devic=
e
>>>> will repeatedly connect and disconnect from the bus. For example,
>>>> while sitting at a VT after connecting the device:
>>>>
>>>> [  209.890431] usb 2-1.5.4: new full-speed USB device number 10 us=
ing ehci-pci
>>>> [  209.992189] input: Wacom Intuos3 6x8 as
>>>> /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.5/2-1.5.4/2-1.5.4:1.=
0/0003:056A:00B1.0009/input/input26
>>>> [  209.992475] input: Wacom Intuos3 6x8 Pad as
>>>> /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.5/2-1.5.4/2-1.5.4:1.=
0/0003:056A:00B1.0009/input/input27
>>>> [  209.992846] wacom 0003:056A:00B1.0009: hidraw4: USB HID v1.00 M=
ouse
>>>> [Tablet PTZ-630] on usb-0000:00:1d.0-1.5.4/input0
>>>> [  213.022545] usb 2-1.5.4: USB disconnect, device number 10
>>>> [  213.344055] usb 2-1.5.4: new full-speed USB device number 11 us=
ing ehci-pci
>>>> [  213.445779] input: Wacom Intuos3 6x8 as
>>>> /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.5/2-1.5.4/2-1.5.4:1.=
0/0003:056A:00B1.000A/input/input28
>>>> [  213.446185] input: Wacom Intuos3 6x8 Pad as
>>>> /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.5/2-1.5.4/2-1.5.4:1.=
0/0003:056A:00B1.000A/input/input29
>>>> [  213.446703] wacom 0003:056A:00B1.000A: hidraw4: USB HID v1.00 M=
ouse
>>>> [Tablet PTZ-630] on usb-0000:00:1d.0-1.5.4/input0
>>>> [  214.815925] usb 2-1.5.4: USB disconnect, device number 11
>>>> [  215.246142] usb 2-1.5.4: new full-speed USB device number 12 us=
ing ehci-pci
>>>>
>>>> [ ... and so on ...]
>>>>
>>>> It makes using the device from a VT difficult (e.g. for debugging)=
,
>>>> but in the typical case where X is started shortly after boot and
>>>> hotplugs devices as soon as they're available it shouldn't pose a
>>>> problem. If Benjamin has any ideas I'd like to hear them, but in t=
he
>>>> meantime I'm comfortable seeing this go upstream:
>>>
>>> HID_QUIRK_ALWAYS_POLL :)
>>>
>>> Some usb devices do not like to not be polled and keep
>>> disconnecting/reconnecting. Looks like the Intuos 3 is one of them.
>>> The only cons are that the device won't save power when no one is r=
eading
>>> the inputs. Not sure if that is a requirement for Wacom tablets tho=
ugh.
>>>
>>> Note that HID_QUIRK_ALWAYS_POLL should make this patch useless in t=
hese
>>> cases, the kernel will keep track of the current device because it =
will
>>> receive the events.
>>>
>>>>
>>>> Acked-by: Jason Gerecke <killertofu@gmail.com>
>>>
>>> Thanks!
>>>
>>> Cheers,
>>> Benjamin
>>>
>>
>> That does indeed seem to solve the Intuos3 weirdness :)
>>
>> Saving power is a big deal for ISDv4/5 sensors where it has a direct=
 impact
>> on runtime. If setting HID_QURIK_ALWAYS_POLL e.g. disables USB selec=
tive
>> suspend then that'd be an issue. However, if it simply causes the ke=
rnel to
>> respond to events even if nobody is listening then it'd probably be =
similar
>> to the situation when we were under drivers/input.
>>
>> I'm inclined to say we should target that quirk at only those device=
s that
>> need it since I know tablet PC manufacturers go to quite some length=
s to
>> minimize every mA of unnecessary current draw from the batteries.
>>
>
> Just a thought, but it looks like the problematic generation have the
> QUIRK_NO_GET set by hid-core (boot interface). If you are on it, coul=
d I
> ask you to test to set HID_QUIRK_ALWAYS_POLL and unset HID_QUIRK_NO_G=
ET
> only if HID_QUIRK_NO_GET was set?
>
> IIRC, there was no problems on the Intuos 4+ with the USB suspend, so
> maybe that trick would be enough.
>
> Cheers,
> Benjamin
>
>

I'm not sure that'll be enough. Most of our devices use a boot mouse=20
interface, even some that work fine using the default quirks (e.g.=20
Cintiq 24HDT). On the tablet PC side of the world, it looks like its a=20
crapshoot whether the sensor will have a boot mouse collection or=20
something else (though I haven't yet checked to see how they react to=20
having a pen in prox without a client).

--=20
Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one /
(That is to say, eight) to the two, /
But you can=E2=80=99t take seven from three, /
So you look at the sixty-fours....
