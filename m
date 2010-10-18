From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 2/3] Support enable Acer Launch Manager mode
Date: Mon, 18 Oct 2010 10:40:13 +0200
Message-ID: <AANLkTim-ONsOdJx+y5wqtLUr+k25KQJu4HS6O1cmgGHu@mail.gmail.com>
References: <4CBC4C660200002300022008@novprvlin0050.provo.novell.com>
	<201010180819.36661.carlos@strangeworlds.co.uk>
	<AANLkTim4qnrn274dfYLBzhHMnA2BWHvVrUNn1DqLnc13@mail.gmail.com>
	<20101018081452.GB8655@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:42574 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322Ab0JRIkP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Oct 2010 04:40:15 -0400
In-Reply-To: <20101018081452.GB8655@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Joey Lee <jlee@novell.com>, Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, mjg59@srcf.ucam.org, jbenc@suse.cz, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org

On Mon, Oct 18, 2010 at 10:14 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Oct 18, 2010 at 09:55:57AM +0200, Corentin Chary wrote:
>> On Mon, Oct 18, 2010 at 9:19 AM, Carlos Corbacho
>> <carlos@strangeworlds.co.uk> wrote:
>> > On Monday 18 October 2010 03:32:22 Joey Lee wrote:
>> >> So, we choice remove rfkill-input then put the logic in x86/platform
>> >> driver?
>> >> A simple question:
>> >> Userland policy daemon or kernel module, which one we want to put the
>> >> wifi hotkey behavior implementation?
>> >
>> > Pass. I really have no opinion on the above, as long as we pick something and
>> > stick with it (i.e. not-another-rfkill-rewrite).
>> >
>> >> > We don't have Launch Manager for Linux, and quite frankly, I hope we
>> >> > never see it - relying on random, vendor specific applications to drive
>> >> > this kind of functionality is just asking for trouble.
>> >>
>> >> Acer BIOS team provide the function to OS for disable the EC hehavior,
>> >> it's available on window, why we hide it on Linux?
>> >
>> > As an aside, just because Windows does something is not a good reason to do it
>> > or expose on on Linux if it doesn't make any sense.
>> >
>> >> Either userland daemon or kernel module who want to implement the wifi
>> >> hotkey behavior, it need enable the launch-manager mode to disable the
>> >> default EC behavior on wifi hotkey.
>> >
>> > When did Acer laptops start doing this then? The behaviour they always did in
>> > the past was that pressing the wireless/ bluetooth/ 3G button sent out a
>> > scancode, and is was then the job of something else to catch that (be it
>> > rfkill-input or friends) and for that something else to then toggle the state.
>> >
>> > Do the current batch of laptops then just 'magically' toggle the state without
>> > needing rfkill-input?
>> >
>> > (And do you actually have contact with someone on the Acer BIOS team? Because
>> > I've never managed to get through to anyone at Acer, so would be interested to
>> > know).
>> >
>> >> If don't want provide the launch-manager mode parameter to userland, can
>> >> we just direct enable it?
>> >
>> > Well, my point is more that we should figure out what we want, and then stick
>> > with that. I don't want to add a pointless module paramater that all of three
>> > people are ever going to use, and then have to support it working both ways.
>> >
>> > -Carlos
>>
>> asus-laptop laptop also has that kind of parameter, but mainly because
>> the behavior of the toggle key is quite random across models. So we
>> need to set it sometimes.
>
> Why sometimes?

The parameter we're talking about is wapf, it's directly linked to WAPF
in the dsdt. WAPF is a bitmask used to control the behavior of the toggle key.
It can: control the device,  control the leds, send key codes.

Here is some doc about what we found on wapf:
https://dev.iksaif.net/projects/acpi4asus/wiki/Asus-laptop_WAPF

By default, we currently write 1 into wapf, because this is the value that
works correctly most of the time. But on some models, the key won't do
anything if you don't set the correct value of wapf.

On windows, the hotk acpi driver (from asus) also sets WAPF, but
if seems to do some hardware check to guess the value to use ... Then
it also handles events, and do actions (toggle wlan devices, etc...).

But all the WAPF/BLED/WLED stuff on asus-laptop isn't really working
properly, mainly because I lacks documentation, and the behavior seems
to be dependent of present hardware (wlan cards mainly).

>>
>> Anyway, I think it's a good thing to have the choice between "handled by
>> hardware/BIOS" and "handled by kernel/userspace", as long as the default choice
>> is coherent and always works correctly.
>
> No, I disagree. Why would you want to have this choice and have to
> maintain it if we already have mechanisms to do it either in kernel or
> in userspace.
>>
>> Most of users will want the key to just toggle wlan/bluetooth. But some of them
>> will be happy if they can configure the behavior of the key (cycle, only toggle
>> WLAN, etc...)
>
> Right. And as of today by default kernel will do simple toggle but there
> is an option for userspace component. Why do we want to bing BIOS into
> the picture?

Because we should consider the BIOS as a fallback method (that may or
may not work). If a newer model comes out, and the kernel/userspace doesn't
know how to handle it, users will be able to use the BIOS while the
driver is being fixed.

-- 
Corentin Chary
http://xf.iksaif.net
