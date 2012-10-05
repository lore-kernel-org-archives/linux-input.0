From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 1/5] Input: wacom - Allow any multi-input Intuos device to
 set prox
Date: Fri, 5 Oct 2012 15:26:03 -0700
Message-ID: <CANRwn3TmuTH=QaCmxUeeEUradchZZgsHDo1xMo3t68c2k_gRSQ@mail.gmail.com>
References: <1346972010-1330-1-git-send-email-killertofu@gmail.com>
	<CAF8JNhKrkbLCTLUpsWJVCbgtdaDSYa1S7tdH=KHi=LXXc2Ac7w@mail.gmail.com>
	<CANRwn3Qjx75e5tXu0bSredFOrscYJ2SuWZ+myU=866Aa0tTzmQ@mail.gmail.com>
	<20121004072519.GC14217@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33651 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753099Ab2JEW0G (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Oct 2012 18:26:06 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1873679wgb.1
        for <linux-input@vger.kernel.org>; Fri, 05 Oct 2012 15:26:03 -0700 (PDT)
In-Reply-To: <20121004072519.GC14217@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ping Cheng <pinglinux@gmail.com>, linux-input@vger.kernel.org, chris@cnpbagwell.com

On Thu, Oct 4, 2012 at 12:25 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Jason,
>
> On Mon, Oct 01, 2012 at 10:09:24AM -0700, Jason Gerecke wrote:
>> On Fri, Sep 28, 2012 at 2:18 PM, Ping Cheng <pinglinux@gmail.com> wrote:
>> > On Thu, Sep 6, 2012 at 3:53 PM, Jason Gerecke <killertofu@gmail.com> wrote:
>> >> The ability to set the proximity flag should apply to any device
>> >> that has both pen and touch input. Rather than listing classes of
>> >> devices known to meet this criteria, simply filter on the quirk
>> >> defining all such devices.
>> >>
>> >> Signed-off-by: Jason Gerecke <killertofu@gmail.com>
>> >
>> > Tested-by: Ping Cheng <pingc@wacom.com> for the whole set.
>> >
>> > Dmitry, do you have questions about this patchset and "input: wacom:
>> > Report correct touch contact size for I5/Bamboo"? We hope they can be
>> > merged soon since we have more patches coming.
>> >
>> > Thank you.
>> >
>> > Ping
>> >
>> The 24HD touch patches from September 6th as well ("Input: wacom - Add
>> touch sensor support for Cintiq 24HD touch"). I was hoping to get them
>> accepted before yesterday's 3.7 merge window opened.
>>
>
> Could you please take a peek at my 'next' branch and see if anything
> wacom-related is missing?
>
> Thanks!
>
> --
> Dmitry

That appears to be everything I had outstanding. I'll rewrite and
resubmit the two Cintiq patches you had to drop due to merge issues.

Jason

---
When you're rife with devastation / There's a simple explanation:
You're a toymaker's creation / Trapped inside a crystal ball.
And whichever way he tilts it / Know that we must be resilient
We won't let them break our spirits / As we sing our silly song.
