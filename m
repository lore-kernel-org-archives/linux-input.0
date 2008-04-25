From: Sebastian Siewior <al+sa@ml.breakpoint.cc>
Subject: Re: [alsa-devel] [RFC] ucb1400 touchscreen, irq auto probing and
	ac97 with its private field
Date: Fri, 25 Apr 2008 14:49:08 +0200
Message-ID: <20080425124908.GA7152@Chamillionaire.breakpoint.cc>
References: <s5hr6cvb5f3.wl%tiwai@suse.de> <20080424185658.GA19029@sirena.org.uk> <s5h8wz24dto.wl%tiwai@suse.de> <Pine.LNX.4.61.0804250906090.7882@tm8103.perex-int.cz> <s5h4p9q4d2e.wl%tiwai@suse.de> <Pine.LNX.4.61.0804250931050.7882@tm8103.perex-int.cz> <s5hve26v0aw.wl%tiwai@suse.de> <Pine.LNX.4.61.0804251008270.7882@tm8103.perex-int.cz> <20080425105429.GA5664@Chamillionaire.breakpoint.cc> <s5habjikx5k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-input-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:54531 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751640AbYDYMtS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2008 08:49:18 -0400
Content-Disposition: inline
In-Reply-To: <s5habjikx5k.wl%tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@opensource.wolfsonmicro.com>, dtor@mail.ru, Dmitry Torokhov <dmitry.torokhov@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, linux-input@vger.kernel.org

* Takashi Iwai | 2008-04-25 13:10:31 [+0200]:

>> Why is it a problem to keep an anonymous struct?
>
>You describe in your text below :)
Right :D

>> If some one uses a
>> wrong struct than it crashes immediatelly or bails out because
>> 0x20495251 is way too large be an IRQ. Putting that magic and casting
>> for every single possible data blows code for no good reason. Don't
>> recover from errors which should not have happen, solve them at root
>> level not where the leaves are.
>
>The root level of the problem is that you pass the anonymous data.
>It _IS_ unsafe and wrong unless handled properly.
Yes and this should not happen in my perfect world :)

>
>> What I intended in first place is to allocate a private field in the bus
>> struct so can pass informations to the lower driver.
>
>As mentioned in my earlier mail, I'm fine with your first patch.  The
>problem occurs when we generalize it.
Generalize? You mean once you need an array of multiple parameters like
struct ressource where the controler driver and device driver are
independent and don't know each other? In this case I understand why you
prefered the int irq over the void pointer.

>> If you need
>> multiple arguments, create your own struct put it in the void * slot,
>> your driver knows what to do.
>
>Your driver does _not_ know what type it is because the data isn't
>created by your driver but the controller driver.  And, it's free to
>attach your driver to any controller.
Sure. But why should the controller attach data that is not desired for
the driver chip? So if the ucb1400 gets probed with private data that is
desired for another driver it will bail out after checking the device
id and nothing happens. In my case the controller knows that there is
ucb1400 touchscreen attached and I can't imagine why the controller
shouldn't know.

>thanks,
>
>Takashi

Sebastian
