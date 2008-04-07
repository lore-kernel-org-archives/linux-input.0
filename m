From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] ati_remote2 autorepeat and loadable keymap support
Date: Mon, 7 Apr 2008 16:39:46 -0400
Message-ID: <20080407163610.ZZRA012@mailhub.coreip.homeip.net>
References: <200802161622.43223.linux@dadeos.co.uk> <200803041855.50138.linux@dadeos.co.uk> <20080304203822.GF531@sci.fi> <200803042134.30339.linux@dadeos.co.uk> <20080304221749.GH531@sci.fi> <Pine.LNX.4.64.0803042320450.15209@jikos.suse.cz> <Pine.LNX.4.64.0803250922090.32241@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.235]:29404 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbYDGUjy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Apr 2008 16:39:54 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1600133wxd.4
        for <linux-input@vger.kernel.org>; Mon, 07 Apr 2008 13:39:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0803250922090.32241@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Ville Syrj?l? <syrjala@sci.fi>, Peter Stokes <linux@dadeos.co.uk>, linux-input@vger.kernel.org

On Tue, Mar 25, 2008 at 09:23:02AM +0100, Jiri Kosina wrote:
> On Tue, 4 Mar 2008, Jiri Kosina wrote:
> 
> > > However I don't see why the repeat vs. no repeat case should depend on 
> > > the device reporting or not reporting keyboard keys. I don't see any 
> > > real connection with a device having some keyboard keys and sending 
> > > repeat events for buttons.
> > The problem is, that currently EV_REP is per-device flag. Once we set 
> > it, it is valid for all EV_KEY events (which includes keyboard events, 
> > but also mouse buttons).
> > I think it might be good to redesign this a little bit, but I'd like to 
> > hear Dmitry's opinion here, let's see when he will appear.
> 
> Dmitry,
> 
> do you have any opinion/idea what might be the best soltuion please?
> 

I think that for now it is driver's responsibility to implement "fancy"
autorepeat, if needed. I think good implementation should respect repeat
rate settings requested from userspace though...

If there are lots of drivers implementing autorepeat themselves and we
start seeing common patterns we could start moving it to the core,
probably by implementing some helper functions. Does this make sense?

-- 
Dmitry
