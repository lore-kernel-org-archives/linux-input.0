From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [systemd-devel] Supporting U2F over HID on Linux?
Date: Fri, 12 Dec 2014 18:32:11 +0100
Message-ID: <CANq1E4QATOTs0ZtQF0mT645Z5u+vxYyphq8-UbqvNAc4iNz3iQ@mail.gmail.com>
References: <CALCETrXKcU1KaEjFUm9QkEhZRh9wFnoR=hV7O9pUJmYRqNCxpg@mail.gmail.com>
	<CANq1E4QvuNHRq6Saca-KigTjmvyosqM6_JkqF-_OHqxLa=Zdow@mail.gmail.com>
	<CALCETrVU5Kq0wYGXNQ1dsihy1LN1WUmAN4J9puyVPv=b_WNrLw@mail.gmail.com>
	<CANq1E4Sa=D_hvSp2SqHy4cV-oxd-kchsNVivcF54cBv8DK7gOQ@mail.gmail.com>
	<alpine.LNX.2.00.1411032115140.19451@pobox.suse.cz>
	<CALCETrVkZxc9G+B9jYYFmiE20VGcnugrB21_MRvjNhDTvP00zQ@mail.gmail.com>
	<CALCETrXf4wX5OoGJs2HWbzSLOz764XXg09mSHiTV=-GVCEUQuQ@mail.gmail.com>
	<CALCETrU9Nfpt0Zch5Swi+OaK=KTjJoOw7GAx4B7q1B56SqrUbA@mail.gmail.com>
	<CANq1E4Q8gTgMj+twRE3xjs1OfKUmbOmOatk_sDPPAW2BB4jscw@mail.gmail.com>
	<CALCETrXcHKwBuOA0wpFzgSe8Z9+t8LyaB7U+vdgVsR=YZc+GjQ@mail.gmail.com>
	<CANq1E4SVQAkyxJpiYsiLkjsET27QUK9PHTHTAqp4wQZVLKrMiw@mail.gmail.com>
	<CALCETrVfvK-BhaQMyfvLndfmX+gwAwshx3vdCFa7sOr+R1Jjpw@mail.gmail.com>
	<CANq1E4Q8+0_cLtwraK=gqFBovQoft9-0S4+ns_n9A7CinNTw7g@mail.gmail.com>
	<CALCETrW-Mt5Hqh353t3zm6Pq2kSUkw_16a2=DFHoEk=G92AU+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:63221 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030953AbaLLRcM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Dec 2014 12:32:12 -0500
Received: by mail-ig0-f173.google.com with SMTP id r2so1833730igi.0
        for <linux-input@vger.kernel.org>; Fri, 12 Dec 2014 09:32:11 -0800 (PST)
In-Reply-To: <CALCETrW-Mt5Hqh353t3zm6Pq2kSUkw_16a2=DFHoEk=G92AU+w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi

On Fri, Dec 12, 2014 at 6:25 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Fri, Dec 12, 2014 at 9:21 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
>> Hi
>>
>> On Fri, Dec 12, 2014 at 6:18 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>>> On Dec 12, 2014 3:05 AM, "David Herrmann" <dh.herrmann@gmail.com> wrote:
>>>>
>>>> So far, the solution is to use hid_device_io_start() and
>>>> hid_device_io_stop() in ->probe(). It's a hack to allow I/O during
>>>> ->probe(). Maybe your idea is the way to go, but unless someone
>>>> implements it, we're stuck with the current code.
>>>
>>> That should work.
>>>
>>> For normal HID drivers (those that don't start IO from probe), what
>>> happens if userspace starts IO before probe returns?  Does the driver
>>> code prevent that somehow?
>>
>> It's only the async hid intr channel that is affected by this.
>> User-space cannot trigger any outgoing I/O on the intr channel. Only
>> the synchronous ctrl channel via SET_REPORT can be triggered, but due
>> to the synchronous nature we always allow I/O on it.
>>
>
> I understand exactly one HID device, and that's U2F.  In U2F,
> userspace will (directly or indirectly) use SET_REPORT, and the device
> responds immediately (ish) using the async intr channel.

How does user-space issue SET_REPORT? Via hidraw? hidraw shouldn't be
used for anything but debugging right now.

The normal hid drivers are managed through hid-input.c, which
registers the input devices and syncs it up with its ->probe()
function. Most of the hid-xyz.c drivers are just quirks for
hid-input.c.

If you now invent your own layer on top, you usually don't want
hid-input.c. Instead, you register your own user-space API (for
instance via cdev_add(), or misc-devices). In those cases, you
register your devices from within ->probe() so it is up to you to
enable I/O before doing this.

I have no idea what user-space API you intend to use. Unfortunately, I
don't even know what kind of API U2F actually provides, so I cannot
even point you into the right direction. Sorry.

(btw., Documentation/hid/hid-transport.txt is an overview of how HID
transport layers work)

Thanks
David
