From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Apple Bluetooth devices: Battery level?
Date: Fri, 12 Feb 2010 15:41:35 +0000
Message-ID: <1265989295.2383.14755.camel@localhost.localdomain>
References: <1244384236.30768.5690.camel@cookie.hadess.net>
	 <alpine.LRH.2.00.0906081530330.31685@twin.jikos.cz>
	 <1244642769.2690.51.camel@cookie.hadess.net>
	 <alpine.LNX.2.00.0906121529210.7457@wotan.suse.de>
	 <1244898975.477818.1961.nullmailer@galant.ukfsn.org>
	 <alpine.LNX.2.00.0906161156470.7457@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:30717 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756539Ab0BLPlk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Feb 2010 10:41:40 -0500
In-Reply-To: <alpine.LNX.2.00.0906161156470.7457@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-bluetooth@vger.kernel.org, linux-input <linux-input@vger.kernel.org>

On Tue, 2009-06-16 at 11:59 +0200, Jiri Kosina wrote:
> On Sat, 13 Jun 2009, Iain Hibbert wrote:
> 
> > Sorry, I posted a parsed version of the report descriptor previously
> > though I failed to cross post:
> > 
> > Collection page=Generic_Desktop usage=Mouse
> >   Input id=2 size=1 count=1 page=Button usage=Button_1 Variable, logical range 0..1
> >   Input id=2 size=1 count=1 page=Button usage=Button_2 Variable, logical range 0..1
> >   Input id=2 size=1 count=1 page=Button usage=Button_3 Variable, logical range 0..1
> >   Input id=2 size=1 count=1 page=Button usage=Button_4 Variable, logical range 0..1
> >   Input id=2 size=4 count=1 page=0x0000 usage=0x0000 Const Variable, logical range 0..1
> > Collection page=Generic_Desktop usage=Pointer
> >   Input id=2 size=8 count=1 page=Generic_Desktop usage=X Variable Relative, logical range -127..127
> >   Input id=2 size=8 count=1 page=Generic_Desktop usage=Y Variable Relative, logical range -127..127
> >   Input id=2 size=8 count=1 page=Consumer usage=AC_Pan Variable Relative, logical range -127..127
> >   Input id=2 size=8 count=1 page=Generic_Desktop usage=Wheel Variable Relative, logical range -127..127
> > End collection
> >   Input id=2 size=8 count=1 page=0x00ff usage=0x00c0 Variable, logical range -127..127
> > Feature id=71 size=8 count=1 page=Device_Controls usage=Battery_Strength Variable NoPref Volatile, logical range 0..100
> > End collection
> > As you can see, there is a Feature report relating to the Battery 
> > Strength, but I do not know what to do with that. I suppose that it is 
> > to be polled in order to return a percentage value..
> 
> Yes, it has to be polled. But at least the initial value should be 
> retrieved during the very initialization of the device -- both USB and 
> Bluetooth implementations this in usbhid_init_reports()/hidp_start() -- 
> they query INPUT and FEATURE reports during device initialization.

Any hints/example code on how to do that? Or is this something you'd
want to work on?

Cheers

