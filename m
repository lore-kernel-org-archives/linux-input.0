From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Apple Bluetooth devices: Battery level?
Date: Tue, 16 Jun 2009 11:59:57 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0906161156470.7457@wotan.suse.de>
References: <1244384236.30768.5690.camel@cookie.hadess.net>  <alpine.LRH.2.00.0906081530330.31685@twin.jikos.cz> <1244642769.2690.51.camel@cookie.hadess.net> <alpine.LNX.2.00.0906121529210.7457@wotan.suse.de>
 <1244898975.477818.1961.nullmailer@galant.ukfsn.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1244898975.477818.1961.nullmailer-miDnOI7kXJ/y0YX2dClxIw@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Iain Hibbert <plunky-+vE1BRBCC0GuOtvtkYNheg@public.gmane.org>
Cc: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Sat, 13 Jun 2009, Iain Hibbert wrote:

> Sorry, I posted a parsed version of the report descriptor previously
> though I failed to cross post:
> 
> Collection page=Generic_Desktop usage=Mouse
>   Input id=2 size=1 count=1 page=Button usage=Button_1 Variable, logical range 0..1
>   Input id=2 size=1 count=1 page=Button usage=Button_2 Variable, logical range 0..1
>   Input id=2 size=1 count=1 page=Button usage=Button_3 Variable, logical range 0..1
>   Input id=2 size=1 count=1 page=Button usage=Button_4 Variable, logical range 0..1
>   Input id=2 size=4 count=1 page=0x0000 usage=0x0000 Const Variable, logical range 0..1
> Collection page=Generic_Desktop usage=Pointer
>   Input id=2 size=8 count=1 page=Generic_Desktop usage=X Variable Relative, logical range -127..127
>   Input id=2 size=8 count=1 page=Generic_Desktop usage=Y Variable Relative, logical range -127..127
>   Input id=2 size=8 count=1 page=Consumer usage=AC_Pan Variable Relative, logical range -127..127
>   Input id=2 size=8 count=1 page=Generic_Desktop usage=Wheel Variable Relative, logical range -127..127
> End collection
>   Input id=2 size=8 count=1 page=0x00ff usage=0x00c0 Variable, logical range -127..127
> Feature id=71 size=8 count=1 page=Device_Controls usage=Battery_Strength Variable NoPref Volatile, logical range 0..100
> End collection
> As you can see, there is a Feature report relating to the Battery 
> Strength, but I do not know what to do with that. I suppose that it is 
> to be polled in order to return a percentage value..

Yes, it has to be polled. But at least the initial value should be 
retrieved during the very initialization of the device -- both USB and 
Bluetooth implementations this in usbhid_init_reports()/hidp_start() -- 
they query INPUT and FEATURE reports during device initialization.

-- 
Jiri Kosina
SUSE Labs
