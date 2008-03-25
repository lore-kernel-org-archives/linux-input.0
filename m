From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] ati_remote2 autorepeat and loadable keymap support
Date: Tue, 25 Mar 2008 09:23:02 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803250922090.32241@twin.jikos.cz>
References: <200802161622.43223.linux@dadeos.co.uk> <200803041855.50138.linux@dadeos.co.uk>
 <20080304203822.GF531@sci.fi> <200803042134.30339.linux@dadeos.co.uk>
 <20080304221749.GH531@sci.fi> <Pine.LNX.4.64.0803042320450.15209@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:45383 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752038AbYCYIXU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Mar 2008 04:23:20 -0400
In-Reply-To: <Pine.LNX.4.64.0803042320450.15209@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?ISO-8859-2?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>, Peter Stokes <linux@dadeos.co.uk>, linux-input@vger.kernel.org

On Tue, 4 Mar 2008, Jiri Kosina wrote:

> > However I don't see why the repeat vs. no repeat case should depend on 
> > the device reporting or not reporting keyboard keys. I don't see any 
> > real connection with a device having some keyboard keys and sending 
> > repeat events for buttons.
> The problem is, that currently EV_REP is per-device flag. Once we set 
> it, it is valid for all EV_KEY events (which includes keyboard events, 
> but also mouse buttons).
> I think it might be good to redesign this a little bit, but I'd like to 
> hear Dmitry's opinion here, let's see when he will appear.

Dmitry,

do you have any opinion/idea what might be the best soltuion please?

Thanks,

-- 
Jiri Kosina
SUSE Labs

