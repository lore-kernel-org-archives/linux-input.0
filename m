From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [v3.11][Regression] HID: hyperv: convert alloc+memcpy to memdup
Date: Tue, 17 Sep 2013 00:05:04 +0300
Message-ID: <20130916210503.GQ25896@mwanda>
References: <5237430B.5040009@canonical.com> <20130916203824.GP25896@mwanda>
 <52376ED9.5080208@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <52376ED9.5080208@canonical.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Joseph Salisbury <joseph.salisbury@canonical.com>
Cc: list@osuosl.org, Jiri Kosina <jkosina@suse.cz>, Haiyang Zhang <haiyangz@microsoft.com>, LKML <linux-kernel@vger.kernel.org>, open@osuosl.org, HID CORE LAYER <linux-input@vger.kernel.org>, devel@linuxdriverproject.org, thomas@m3y3r.de
List-Id: linux-input@vger.kernel.org

On Mon, Sep 16, 2013 at 04:49:29PM -0400, Joseph Salisbury wrote:
> On 09/16/2013 04:38 PM, Dan Carpenter wrote:
> > On Mon, Sep 16, 2013 at 01:42:35PM -0400, Joseph Salisbury wrote:
> >> Reverting the patch changes the driver back to useing kzalloc() and
> >> memcpy() instead of  kmemdup.  Doing so has uncovered another bug, which
> >> causes an oops on memcpy()[1].  We are in the process of bisecting that
> >> one now and will provide the results.
> > The two bugs are the same it's that the code has shifted a little.  Mark
> > the commit as buggy and continue with the git bisect.
> >
> > regards,
> > dan carpenter
> Can you explain a little further?  Mark commit a4a23f6 as bad?  An
> initial bisect already reported that was the first bad commit, so it
> can't be marked bad.  The oops on memcpy() happens after commit a4a23f6
> is reverted.  The oops on memcpy() did not happen before a4a23f6 was
> committed, so I assume this new oops was introduced by a change later.
> 
> Right now I'm bisecting down the oops on memcpy() by updating the bisect
> with good or bad, depending if the test kernel hit the oops.  I then
> revert a4a23f6, so that revert is the HEAD of the tree each time before
> building the kernel again(As long as the commit spit out by bisect is
> after when a4a23f6 was introduced).

Yep.  Please continue bisecting the memcpy() oops.

kmemdup() is just a kzalloc() followed by a memcpy().  When we split it
apart by reverting the patch then we would expect the oops to move to
the memcpy() part.  Somehow "desc" is a bogus pointer, but I don't
immediately see how that is possible.

regards,
dan carpenter
