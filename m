From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Synaptics i2c touchscreen driver
Date: Mon, 13 Sep 2010 09:36:42 -0700
Message-ID: <20100913163641.GB14598@core.coreip.homeip.net>
References: <27F9C60D11D683428E133F85D2BB4A530450B6371B@dlee03.ent.ti.com>
 <20100913152757.GA24329@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63799 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031Ab0IMQgs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Sep 2010 12:36:48 -0400
Received: by pwi3 with SMTP id 3so2224475pwi.19
        for <linux-input@vger.kernel.org>; Mon, 13 Sep 2010 09:36:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100913152757.GA24329@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: "Arce, Abraham" <x0066660@ti.com>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, Sep 13, 2010 at 08:27:57AM -0700, Greg KH wrote:
> On Sun, Sep 12, 2010 at 04:45:23PM -0500, Arce, Abraham wrote:
> > Hi Greg,
> > 
> > I was watching your Android presentation gave at ELC 2010, in that,
> > you have mention Synaptics i2c touchscreen driver. I've been trying to
> > identify if Synaptics team has an upstreaming plan but still no clear
> > information on this.
> > 
> > I have already requested this info but things are extremely quiet.
> > 
> > http://www.spinics.net/lists/linux-input/msg11006.html
> > 
> > Any information will be highly appreciated...
> 
> Sorry, I don't have any information or know anything about this at all.
> 

As far as I know [current] versions of Android use RMI3 touchscreens
which are older technology. Synaptics is trying to get their newer RMI4
driver merged and probably not that interested in RMI3 anymore.

Thanks.

-- 
Dmitry
