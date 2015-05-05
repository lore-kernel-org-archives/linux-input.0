From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH V3 3/3] mfd: da9063: MFD support for OnKey driver
Date: Tue, 5 May 2015 10:52:17 +0200
Message-ID: <CAMuHMdWjSUqtrOC=CvhKQFb2oBHTJYSPUJknf_o92P=OuLS3NQ@mail.gmail.com>
References: <cover.1430393194.git.stwiss.opensource@diasemi.com>
	<639fd177d5ddd4ce80df45f9d774cc971b286ef9.1430393194.git.stwiss.opensource@diasemi.com>
	<CAMuHMdW43GHj-iO1F9gjHsjYOvvycjrP6WPyCKSOvcpcwPsM-w@mail.gmail.com>
	<6ED8E3B22081A4459DAC7699F3695FB7014B219017@SW-EX-MBX02.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:34463 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031013AbbEEIwS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 May 2015 04:52:18 -0400
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7014B219017@SW-EX-MBX02.diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Cc: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, DT <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, INPUT <linux-input@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>

Hi Steve,

On Tue, May 5, 2015 at 10:36 AM, Opensource [Steve Twiss]
<stwiss.opensource@diasemi.com> wrote:
> On 04 May 2015 08:47, Geert Uytterhoeven wrote:
>> On Thu, Apr 30, 2015 at 1:26 PM, S Twiss <stwiss.opensource@diasemi.com>
>> wrote:
>> > Add MFD support for the DA9063 OnKey driver

>> > +static int da9063_clear_fault_log(struct da9063 *da9063)
>> > +{

>> > +}
>> > +
>> >  int da9063_device_init(struct da9063 *da9063, unsigned int irq)
>> >  {
>> >         struct da9063_pdata *pdata = da9063->dev->platform_data;
>> >         int model, variant_id, variant_code;
>> >         int ret;
>> >
>> > +       ret = da9063_clear_fault_log(da9063);
>> > +       if (ret < 0)
>> > +               dev_err(da9063->dev, "Cannot clear fault log\n");
>> > +
>> >         if (pdata) {
>> >                 da9063->flags = pdata->flags;
>> >                 da9063->irq_base = pdata->irq_base;
>>
>> The code above doesn't seem to match the patch description.
>> Can you please explain why it is needed?
>
> Yes, at first it does seem that the fault-log clearing function is unrelated to the
> "MFD support for the DA9063 OnKey driver", but there is an important connection
> that makes it essential for the OnKey driver in this case.
>
> I have made some explanation of the OnKey's operation in this thread here:
> https://lkml.org/lkml/2015/4/29/406
>
> But I only described the OnKey's point-of-view for case (4) of the "OnKey operation"
> Case (4): the long-long press and no key release -- the hardware power-cut when
> software is unable to respond (for whatever reason).
>
> In this case, if the software was not responsive and a hardware shutdown of the
> device was chosen, the FAULT_LOG would persist with information that would be
> accessible when the device was restarted: it would be possible to take action the
> next time the device was turned on again (maybe to trigger some mitigation exercise
> in the bootloader -- e.g. say to complete memory checks or put the device into a
> safe mode).
>
> However this mitigation exercise and clearance of the fault-log cannot be counted on
> outside the Linux kernel and so the clearance function da9063_clear_fault_log () has
> been done here.
>
> If this clearance function did not exist, then after a hardware shutdown (due to S/W
> failure), the next time the device is restarted the FAULT_LOG would persist with values
> from the previous error.

Thanks for your explanation!

Please add (some parts of it) to the patch description.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
