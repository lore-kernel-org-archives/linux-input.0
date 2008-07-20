From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [alsa-devel] [0/2] Jack reporting
Date: Sun, 20 Jul 2008 01:23:20 -0400
Message-ID: <20080720052320.GB7853@anvil.corenet.prv>
References: <20080703095026.GA652@sirena.org.uk> <20080714151058.GF25448@sirena.org.uk> <s5hlk02148k.wl%tiwai@suse.de> <20080716125053.GA17134@rakim.wolfsonmicro.main> <20080716112939.ZZRA012@mailhub.coreip.homeip.net> <20080717103111.GB15333@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:3766 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbYGTFX1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Jul 2008 01:23:27 -0400
Received: by py-out-1112.google.com with SMTP id p76so752856pyb.10
        for <linux-input@vger.kernel.org>; Sat, 19 Jul 2008 22:23:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080717103111.GB15333@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-input@vger.kernel.org

On Thu, Jul 17, 2008 at 11:31:12AM +0100, Mark Brown wrote:
> On Wed, Jul 16, 2008 at 12:36:06PM -0400, Dmitry Torokhov wrote:
> > On Wed, Jul 16, 2008 at 01:50:53PM +0100, Mark Brown wrote:
> 
> > > As well as detecting the presence of a connected device typical jack
> > > detection implementations also support the implementation of at least
> > > one button which would require an input device for at least some jacks
> 
> > It really depends on what you can do with this button. If it is just a
> > simple circuit breaker then it is not really an input device. However
> > is you can remap it for different purposes or map a regular key on a
> > keybaord to perform this function then I will agree with you. For example
> 
> As far as the hardware is concerned it's just a button - if it's visible
> to software then there's no fixed function for it and any action taken
> will be application/system specific.  There will normally be a side
> effect in hardware muting the microphone but that's not intended to be
> the main effect.

Ok, let's add it to the input subsystem then. If we see lots of switch
types sprnging up we cam talk about the new subsystem again. 

I added the switch definition to input.h and it shoudl hit the mainline
when I ask Linus to pull early next week. 

-- 
Dmitry
