From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [rtc-linux] RE: [PATCH V3 1/4] mfd: da9062: DA9062 MFD core
 driver
Date: Thu, 11 Jun 2015 23:46:29 +0200
Message-ID: <20150611214629.GA3890@piout.net>
References: <cover.1432041031.git.stwiss.opensource@diasemi.com>
 <ecf72b79429e6758111a908fd1ded29c0b96da15.1432041031.git.stwiss.opensource@diasemi.com>
 <20150526161024.GQ11677@x1>
 <6ED8E3B22081A4459DAC7699F3695FB7014B22F4C4@SW-EX-MBX02.diasemi.com>
 <20150611085653.GG2982@x1>
 <6ED8E3B22081A4459DAC7699F3695FB7014B22F4DC@SW-EX-MBX02.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:36363 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753370AbbFKVqc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Jun 2015 17:46:32 -0400
Content-Disposition: inline
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7014B22F4DC@SW-EX-MBX02.diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Cc: Lee Jones <lee.jones@linaro.org>, LINUXKERNEL <linux-kernel@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Alessandro Zummo <a.zummo@towertech.it>, DEVICETREE <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>

Hi,

On 11/06/2015 at 09:27:45 +0000, Opensource [Steve Twiss] wrote :
> 
> Thanks for replying so quickly.
> 
> > I'm still not particularly happy with this.  Can yo speak to your H/W
> > guys and get them to change their scripts to output sensible header
> > files?
> 
> Ah. Ok. 
> 
> For our side, the generated headers might not just be used for Linux. I've
> just discussed this with my colleagues and they will need it to remain.
> So I guess internally we will keep the headers like this, but as it enters
> my submission process I can change it for the Linux community.
>  
> > To be honest, it's probably not a blocker for acceptance, but if someone
> > writes a patch next week to change all of the (0x01 << X) lines to
> > start using the BIT() macro, I will accept it.  Better to influenced
> > your guys so you are not overly inconvenienced.
> 
> Yep: I will change this BIT() macro for the submissions in future.
> Depending on the next step, I will send a patch to this or update the submission
> if there are further comments on this patch set.
> 

Maybe a good solution would be to define BIT() at the top of your
generated header so that you simply have to remove it or replace it with
the proper include before mainline submission.

> > FWIW, when upstreaming code, the excuse "someone else wrote it", has
> > never been a good one to use on the lists.   Believe me, I've
> > tried. ;)
> 
> heh okay :)
> 
> Regards,
> Steve
> 
> -- 
> -- 
> You received this message because you are subscribed to "rtc-linux".
> Membership options at http://groups.google.com/group/rtc-linux .
> Please read http://groups.google.com/group/rtc-linux/web/checklist
> before submitting a driver.
> --- 
> You received this message because you are subscribed to the Google Groups "rtc-linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
