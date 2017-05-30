From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] Input: synaptics-rmi4 - use %ph to form F34
 configuration ID
Date: Tue, 30 May 2017 22:04:19 +0300
Message-ID: <1496171059.28981.33.camel@linux.intel.com>
References: <20170530044944.GA33451@dtor-ws>
         <20170530082358.GB1293@mail.corp.redhat.com>
         <20170530165913.GD12922@dtor-ws> <1496165034.2618.26.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:58997 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751086AbdE3TEX (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 30 May 2017 15:04:23 -0400
In-Reply-To: <1496165034.2618.26.camel@perches.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joe Perches <joe@perches.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, Nick Dyer <nick@shmanahar.org>, Dan Carpenter <dan.carpenter@oracle.com>, linux-kernel@vger.kernel.org

On Tue, 2017-05-30 at 10:23 -0700, Joe Perches wrote:
> On Tue, 2017-05-30 at 09:59 -0700, Dmitry Torokhov wrote:
> > On Tue, May 30, 2017 at 10:23:58AM +0200, Benjamin Tissoires wrote:
> > > On May 29 2017 or thereabouts, Dmitry Torokhov wrote:
> > > > 

> > Or we'd need to introduce %pH I guess.
> 
> As it's debugging output, I'd hazard to guess it doesn't matter.
> 
> If someone _really_ needs upper-case output in *ph,

Starting from the same...

> 
> A pity that %ph[cdnCDN] isn't possible as that's the style used
> by %pU[blBL] for lower/upper case output.
> 
> There are < 80 uses of %[\*\d]+ph[CDN], maybe it'd be reasonable
> to do a treewide sed to lowercase for them.  Dunno.

And I think less intrusive would be 
%pH[CDN]
since the latter proposal misses plain %*ph use.

But for now I would rather avoid it at all, I'm pretty sure there very
rare cases when one needs
1) to print a dump, *and*
2) it should be upper cased.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
