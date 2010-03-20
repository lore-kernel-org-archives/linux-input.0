From: Yong Wang <yong.y.wang@linux.intel.com>
Subject: Re: [PATCH] eeepc-wmi: new driver for WMI based hotkeys on Eee PC
	laptops
Date: Sat, 20 Mar 2010 08:55:53 +0800
Message-ID: <20100320005553.GB32163@ywang-moblin2.bj.intel.com>
References: <20100319133924.GA30427@ywang-moblin2.bj.intel.com> <20100319135929.GA29027@srcf.ucam.org> <20100319151054.GA30664@ywang-moblin2.bj.intel.com> <20100319152323.GA30456@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga12.intel.com ([143.182.124.36]:60789 "EHLO
	azsmga102.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752111Ab0CTBEv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Mar 2010 21:04:51 -0400
Content-Disposition: inline
In-Reply-To: <20100319152323.GA30456@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Corentin Chary <corentincj@iksaif.net>, platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org

On Fri, Mar 19, 2010 at 03:23:23PM +0000, Matthew Garrett wrote:
> 
> > > > +		if (code >= NOTIFY_BRNUP_MIN && code <= NOTIFY_BRNUP_MAX)
> > > > +			code = NOTIFY_BRNUP_MIN;
> > > > +		else if (code >= NOTIFY_BRNDOWN_MIN && code <= NOTIFY_BRNDOWN_MAX)
> > > > +			code = NOTIFY_BRNDOWN_MIN;
> > > 
> > > Do the brightness keys just send notifications, or do they actually 
> > > change the brightness? If they actually change the brightness, we 
> > > shouldn't send input events.
> > > 
> > 
> > Yes, hardware and bios change brightness by themselves without software intervention
> > on my Eee PC 1005 when pressing the hotkeys.
> 
> Ok. In that case, you shouldn't send input events. Once backlight 
> control is implemented in the eee-wmi driver you can send notifications 
> via that instead.
> 

One question just popped off the top my head. What if there is a power
applet that wants to display a slider field at the bottom of the screen
showing the current brightness real time whenever users press brightness
hotkeys? Shouldn't it listen to the standard input events translated by
X into standard XF86 keysyms? Or shall it listen to the ACPI backlight
events? If so, it is the ACPI LCD event when using acpi backlight
driver. But what if those vendor specific backlight drivers are used?

Thanks
-Yong
