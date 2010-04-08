From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 0/2]-V2 Add touch screen input driver for TPS6507x
 family of multi-function chips.
Date: Thu, 8 Apr 2010 11:32:49 +0200
Message-ID: <20100408093248.GA3075@sortiz.org>
References: <1270511593-4785-1-git-send-email-todd.fischer@ridgerun.com>
 <20100407084644.GB2962@sortiz.org>
 <874ojnfdlt.fsf@deeprootsystems.com>
 <87ljczdydj.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:2265 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754105Ab0DHJc2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Apr 2010 05:32:28 -0400
Content-Disposition: inline
In-Reply-To: <87ljczdydj.fsf@deeprootsystems.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Todd Fischer <todd.fischer@ridgerun.com>, davinci-linux-open-source@linux.davincidsp.com, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, linux-input@vger.kernel.org

Hi Kevin,

On Wed, Apr 07, 2010 at 09:24:24AM -0700, Kevin Hilman wrote:
> Kevin Hilman <khilman@deeprootsystems.com> writes:
> 
> > Samuel Ortiz <sameo@linux.intel.com> writes:
> >
> >> Hi Todd, hi Kevin,
> >>
> >> On Mon, Apr 05, 2010 at 05:53:11PM -0600, Todd Fischer wrote:
> >>> 
> >>> This is the second posting of the TPS6507x touch screen driver. I have
> >>> incorporated Kevin Hilman's request to split the board specific changes
> >>> into a separate patch.
> 
> [...]
> 
> >>
> >> I've applied patch #1 of this patchset. Kevin, would you please take patch #2?
> >
> > Thanks.  Yes, patch #2 will be queued for linux-next and 2.6.35.
> 
> After trying to apply this, I ran into some snags
> 
> The other series '[PATCH 0/4]-V3 TPS6507x MFD driver' also had some
> board file changes mixed in that I did not catch, and patch #2 of this
> series depends on those.
> 
> So either we split those out and merge them via my tree, or you can
> just merge patch #2 of this series via your tree as well.
> 
> I'm OK with either option, but just merging patch #2 of this series
> via your tree seems like the least amount of hassle at this time.
Definitely. I'm taking this patch, thanks a lot.

Cheers,
Samuel.


> If you merge via your tree, please add:
> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> 
> Kevin

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
