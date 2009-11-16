From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: fix wrong synaptics detection in
	psmouse_extensions()
Date: Mon, 16 Nov 2009 11:53:32 -0800
Message-ID: <20091116195332.GD24026@core.coreip.homeip.net>
References: <alpine.LSU.2.00.0911161245570.15039@wotan.suse.de> <20091116170151.GA24026@core.coreip.homeip.net> <alpine.LSU.2.00.0911161806580.15039@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753852AbZKPTxh@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.00.0911161806580.15039@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Nov 16, 2009 at 06:12:39PM +0100, Jiri Kosina wrote:
> 
> [ fixed linux-input CC which I have typoed previously ]
> 
> On Mon, 16 Nov 2009, Dmitry Torokhov wrote:
> 
> > On Mon, Nov 16, 2009 at 12:51:30PM +0100, Jiri Kosina wrote:
> > > Commit b7802c5c1ea ("Input: psmouse - use boolean type") caused the 
> > > synaptics_hardware variable to be completely useless, as it is constantly 
> > > set to 'true' throughout the whole psmouse_extensions(). This was caused 
> > > by the following hunk in the commit in question
> > > 
> > > 	-       int synaptics_hardware = 0;
> > > 	+       bool synaptics_hardware = true;
> > > 
> > > which is wrong. Fix that up.
> > 
> > Hmm, not sure what I was thinnking at that time but it is obviously I
> > should have stayed away form tehe keyboard...
> > 
> > Applied, thank you Jiri.
> 
> I guess you will be pushing that one to .32 still, right? 

Yes, I will try to get it in .32

> I think it's 
> quite crucial fix, so if it doesn't make it in time for .32 (I am not sure 
> whether Linus will be doing next -rc or not), it should go to -stable for 
> .32 right away.

Actually it is not that critical, it will only cause us to do an
unnecessary full reset when every protocol detection failed and we
resort to the bare PS/2 protocol. Still  the fix is tiny so might as
well do stable if it misses release.

-- 
Dmitry
