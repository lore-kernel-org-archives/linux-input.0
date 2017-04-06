From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v3 02/19] HID: logitech-hidpp: Add scope to battery
Date: Thu, 6 Apr 2017 11:57:54 +0200
Message-ID: <20170406095754.GB10306@mail.corp.redhat.com>
References: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
 <20170327145939.29824-3-benjamin.tissoires@redhat.com>
 <alpine.LSU.2.20.1704061147460.28004@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751301AbdDFJ6C (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 6 Apr 2017 05:58:02 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1704061147460.28004@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Apr 06 2017 or thereabouts, Jiri Kosina wrote:
> On Mon, 27 Mar 2017, Benjamin Tissoires wrote:
> 
> > From: Bastien Nocera <hadess@hadess.net>
> > 
> > Without a scope defined, UPower assumes that the battery provides
> > power to the computer it's connected to, like a laptop battery or a UPS.
> > 
> > Tested-by: Peter Hutterer <peter.hutterer@who-t.net>
> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > 
> > ---
> > 
> > no changes in v3
> > 
> > changes in v2:
> > * fixed typo in commit message
> > ---
> >  drivers/hid/hid-logitech-hidpp.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> > index 4eeb550..4aaf237 100644
> > --- a/drivers/hid/hid-logitech-hidpp.c
> > +++ b/drivers/hid/hid-logitech-hidpp.c
> > @@ -761,6 +761,7 @@ static int hidpp20_battery_event(struct hidpp_device *hidpp,
> >  static enum power_supply_property hidpp_battery_props[] = {
> >  	POWER_SUPPLY_PROP_STATUS,
> >  	POWER_SUPPLY_PROP_CAPACITY,
> > +	POWER_SUPPLY_PROP_SCOPE,
> 
> This certainly assumes some other patchset to be already applied, right?

Hehe, once again you forgot about it, and me to make a note about it
too ;-) 

> 
> Which tree is this patchset based on, please?

Your for-4.8/logitech-hidpp-battery branch :)

Cheers,
Benjamin

> 
> Thanks,
> 
> -- 
> Jiri Kosina
> SUSE Labs
> 
