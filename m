From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2 05/15] HID: logitech-hidpp: forward device info in
 power_supply
Date: Tue, 7 Feb 2017 09:35:57 +0100
Message-ID: <20170207083557.GD16529@mail.corp.redhat.com>
References: <20170202141229.17322-1-benjamin.tissoires@redhat.com>
 <20170202141229.17322-6-benjamin.tissoires@redhat.com>
 <1486134491.2316.11.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1486134491.2316.11.camel@hadess.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Jiri Kosina <jikos@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Bastien,

On Feb 03 2017 or thereabouts, Bastien Nocera wrote:
> On Thu, 2017-02-02 at 15:12 +0100, Benjamin Tissoires wrote:
> > +               case POWER_SUPPLY_PROP_MANUFACTURER:
> > +                       val->strval = "Logitech, Inc.";
> 
> I don't like this change. I'd prefer the concatenated manufacturer and
> model strings leading to user-friendly strings, and "Logitech T650" is
> better than "Logitech, Inc. T650".

Is this the only problematic issue? We are at rc7 already so I would
like to have the final version ready ASAP.

Cheers,
Benjamin
