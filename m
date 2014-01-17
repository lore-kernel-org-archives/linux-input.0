From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH 4/4] HID: sony: Map gyroscopes and accelerometers to axes
Date: Fri, 17 Jan 2014 18:38:02 +0100
Message-ID: <CANq1E4R6V_V9UaKzHjy2gqr98hUAvB8dxVjzpFcA=EhMncz45Q@mail.gmail.com>
References: <alpine.DEB.2.10.1401162137400.15779@franz-virtual-machine>
	<20140117125137.ad402d6be31de52a25fedd4a@studenti.unina.it>
	<alpine.LNX.2.00.1401171319500.23018@pobox.suse.cz>
	<52D96619.7000209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:48357 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbaAQRiD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jan 2014 12:38:03 -0500
Received: by mail-ie0-f170.google.com with SMTP id u16so3956159iet.29
        for <linux-input@vger.kernel.org>; Fri, 17 Jan 2014 09:38:02 -0800 (PST)
In-Reply-To: <52D96619.7000209@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Antonio Ospite <ospite@studenti.unina.it>, Frank Praznik <frank.praznik@oh.rr.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi

On Fri, Jan 17, 2014 at 6:19 PM, Frank Praznik <frank.praznik@gmail.com> wrote:
> On 1/17/2014 07:21, Jiri Kosina wrote:
>>
>> On Fri, 17 Jan 2014, Antonio Ospite wrote:
>>
>>>> Use a modified HID descriptor for the Dualshock 4 to assign the
>>>> gyroscope
>>>> sensors and accelerometers to axes.
>>>>
>>> What about putting the descriptor fixup on hold for now?
>>> Jiri, have you already pushed these patches?
>>>
>>> Once the ABS2 stuff from David Hermann is done then proper mapping
>>> following the Gamepad API[1] and the Motion-Tracking API[2] could be
>>> added.
>>>
>>> [1] Documentation/input/gamepad.txt
>>> [2] Documentation/input/motion-tracking.txt
>>>
>>> We could even have the DS3 and DS4 expose the same mapping.
>>>
>>> Just a suggestion.
>>
>> Hi,
>>
>> yes, I have already pushed it, but we can of course discuss not including
>> it into pull for Linus if necessary.
>>
>> My understanding is that once ABS2 stuff is done, this can just be
>> switched to using it in a backwards-compatible way, and the report fixup
>> could be dropped, no?
>>
> The default descriptor doesn't map the accelerometers or gyros to anything.
> It's just a 'user defined' page that causes the HID system to skip over the
> bytes in the report.  My changes to the descriptor map the accelerometers to
> usage 0x40, 0x41 and 0x42 and the gyroscope values to 0x43, 0x44 and 0x45.
> These are the proper HID usage values for accelerometers and gyros according
> to the HID spec and according to the updated motion-tracking.txt this is
> exactly what they need to be mapped to to work with the ABS2 changes.
> Unless I'm missing something,  these descriptor changes should be
> forward-compatible.

Your patch is fine. Issue is, once we introduce the interfaces
described in motion-tracking.txt, we would have to decide whether we
want to adjust hid-input.c to use it. If we do that, we might break
user-space, but if we don't do that, we will never map the stuff
correctly. Not that easy to fix.

So in case we postpone your patch, we could make sure it maps to the
new bits right from the beginning. But I'm not so sure it's worth it
as ABS2 is still not fully discussed.

Thanks
David
