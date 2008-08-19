From: David Brownell <david-b@pacbell.net>
Subject: Re: PROBLEM: USB keyboards works only 4 per PC host port
Date: Tue, 19 Aug 2008 12:12:17 -0700 (PDT)
Message-ID: <681431.40736.qm@web82201.mail.mud.yahoo.com>
References: <Pine.LNX.4.44L0.0808191400150.3391-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxconsole-dev-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0808191400150.3391-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linuxconsole-dev>,
	<mailto:linuxconsole-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linuxconsole-dev>
List-Post: <mailto:linuxconsole-dev@lists.sourceforge.net>
List-Help: <mailto:linuxconsole-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linuxconsole-dev>,
	<mailto:linuxconsole-dev-request@lists.sourceforge.net?subject=subscribe>
Sender: linuxconsole-dev-bounces@lists.sourceforge.net
Errors-To: linuxconsole-dev-bounces@lists.sourceforge.net
To: Alan Stern <stern@rowland.harvard.edu>, juanslayton@dslextreme.com
Cc: jkosina@suse.cz, lud <linux-usb@vger.kernel.org>, linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, linuxconsole-dev@lists.sourceforge.net, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--- Alan Stern <stern@rowland.harvard.edu> wrote:

> On Tue, 19 Aug 2008 juanslayton@dslextreme.com wrote:
> > If I understand your analysis, Aivils' problem is because the UHCI
> > controllers are too slow.
> 
> Not just that; it also is a question of scheduling.  The uhci-hcd
> driver isn't very clever about scheduling, and it tries to put all the
> packets into the same frame.  If the packets were distributed among
> multiple frames then the limit would be considerably higher (eight
> times higher in this case).
> 
> I'm not sure of the scheduling details in the ohci-hcd driver; they
> might well be more flexible than in uhci-hcd.  In which case a single
> OHCI controller would be able to handle up to 32 of these keyboards, 
> even though it is no faster than a UHCI controller.

The OHCI scheduling is pretty simple and compact.  I'd think it would
be easy enough to make UHCI do the same sort of thing:  track bandwidth
assigned to 2^N frames (OHCI hardware imposes a smaller limit for N
than UHCI hardware does), and pick the least loaded of those frames to
use for new transfers.  In ohci-q.c see balance(), periodic_{,un}link().

Thing is that would involve changing how UHCI manages periodic transfers;
assuming it hasn't changed those structures since last I looked.


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
