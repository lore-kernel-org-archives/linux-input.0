From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 02/17] HID: logitech-hidpp: Add scope to battery
Date: Fri, 20 Jan 2017 15:26:57 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1701201526290.25515@cbobk.fhfr.pm>
References: <20170117143547.30488-1-benjamin.tissoires@redhat.com> <20170117143547.30488-3-benjamin.tissoires@redhat.com> <alpine.LSU.2.20.1701201408570.25515@cbobk.fhfr.pm> <20170120142517.GJ28187@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752147AbdATO1A (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 20 Jan 2017 09:27:00 -0500
In-Reply-To: <20170120142517.GJ28187@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Bastien Nocera <hadess@hadess.net>, Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 20 Jan 2017, Benjamin Tissoires wrote:

> > > Without a scope defined, UPower assumes that the battery is provide
> > > power to the computer it's connected to, like a laptop battery or a UPS.
> > > 
> > > Tested-by: Peter Hutterer <peter.hutterer@who-t.net>
> > > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > ---
> > >  drivers/hid/hid-logitech-hidpp.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> > > index 4eeb550..4aaf237 100644
> > > --- a/drivers/hid/hid-logitech-hidpp.c
> > > +++ b/drivers/hid/hid-logitech-hidpp.c
> > > @@ -761,6 +761,7 @@ static int hidpp20_battery_event(struct hidpp_device *hidpp,
> > >  static enum power_supply_property hidpp_battery_props[] = {
> > >  	POWER_SUPPLY_PROP_STATUS,
> > >  	POWER_SUPPLY_PROP_CAPACITY,
> > > +	POWER_SUPPLY_PROP_SCOPE,
> > 
> > Actually, what is the code baseline for this patchset please? I don't 
> > think I've ever seen hidpp_battery_props[] before.
> > 
> 
> Sorry, I should have mentioned this was on top of your
> for-4.8/logitech-hidpp-battery (merged with for-next, but which was put
> on hold since last Summer).

Ah, so I *did* see it, but forgot :) Thanks.

I'll look at the patchset in proper context now.

-- 
Jiri Kosina
SUSE Labs

