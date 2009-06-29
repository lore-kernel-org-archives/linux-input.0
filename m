From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/2] fix gpio-keys debouncing and timer sleep issues
Date: Sun, 28 Jun 2009 22:59:40 -0700
Message-ID: <20090629055940.GC12821@dtor-d630.eng.vmware.com>
References: <20090626002345.07928230@dxy.sh.intel.com> <cover.1246015395.git.ext-jani.1.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:44797 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbZF2F7l (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Jun 2009 01:59:41 -0400
Content-Disposition: inline
In-Reply-To: <cover.1246015395.git.ext-jani.1.nikula@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jani Nikula <ext-jani.1.nikula@nokia.com>
Cc: alek.du@intel.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, soni.trilok@gmail.com, ben-linux@fluff.org, ext-phil.2.carmody@nokia.com

Hi Jani,

On Fri, Jun 26, 2009 at 03:15:16PM +0300, Jani Nikula wrote:
> Alek, someone might depend on how debouncing worked before, so let's not 
> break it. I, for one, am looking at using this in the future, and would 
> want this to work as it was before.
> 
> Why don't we fix this instead of debating? For simplicity, here's first 
> a revert of the original patch and then a fix to the sleep issue. 
> Unfortunately, I do not have the equipment to properly test this right 
> now.
> 

I intend to apply the both patches. It is unfortunate that we need to
use both a timer and a workqueue, I wonder what would it take to
implement something like reschedule_delayed_work() that would adjust
the delay in the same fashion that mod_timer() does?

-- 
Dmitry
