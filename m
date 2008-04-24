From: Sebastian Siewior <al+sa@ml.breakpoint.cc>
Subject: Re: [alsa-devel] [RFC] ucb1400 touchscreen, irq auto probing and
	ac97 with its private field
Date: Thu, 24 Apr 2008 17:35:20 +0200
Message-ID: <20080424153520.GC26452@Chamillionaire.breakpoint.cc>
References: <20080424140459.GB24212@Chamillionaire.breakpoint.cc> <20080424145749.GB22369@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-input-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:35082 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753830AbYDXPfZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Apr 2008 11:35:25 -0400
Content-Disposition: inline
In-Reply-To: <20080424145749.GB22369@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@mail.ru, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-input@vger.kernel.org

* Mark Brown | 2008-04-24 15:57:52 [+0100]:

>On Thu, Apr 24, 2008 at 04:04:59PM +0200, Sebastian Siewior wrote:
>
>> I've sent a RFC to the alsa mailing list [1] about adding an extra field in
>> order to pass the IRQ from the AC97 driver to the ucb1400 driver. The
>> result was:
>
>> Now I'm curious what solution the people here prefer:
>> - adding a private field [1] (my favorite)
>
>As I indicated in reply to your initial RFC any such private field
>ought to be a void * in order to allow other information to be passed
>through to drivers.
I got that.

>Note that this will also need changes in all the relevant AC97 drivers
>to support getting the private data from platform/machine definition
>code to the relevant driver using whatever methods are appropriate for
>the platform.
Sure. I haven't found any driver that needs any extra information. For
instance a board that uses ucb1400_ts and gets the interrupt via auto
probing can't be auto converted due to -ENOCLUE. Therefore the ucb1400
driver acts like before if the private field is NULL.

>> - hacking up the ucb1400 [2] (doesn't solve [3] and needs addition code
>>   to solve [4]).
>
>[3] is the issue with the WM97xx touchscreen drivers.  That's currently
>solved by exactly this issue - as far as I can see from the patch you
>cite you're using OpenFirmware.  In that case isn't modifying the driver
>to query OpenFirmware an idiomatic solution anyway (though it still
>leaves other platforms in the lurch)?
Not really. I have to parse the whole device tree and pick one single
value. This isn't done by any other driver as far as I can see and it
equals a global variable.
My device tree currently looks like the following:

|                ac97@f0000400 {
|                        compatible = "fpga-ac97";
|                        reg = <f0000400 100>;
|                        interrupts = <5 1>;
|                        interrupt-parent = <&mpic>;
|                        ucb1400@ac97 {
|                                compatible = "Phillips,ucb1400_ts"
|                                interrupts = <9 0>;
|                                interrupt-parent = <&mpic>;
|                        }
|                };

Now, while I get auto probed for my device (fpga-ac97) I grab and setup
the IRQ for the ucb1400_ts device and pass the IRQ-number in the ac97
struct. If you have a platform driver you can still do something like:

|static struct resource smc91x_resources[] = {
|        {
|                .start = 0x20200300,
|                .end = 0x20200300 + 16,
|                .flags = IORESOURCE_MEM,
|        }, {
|                .start = IRQ_PF0,
|                .end = IRQ_PF0,
|                .flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
|        },
|};
|static struct platform_device smc91x_device = {
|        .name = "smc91x",
|        .id = 0,
|        .num_resources = ARRAY_SIZE(smc91x_resources),
|        .resource = smc91x_resources,
|};

and add another IORESOURCE_IRQ field with holds the interrupt number for
your ac97 device (in case of ucb1400_ts or some other thing for a total
different driver). The ucb1400_ts driver itself does not care anymore
because it is getting this information from the ac97 struct.

>> - something totally different what did not come to my attention yet.
>
>Something that worked for more than just AC97 would be nice - a method
>for getting platform data to drivers for devices on buses that are
>normally autoprobed.
I thing here is a miss understanding. What would be something beside
ac97? Gimme a real world example plz. According to grep ucb1400 is the
driver attached to ac97 bus (well, nothing else matches on ac97_bus_type
except the sound & codec thing in sound/ which don't need any extra
parameters).

Sebastian
