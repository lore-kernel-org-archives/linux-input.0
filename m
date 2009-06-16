From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Apple Bluetooth devices: Battery level?
Date: Tue, 16 Jun 2009 15:37:08 +0200
Message-ID: <1245159428.15367.22.camel@violet>
References: <1244384236.30768.5690.camel@cookie.hadess.net>
	 <alpine.LRH.2.00.0906081530330.31685@twin.jikos.cz>
	 <1244642769.2690.51.camel@cookie.hadess.net>
	 <alpine.LNX.2.00.0906121529210.7457@wotan.suse.de>
	 <1244898975.477818.1961.nullmailer@galant.ukfsn.org>
	 <alpine.LNX.2.00.0906161156470.7457@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:44825 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753881AbZFPNhL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Jun 2009 09:37:11 -0400
In-Reply-To: <alpine.LNX.2.00.0906161156470.7457@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Iain Hibbert <plunky@rya-online.net>, Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org, linux-input <linux-input@vger.kernel.org>

Hi Jiri,

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

since the descriptors are the same, can we not do this inside the HID
core with a specific quirk setting. And maybe even a timer that polls it
every 30 minutes or so.

Regards

Marcel


