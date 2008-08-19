From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: PROBLEM: USB keyboards works only 4 per PC host port
Date: Tue, 19 Aug 2008 13:55:58 -0400
Message-ID: <20080819135447.ZZRA012@mailhub.coreip.homeip.net>
References: <200808080702.24969.aivils@latnet.lv>
	<200808181642.49489.aivils@latnet.lv>
	<20080818081432.782d9632.rdunlap@xenotime.net>
	<200808191527.06945.aivils@latnet.lv>
	<20080819081936.37fef673.rdunlap@xenotime.net>
	<alpine.LNX.1.10.0808191721560.18058@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxconsole-dev-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.10.0808191721560.18058@jikos.suse.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linuxconsole-dev>,
	<mailto:linuxconsole-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linuxconsole-dev>
List-Post: <mailto:linuxconsole-dev@lists.sourceforge.net>
List-Help: <mailto:linuxconsole-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linuxconsole-dev>,
	<mailto:linuxconsole-dev-request@lists.sourceforge.net?subject=subscribe>
Sender: linuxconsole-dev-bounces@lists.sourceforge.net
Errors-To: linuxconsole-dev-bounces@lists.sourceforge.net
To: Jiri Kosina <jkosina@suse.cz>
Cc: lud <linux-usb@vger.kernel.org>, linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, linuxconsole-dev@lists.sourceforge.net, stern@rowland.harvard.edu, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Aug 19, 2008 at 05:23:07PM +0200, Jiri Kosina wrote:
> On Tue, 19 Aug 2008, Randy Dunlap wrote:
> 
> > > 2.6.22-1-mepis-smp
> > > Quite stable. Have oops sometime inside evdev. Support up to 16 
> > > USB keyboards, where 4 hubs are plugged into PC and 4 keyboards on
> > > each hub. Any hub cascade support only 4 keyboards, where 5th or more
> > > is registered but don't send input events. Oops inside evdev , when
> > > USB keyboard unplugged. No slow down even all USB keyboards does
> > > not work properly. My be this one support more than 16 keyboards, but
> > > i don't have PC USB ports enough.
> > Has the evdev oops been reported and/or fixed? I think that we would 
> > prefer to fix that soonish.
> 
> We haven't seen the respective oops yet, or have I missed it?
> 
> I'd bet it is fixed in newer kernels by patches that introduce proper 
> locking into evdev code.
> 

If evdev (or any other part of the input sybsystem) still oopses in
2.6.26 and 2.6.27 I would like to see that oops very much.

-- 
Dmitry

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
