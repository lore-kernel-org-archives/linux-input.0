From: Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: Re: [v3.11][Regression] HID: hyperv: convert alloc+memcpy to memdup
Date: Tue, 24 Sep 2013 14:25:09 -0400
Message-ID: <5241D905.9030001@canonical.com>
References: <5237430B.5040009@canonical.com> <20130916203824.GP25896@mwanda>
 <52376ED9.5080208@canonical.com> <20130916210503.GQ25896@mwanda>
 <5237A5D5.8010006@canonical.com>
 <alpine.LNX.2.00.1309241129370.18703@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <alpine.LNX.2.00.1309241129370.18703@pobox.suse.cz>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: list@osuosl.org, Haiyang Zhang <haiyangz@microsoft.com>, LKML <linux-kernel@vger.kernel.org>, open@osuosl.org, Dan Carpenter <dan.carpenter@oracle.com>, HID CORE LAYER <linux-input@vger.kernel.org>, devel@linuxdriverproject.org, thomas@m3y3r.de
List-Id: linux-input@vger.kernel.org

On 09/24/2013 05:29 AM, Jiri Kosina wrote:
> On Mon, 16 Sep 2013, Joseph Salisbury wrote:
>
>>>> Can you explain a little further?  Mark commit a4a23f6 as bad?  An
>>>> initial bisect already reported that was the first bad commit, so it
>>>> can't be marked bad.  The oops on memcpy() happens after commit a4a23f6
>>>> is reverted.  The oops on memcpy() did not happen before a4a23f6 was
>>>> committed, so I assume this new oops was introduced by a change later.
>>>>
>>>> Right now I'm bisecting down the oops on memcpy() by updating the bisect
>>>> with good or bad, depending if the test kernel hit the oops.  I then
>>>> revert a4a23f6, so that revert is the HEAD of the tree each time before
>>>> building the kernel again(As long as the commit spit out by bisect is
>>>> after when a4a23f6 was introduced).
>>> Yep.  Please continue bisecting the memcpy() oops.
>>>
>>> kmemdup() is just a kzalloc() followed by a memcpy().  When we split it
>>> apart by reverting the patch then we would expect the oops to move to
>>> the memcpy() part.  Somehow "desc" is a bogus pointer, but I don't
>>> immediately see how that is possible.
>>>
>>> regards,
>>> dan carpenter
>> Thanks for the details.  We'll continue the bisect and let you know how
>> it goes.
> Did this please yield any useful result?
>
> Thanks,
>

We also tested the 3.12-rc2 kernel, but it also produces an oops and
lockup.  In case it's of use, the 3.12-rc2 oops can be seen at:
https://launchpadlibrarian.net/151359441/kern.log
