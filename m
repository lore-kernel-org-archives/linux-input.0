From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [RFC] Port of hid-egalax to the unified hid-multitouch driver
Date: Tue, 8 Mar 2011 16:12:49 +0100
Message-ID: <AANLkTik3J+bpiC_5JQkbJoQ0mKQoA6ZtxGCDEs1SJGrc@mail.gmail.com>
References: <1299417883.9645.494.camel@itzy>
	<AANLkTikWm3iBwqSTsQZWsLZ4b_q2aScUEo4dW9GJ9Kcz@mail.gmail.com>
	<alpine.LNX.2.00.1103081413220.19969@pobox.suse.cz>
	<20110308132925.GA19098@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57555 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754588Ab1CHPMv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Mar 2011 10:12:51 -0500
Received: by wwa36 with SMTP id 36so1254893wwa.1
        for <linux-input@vger.kernel.org>; Tue, 08 Mar 2011 07:12:49 -0800 (PST)
In-Reply-To: <20110308132925.GA19098@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, Richard Nauber <richard.nauber@googlemail.com>, linux-input@vger.kernel.org

On Tue, Mar 8, 2011 at 14:29, Henrik Rydberg <rydberg@euromail.se> wrote:
>> > This reminds me that we have to switch the other drivers to
>> > hid-multitouch too.
>>
>> That would be nice. I don't see this really being done for the upcoming
>> merge window, right Benjamin?
>
> There has been no activity in that direction here either...

I've got Stantum, Cando and 3m that can be merged right now. I mean
that they have been tested and do not have regressions (crossing
fingers).
This let Quanta and Mosart. I'm sure they worked some weeks ago, but
I'm not sure (tested the last few days) ATM.

If you want, I can send the three that goes well, and for the other,
we'll see for 2.6.40.
I have the auto-detection of contact counts that could go for 2.6.39 as well.

Cheers,
Benjamin

>
>> > Actually, I was not in favor of porting this driver into hid-multitouch.
>> > eGalax has two differents protocols: one for resistive technology (which
>> > is compatible with hid-multitouch in its current form), and one for
>> > capacitive technology (which requires the "corrupt packet length"
>> > quirk).
>> >
>> > Apparently, according to the kernel logs the Samsung MB30 is a resistive
>> > technology (correct me if I'm wrong). This means that we also need
>> > testings for the capacitive one.
>> >
>> > I'll let the community decide whether we should include this in
>> > hid-multitouch. Henrik, Jiri, any idea?
>>
>> Either directly hid-multitouch, or hid-multitouch-capacitive sub-module
>> should be fine.
>
> Maybe it is obvious already, but I think the patch is great. There is
> really no reason to split the driver - in particular given that the
> manufacturer has ensured similar behavior from both types.
>
> Thanks,
> Henrik
>
