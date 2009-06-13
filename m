From: Iain Hibbert <plunky-+vE1BRBCC0GuOtvtkYNheg@public.gmane.org>
Subject: Re: Apple Bluetooth devices: Battery level?
Date: Sat, 13 Jun 2009 14:16:15 +0100 (BST)
Message-ID: <1244898975.477818.1961.nullmailer@galant.ukfsn.org>
References: <1244384236.30768.5690.camel@cookie.hadess.net>  <alpine.LRH.2.00.0906081530330.31685@twin.jikos.cz> <1244642769.2690.51.camel@cookie.hadess.net> <alpine.LNX.2.00.0906121529210.7457@wotan.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.0906121529210.7457-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, 12 Jun 2009, Jiri Kosina wrote:

> It doesn't seem to be sending the battery level in a standard-compliant
> way, at least according to these reports.

but I wonder what is the standard-compliant way?

> Could you also please post the report descriptor data? They should appear
> in a hid debugging mode once the mouse is connected.

Sorry, I posted a parsed version of the report descriptor previously
though I failed to cross post:

Collection page=Generic_Desktop usage=Mouse
  Input id=2 size=1 count=1 page=Button usage=Button_1 Variable, logical range 0..1
  Input id=2 size=1 count=1 page=Button usage=Button_2 Variable, logical range 0..1
  Input id=2 size=1 count=1 page=Button usage=Button_3 Variable, logical range 0..1
  Input id=2 size=1 count=1 page=Button usage=Button_4 Variable, logical range 0..1
  Input id=2 size=4 count=1 page=0x0000 usage=0x0000 Const Variable, logical range 0..1
Collection page=Generic_Desktop usage=Pointer
  Input id=2 size=8 count=1 page=Generic_Desktop usage=X Variable Relative, logical range -127..127
  Input id=2 size=8 count=1 page=Generic_Desktop usage=Y Variable Relative, logical range -127..127
  Input id=2 size=8 count=1 page=Consumer usage=AC_Pan Variable Relative, logical range -127..127
  Input id=2 size=8 count=1 page=Generic_Desktop usage=Wheel Variable Relative, logical range -127..127
End collection
  Input id=2 size=8 count=1 page=0x00ff usage=0x00c0 Variable, logical range -127..127
Feature id=71 size=8 count=1 page=Device_Controls usage=Battery_Strength Variable NoPref Volatile, logical range 0..100
End collection

As you can see, there is a Feature report relating to the Battery
Strength, but I do not know what to do with that. I suppose that it is to
be polled in order to return a percentage value..

> Does 00ff.00c0 usage change it's value if you put different batteries into
> the mouse?

The mighty mouse has a single hard shell and detects the difference
between left click and right click by a capacitance detector underneath
the finger positions. This usage contains bits indicating where the mouse
is being touched though I guess it is just for testing as the OS does not
really need to know (it generates normal button clicks).

There is one more data point that may be interesting. The mighty mouse
(and an old Apple keyboard I have) spits out an input report that is not
mentioned in the descriptor with id=48 just before the battery fails. I
captured it once and it contained a single byte with value 0x01. I have no
idea what that report is for but as I use NiMH batteries which maintain
voltage until very near the end, it could be a charge level warning.

regards,
iain
