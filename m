From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Add Acer Aspire 5710 to nomux blacklist
Date: Thu, 10 Jul 2014 14:11:13 -0700
Message-ID: <20140710211113.GB37059@core.coreip.homeip.net>
References: <alpine.LNX.2.00.1406251139070.15939@pobox.suse.cz>
 <20140709165438.GC10364@core.coreip.homeip.net>
 <20140709174821.GA30912@suse.cz>
 <20140709193830.GE10364@core.coreip.homeip.net>
 <53BE4180.4030907@redhat.com>
 <20140710084551.GA26864@suse.cz>
 <53BEAF57.30409@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:42272 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbaGJVLR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Jul 2014 17:11:17 -0400
Received: by mail-pd0-f170.google.com with SMTP id z10so182548pdj.1
        for <linux-input@vger.kernel.org>; Thu, 10 Jul 2014 14:11:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <53BEAF57.30409@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On Thu, Jul 10, 2014 at 05:20:55PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 07/10/2014 10:45 AM, Vojtech Pavlik wrote:
> > On Thu, Jul 10, 2014 at 09:32:16AM +0200, Hans de Goede wrote:
> > 
> >>>>> I also expect
> >>>>> that most of external PS/2 mice are dead by now, so number of cases when
> >>>>
> >>>> One would at least hope so. Sadly, internal mice and PS/2 keyboards
> >>>> aren't going to go away any soon, due to larger power consumption of USB
> >>>> devices.
> >>>
> >>> Right, but we are not talking about mouse vs keyboard, they use separate
> >>> ports anyway, it is touchpad plus external PS/2 mouse case where active
> >>> MUX might help.
> >>
> >> What about laptops with both a touchpad and a trackpoint ? I think in most
> >> cases the trackpoint works through some sort of pass-through mode of the
> >> touchpad (or is outright part of the touchpad ps/2 device), but are we
> >> sure there are no cases where the trackpoint and touchpad are really
> >> separate ps/2 devices hookedup through an active mux ?
> > 
> > I'm not aware of any current machines using active multiplexing for
> > that. There are basically two touchpad manufacturers: Synaptics and
> > ALPS.
> 
> And elantech
> 
> > Synaptics has a nearly transparent passthrough mode and
> > touchpoints are connected through that. ALPS basically manufactures a
> > touchpad+touchpoint combo device and thus doesn't need a fully
> > transparent passthrough.
> 
> Elantech now a days also produces a combo like alps.

They still wire it up internally and route all data through AUX port and
not use active MUX for that.

> 
> > Active multiplexing was typically used for external PS/2 ports on
> > laptops, because the manufacturer couldn't anticipate the protocol of
> > the externally connected device.
> 
> Right, but what about users who still have a laptop with an external
> ps/2 port which they happen to also still use ?

The assertion that it works well now, which is a stretch. As far as I
know Windows by default does not activate it, so manufacturers rarely
test it.

> 
> 
> 
> > 
> >>>>> we have users with PS/2 touchpad + external PS/2 mouse + working active
> >>>>> MUX is exceedingly small.
> >>>>>
> >>>>> Let's pull Vojtech in ;)
> >>>>
> >>>> What I'd prefer is to, based on DMI data, report but not enable by
> >>>> default Active MUX mode on any machine manufactured after a certain
> >>>> date. Plus have a DMI-based whitelist for machines that absolutely
> >>>> needed, if any are found later.
> >>>
> >>> Looking at the changes to nomux blacklist sometimes even trying MUX
> >>> messes up KBC. Instead of playing date games I'd rather simply make
> >>> i8042.nomux default. I'm fine with having whitelist for boxes that
> >>> actually need and support muxing properly.
> >>
> >> I'm a bit skeptical about making this change, see above.
> > 
> > I'm not too keen about it either, as it could break existing setups. 
> > 
> > But I have to concede that any working hardware still using both
> > external and internal PS/2 and thus needing Active Multiplexing is most
> > likely to be found in museums today.
> > 
> > So the risk of breakage isn't all that big.
> 
> One of the nice things about Linux is that in general we've pretty
> decent support for older hardware, so if we decide to flip the nomux
> default, I think we should really do so based on some BIOS cut-off
> date, so as to not break older model laptops.

I think historically IBM and HPs had working MUX support while other's
did might advertise support and fail miserably when we would try
activating it.

Given that now majority of mice are USB even if we select wrong default
on some older box I think it would be acceptable as opposed to a newer
box not having touchpad at all...

Thanks.

-- 
Dmitry
