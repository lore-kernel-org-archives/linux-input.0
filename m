From: Jason Ekstrand <jason@jlekstrand.net>
Subject: Re: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Mon, 16 Mar 2015 10:10:40 -0700
Message-ID: <CAOFGe97na_mw-_AHJn6zyxVb-kDAxntjEgvXRcy6eg7uPfhQ8A@mail.gmail.com>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com>
	<201502202141.16017@pali>
	<54EE1917.4020805@dell.com>
	<201502252145.22577@pali>
	<CAN+gG=EY-gyNKyEyfXw8hTDL8L4TR8OQLM2g+uLUUv_HM3mHWA@mail.gmail.com>
	<5506E8D2.60207@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5506E8D2.60207@dell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Rob <robr.bensson@gmail.com>
List-Id: linux-input@vger.kernel.org

On Mon, Mar 16, 2015 at 7:29 AM, Mario Limonciello
<mario_limonciello@dell.com> wrote:
>
> On 03/14/2015 02:17 PM, Benjamin Tissoires wrote:
>>
>> [top posting, sorry]
>>
>> Jason made some interesting progress today:
>> with the patch in https://lkml.org/lkml/2015/3/12/149, the sound card
>> is not switched in the I2S mode and works while the touchpad keeps
>> using I2C.
>> It looks like suspend/resume is also fixed by that :)
>>
>> I thought it was worth mentioning to the people in this thread.
>>
>> Cheers,
>> Benjamin
>
> Benjamin,
>
> Thanks for reporting the progress to me.
>
> Jason,
>
> Are you sure upon the particulars of what's happening here?  That patch only
> modifies the behavior of how the EC is configured.
> I'm not aware of any suspend/resume issues, especially related to the EC, so
> that really surprises me.  My initial suspicion is a suspend/resume issue
> you encountered was rare enough that you just haven't hit it yet even with
> that patch applied.  Maybe something in the out of kernel Broadcom wireless
> driver if you are still using the Broadcom card with it.

It's nothing about the wireless.  I swapped it out for an intel card
on day 3 or so.

Yes, I am almost 100% sure that this affects suspend/resume.  Prior to
the _REV hack, my laptop *never* suspended correctly.  Now it
regularly suspends just fine.  I also double-checked that rebasing on
Linus' master didn't affect it.  With the _REV hack it doesn't
suspend.  Without it, it's just fine.

I don't know much about suspend/resume but is it possible that the
problem is the kernel not being able to properly shut down the sound
card?

> I believe you are incorrect in the audio being put in HDA mode. It's more
> likely that it's operating closer to properly in I2S mode.  Here's some
> background around what that patch is doing.
> When this platform started development the Linux kernel didn't yet respond
> true to Windows 2013.  All our validation for Linux happened on kernel 3.13.

That matches what I've seen.  With the _REV hack, I see nothing about
HDA in dmesg and I get different audio messages than with an _OSI of
Windows 2009.

> _OSI of Windows 2009 is supposed to set it for PS2 mouse, HDA device in ACPI
> and configure the EC to set up the Realtek codec for HDA mode.  Linux was
> planned to mirror this behavior during development.
> _OSI of Windows 2013 is supposed to set it up for I2C mouse, I2S audio in
> ACPI and configure the EC to set up the Realtek codec for I2S mode.
>
> From when the platform was in development a _REV check was put in for
> Windows 2013 to make sure that in case the kernel started to respond to
> Windows 2013 we would still have it running in the intended modes for Linux.
> There was a mistake in this _REV check though that caused the I2S ACPI
> device but to misconfigure the EC. The reason _REV = 2 and _OSI = Windows
> 2013 you are getting working audio is the rt286 driver is starting to be
> used.  You can validate this by looking at dmesg for lines about rt286.
> Realtek recently submitted some patches for this at Dell's request. There
> are still a variety of issues with the I2S driver including jack detection
> and some other microphone issues.  Pulseaudio will possibly need some
> patches to work properly with this device too. Ideally we don't want
> customers to use I2S mode on Linux until it's solid.
>
> I don't believe this was in Linus' tree yet, so if you don't have it you can
> apply it and it should fix at least one microphone issue when in I2S mode.
> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-March/088724.html
>
> Whether or not that _REV patch gets applied to the kernel we are fixing this
> incorrect behavior for Windows 2013 _OSI and Linux in upcoming BIOS A02.
> In BIOS A02 there will still be a _REV check but it will do this:
> Windows 2013 _OSI, _REV 5: I2C mouse, HDA device in ACPI, configure EC for
> HDA mode.
> Windows 2013 _OSI, _REV 2: I2C mouse, I2S device in ACPI, configure EC for
> I2S mode.

I look forward to seeing the update.  Thanks for working on this!
--Jason Ekstrand
