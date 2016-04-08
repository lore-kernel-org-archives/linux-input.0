From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: Re: [PATCH-V2 1/1] HID: Force feedback support for the Logitech G920
Date: Fri, 8 Apr 2016 23:34:14 +0200
Message-ID: <CADbOyBSOu9J2m1cVdaEVWRq1rYGxnp-dPRSuW8qboyW=n=LGuA@mail.gmail.com>
References: <1452468315-8978-1-git-send-email-e.velds@gmail.com>
	<0db5d205435e01d8228b97a2d87ef42d.squirrel@mungewell.org>
	<alpine.LNX.2.00.1601281430560.21446@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:33170 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827AbcDHVeP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Apr 2016 17:34:15 -0400
In-Reply-To: <alpine.LNX.2.00.1601281430560.21446@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>
Cc: Simon Wood <simon@mungewell.org>, Edwin Velds <e.velds@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Michal Maly <madcatxster@devoid-pointer.net>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Thu, Jan 28, 2016 at 2:33 PM, Jiri Kosina <jikos@kernel.org> wrote:
> On Tue, 26 Jan 2016, Simon Wood wrote:
>
>> On Sun, January 10, 2016 4:25 pm, Edwin Velds wrote:
>> > This patch implements force feedback support for the Logitech
>> > G920 Driving Force Racing Wheel. It is a generic implementation
>> > of feature 0x8123 of the Logitech HID++ protocol and should be usable for
>> > any future devices that implement this feature.
>>
>> Apologies for being slow on this (something to do with changing jobs and
>> accomodation ;-).
>>
>> Doesn't patch cleanly on Linus' HEAD due to:
>> --
>> commit d8ce9bf5551bfea431893bdd0a943f24a5170828
>> Author: Geliang Tang <geliangtang@163.com>
>> Date:   Sun Dec 27 17:25:20 2015 +0800
>>
>>     HID: move to_hid_device() to hid.h
>
> I've fixed the conflict.
>
>> --
>>
>> A couple of white space issues:
>> --
>> ERROR: trailing whitespace
>> #114: FILE: drivers/hid/hid-logitech-hidpp.c:867:
>> +static const u8 HIDPP_FF_CONDITION_CMDS[] = { $
>>
>> ERROR: trailing whitespace
>> #121: FILE: drivers/hid/hid-logitech-hidpp.c:874:
>> +static const char *HIDPP_FF_CONDITION_NAMES[] = { $
>
> Fixed as well.
>
>> --
>>
>> Note: The wheel _DOES_NOT_ auto switch to Logitech/HID mode (it is stuck
>> in XBox since the xpad changes where not included). Michal has an
>> alternative approach documented here:
>
> I've ammended the changelog with this information.

Here is the official post on the usb_modeswitch forum:
http://www.draisberghof.de/usb_modeswitch/bb/viewtopic.php?f=2&t=2510
It will be included in the next usb-modeswitch-data release.

Thanks,
Elias
