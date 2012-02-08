From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Microsoft Touch Mouse driver [was: Re: your mail]
Date: Wed, 8 Feb 2012 09:09:10 -0800
Message-ID: <20120208170910.GA4181@core.coreip.homeip.net>
References: <BROWNM3h3vLgAusVxON00000cfa@brown.emailprod.vodafone.se>
 <20120125132612.GA3890@polaris.bitmath.org>
 <4F200D14.80702@gmail.com>
 <20120125150035.GA4222@polaris.bitmath.org>
 <20120130072732.GA1855@core.coreip.homeip.net>
 <4F3113F6.6000403@gmail.com>
 <20120207161231.GA13128@polaris.bitmath.org>
 <4F3192F4.1040401@gmail.com>
 <20120207223824.GA15836@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43444 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757361Ab2BHRJU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Feb 2012 12:09:20 -0500
Received: by pbcun15 with SMTP id un15so730020pbc.19
        for <linux-input@vger.kernel.org>; Wed, 08 Feb 2012 09:09:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120207223824.GA15836@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Maurus Cuelenaere <mcuelenaere@gmail.com>, linux-input@vger.kernel.org

On Tue, Feb 07, 2012 at 11:38:24PM +0100, Henrik Rydberg wrote:
> > >>Any hints on how to do this in userspace? Of course I could hack up
> > >>xf86-input-evdev, but I'd like to do this at the highest possible
> > >>layer, ie the input subsystem.
> > >The application you describe could well be implemented in the driver
> > >you submitted; a simple handling of the MT data resulting in normal
> > >input events.
> > 
> > Yes, that was my initial idea. But as I had the impression that an
> > userspace solution was preferred, I wondered how to solve that.
> 
> The conclusion was that as is, the device is unsuitable as an MT
> device, needing either further in-kernel conversion or some other,
> non-MT way of getting the data to userspace. Converting the data as
> you describe, outputting normal input events, falls into the first
> category.

It should be possible to grab both interfaces using hidraw, perform
necessary decoding in userspace and route proper MT stream (including
button data) back into the kernel via uinput. This way the rest of the
stack doe not need to be touched.

Thanks.

-- 
Dmitry
