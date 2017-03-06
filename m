From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v2 05/15] HID: logitech-hidpp: forward device info in
 power_supply
Date: Mon, 06 Mar 2017 13:27:48 +0100
Message-ID: <1488803268.28315.4.camel@hadess.net>
References: <20170202141229.17322-1-benjamin.tissoires@redhat.com>
         <20170202141229.17322-6-benjamin.tissoires@redhat.com>
         <1486134491.2316.11.camel@hadess.net>
         <20170207083557.GD16529@mail.corp.redhat.com>
         <alpine.LSU.2.20.1703061317480.31814@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LSU.2.20.1703061317480.31814@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 2017-03-06 at 13:18 +0100, Jiri Kosina wrote:
> On Tue, 7 Feb 2017, Benjamin Tissoires wrote:
> 
> > > > +               case POWER_SUPPLY_PROP_MANUFACTURER:
> > > > +                       val->strval = "Logitech, Inc.";
> > > 
> > > I don't like this change. I'd prefer the concatenated
> > > manufacturer and
> > > model strings leading to user-friendly strings, and "Logitech
> > > T650" is
> > > better than "Logitech, Inc. T650".
> > 
> > Is this the only problematic issue? We are at rc7 already so I
> > would
> > like to have the final version ready ASAP.
> 
> Bastien, do you have any input on the rest of the series please?

My comment about "[PATCH 04/15] HID: logitech-hidpp: battery: remove
overloads and provide ONLINE" is the blocker.

No particular comments about the rest of the series.
