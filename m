From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2 05/15] HID: logitech-hidpp: forward device info in
 power_supply
Date: Mon, 6 Mar 2017 13:18:04 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1703061317480.31814@cbobk.fhfr.pm>
References: <20170202141229.17322-1-benjamin.tissoires@redhat.com> <20170202141229.17322-6-benjamin.tissoires@redhat.com> <1486134491.2316.11.camel@hadess.net> <20170207083557.GD16529@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170207083557.GD16529@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Bastien Nocera <hadess@hadess.net>, Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 7 Feb 2017, Benjamin Tissoires wrote:

> > > +               case POWER_SUPPLY_PROP_MANUFACTURER:
> > > +                       val->strval = "Logitech, Inc.";
> > 
> > I don't like this change. I'd prefer the concatenated manufacturer and
> > model strings leading to user-friendly strings, and "Logitech T650" is
> > better than "Logitech, Inc. T650".
> 
> Is this the only problematic issue? We are at rc7 already so I would
> like to have the final version ready ASAP.

Bastien, do you have any input on the rest of the series please?

Thanks,

-- 
Jiri Kosina
SUSE Labs
