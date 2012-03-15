From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: User space raw hid support
Date: Thu, 15 Mar 2012 22:40:55 +0100
Message-ID: <CANq1E4SsRH=aui4NmswNn1CT05ERZZiCV9LX9K3uAh_q3B14iw@mail.gmail.com>
References: <F0070FBC0FB3174D8D11444EB2D5B0260B44E9F3@DNCE02.ent.ti.com>
	<CANq1E4ScdbDCTBa4H-b-yEwOEnhrX4hKV-a3TxFaOJsyYiAurA@mail.gmail.com>
	<CAKT1EBfEtKXAcpZ7qz1Z3RSGXR-U8aTai=CuoZ45YHBHYNUqsw@mail.gmail.com>
	<CAAngNMZ=9V1cAiHbZMWGiqLxro9mFHieWSBRYdZxM6d=MXyxRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:36261 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032342Ab2COVk4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Mar 2012 17:40:56 -0400
Received: by wejx9 with SMTP id x9so3319287wej.19
        for <linux-input@vger.kernel.org>; Thu, 15 Mar 2012 14:40:55 -0700 (PDT)
In-Reply-To: <CAAngNMZ=9V1cAiHbZMWGiqLxro9mFHieWSBRYdZxM6d=MXyxRw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joao Paulo Rechi Vita <jprvita@openbossa.org>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>, "Ganir, Chen" <chen.ganir@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Joao

Jiri, maybe you can comment on this. We are trying to provide
hid_ll_drivers from user-space
to implement BT-HIDP for BT-low-energy. My idea is to write an
uinput-like interface which allows
to register hid_ll_drivers from userspace. Do you have any objections h=
ere?

On Thu, Mar 15, 2012 at 9:27 PM, Joao Paulo Rechi Vita
<jprvita@openbossa.org> wrote:
> Hello all,
>
> On Thu, Mar 15, 2012 at 5:06 PM, Claudio Takahasi
> <claudio.takahasi@openbossa.org> wrote:
>> Hi David/Chen:
>>
>> On Wed, Mar 14, 2012 at 1:47 PM, David Herrmann
>> <dh.herrmann@googlemail.com> wrote:
>>> Hi Chen
>>>
>>> On Wed, Mar 14, 2012 at 12:47 PM, Ganir, Chen <chen.ganir@ti.com> w=
rote:
>>>> Hi all.
>>>>
>>>> I'm currently working on a HID Over GATT Implementation (HID over =
Bluetooth Low energy).
>>>>
>
> We're also working to support the HoG here at INdT.
>
>>>> As part of the design, it is required to configure the HID subsyst=
em from user space, configure a report descriptor with input/output/fea=
ture report points, and send/receive data from and to the kernel HID Su=
bsystem, from user space.
>>>>
>>>> Is there anything already supporting this feature ? I was looking =
at hid-raw, but it is used to send raw data from user space to the hid =
device - I need to send raw hid from the device to the kernel.
>>>
>>> What do you mean with that? hidraw uses the
>>> hid_input/output_raw_report() callbacks which HIDP/USBHID provide.
>>> They provide direct access to the HID channels. With the
>>> Bluetooth-backend you can directly write to the L2CAP channels. I
>>> don't understand what you mean with "device to the kernel".
>>
>> HoG encapsulates HID reports using ATT protocol. The userspace needs
>> to transcode the data and send back to the kernel.
>> There isn't dynamic L2CAP channel allocation for Bluetooth Low Energ=
y.
>> Only one fixed data channel is allowed, and more than one profile ca=
n
>> be exposed by the remote: services have a shared channel.
>>
>
> Trying to make it more clear: there is only one L2CAP socket for all
> low energy data exchanged between the host and the remote device. Dat=
a
> for different services/profiles is multiplexed and encapsulated on th=
e
> ATT protocol =A0on the same socket. Since we don't want to move the A=
TT
> parser inside the kernel, the plan is to extract HoG traffic from thi=
s
> socket on the userspace, reconstruct regular HID reports, and send
> them back to the kernel to be handled by the HID/input subsystems.

Thanks for clarifying that. I now understand what you are planning to d=
o.

>>>
>>> Do you need something more low-level or more high-level? Currently,
>>> HIDP/USBHID provide the transport layer and register themselves wit=
h
>>> the HID core. The HID core parses the HID protocol and provides inp=
ut
>>> devices on top of it. I don't understand where in-between of this y=
ou
>>> want the hooks to be?
>>>
>
> We want something that works similar to HIDP and USBHID, the only
> difference is that it needs to be able to receive/send HID
> input/output reports to the userspace instead of to a hw device.
>
>>>> Our basic idea was to develop a new misc char driver, at /dev/uhid=
=2E This device will be opened for each remote device we have access to=
, configured, and then read/write the raw HID packets from the device d=
irectly to this driver. We would like our solution to be a simple proxy=
 between the device and the HID system, and we do not want to include a=
 HID parser in our code, to make sure latency stays as low as possible.
>
> I personally don't think HID parsing on the userspace would add much
> latency, but duplicating this code on the userspace is definitely
> something we want to avoid.

Agreed. Personally I think rewriting the HID parser wouldn't be much
work but it also
wouldn't buy us anything. We eventually would feed the input via
uinput into the kernel
anyway so we do not save any round-trips here. So feeding it directly
into the HID system
seems legit to me.

>>>
>>> Does that mean you want to sit on top of the kernel HID parser or y=
ou
>>> don't want any parser in between? /dev/uhid looks like a HID-backen=
d
>>> like HIDP/usbhid so hidraw seems to be perfect for this.
>>
>
> We want something that behaves exactly like uinput, but that also doe=
s
> HID parsing. Is there something on the input subsystem that behaves
> like that?

No. What you need is to write a hid_ll_driver which accepts input from
user-space. The HID
system takes input from low-level drivers (hid_ll_driver) like HIDP
and USBHID and creates
input devices on top of it. There is currently no way to write
hid_ll_drivers in user-space,
however, it should be easy to write one.

I am CC'ing Jiri Kosina (HID Maintainer) and Dmitri to go sure they
don't know any other way of
dealing with this. I will have a look at this and try to write a short
uinput-like driver
for HID if you are interested in this.

>> How does hidraw interfaces with the userspace?
>>
>
> Does hidraw covers the use-case I've tried to describe here? It's
> documentation was a bit confusing to me, any clarification will be
> very helpful.

No, I am sorry, hidraw is definitely not what you need here.

> Thanks a lot,
>
> --
> Jo=E3o Paulo Rechi Vita
> Openbossa Labs - INdT

Regards
David
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
