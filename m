From: Jiri Kosina <jikos@kernel.org>
Subject: Re: HID: intel_ish-hid: various cleanups
Date: Tue, 30 May 2017 14:13:38 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1705301412120.26873@cbobk.fhfr.pm>
References: <20170518202144.3482304-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53048 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750992AbdE3MNk (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 30 May 2017 08:13:40 -0400
In-Reply-To: <20170518202144.3482304-1-arnd@arndb.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 18 May 2017, Arnd Bergmann wrote:

> I ran into a warning message during randconfig testing and spent way
> too much time figuring out how to best address it. One thing led to
> another and I ended up with a 5 patch series.
> 
> Unforunately I screwed up the first version of the series and
> had to replace the first patch, but the second version should
> be much better.
> 
> Please have a look at the first patch separately, it might fix an
> important bug and need backporting to stable kernels, or it might
> only address a harmless warning.
> 
> For the rest of the patches, please merge for 4.13 unless you
> see something wrong.

All queued in for-4.13/ish. Thanks,

-- 
Jiri Kosina
SUSE Labs

