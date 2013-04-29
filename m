From: Leon Romanovsky <leon@leon.nu>
Subject: Re: [alsa-devel] [PATCH] ASoC: wm8962: Convert to devm_input_allocate_device()
Date: Mon, 29 Apr 2013 21:52:34 +0300
Message-ID: <CALq1K=+4bz0RtuxK=sOEr_k1y2e5x67oUFbo8T7cs0t2vX+54Q@mail.gmail.com>
References: <1356009506-4766-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CALq1K=+sJUZ++_sMkU1Sg9+aE-HpF1tnfPHGCEJ789hj19Yp9A@mail.gmail.com>
 <20130425125234.GV5019@opensource.wolfsonmicro.com> <CALq1K=+ViDvsCZDR5KndX-T1Dt6tghPjiP7F6wm+npYOw2DE1A@mail.gmail.com>
 <20130428094745.GA5877@sirena.org.uk> <CALq1K=+=J9oPGvbrXuhS=Bgqj+viC5EAkTHKkNuHxBadExpXdA@mail.gmail.com>
 <20130429101959.GE5019@opensource.wolfsonmicro.com> <CALq1K=KGrDJZa_w_ZVdriptpiKsWvwYDcx3aV3oVXMyTxMjcqg@mail.gmail.com>
 <20130429180727.GA3915@core.coreip.homeip.net> <20130429181903.GB3915@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:63031 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757521Ab3D2Swz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Apr 2013 14:52:55 -0400
Received: by mail-vc0-f174.google.com with SMTP id hf12so1077031vcb.33
        for <linux-input@vger.kernel.org>; Mon, 29 Apr 2013 11:52:55 -0700 (PDT)
In-Reply-To: <20130429181903.GB3915@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, patches <patches@opensource.wolfsonmicro.com>, linux-input@vger.kernel.org

On Mon, Apr 29, 2013 at 9:19 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Apr 29, 2013 at 11:07:28AM -0700, Dmitry Torokhov wrote:
>> On Mon, Apr 29, 2013 at 08:47:37PM +0300, Leon Romanovsky wrote:
>> > On Mon, Apr 29, 2013 at 1:19 PM, Mark Brown <broonie@kernel.org> wrote:
>> > > On Sun, Apr 28, 2013 at 09:32:18PM +0300, Leon Romanovsky wrote:
>> > >
>> > >> I think the reason of our misunderstanding is due to the name of
>> > >> input_free_device call. From the code, it is device destroy function,
>> > >> and the freeing itself done as an error handling of
>> > >> input_register_device
>> > >> (http://lxr.free-electrons.com/source/drivers/input/input.c#L2114).
>> > >
>> > >> How do you think we need to proceed? Do I need to send patches with
>> > >> explicit call to input_free_device function?
>> > >
>> > > I really think the input API needs to be looked at here, this is all way
>> > > too error prone.  Calling input_free_device() on something allocated
>> > > using devm_ looks like an error itself...
>> > In general, I agree with you, but I think we both agree that the
>> > current patch is not working as expected.
>> > The problem is that you allocated device with devm_ and later at the
>> > code you tried to register it, but failed. In this case no one will
>> > call to devres_destroy, because it is done at unregister stage only.
>> >
>> > I see two possible solutions:
>> > 1. short one - fix your patches
>> > 2. long one - add input_free_device code into input_register_device
>> > call (http://lxr.free-electrons.com/source/drivers/input/input.c#L2114).
>> >
>>
>> The rules are pretty straightforward:
>>
>> 1. If you are using devm_input_allocate_device() you do not need to call
>> input_free_device() nor input_unregister_device()  - the core will
>> create a devres structure for freeing the device and if
>> input_register_device() succeeds it will also add a 2nd devres for
>> unregistering. This way the "normal" unwind is a 2-step process with
>> device is "half alive" and being able to survive input_event() calls
>> from IRQ handlers if they are still alive.
>>
>> IOW  it should all "just work".
>>
>> 2. If you are using input_allocate_device() then you need to call
>> input_free_device() until you called input_register_device(), afterward
>> input_unregister_device() should be called.
>>
>
> BTW, looking at Marks patch it looks good to me.
Dmitry, thanks for the explanation.

Mark, please take my apologies, I was mislead by the following comment
on the code:
http://lxr.free-electrons.com/source/drivers/input/input.c#L1825
1822  * input_free_device - free memory occupied by input_dev structure
1823  * @dev: input device to free
1824  *
1825  * This function should only be used if input_register_device()
1826  * was not called yet or if it failed.

>
> --
> Dmitry



--
Leon Romanovsky | Independent Linux Consultant
        www.leon.nu | leon@leon.nu
