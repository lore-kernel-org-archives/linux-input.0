From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [regression] 2.6.30 leaking keys on console switch
Date: Thu, 9 Jul 2009 22:03:18 +0200
Message-ID: <20090709200318.GB16355@basil.fritz.box>
References: <87eiss7uhb.fsf@basil.nowhere.org> <alpine.LNX.2.00.0907071048210.4994@wotan.suse.de> <20090708065325.GE3309@dtor-d630.eng.vmware.com> <alpine.LNX.2.00.0907091319480.27327@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755573AbZGIUDa@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0907091319480.27327@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andi Kleen <andi@firstfloor.org>, rjw@sisk.pl, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

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
> 
> Still, I don't see the leaking F key in the evtest output (see the mail 
> from yesterday), which is quite puzzling.

Everything quite puzzling.

I find it puzzling that people cannot reproduce this. I see this on two
quite different systems (different keyboard, system). Does really nobody
else see it?

I checked now and it happens with both when I switch with Alt-Fx
and Ctrl-Alt-Fx (at least on SUSE the later works from the consoles
too, so i usually use that)

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
