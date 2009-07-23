From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: A few changes to pxa27x_keypad
Date: Thu, 23 Jul 2009 02:24:57 -0700
Message-ID: <20090723092456.GA2512@dtor-d630.eng.vmware.com>
References: <20090721080845.GD10168@dtor-d630.eng.vmware.com> <4A659C28.3040305@compulab.co.il> <20090723063044.GD2782@dtor-d630.eng.vmware.com> <20090723072802.GB3997@dtor-d630.eng.vmware.com> <4A6827C9.2090203@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:54222 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053AbZGWJZB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jul 2009 05:25:01 -0400
Received: by rv-out-0506.google.com with SMTP id f6so231210rvb.1
        for <linux-input@vger.kernel.org>; Thu, 23 Jul 2009 02:25:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A6827C9.2090203@compulab.co.il>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: Eric Miao <eric.y.miao@gmail.com>, linux-input@vger.kernel.org

On Thu, Jul 23, 2009 at 12:05:13PM +0300, Mike Rapoport wrote:
> 
> 
> Dmitry Torokhov wrote:
> > On Wed, Jul 22, 2009 at 11:30:44PM -0700, Dmitry Torokhov wrote:
> >> On Tue, Jul 21, 2009 at 01:44:56PM +0300, Mike Rapoport wrote:
> >>> Hi Dmitry,
> >>>
> >>> Dmitry Torokhov wrote:
> >>>> Hi Eric,
> >>>>
> >>>> I made a few adjustments to the pxa27x_keypad driver and was wondering
> >>>> if you would be able to give it a sping and check if I broke it or not.
> >>> Apparently not :)
> >>> Tested-by: Mike Rapoport <mike@compulab.co.il>
> >>>
> >> Cool, thanks for testing. I have another one for you then ;)
> >>
> >> TIA!
> >>
> > 
> > Umm.. this one is hopefully better...
> > 
> > Input: pxa27x_keypad - switch to using dev_pm_ops
> > 
> > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> I've got this with 2.6.31-rc3
>   CC      drivers/input/keyboard/pxa27x_keypad.o
> drivers/input/keyboard/pxa27x_keypad.c:591: warning: initialization discards
> qualifiers from pointer target type
> 

Ah, yes... it needs my patch constifying the pm pointer that Rafael
picked up. Thank you for testing.

-- 
Dmitry
