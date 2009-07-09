From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [regression] 2.6.30 leaking keys on console switch
Date: Thu, 9 Jul 2009 14:00:55 +0200
Message-ID: <20090709120055.GB13422@one.firstfloor.org>
References: <87eiss7uhb.fsf@basil.nowhere.org> <alpine.LNX.2.00.0907071048210.4994@wotan.suse.de> <20090708065325.GE3309@dtor-d630.eng.vmware.com> <alpine.LNX.2.00.0907091319480.27327@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:34393 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757590AbZGIMA5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2009 08:00:57 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0907091319480.27327@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andi Kleen <andi@firstfloor.org>, rjw@sisk.pl, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jul 09, 2009 at 01:20:56PM +0200, Jiri Kosina wrote:
> On Tue, 7 Jul 2009, Dmitry Torokhov wrote:
> 
> > > Are you seeing with a specific keyboard type(s), or is this a general 
> > > problem? Could you confirm whether it is specific either to PS2 or USB 
> > > keyboards only, or it does happen for both?
> > Can't think of any input chnages in this timeftrame that would cause
> > such effect. Maybe TTY changes?
> 
> By the way, if I understand it correctly, Andi is able to see the very 
> same effect even inside X, so tty can be possibly ruled out, right?

I see it both in X (with firefox) and on the console (e.g. links
starts doing something)

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only.
