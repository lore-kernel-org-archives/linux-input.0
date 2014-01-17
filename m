From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 4/4] HID: sony: Map gyroscopes and accelerometers to
 axes
Date: Fri, 17 Jan 2014 13:21:02 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1401171319500.23018@pobox.suse.cz>
References: <alpine.DEB.2.10.1401162137400.15779@franz-virtual-machine> <20140117125137.ad402d6be31de52a25fedd4a@studenti.unina.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35008 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752496AbaAQMVH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jan 2014 07:21:07 -0500
In-Reply-To: <20140117125137.ad402d6be31de52a25fedd4a@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: Frank Praznik <frank.praznik@oh.rr.com>, linux-input@vger.kernel.org

On Fri, 17 Jan 2014, Antonio Ospite wrote:

> > Use a modified HID descriptor for the Dualshock 4 to assign the gyroscope
> > sensors and accelerometers to axes.
> >
> 
> What about putting the descriptor fixup on hold for now?
> Jiri, have you already pushed these patches?
> 
> Once the ABS2 stuff from David Hermann is done then proper mapping
> following the Gamepad API[1] and the Motion-Tracking API[2] could be
> added.
> 
> [1] Documentation/input/gamepad.txt
> [2] Documentation/input/motion-tracking.txt
> 
> We could even have the DS3 and DS4 expose the same mapping.
> 
> Just a suggestion.

Hi,

yes, I have already pushed it, but we can of course discuss not including 
it into pull for Linus if necessary.

My understanding is that once ABS2 stuff is done, this can just be 
switched to using it in a backwards-compatible way, and the report fixup 
could be dropped, no?

-- 
Jiri Kosina
SUSE Labs
