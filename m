From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v3 02/19] HID: logitech-hidpp: Add scope to battery
Date: Thu, 6 Apr 2017 20:34:21 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1704061439300.28004@cbobk.fhfr.pm>
References: <20170327145939.29824-1-benjamin.tissoires@redhat.com> <20170327145939.29824-3-benjamin.tissoires@redhat.com> <alpine.LSU.2.20.1704061147460.28004@cbobk.fhfr.pm> <20170406095754.GB10306@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49158 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753481AbdDFSeX (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 6 Apr 2017 14:34:23 -0400
In-Reply-To: <20170406095754.GB10306@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 6 Apr 2017, Benjamin Tissoires wrote:

> > > Without a scope defined, UPower assumes that the battery provides
> > > power to the computer it's connected to, like a laptop battery or a UPS.
> > > 
> > > Tested-by: Peter Hutterer <peter.hutterer@who-t.net>
> > > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > 
> > > ---
> > > 
> > > no changes in v3
> > > 
> > > changes in v2:
> > > * fixed typo in commit message
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
> > This certainly assumes some other patchset to be already applied, right?
> 
> Hehe, once again you forgot about it, and me to make a note about it
> too ;-) 

Bah, right; I was pretty sure we've discussed this, but was not able to 
find in anywhere in the history :)

Now queued in for-4.12/logitech-hidpp-battery-power-supply. Thanks,

-- 
Jiri Kosina
SUSE Labs

