From: "Chris Verges" <chrisv@cyberswitching.com>
Subject: RE: [PATCH 1/1] linux-2.6.32-tsc2008.patch
Date: Tue, 26 Jan 2010 07:43:41 -0800
Message-ID: <68FBE0F3CE97264395875AC1C468F22C220A2F@mail03.cyberswitching.local>
References: <68FBE0F3CE97264395875AC1C468F22C220789@mail03.cyberswitching.local> <20100126093840.GB3480@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from p01c12o148.mxlogic.net ([208.65.145.71]:59994 "EHLO
	p01c12o148.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753876Ab0AZPoZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jan 2010 10:44:25 -0500
Content-class: urn:content-classes:message
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

> This is another example of a driver that is very similar (not 
> surprisingly of course) to TSC2007. Could we look into turning TSC2007

> a core module with I2C and SPI transports? Mike Frysinger was doing 
> similar work for ad7879 if you'd like to take a look.

Hi Dmitry,

I did some work with Mike on the ad525x_dpot driver; he definitely knows
his stuff.

I hear you on merging the two drivers.  They are probably similar to
many points.  However, there are two key differences: (1) I2C vs SPI and
(2) totally different command registers.  It's probably possible to
merge the two drivers, but my project is coming to an end so I do not
have a lot of extra time to spend on this.  Such is the way of things,
unfortunately.

If anyone else out there would like to do the work to merge the two,
I'll gladly give whatever support I can on the tsc2008 side, including
testing on the hardware platform and code reviews.

Best regards,
Chris

P.S.  Is there a kernel driver wishlist that talks about how an abstract
communication API would be nice for drivers that want to support both
I2C and SPI endpoints?  It seems like a common problem that many drivers
would face as they mature and support different protocols.
