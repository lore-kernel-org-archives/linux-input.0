From: Andy Whitcroft <apw@canonical.com>
Subject: Re: [PATCH 0/1] sysrq is half-enabled by default
Date: Tue, 18 Jan 2011 09:38:44 +0000
Message-ID: <20110118093844.GH16804@shadowen.org>
References: <1295123037-2649-1-git-send-email-apw@canonical.com>
 <20110115215450.GB19872@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110115215450.GB19872@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, Jan 15, 2011 at 01:54:50PM -0800, Dmitry Torokhov wrote:
> Hi Andy,
> 
> On Sat, Jan 15, 2011 at 08:23:56PM +0000, Andy Whitcroft wrote:
> > It seems that recent cleanups to sysrq handling have lead to us having
> > two copies of the sysrq enable status.  At boot these are currently
> > inconsistently specified leading to sysrq actually being enabled but
> > reported as not enabled in sysfs.  Following this email is a patch to
> > link both of these copies to a common configuration setting.
> > 
> 
> Thanks for noticing this, but I do not think we need a new configuration
> parameter. We did not have it for about 10 years and distributions know
> how to disable it upon boot if they want to.
> 
> Do youthink you could cange the patch and add a default value (1) to
> inlude/linux/sysrq.h and use it in sysctl and the handler code?

Sure thing.

-apw
