From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH resend2] Input: usbtouchscreen - initialize eGalax
 devices
Date: Thu, 1 Nov 2012 11:38:19 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1211011137260.6606@pobox.suse.cz>
References: <20120903132648.GC11919@newmaster.mivlgu.local> <20120905060704.GC25962@core.coreip.homeip.net> <20120907204232.GA24528@alittletooquiet.net> <3475963.zdirdksHlt@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33602 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750815Ab2KAKi2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 1 Nov 2012 06:38:28 -0400
In-Reply-To: <3475963.zdirdksHlt@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Forest Bond <forest@alittletooquiet.net>, Daniel Ritz <daniel.ritz@gmx.ch>, Alan Stern <stern@rowland.harvard.edu>, Sergei Shtylyov <sshtylyov@mvista.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Mon, 10 Sep 2012, Dmitry Torokhov wrote:

> > The other piece to this puzzle is that usbhid should blacklist these devices
> > to avoid binding if it happens to be loaded before usbtouchscreen.  To do
> > this, usbhid needs to be able to blacklist devices based on interface
> > protocol (right now it only supports blacklist on VID + PID).
> > 
> > Would you accept a patch set that implements this?
> 
> Juri, this question is really for you...

Generally, I am not objecting to this idea in general.

What is the particular use case here, so that it's needed?

Thanks,

-- 
Jiri Kosina
SUSE Labs
