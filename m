From: Arjan Opmeer <arjan@opmeer.net>
Subject: Re: [PATCH] input: Update Elantech touchpad driver to v5 for
	kernel 2.6.27-rc5-mm1
Date: Fri, 19 Sep 2008 09:05:30 +0200
Message-ID: <20080919070530.GA7599@adopmeer.homeip.net>
References: <20080914032344.GA16228@adopmeer.homeip.net> <20080919041727.GB7594@core.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out0.tiscali.nl ([195.241.79.175]:38136 "EHLO
	smtp-out0.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbYISHFi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Sep 2008 03:05:38 -0400
Content-Disposition: inline
In-Reply-To: <20080919041727.GB7594@core.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: akpm@linux-foundation.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org


Hi Dmitry,

(Sorry for calling you Dimitry earlier :)

On Fri, Sep 19, 2008 at 12:17:27AM -0400, Dmitry Torokhov wrote:
> On Sun, Sep 14, 2008 at 05:23:44AM +0200, Arjan Opmeer wrote:
> > 
> > Update the Elantech touchpad driver to v5
> 
> Could you tell me if issues with pressure reporting mentioned in bugzilla
> #8781 have been resolved?

I am not exactly sure what the issue is that is described there.

As far as I know the touchpad does not report pressure (maybe the EeePC
style touchpad does, but I do not have hands on experience with that).
However the Xorg Synaptics driver requires pressure events to work. So I
chose a default pressure value and the driver always toggles between no
pressure and default pressure for no touch and touch respectively. This
seems to work well for all my testers as I have not heard any complaints.

A related issue seems to be that the Ubuntu packaged version of the Xorg
Synaptics driver appears to have a bug where adjusting MaxTapTime doesn't
have any effect. In the absence of true pressure reporting this is the
primary parameter to configure ones personal tapping preference for the
Elantech touchpad. I believe the bug reporter in question wants to set this
value to 0 to disable tapping altogether (although the TouchpadOff option
would be better suited), but because of this bug cannot do so.

So all in all I am not quite sure that this is a problem with the Elantech
driver per se.

> I am about to put the driver in my tree and need to know if I can enable
> it unconditionally or need to mark it experimental.

Well, either is fine with me. Just getting it in the mainline kernel will
give it a broader exposure and more testing I guess.


Arjan
