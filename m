From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Add Acer Aspire 5710 to nomux blacklist
Date: Wed, 9 Jul 2014 12:38:31 -0700
Message-ID: <20140709193830.GE10364@core.coreip.homeip.net>
References: <alpine.LNX.2.00.1406251139070.15939@pobox.suse.cz>
 <20140709165438.GC10364@core.coreip.homeip.net>
 <20140709174821.GA30912@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:54524 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755428AbaGITif (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Jul 2014 15:38:35 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so9813475pab.29
        for <linux-input@vger.kernel.org>; Wed, 09 Jul 2014 12:38:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140709174821.GA30912@suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, hdegoede@redhat.com

On Wed, Jul 09, 2014 at 07:48:21PM +0200, Vojtech Pavlik wrote:
> On Wed, Jul 09, 2014 at 09:54:38AM -0700, Dmitry Torokhov wrote:
> > On Wed, Jun 25, 2014 at 11:42:43AM +0200, Jiri Kosina wrote:
> > > Acer Aspire needs to be added to nomux blacklist, otherwise the touchpad 
> > > misbehaves rather randomly.
> > > 
> > > Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> > > 
> > > ---
> > > 
> > > Hi Dmitry,
> > > 
> > > I've come across this a few year old patch originating from our internal 
> > > bugzilla, which was apparently been lost between the cracks somewhere. 
> > > We've been carrying it in our kernel tree for quite some time ... could 
> > > you please apply it? Thanks.
> > 
> > I will. I also wonder if by now we should stop defaulting to MUX mode:
> > all newer desktop/server boxes use USB, only laptops still use PS/2,
> 
> MUX mode was only ever available on laptops - no desktop computer I'm
> aware of ever had it.

Yeah, I don't recall seeing one either.

> 
> > and quite a few of them not implement active MUX properly. 
> 
> Do you still get reports of non-working, but advertized Active
> Multiplexing mode on new laptops?

Evey now and then... Vendors seem to not normally touch that code.

> 
> > I also expect
> > that most of external PS/2 mice are dead by now, so number of cases when
> 
> One would at least hope so. Sadly, internal mice and PS/2 keyboards
> aren't going to go away any soon, due to larger power consumption of USB
> devices.

Right, but we are not talking about mouse vs keyboard, they use separate
ports anyway, it is touchpad plus external PS/2 mouse case where active
MUX might help.

> 
> > we have users with PS/2 touchpad + external PS/2 mouse + working active
> > MUX is exceedingly small.
> > 
> > Let's pull Vojtech in ;)
> 
> What I'd prefer is to, based on DMI data, report but not enable by
> default Active MUX mode on any machine manufactured after a certain
> date. Plus have a DMI-based whitelist for machines that absolutely
> needed, if any are found later.

Looking at the changes to nomux blacklist sometimes even trying MUX
messes up KBC. Instead of playing date games I'd rather simply make
i8042.nomux default. I'm fine with having whitelist for boxes that
actually need and support muxing properly.

Thanks.

-- 
Dmitry
