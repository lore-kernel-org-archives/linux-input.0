From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [regression] 2.6.30 leaking keys on console switch
Date: Thu, 9 Jul 2009 22:01:35 +0200
Message-ID: <20090709200135.GA16355@basil.fritz.box>
References: <87eiss7uhb.fsf@basil.nowhere.org> <alpine.LNX.2.00.0907071048210.4994@wotan.suse.de> <20090708065325.GE3309@dtor-d630.eng.vmware.com> <alpine.LNX.2.00.0907081317000.27327@wotan.suse.de> <alpine.LNX.2.00.0907091328370.27327@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:43260 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407AbZGIUBh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2009 16:01:37 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0907091328370.27327@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andi Kleen <andi@firstfloor.org>, rjw@sisk.pl, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jul 09, 2009 at 01:29:55PM +0200, Jiri Kosina wrote:
> On Wed, 8 Jul 2009, Jiri Kosina wrote:
> 
> > For completness, Andi sent me the following evtest output off-list 
> > yesterday. The LeftAlt being autorepeated at time 1246964430.448470 is a 
> > little bit suspicious, as it is preceeded by release ... I don't see how 
> > this could be causing the behavior Andi is observing though.
> > 
> > I am not able to reproduce the problem myself.
> 
> Umm, actually, Andi, could you verify whether reverting e7b5c1ef4d changes 
> the behavior you are observing in any way?

Tested that, no change unfortunately.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
