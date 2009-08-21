From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] [ARM] pxa/em-x270: add synaptics_i2c touchpad
Date: Fri, 21 Aug 2009 16:16:14 +0200
Message-ID: <20090821141614.GC1456@ucw.cz>
References: <cover.1245156138.git.mike@compulab.co.il> <4A65207A.8070909@gmail.com> <20090729150859.GK1534@ucw.cz> <4A7071CD.9020303@compulab.co.il> <20090804131455.GG18974@elf.ucw.cz> <4A792913.8040006@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755825AbZHVMAc@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4A792913.8040006@compulab.co.il>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk, kernel list <linux-kernel@vger.kernel.org>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi!

> >>>>> This patch set adds synaptics_i2c touchpad device registration for the exeda
> >>>>> platform together with voltage reulator glue needed to enable the touchpad
> >>>>> controller.
> >>>>>
> >>> Hmm, t-mobile g1 uses synaptics touchpad connected over i2c, too... Is
> >>> there chance they are compatible or at least similar?
> >> The touchpad controller I have uses the same RMI protocol that g1 does, but it
> >> supports different register set. Besides, g1 has a *touchscreen* and exeda has
> >> 1.5cm x 1.5cm  *touchpad*.
> > 
> > Can we get some code shared? It still looks similar enough.
> 
> The controller detection and basic initialization (report rate, filtering, Z
> Clip) seems to be the same. But afterwards things begin to diverge. For
> instance, g1 reads and parses 15 bytes of data, whilst my touchpad has only 9
> data registers.
> It seems to me that it should be possible to share initialization and basic
> register access, and have different work functions and input events reporting.
> 
> Probably if we had full implementation of Synaptics RMI protocol we could have
> single driver for all RMI-compatible Synaptics devices. RMI states that device
> can report what functionality it supports and based on that it should be
> possible to provide appropriate event parsing and reporting.

Thanks for info. It seems like merging them is project far ahead...

       	   	    	       	       	       	       	   Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
