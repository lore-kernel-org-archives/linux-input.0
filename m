From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 23/28] keyboard,
 input: Add hook to input to allow low level event clear
Date: Sun, 28 Feb 2010 21:04:37 -0800
Message-ID: <20100301050437.GE765@core.coreip.homeip.net>
References: <1267132893-23624-1-git-send-email-jason.wessel@windriver.com>
	<1267132893-23624-24-git-send-email-jason.wessel@windriver.com>
	<20100226080329.GD17062@core.coreip.homeip.net>
	<4B87F17B.6040305@windriver.com>
	<20100227075528.GA793@core.coreip.homeip.net>
	<4B8B3B08.7000705@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kgdb-bugreport-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <4B8B3B08.7000705@windriver.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport>,
	<mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kgdb-bugreport>
List-Post: <mailto:kgdb-bugreport@lists.sourceforge.net>
List-Help: <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport>,
	<mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=subscribe>
Errors-To: kgdb-bugreport-bounces@lists.sourceforge.net
To: Jason Wessel <jason.wessel@windriver.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, kgdb-bugreport@lists.sourceforge.net, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, torvalds@linux-foundation.org, Alexey Dobriyan <adobriyan@gmail.com>
List-Id: linux-input@vger.kernel.org

On Sun, Feb 28, 2010 at 09:56:56PM -0600, Jason Wessel wrote:
> Dmitry Torokhov wrote:
> > The problem with your patch is that you end up using input_pass_event()
> > which only passes events to handler, but it does not reset device state.
> > This will cause loss of the first press of the same button after
> > returning from kdb. input_inject_event() should do what you need. You
> > just need to do it from a tasklet or, better yet (there is no
> > performance issue) schedule a work on keventd so you don't deadlock
> > on the event lock. It will also do all necessary locking, which is
> > something you seem to be ignoring.
> >
> > ...
> >
> >   
> 
> For now I am just going to drop this patch from the series, and I think
> we should pick up the continuation of the discussion on the
> linux-input.  The lack of this patch simply means keys can stuck down
> sometimes if you go in and out of the kernel debug shell when running
> X.   People were able to live with this a long time in the original kdb
> v4.4, so they can live with it a while longer while a solution is hashed
> out to "unstick the keys".
> 
> This will allow me to re-issue a pull request which has no patches which
> are in the discussion state.
> 

OK.

> It is not obvious to me how walk through the input device list with the
> right locks and then obtain the handle required to call the inject
> input.  It does not appear that it is possible to hold the locks while
> walking through the keycode device bitmap and issue calls to inject
> input. Is there any kind of input API function to obtain the device bitmaps?
> 

There is key_down bitmap right there in keyboard.c that reflects all
keys that are considered "down" as far as keyboard driver is concerned.
You can use input_handler_for_each_handle() for kbd_handler to iterate
through all input handles and send "up" events for all keys that
keyboard.c is considering as being "down". There is no harm in sending
extra "up" events for keys that are not pressed - the event will simply
be ignored by input core.

Hope this helps.

-- 
Dmitry

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
