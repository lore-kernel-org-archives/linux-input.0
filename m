From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Synaptics i2c touchscreen driver
Date: Tue, 14 Sep 2010 00:48:50 -0700
Message-ID: <20100914074850.GA15167@core.coreip.homeip.net>
References: <27F9C60D11D683428E133F85D2BB4A530450B63EDD@dlee03.ent.ti.com>
 <7B4B50AC280A5E45A42CD2D364A3CE2F3A6BE70F9B@USW-EX2K7-1.synaptics-inc.local>
 <20100914005046.GA27540@core.coreip.homeip.net>
 <4C8F2426.8040301@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:45089 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065Ab0INHs4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Sep 2010 03:48:56 -0400
Received: by pxi10 with SMTP id 10so2375176pxi.19
        for <linux-input@vger.kernel.org>; Tue, 14 Sep 2010 00:48:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C8F2426.8040301@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <tsoni@codeaurora.org>
Cc: William Manson <WManson@synaptics.com>, "'Arce, Abraham'" <x0066660@ti.com>, Greg KH <gregkh@suse.de>, Christopher Heiny <Cheiny@synaptics.com>, Allie Xiong <axiong@synaptics.com>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, Sep 14, 2010 at 12:58:38PM +0530, Trilok Soni wrote:
> Hi Dmitry, William,
> 
> On 9/14/2010 6:20 AM, Dmitry Torokhov wrote:
> > Hi William,
> > 
> > On Mon, Sep 13, 2010 at 05:26:15PM -0700, William Manson wrote:
> >> Hi Abraham -
> >>
> >> Yes - the TM1217 is an RMI4 based module [I just got an email from a
> >> f/w engineer confirming it is indeed RMI4].
> >>
> >> We are currently working on submitting a new patch for our RMI4 based
> >> driver to add some functionality based on Dmitry Torokhov's request
> >> that we implement an RMI bus architecture. This is kind of a large
> >> change and we had hoped our current submission for our RMI4 driver
> >> would be added to the Kernel.org under a branch where every developer
> >> could access it and then we could add in the RMI bus architecture in a
> >> later patch. So it will take a while till we can make a new patch but
> >> I have no problem if you want to try the existing patch out.
> > 
> > I have committed the latest version of the patch Christopher sent (sans
> > defconfig and gta01 platform changes that do not really belong there) to
> > synaptics-rmi4 branch of my tree on kernel.org. I branched it off 2.6.35
> > release so it should be reasonably usable.
> 
> Why don't you submit to drivers/staging instead of creating branch at Dmitry's GIT tree?
> 
> You can probably attract more developers and you don't need to rebase to latest kernel 
> everytime.
> 

Since it is an input driver it is easier for me to apply patches to my
tree instead of routing through Greg. I intend to keep that ranch at
2.6.35 unless we have to rebase.

Thanks.

-- 
Dmitry
