From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: evdev regression on macbook with 2.6.33-rc5
Date: Mon, 25 Jan 2010 15:25:21 -0800
Message-ID: <20100125232520.GC30307@core.coreip.homeip.net>
References: <3d8471ca1001231053k512011dcnfab50052ce3667fa@mail.gmail.com>
 <20100124093055.GA17607@core.coreip.homeip.net>
 <3d8471ca1001251449g6bdbdb4fn11f566b41691f870@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752153Ab0AYXZk@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3d8471ca1001251449g6bdbdb4fn11f566b41691f870@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guillaume Chazarain <guichaz@gmail.com>
Cc: ajax@redhat.com, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jan 25, 2010 at 11:49:20PM +0100, Guillaume Chazarain wrote:
> On Sun, Jan 24, 2010 at 10:30 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > DOes the same behavior happens when you try using 'evtest' utility while
> > in console?
> 
> Hi Dmitry,
> 
> While struggling to make evtest show keyboard events, I discovered
> that the problem is an incompatibility with mouseemu
> (http://packages.ubuntu.com/karmic/mouseemu) as killing it makes the
> keyboard work fine.
> 
> So, with mouseemu running, evtest won't print any event at all even if
> I move the mouse, and when mouseemu is off everything works fine and
> evtest prints the expected events.
> 

Ah, well, I checked out the sources for this fine specimen. Oh man...
Then we have Debian guys adding their perls to keyboard handler:

++	if (inp.type != EV_KEY && inp.type != EV_REP)
++		return;

Obviously EV_SYN is completely useless message. And who cares about
keyboards with scroll wheels, volume sliders, etc, right?

This package either needs lots of love or it just needs to die...

-- 
Dmitry
