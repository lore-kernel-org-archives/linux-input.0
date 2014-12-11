From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [systemd-devel] Supporting U2F over HID on Linux?
Date: Thu, 11 Dec 2014 09:49:28 +0100
Message-ID: <CANq1E4Q8gTgMj+twRE3xjs1OfKUmbOmOatk_sDPPAW2BB4jscw@mail.gmail.com>
References: <CALCETrXKcU1KaEjFUm9QkEhZRh9wFnoR=hV7O9pUJmYRqNCxpg@mail.gmail.com>
	<CANq1E4QvuNHRq6Saca-KigTjmvyosqM6_JkqF-_OHqxLa=Zdow@mail.gmail.com>
	<CALCETrVU5Kq0wYGXNQ1dsihy1LN1WUmAN4J9puyVPv=b_WNrLw@mail.gmail.com>
	<CANq1E4Sa=D_hvSp2SqHy4cV-oxd-kchsNVivcF54cBv8DK7gOQ@mail.gmail.com>
	<alpine.LNX.2.00.1411032115140.19451@pobox.suse.cz>
	<CALCETrVkZxc9G+B9jYYFmiE20VGcnugrB21_MRvjNhDTvP00zQ@mail.gmail.com>
	<CALCETrXf4wX5OoGJs2HWbzSLOz764XXg09mSHiTV=-GVCEUQuQ@mail.gmail.com>
	<CALCETrU9Nfpt0Zch5Swi+OaK=KTjJoOw7GAx4B7q1B56SqrUbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:38397 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934099AbaLKIte (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Dec 2014 03:49:34 -0500
Received: by mail-ie0-f180.google.com with SMTP id rp18so4445761iec.11
        for <linux-input@vger.kernel.org>; Thu, 11 Dec 2014 00:49:33 -0800 (PST)
In-Reply-To: <CALCETrU9Nfpt0Zch5Swi+OaK=KTjJoOw7GAx4B7q1B56SqrUbA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Jiri Kosina <jkosina@suse.cz>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

Hi

On Wed, Dec 10, 2014 at 6:07 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Tue, Dec 9, 2014 at 12:46 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> On Mon, Nov 3, 2014 at 12:41 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>>> On Mon, Nov 3, 2014 at 12:21 PM, Jiri Kosina <jkosina@suse.cz> wrote:
>>>> On Mon, 3 Nov 2014, David Herrmann wrote:
>>>>
>>>>> > Agreed, mostly.  My only real concern is that this could be annoying
>>>>> > for the userspace developers who will need to target Linux and HIDAPI
>>>>> > separately.  Admittedly the Linux support will be trivial.
>>>>>
>>>>> I see. I'll not stop you from using hidraw, I'd just not recommend it.
>>>>> Especially for security stuff I dislike exposing the whole HID device
>>>>> writable. But yeah, I guess you got my point.
>>>>
>>>> Alright, I am basically thinking loudly now, but how about we allow HID
>>>> drivers that would override default hidraw interface?
>>>>
>>>> I am very well aware of the fact that this could be opening a can of
>>>> worms, so we'll have to make it very restrictive. How about, let's say, we
>>>> allow HID drivers to provide custom hidraw interface (completely
>>>> overriding the one that HID core would normally create) only for cases
>>>> such as:
>>>>
>>>> - the intent is to expose only certain parts of a combined device
>>>> - the intent is to introduce some level of access control
>>>>
>>>> I.e. still no interference of kernel with data parsing allowed.
>>>
>>> Hmm.  Would this be like a filter on hidraw actions?
>>>
>>> How would udev distinguish these special hidraw devices from normal
>>> hidraw devices?
>>>
>>> Also, for U2F, this could be a little awkward.  There's some crazy
>>> fragmentation stuff to allow a U2F request to be split across HID
>>> requests, and I think a kernel driver would much rather get the
>>> original unfragmented application request.
>>>
>>
>> I started writing a driver for this.  I got enumeration working.  I
>> assume I should create a "u2f" device class, and then... ?
>>
>> Where am I supposed to get my character device from?  Do I register my
>> own chrdev major?  Do I use misc?  Is there some input thing I'm
>> supposed to use?
>
> Another question:
>
> I'm hitting this in hid_input_report:
>
>     if (down_trylock(&hid->driver_input_lock)) {
>         pr_err("HID: trylock failed\n");  // I added this
>         return -EBUSY;
>     }
>
> This is a problem for u2f: u2f reports are actual protocol messages,
> and there isn't a retransmit mechanism.  Losing messages randomly
> causes the handshake to fail, and then nothing works.
>
> I *think* that the only way I can hit that failure is during probe (or
> if the USB stack somehow completes two transfers at once). This still
> makes it quite awkward to start IO from the probe routine.
>
> I could start a work item to take driver_input_lock, release it again,
> and then start the handshake, but that sucks.

HID reports are ordered. It's the responsibility of the
transport-layer to not provide multiple reports in parallel. The
reason we have this down_trylock() is to drop packages if no driver is
loaded, yet. I wonder how you can trigger this? Does this happen
during runtime or only driver load? Do you send GET_REPORT requests to
the device?

Thanks
David
