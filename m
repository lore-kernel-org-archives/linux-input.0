From: "johann deneux" <johann.deneux@gmail.com>
Subject: Re: [PATCH] iforce: Use usb_kill_urb instead of
	usb_unlink_urb.
Date: Sun, 18 Mar 2007 09:01:28 +0100
Message-ID: <38b3b7c0703180101hef6b82cn9c920eb20edade7f@mail.gmail.com>
References: <38b3b7c0703171439n10025a7bx55a588911eb765d6@mail.gmail.com>
	<38b3b7c0703171443j2f50f913r76ab111ba7ed109f@mail.gmail.com>
	<38b3b7c0703171450q5217f4eer91e7ba0f6135d98@mail.gmail.com>
	<200703172137.23385.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200703172137.23385.dtor@insightbb.com>
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
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-usb-devel@lists.sourceforge.net
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On 3/18/07, Dmitry Torokhov <dtor@insightbb.com> wrote:
> Hi Johann,
>
> On Saturday 17 March 2007 17:50, johann deneux wrote:
> > A note about that patch: Apparently Anders Fugmann submitted a patch to use
> > usb_kill_urb to linux-usb-devel for version 2.6.10.
> > I don't know if this patch got lost, or if it was rejected.
>
> Since every other USB dirver uses usb_kill_urb it loosk like the patch was
> just missed...
>
> >
> > On 3/17/07, johann deneux <johann.deneux@gmail.com> wrote:
> > >
> > > commit 0ba8785483c2ee7f56e8f242e000f6cd17a7da40
> > > Author: Johann Deneux <johann.deneux@gmail.com>
> > > Date:   Sat Mar 17 22:23:44 2007 +0100
> > >
> > >     iforce: Use usb_kill_urb instead of usb_unlink_urb.
> > >
> > >     Using usb_unlink_urb can cause iforce_open to fail when called soon
> > > after iforce_release.
> > >     Also updated my email address and replaced calls to printk() by dbg(),
> > > warn(), info(), err()...
> > >
>
> Since there seems a lot of implementations of r warn(), err(), etc what kind
> of output would iforce produce?
>

It uses the implementation from include/linux/usb.h. The output from
the module should be approximately the same as before, except for
debug messages which were previously inconditionally produced, and are
now produced only when macro DEBUG is defined and non-zero.
Macros warn(), dbg()... in usb.h use printk KERN_WARNING, KERN_DEBUG...

-- 
Johann

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
