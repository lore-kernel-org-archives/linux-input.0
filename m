From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH 0/2] input: Add INPUT_PROP_POINTING_STICK property
Date: Tue, 2 Sep 2014 16:50:53 +0200
Message-ID: <CANq1E4RMKmM3Qk09-hd49VSH2On_n8-x7sOp7OKd9Ww-48sLzw@mail.gmail.com>
References: <1409661804-10489-1-git-send-email-hdegoede@redhat.com>
	<CANq1E4TU9Q3eWm25LhySk28de7r4tjZTLaCMHLOfVo738fnoFg@mail.gmail.com>
	<5405D6D4.4070406@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:46373 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704AbaIBOux (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Sep 2014 10:50:53 -0400
Received: by mail-ie0-f182.google.com with SMTP id rd18so7812290iec.27
        for <linux-input@vger.kernel.org>; Tue, 02 Sep 2014 07:50:53 -0700 (PDT)
In-Reply-To: <5405D6D4.4070406@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi

On Tue, Sep 2, 2014 at 4:40 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> On 09/02/2014 02:55 PM, David Herrmann wrote:
>> Hi
>>
>> On Tue, Sep 2, 2014 at 2:43 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>>> Hi,
>>>
>>> It is useful for userspace to know that they're not dealing with a regular
>>> mouse but rather with a pointing stick (e.g. a trackpoint) so that userspace
>>> can e.g. automatically enable middle button scrollwheel emulation.
>>>
>>> It is impossible to tell the difference from the evdev info without resorting
>>> to putting a list of device / driver names in userspace, this is undesirable.
>>
>> ..so it is better to put that table into the kernel?
>
> No not a table, at the kernel level we actually have different drivers
> for pointer sticks and for other mouse (and mouse like devices), so this is
> a simple matter of adding a single line of code to all of 4 drivers.
>
> We could have a table in userspace matching the driver/model strings used
> by those 4 drivers, but what if a 5th pops up ?

Ok, for now it's pretty easy as all "pointing stick" drivers are
already separate in the kernel. But imagine a new generation of
"pointing stick" devices is an HID device handled by hid-input.c. What
do you do? To set the INPUT_PROPERTY bit, you need to add a driver for
this vid/did combination. Seems overkill, so we'd probably not set
this property bit for this device and let user-space deal with it. Now
we end up with two places to store such information.

We already fix scancode/keycode mappings via hwdb as it would be
excessive to write kernel drivers for all devices just to fix those.
Imo, device properties are very similar to this. We have to draw a
line between properties the kernel should detect and expose, and
properties we detect in user-space. We already gave up defining ABS_
axes for everything (I mean, we report all kinds of data via ABS_X,
ranging from trackpad, to pressure and accelerometer data). User-space
needs to detect what devices it deals with, to know what the different
axes event-bits mean.

Yeah, the POINTING_STICK property turns out to be trivial, so please
go ahead. I just want to remind you, that we need a user-space
database, anyway. And hwdb entries can be added via simple distro
updates (even users can regenerate it themselves). Kernel driver
changes are way more heavy.. and slow.

Thanks
David
