From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH 4/4] HID: sony: Map gyroscopes and accelerometers to axes
Date: Fri, 17 Jan 2014 13:34:09 +0100
Message-ID: <CANq1E4T0Vzrhj_+Dym0qBpV7vi=WPxyZv-DDZ7Z2Lvh7c2bwEw@mail.gmail.com>
References: <alpine.DEB.2.10.1401162137400.15779@franz-virtual-machine>
	<20140117125137.ad402d6be31de52a25fedd4a@studenti.unina.it>
	<alpine.LNX.2.00.1401171319500.23018@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35542 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbaAQMeK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jan 2014 07:34:10 -0500
Received: by mail-ig0-f176.google.com with SMTP id j1so1454228iga.3
        for <linux-input@vger.kernel.org>; Fri, 17 Jan 2014 04:34:09 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1401171319500.23018@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Antonio Ospite <ospite@studenti.unina.it>, Frank Praznik <frank.praznik@oh.rr.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi

On Fri, Jan 17, 2014 at 1:21 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Fri, 17 Jan 2014, Antonio Ospite wrote:
>
>> > Use a modified HID descriptor for the Dualshock 4 to assign the gyroscope
>> > sensors and accelerometers to axes.
>> >
>>
>> What about putting the descriptor fixup on hold for now?
>> Jiri, have you already pushed these patches?
>>
>> Once the ABS2 stuff from David Hermann is done then proper mapping
>> following the Gamepad API[1] and the Motion-Tracking API[2] could be
>> added.
>>
>> [1] Documentation/input/gamepad.txt
>> [2] Documentation/input/motion-tracking.txt
>>
>> We could even have the DS3 and DS4 expose the same mapping.
>>
>> Just a suggestion.
>
> Hi,
>
> yes, I have already pushed it, but we can of course discuss not including
> it into pull for Linus if necessary.
>
> My understanding is that once ABS2 stuff is done, this can just be
> switched to using it in a backwards-compatible way, and the report fixup
> could be dropped, no?

No. With ABS2 we can introduce ABS_GYRO_X/Y/Z and ABS_ACCEL_X/Y/Z, so
we would change the mappings. Antonio just wants to point out that if
we wait for ABS2, we could use the new mappings right from the
beginning so we never change them and will risk
backwards-incompatibility.

But Dmitry was actually concerned of adding more and more ABS_* bits
due to memory-consumption, I guess. I currently keep the ABS2 patches
on hold until we agree how to move forward. Maybe Dmitry can comment
on that? Because I see no point of introducing ABS2 if we later decide
to not add ABS_* bits for all the different axes.

Thanks
David
