From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] Input: Add Acer Aspire 5710 to nomux blacklist
Date: Wed, 9 Jul 2014 19:48:21 +0200
Message-ID: <20140709174821.GA30912@suse.cz>
References: <alpine.LNX.2.00.1406251139070.15939@pobox.suse.cz>
 <20140709165438.GC10364@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from jablonecka.jablonka.cz ([91.219.244.36]:49701 "EHLO
	jablonecka.jablonka.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754252AbaGISMJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Jul 2014 14:12:09 -0400
Content-Disposition: inline
In-Reply-To: <20140709165438.GC10364@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, hdegoede@redhat.com

On Wed, Jul 09, 2014 at 09:54:38AM -0700, Dmitry Torokhov wrote:
> On Wed, Jun 25, 2014 at 11:42:43AM +0200, Jiri Kosina wrote:
> > Acer Aspire needs to be added to nomux blacklist, otherwise the touchpad 
> > misbehaves rather randomly.
> > 
> > Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> > 
> > ---
> > 
> > Hi Dmitry,
> > 
> > I've come across this a few year old patch originating from our internal 
> > bugzilla, which was apparently been lost between the cracks somewhere. 
> > We've been carrying it in our kernel tree for quite some time ... could 
> > you please apply it? Thanks.
> 
> I will. I also wonder if by now we should stop defaulting to MUX mode:
> all newer desktop/server boxes use USB, only laptops still use PS/2,

MUX mode was only ever available on laptops - no desktop computer I'm
aware of ever had it.

> and quite a few of them not implement active MUX properly. 

Do you still get reports of non-working, but advertized Active
Multiplexing mode on new laptops?

> I also expect
> that most of external PS/2 mice are dead by now, so number of cases when

One would at least hope so. Sadly, internal mice and PS/2 keyboards
aren't going to go away any soon, due to larger power consumption of USB
devices.

> we have users with PS/2 touchpad + external PS/2 mouse + working active
> MUX is exceedingly small.
> 
> Let's pull Vojtech in ;)

What I'd prefer is to, based on DMI data, report but not enable by
default Active MUX mode on any machine manufactured after a certain
date. Plus have a DMI-based whitelist for machines that absolutely
needed, if any are found later.

-- 
Vojtech Pavlik
Director SUSE Labs
