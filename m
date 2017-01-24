From: Roderick Colenbrander <roderick@gaikai.com>
Subject: Re: Method to power off HID device from driver?
Date: Tue, 24 Jan 2017 07:29:48 -0800
Message-ID: <CANndSKkaGDGiiu8vKgvvyi6N+10zwZJgG2v78WeBSj6VnDBMXg@mail.gmail.com>
References: <CANndSKn1JE0Fnxgn9rpUyR1fUv7GM_Y4xwpfevSUiOYnVSYYig@mail.gmail.com>
 <CANndSK=-V0DXWh=XCr=GUAyWvQ0ZKrRfDdkvhFMbVWTj57+uiQ@mail.gmail.com>
 <D5A9B8BF-4720-4BB4-826E-CCA150D2976F@gmail.com> <1481168348.2286.11.camel@hadess.net>
 <CANndSKkeMtLp6S2MRXFHTrdyUnVQ7HqwyKB2F-pqbgJFPh8A9w@mail.gmail.com>
 <alpine.LSU.2.20.1701191436220.25515@cbobk.fhfr.pm> <1484833373.21721.8.camel@hadess.net>
 <CANndSKkp+wYjp4DpWX5VK7MLWEn60tgcc5QX=r87gPQJKvkoPg@mail.gmail.com>
 <1484843168.21721.9.camel@hadess.net> <CANndSKmuZc72hPVbC3o-CL_wGwo+-Y63y_eLSEhsgwjaMU=pSA@mail.gmail.com>
 <1485251253.5845.15.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ot0-f173.google.com ([74.125.82.173]:36780 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbdAXPh1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 24 Jan 2017 10:37:27 -0500
Received: by mail-ot0-f173.google.com with SMTP id 104so129802525otd.3
        for <linux-input@vger.kernel.org>; Tue, 24 Jan 2017 07:37:26 -0800 (PST)
In-Reply-To: <1485251253.5845.15.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Cameron Gutman <aicommander@gmail.com>

On Tue, Jan 24, 2017 at 1:47 AM, Bastien Nocera <hadess@hadess.net> wrote:
> On Thu, 2017-01-19 at 10:07 -0800, Roderick Colenbrander wrote:
>> On Thu, Jan 19, 2017 at 8:26 AM, Bastien Nocera <hadess@hadess.net>
>> wrote:
>> > On Thu, 2017-01-19 at 08:18 -0800, Roderick Colenbrander wrote:
>> > > In my case it are Hid packets to trigger a disconnect.
>> >
>> > "HID packets" isn't a hardware transport.
>>
>> My reply was a little too quick. The devices we like this capability
>> for are Bluetooth and USB based, so for Bluetooth we care about uhid
>> /
>> bt-hidp and for USB usb-hid.
>
> What's the use case for USB based devices? Is this to "switch off" pads
> like on XBox and Playstation consoles? I'm pretty sure the devices are
> still on. Do you expect an unplug/replug to be necessary for USB
> devices?

The main use case for USB devices is the PlayStation dongle which is a
device which can be used to use a DS4 on a PC. Behind the scenes a USB
to Bluetooth bridge, but it hides the Bluetooth from the OS. The
dongle would always be on, but a way is needed to disconnect the DS4
from it else the battery would drain. I don't intend to turn off the
dongle itself or a USB connected DS4, I suspect that's already doable
somehow through USB sysfs nodes nor do I know of a HID method to
disconnect the device in those cases.
