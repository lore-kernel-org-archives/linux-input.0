From: "Avuton Olrich" <avuton@gmail.com>
Subject: Re: linux-2.6.20.4-ck1 / evdev / hub crash
Date: Tue, 3 Apr 2007 20:10:28 -0700
Message-ID: <3aa654a40704032010s2cc20ce6y6416dc1502f59b88@mail.gmail.com>
References: <3aa654a40703282007xabf2fefi97c04162204ec091@mail.gmail.com>
	<Pine.LNX.4.64.0703291051500.19566@jikos.suse.cz>
	<200704032302.14952.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200704032302.14952.dtor@insightbb.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, Jiri Kosina <jkosina@suse.cz>, linux-usb-devel@lists.sourceforge.net
List-Id: linux-input@vger.kernel.org

On 4/3/07, Dmitry Torokhov <dtor@insightbb.com> wrote:
> On Thursday 29 March 2007 04:56, Jiri Kosina wrote:
> > On Wed, 28 Mar 2007, Avuton Olrich wrote:
> >
> > > I've been having problems lately with my mouse, and I know that the
> > > kernel is tainted. If that's a problem please just ignore this dump.
> > > I just restarted my computer with a ck[1] kernel, which I had been on
> > > for a couple of days before this, when X started I noticed that my MX
> > > Revolution mouse didn't work, so I tried to restart KDM (every now and
> > > again evdev fails, has problems). When that didn't work I decided to
> > > remove and reinstall the receiver from the hub, when I did I noticed X
> > > wouldn't start any more and my dmesg[2] had a dump. Also including a
> > > copy of my .config[3] (slightly modified for use with a newer kernel).
> > > This isn't a reoccurring issue, yet, just wanted to report it in case
> > > it's of any use, thanks. I'm not on the list, please CC me if anything
> > > is needed.
> > > 1.
> > > http://ck.kolivas.org/patches/pre-releases/2.6.20.4/2.6.20.4-ck1/patch-2.6.20.4-ck1.bz2
> > > 2. http://avuton.googlepages.com/evdev_dump
> > > 3. http://avuton.googlepages.com/config
> >
> > Hi,
> >
> > I added Dmitry and linux-input mailinglist to CC. This is the second time
> > I see oops on dereferencing 0x00100100 pointer in evdev_disconnect()
> > called from input_unregister_device()
> > - the first one is DVB-T related thing reported a few days ago here -
> > http://lkml.org/lkml/2007/3/9/212
> >
>
> Could you please try 2.6.21-rc5-mm4? It has evdev locking patch that
> I believe should fix these kind of oopses.

I'd have no problem testing it, but since that oops, it hasn't
reoccurred I couldn't reproduce it when I attempted (about 20-30
pull-outs). Obviously, if there's some reason for me to try, I will,
but I don't see any advantage to you or I.
-- 
avuton
--
 Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
