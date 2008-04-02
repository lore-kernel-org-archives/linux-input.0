From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: 2.6.25-rc5.git4 regression PS/2 mouse not detected/working
Date: Wed, 2 Apr 2008 13:44:56 -0400
Message-ID: <20080402134351.ZZRA012@mailhub.coreip.homeip.net>
References: <1205775229.25146.11.camel@indigo.declera.com> <200804022038.33245.balajirrao@gmail.com> <20080402113043.ZZRA012@mailhub.coreip.homeip.net> <200804022300.14164.balajirrao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:10557 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756593AbYDBRpC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Apr 2008 13:45:02 -0400
Received: by py-out-1112.google.com with SMTP id u52so3906236pyb.10
        for <linux-input@vger.kernel.org>; Wed, 02 Apr 2008 10:45:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200804022300.14164.balajirrao@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Balaji Rao <balajirrao@gmail.com>
Cc: Yanko Kaneti <yaneti@declera.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, Thomas Gleixner <tglx@linutronix.de>

On Wed, Apr 02, 2008 at 11:00:13PM +0530, Balaji Rao wrote:
> On Wednesday 02 April 2008 09:03:28 pm Dmitry Torokhov wrote:
> > Hi Blaji,
> > 
> > On Wed, Apr 02, 2008 at 08:38:33PM +0530, Balaji Rao wrote:
> > > 
> > > Coincidentally even I hit upon this bug a couple of days ago after enabling 
> > > HPET in my BIOS. A quick check told me that IRQ 12 which the patch assigns to 
> > > the HPET device is used by the PS/2 mouse as well. This makes the mouse 
> > > inactive.
> > > 
> > > I am working on this.. I am not sure if the PS/2 code is misbehaving though..
> > >
> > 
> > Normally IRQ12 can not be shared on X86 if PS/2 mouse is present.
> > If PCI side tries to grab the IRQ then ISA (legacy) side will never
> > see its interrupts coming.
> > 
> OK. So, I need to specifically check for IRQ12 being assigned and avoid it ?
> 

Yeah.. I think there are other legacy IRQs that should be avoided as well.
I am pretty sure Ingo would have a better idea which they are.

-- 
Dmitry
