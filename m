From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: wm8962: Convert to
 devm_input_allocate_device()
Date: Mon, 29 Apr 2013 11:19:04 -0700
Message-ID: <20130429181903.GB3915@core.coreip.homeip.net>
References: <1356009506-4766-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CALq1K=+sJUZ++_sMkU1Sg9+aE-HpF1tnfPHGCEJ789hj19Yp9A@mail.gmail.com>
 <20130425125234.GV5019@opensource.wolfsonmicro.com>
 <CALq1K=+ViDvsCZDR5KndX-T1Dt6tghPjiP7F6wm+npYOw2DE1A@mail.gmail.com>
 <20130428094745.GA5877@sirena.org.uk>
 <CALq1K=+=J9oPGvbrXuhS=Bgqj+viC5EAkTHKkNuHxBadExpXdA@mail.gmail.com>
 <20130429101959.GE5019@opensource.wolfsonmicro.com>
 <CALq1K=KGrDJZa_w_ZVdriptpiKsWvwYDcx3aV3oVXMyTxMjcqg@mail.gmail.com>
 <20130429180727.GA3915@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:57118 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754931Ab3D2STH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Apr 2013 14:19:07 -0400
Received: by mail-da0-f46.google.com with SMTP id x4so2496017daj.5
        for <linux-input@vger.kernel.org>; Mon, 29 Apr 2013 11:19:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130429180727.GA3915@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Leon Romanovsky <leon@leon.nu>
Cc: Mark Brown <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, patches <patches@opensource.wolfsonmicro.com>, linux-input@vger.kernel.org

On Mon, Apr 29, 2013 at 11:07:28AM -0700, Dmitry Torokhov wrote:
> On Mon, Apr 29, 2013 at 08:47:37PM +0300, Leon Romanovsky wrote:
> > On Mon, Apr 29, 2013 at 1:19 PM, Mark Brown <broonie@kernel.org> wrote:
> > > On Sun, Apr 28, 2013 at 09:32:18PM +0300, Leon Romanovsky wrote:
> > >
> > >> I think the reason of our misunderstanding is due to the name of
> > >> input_free_device call. From the code, it is device destroy function,
> > >> and the freeing itself done as an error handling of
> > >> input_register_device
> > >> (http://lxr.free-electrons.com/source/drivers/input/input.c#L2114).
> > >
> > >> How do you think we need to proceed? Do I need to send patches with
> > >> explicit call to input_free_device function?
> > >
> > > I really think the input API needs to be looked at here, this is all way
> > > too error prone.  Calling input_free_device() on something allocated
> > > using devm_ looks like an error itself...
> > In general, I agree with you, but I think we both agree that the
> > current patch is not working as expected.
> > The problem is that you allocated device with devm_ and later at the
> > code you tried to register it, but failed. In this case no one will
> > call to devres_destroy, because it is done at unregister stage only.
> > 
> > I see two possible solutions:
> > 1. short one - fix your patches
> > 2. long one - add input_free_device code into input_register_device
> > call (http://lxr.free-electrons.com/source/drivers/input/input.c#L2114).
> > 
> 
> The rules are pretty straightforward:
> 
> 1. If you are using devm_input_allocate_device() you do not need to call
> input_free_device() nor input_unregister_device()  - the core will
> create a devres structure for freeing the device and if
> input_register_device() succeeds it will also add a 2nd devres for
> unregistering. This way the "normal" unwind is a 2-step process with
> device is "half alive" and being able to survive input_event() calls
> from IRQ handlers if they are still alive.
> 
> IOW  it should all "just work".
> 
> 2. If you are using input_allocate_device() then you need to call
> input_free_device() until you called input_register_device(), afterward
> input_unregister_device() should be called.
> 

BTW, looking at Marks patch it looks good to me.

-- 
Dmitry
