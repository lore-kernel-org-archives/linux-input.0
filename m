From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Connecting input driver to underlying uart
Date: Fri, 17 Jul 2015 16:27:42 -0700
Message-ID: <20150717232742.GH39282@dtor-ws>
References: <359253492.mQaq5M2qFo@jclayton-pc>
 <1466420.W6prjcqLLf@jclayton-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:33352 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753449AbbGQX1q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jul 2015 19:27:46 -0400
Received: by pdbqm3 with SMTP id qm3so68730657pdb.0
        for <linux-input@vger.kernel.org>; Fri, 17 Jul 2015 16:27:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1466420.W6prjcqLLf@jclayton-pc>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joshua Clayton <stillcompiling@gmail.com>
Cc: linux-input@vger.kernel.org

On Fri, Jul 17, 2015 at 04:00:16PM -0700, Joshua Clayton wrote:
> On Wednesday, July 15, 2015 11:22:06 AM you wrote:
> > Hi list,
> > I'm starting work on an input driver.
> > the device is connected to an RS232 uart in my freescale imx6q arm system, 
> > which has 2 serial ports, one of which is a console
> > 
> > It is not anything like a ps2/at device.
> > How can I get it to take over the uart device? A devicetree entry?
> > 
> > I do not understand serio probing, and don't understand if I should use serio 
> > for a non ps2 compatible device.
> > 
> > Any pointers would be helpful.
> > 
> > The input device documentation is great if I can just figure out how to 
> > connect it to my hardware.
> > 
> > 
> I went ahead and converted (parts of) the existing userspace driver. 
> Clearly I am missing something. My driver is registered with serio, but serio is not associated with any devices.
> I turned on the SERIO_SERPORT...
> /sys/bus/serio/devices/ is empty.
> I would like it to bind my driver to /dev/ttymxc1 (uart 2 on this  system), or its underlying uart.

You need to use inputattach utility to activate serport on the uart of
your choosing and tell it what type of serio port to create.

Thanks.

-- 
Dmitry
