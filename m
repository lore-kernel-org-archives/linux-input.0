From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
Subject: Re: User space raw hid support
Date: Thu, 15 Mar 2012 17:27:20 -0300
Message-ID: <CAAngNMZ=9V1cAiHbZMWGiqLxro9mFHieWSBRYdZxM6d=MXyxRw@mail.gmail.com>
References: <F0070FBC0FB3174D8D11444EB2D5B0260B44E9F3@DNCE02.ent.ti.com>
	<CANq1E4ScdbDCTBa4H-b-yEwOEnhrX4hKV-a3TxFaOJsyYiAurA@mail.gmail.com>
	<CAKT1EBfEtKXAcpZ7qz1Z3RSGXR-U8aTai=CuoZ45YHBHYNUqsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47872 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161383Ab2COU1V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Mar 2012 16:27:21 -0400
Received: by dajr28 with SMTP id r28so5003635daj.19
        for <linux-input@vger.kernel.org>; Thu, 15 Mar 2012 13:27:20 -0700 (PDT)
In-Reply-To: <CAKT1EBfEtKXAcpZ7qz1Z3RSGXR-U8aTai=CuoZ45YHBHYNUqsw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: David Herrmann <dh.herrmann@googlemail.com>, "Ganir, Chen" <chen.ganir@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hello all,

On Thu, Mar 15, 2012 at 5:06 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> Hi David/Chen:
>
> On Wed, Mar 14, 2012 at 1:47 PM, David Herrmann
> <dh.herrmann@googlemail.com> wrote:
>> Hi Chen
>>
>> On Wed, Mar 14, 2012 at 12:47 PM, Ganir, Chen <chen.ganir@ti.com> wr=
ote:
>>> Hi all.
>>>
>>> I'm currently working on a HID Over GATT Implementation (HID over B=
luetooth Low energy).
>>>

We're also working to support the HoG here at INdT.

>>> As part of the design, it is required to configure the HID subsyste=
m from user space, configure a report descriptor with input/output/feat=
ure report points, and send/receive data from and to the kernel HID Sub=
system, from user space.
>>>
>>> Is there anything already supporting this feature ? I was looking a=
t hid-raw, but it is used to send raw data from user space to the hid d=
evice - I need to send raw hid from the device to the kernel.
>>
>> What do you mean with that? hidraw uses the
>> hid_input/output_raw_report() callbacks which HIDP/USBHID provide.
>> They provide direct access to the HID channels. With the
>> Bluetooth-backend you can directly write to the L2CAP channels. I
>> don't understand what you mean with "device to the kernel".
>
> HoG encapsulates HID reports using ATT protocol. The userspace needs
> to transcode the data and send back to the kernel.
> There isn't dynamic L2CAP channel allocation for Bluetooth Low Energy=
=2E
> Only one fixed data channel is allowed, and more than one profile can
> be exposed by the remote: services have a shared channel.
>

Trying to make it more clear: there is only one L2CAP socket for all
low energy data exchanged between the host and the remote device. Data
for different services/profiles is multiplexed and encapsulated on the
ATT protocol  on the same socket. Since we don't want to move the ATT
parser inside the kernel, the plan is to extract HoG traffic from this
socket on the userspace, reconstruct regular HID reports, and send
them back to the kernel to be handled by the HID/input subsystems.

>>
>> Do you need something more low-level or more high-level? Currently,
>> HIDP/USBHID provide the transport layer and register themselves with
>> the HID core. The HID core parses the HID protocol and provides inpu=
t
>> devices on top of it. I don't understand where in-between of this yo=
u
>> want the hooks to be?
>>

We want something that works similar to HIDP and USBHID, the only
difference is that it needs to be able to receive/send HID
input/output reports to the userspace instead of to a hw device.

>>> Our basic idea was to develop a new misc char driver, at /dev/uhid.=
 This device will be opened for each remote device we have access to, c=
onfigured, and then read/write the raw HID packets from the device dire=
ctly to this driver. We would like our solution to be a simple proxy be=
tween the device and the HID system, and we do not want to include a HI=
D parser in our code, to make sure latency stays as low as possible.

I personally don't think HID parsing on the userspace would add much
latency, but duplicating this code on the userspace is definitely
something we want to avoid.

>>
>> Does that mean you want to sit on top of the kernel HID parser or yo=
u
>> don't want any parser in between? /dev/uhid looks like a HID-backend
>> like HIDP/usbhid so hidraw seems to be perfect for this.
>

We want something that behaves exactly like uinput, but that also does
HID parsing. Is there something on the input subsystem that behaves
like that?

> How does hidraw interfaces with the userspace?
>

Does hidraw covers the use-case I've tried to describe here? It's
documentation was a bit confusing to me, any clarification will be
very helpful.

Thanks a lot,

--=20
Jo=C3=A3o Paulo Rechi Vita
Openbossa Labs - INdT
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
