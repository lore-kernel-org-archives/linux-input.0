From: "Arce, Abraham" <x0066660@ti.com>
Subject: RE: Synaptics i2c touchscreen driver
Date: Mon, 13 Sep 2010 16:25:34 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A530450B63EDD@dlee03.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A530450B6371B@dlee03.ent.ti.com>
 <20100913152757.GA24329@suse.de>
 <20100913163641.GB14598@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47667 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752198Ab0IMVZm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Sep 2010 17:25:42 -0400
In-Reply-To: <20100913163641.GB14598@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <gregkh@suse.de>, Christopher Heiny <cheiny@synaptics.com>, Allie Xiong <axiong@synaptics.com>, William Manson <wmanson@synaptics.com>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi,

> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> > On Mon, Sep 13, 2010 at 08:27:57AM -0700, Greg KH wrote:
> > > On Sun, Sep 12, 2010 at 04:45:23PM -0500, Arce, Abraham wrote:
> > >
> > > I was watching your Android presentation gave at ELC 2010, in that,
> > > you have mention Synaptics i2c touchscreen driver. I've been trying to
> > > identify if Synaptics team has an upstreaming plan but still no clear
> > > information on this.
> > >
> > > I have already requested this info but things are extremely quiet.
> > >
> > > http://www.spinics.net/lists/linux-input/msg11006.html
> > >
> > > Any information will be highly appreciated...
> >
> > Sorry, I don't have any information or know anything about this at all.
> >
> 
> As far as I know [current] versions of Android use RMI3 touchscreens
> which are older technology. Synaptics is trying to get their newer RMI4
> driver merged and probably not that interested in RMI3 anymore.

Thanks Greg and Dmitry for all the info... it helped!

Christopher, Allie, William,

First, I am looking for more information on TM-01217 controller, I remember looking at some document saying that that this particular controller supports RMI4, is this correct?

Another question, it is about the final patch for touchscreens based on RMI4 protocol:

http://www.spinics.net/lists/linux-input/msg10042.html

When are you planning to release the final patch for upstreaming? Any help that you may need from the community?

Best Regards
Abraham

