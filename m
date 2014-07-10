From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] Input: Add Acer Aspire 5710 to nomux blacklist
Date: Thu, 10 Jul 2014 10:45:51 +0200
Message-ID: <20140710084551.GA26864@suse.cz>
References: <alpine.LNX.2.00.1406251139070.15939@pobox.suse.cz>
 <20140709165438.GC10364@core.coreip.homeip.net>
 <20140709174821.GA30912@suse.cz>
 <20140709193830.GE10364@core.coreip.homeip.net>
 <53BE4180.4030907@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59633 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751944AbaGJIpz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Jul 2014 04:45:55 -0400
Content-Disposition: inline
In-Reply-To: <53BE4180.4030907@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On Thu, Jul 10, 2014 at 09:32:16AM +0200, Hans de Goede wrote:

> >>> I also expect
> >>> that most of external PS/2 mice are dead by now, so number of cases when
> >>
> >> One would at least hope so. Sadly, internal mice and PS/2 keyboards
> >> aren't going to go away any soon, due to larger power consumption of USB
> >> devices.
> > 
> > Right, but we are not talking about mouse vs keyboard, they use separate
> > ports anyway, it is touchpad plus external PS/2 mouse case where active
> > MUX might help.
> 
> What about laptops with both a touchpad and a trackpoint ? I think in most
> cases the trackpoint works through some sort of pass-through mode of the
> touchpad (or is outright part of the touchpad ps/2 device), but are we
> sure there are no cases where the trackpoint and touchpad are really
> separate ps/2 devices hookedup through an active mux ?

I'm not aware of any current machines using active multiplexing for
that. There are basically two touchpad manufacturers: Synaptics and
ALPS. Synaptics has a nearly transparent passthrough mode and
touchpoints are connected through that. ALPS basically manufactures a
touchpad+touchpoint combo device and thus doesn't need a fully
transparent passthrough.

Active multiplexing was typically used for external PS/2 ports on
laptops, because the manufacturer couldn't anticipate the protocol of
the externally connected device.

> >>> we have users with PS/2 touchpad + external PS/2 mouse + working active
> >>> MUX is exceedingly small.
> >>>
> >>> Let's pull Vojtech in ;)
> >>
> >> What I'd prefer is to, based on DMI data, report but not enable by
> >> default Active MUX mode on any machine manufactured after a certain
> >> date. Plus have a DMI-based whitelist for machines that absolutely
> >> needed, if any are found later.
> > 
> > Looking at the changes to nomux blacklist sometimes even trying MUX
> > messes up KBC. Instead of playing date games I'd rather simply make
> > i8042.nomux default. I'm fine with having whitelist for boxes that
> > actually need and support muxing properly.
> 
> I'm a bit skeptical about making this change, see above.

I'm not too keen about it either, as it could break existing setups. 

But I have to concede that any working hardware still using both
external and internal PS/2 and thus needing Active Multiplexing is most
likely to be found in museums today.

So the risk of breakage isn't all that big.

-- 
Vojtech Pavlik
Director SUSE Labs
