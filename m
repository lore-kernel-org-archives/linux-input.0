From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2 05/15] HID: logitech-hidpp: forward device info in
 power_supply
Date: Mon, 6 Mar 2017 14:39:58 +0100
Message-ID: <20170306133958.GY7064@mail.corp.redhat.com>
References: <20170202141229.17322-1-benjamin.tissoires@redhat.com>
 <20170202141229.17322-6-benjamin.tissoires@redhat.com>
 <1486134491.2316.11.camel@hadess.net>
 <20170207083557.GD16529@mail.corp.redhat.com>
 <alpine.LSU.2.20.1703061317480.31814@cbobk.fhfr.pm>
 <1488803268.28315.4.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1488803268.28315.4.camel@hadess.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Jiri Kosina <jikos@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mar 06 2017 or thereabouts, Bastien Nocera wrote:
> On Mon, 2017-03-06 at 13:18 +0100, Jiri Kosina wrote:
> > On Tue, 7 Feb 2017, Benjamin Tissoires wrote:
> > 
> > > > > +               case POWER_SUPPLY_PROP_MANUFACTURER:
> > > > > +                       val->strval = "Logitech, Inc.";
> > > > 
> > > > I don't like this change. I'd prefer the concatenated
> > > > manufacturer and
> > > > model strings leading to user-friendly strings, and "Logitech
> > > > T650" is
> > > > better than "Logitech, Inc. T650".
> > > 
> > > Is this the only problematic issue? We are at rc7 already so I
> > > would
> > > like to have the final version ready ASAP.
> > 
> > Bastien, do you have any input on the rest of the series please?
> 
> My comment about "[PATCH 04/15] HID: logitech-hidpp: battery: remove
> overloads and provide ONLINE" is the blocker.
> 
> No particular comments about the rest of the series.

Yes, sorry, this is still on my plate. I'll send out a revised series
soon hopefully.

Cheers,
Benjamin
