From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Query last reported event state
Date: Wed, 25 Nov 2009 19:51:42 -0800
Message-ID: <20091126035142.GB23244@core.coreip.homeip.net>
References: <20091124173356.GB14091@buzzloop.caiaq.de> <20091124195729.GB27249@gw.healthdatacare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:34003 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758291AbZKZDvk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Nov 2009 22:51:40 -0500
Received: by pwi3 with SMTP id 3so246493pwi.21
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2009 19:51:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091124195729.GB27249@gw.healthdatacare.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@iki.fi>
Cc: Daniel Mack <daniel@caiaq.de>, linux-input@vger.kernel.org

On Tue, Nov 24, 2009 at 09:57:29PM +0200, Mika Westerberg wrote:
> Hi Daniel,
> 
> On Tue, Nov 24, 2009 at 06:33:56PM +0100, Daniel Mack wrote:
> > Hi,
> > 
> > is there a way to query the last state an input device reported,
> > preferably even for a special key mask? When a button is pressed and a
> > userspace application is started, it should be able to figure out the
> > current state, especially because those GPIO signals are likely
> > connected to other peripherals to report arbitrary events in the system.
> > Is there any such framework for that purpose?
> 
> Not sure whether this helps, but you can look <linux/input.h> and
> check what ioctl()s it provides for this purpose. At least there
> seems to be:
> 	EVIOCGKEY - get global keystate
> 	EVIOCGSW - get all switch states
> 	EVIOCGBIT - get event bits
> 
> Maybe you can use some of these to query current status of input events.

This is correct. The first 2 ioctls are there so userspace can get the
current state of input device. The last ioctl is to query capabilities,
not the state though.

-- 
Dmitry
