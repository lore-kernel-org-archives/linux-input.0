From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [v3.11][Regression] HID: hyperv: convert alloc+memcpy to
 memdup
Date: Fri, 27 Sep 2013 12:50:57 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1309271250130.18703@pobox.suse.cz>
References: <5237430B.5040009@canonical.com> <20130916203824.GP25896@mwanda>
 <52376ED9.5080208@canonical.com> <20130916210503.GQ25896@mwanda>
 <5237A5D5.8010006@canonical.com>
 <alpine.LNX.2.00.1309241129370.18703@pobox.suse.cz>
 <52432152.3030100@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <52432152.3030100@canonical.com>
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
Cc: list@osuosl.org, Haiyang Zhang <haiyangz@microsoft.com>, LKML <linux-kernel@vger.kernel.org>, open@osuosl.org, Dan Carpenter <dan.carpenter@oracle.com>, HID CORE LAYER <linux-input@vger.kernel.org>, devel@linuxdriverproject.org, thomas@m3y3r.de
List-Id: linux-input@vger.kernel.org

On Wed, 25 Sep 2013, Joseph Salisbury wrote:

> After further testing reverting the following commit does in fact
> resolve the bug:
> 
> commit b1a1442a23776756b254b69786848a94d92445ba
> Author: Jiri Kosina <jkosina@suse.cz>
> Date: Mon Jun 3 11:27:48 2013 +0200
> 
>     HID: core: fix reporting of raw events
> 
> Reverting this commit in v3.12-rc2 prevents the system from locking up, 
> which happens when connecting a bluetooth trackpad.
> 
> Jiri, do you think we should revert this patch, or is there some further 
> debugging/data collecting you would like to do?

Hi Joseph,

in this mail:

	Message-ID: <5241992E.3090805@canonical.com>
	Date: Tue, 24 Sep 2013 09:52:46 -0400

you said that reverting this commit doesn't prevent the lockups, so I am 
rather confused ... ?

Thanks,

-- 
Jiri Kosina
SUSE Labs
