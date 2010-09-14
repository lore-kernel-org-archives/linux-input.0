From: "Arce, Abraham" <x0066660@ti.com>
Subject: RE: Synaptics i2c touchscreen driver
Date: Tue, 14 Sep 2010 01:52:49 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A530450C31AB7@dlee03.ent.ti.com>
References: <20100914005046.GA27540@core.coreip.homeip.net>
 <7B4B50AC280A5E45A42CD2D364A3CE2F3A6BE70F9C@USW-EX2K7-1.synaptics-inc.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47995 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621Ab0INGxA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Sep 2010 02:53:00 -0400
In-Reply-To: <7B4B50AC280A5E45A42CD2D364A3CE2F3A6BE70F9C@USW-EX2K7-1.synaptics-inc.local>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: William Manson <WManson@synaptics.com>, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: Greg KH <gregkh@suse.de>, Christopher Heiny <Cheiny@synaptics.com>, Allie Xiong <axiong@synaptics.com>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi,

> From: William Manson [mailto:WManson@synaptics.com]
> 
> Dmitry -
> 
> Thanks - yes this will help very much.
> 
> > >
> > > Yes - the TM1217 is an RMI4 based module [I just got an email from a
> > > f/w engineer confirming it is indeed RMI4].
> > >
> > > We are currently working on submitting a new patch for our RMI4 based
> > > driver to add some functionality based on Dmitry Torokhov's request
> > > that we implement an RMI bus architecture. This is kind of a large
> > > change and we had hoped our current submission for our RMI4 driver
> > > would be added to the Kernel.org under a branch where every developer
> > > could access it and then we could add in the RMI bus architecture in a
> > > later patch. So it will take a while till we can make a new patch but
> > > I have no problem if you want to try the existing patch out.
> 
> I have committed the latest version of the patch Christopher sent (sans
> defconfig and gta01 platform changes that do not really belong there) to
> synaptics-rmi4 branch of my tree on kernel.org. I branched it off 2.6.35
> release so it should be reasonably usable.
> 
> I shall be accepting patches applicable to that branch and if other
> community players (Arce and others) will have time to work on the driver
> - that would be great.
> 

I'll give a try the synaptics-rmi4 branch...

Thanks William and Dmitry for the quick response!

Best Regards
Abraham

