From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: A few changes to pxa27x_keypad
Date: Fri, 4 Sep 2009 01:17:55 -0700
Message-ID: <20090904085054.0FFCC526EA5@mailhub.coreip.homeip.net>
References: <20090721080845.GD10168@dtor-d630.eng.vmware.com> <4A659C28.3040305@compulab.co.il> <20090723063044.GD2782@dtor-d630.eng.vmware.com> <20090723072802.GB3997@dtor-d630.eng.vmware.com> <20090723073625.GC3997@dtor-d630.eng.vmware.com> <20090904055259.5D44C526EA5@mailhub.coreip.homeip.net> <f17812d70909040045j688f1ae8la7b67e0acc813f9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f190.google.com ([209.85.222.190]:62590 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756596AbZIDITL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Sep 2009 04:19:11 -0400
Received: by pzk28 with SMTP id 28so621112pzk.27
        for <linux-input@vger.kernel.org>; Fri, 04 Sep 2009 01:19:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f17812d70909040045j688f1ae8la7b67e0acc813f9d@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Mike Rapoport <mike@compulab.co.il>, linux-input@vger.kernel.org

On Fri, Sep 04, 2009 at 03:45:42PM +0800, Eric Miao wrote:
> On Fri, Sep 4, 2009 at 1:20 PM, Dmitry
> Torokhov<dmitry.torokhov@gmail.com> wrote:
> > On Thu, Jul 23, 2009 at 12:36:25AM -0700, Dmitry Torokhov wrote:
> >> On Thu, Jul 23, 2009 at 12:28:02AM -0700, Dmitry Torokhov wrote:
> >> > On Wed, Jul 22, 2009 at 11:30:44PM -0700, Dmitry Torokhov wrote:
> >> > > On Tue, Jul 21, 2009 at 01:44:56PM +0300, Mike Rapoport wrote:
> >> > > > Hi Dmitry,
> >> > > >
> >> > > > Dmitry Torokhov wrote:
> >> > > > > Hi Eric,
> >> > > > >
> >> > > > > I made a few adjustments to the pxa27x_keypad driver and was wondering
> >> > > > > if you would be able to give it a sping and check if I broke it or not.
> >> > > >
> >> > > > Apparently not :)
> >> > > > Tested-by: Mike Rapoport <mike@compulab.co.il>
> >> > > >
> >> > >
> >> > > Cool, thanks for testing. I have another one for you then ;)
> >> > >
> >> > > TIA!
> >> > >
> >> >
> >> > Umm.. this one is hopefully better...
> >> >
> >>
> >> And another one implementing keymap manipulation.
> >>
> >
> > *ping* Any chance you could try this one out for me? Pretty please...
> >
> 
> Hi Dmitry,
> 
> Mike has already tested this, 

Ah, my bad then... I understood that he only tested dev_pm_ops
conversion (the first patch) and not both.

> and I tested this again on my Littleton/pxa3xx,
> it works pretty good, and the change looks quite OK, so if you need my Ack,
> here it goes:
> 
> Acked-by: Eric Miao <eric.y.miao@gmail.com>

Thank you, much appreciated.

-- 
Dmitry
