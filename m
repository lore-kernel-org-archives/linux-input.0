From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Add device tree binding for WM8753
Date: Thu, 11 Aug 2011 22:57:54 -0700
Message-ID: <20110812055754.GC25184@core.coreip.homeip.net>
References: <CAGsJ_4y2tDb3ZBPo8bCtrjFt0OWzR8WeG+kL_RKJPRP7-pZopw@mail.gmail.com>
 <20110809065100.GB8017@core.coreip.homeip.net>
 <20110809142851.GA15861@opensource.wolfsonmicro.com>
 <CAGsJ_4w-YhWQTFovkynKVVr6JkwcHJQn-EmfxUxOSd=C2BwhiA@mail.gmail.com>
 <20110810045113.GA23625@opensource.wolfsonmicro.com>
 <CAGsJ_4ykb65aD_a-04NuE-DRoERmB+WKLvaS8+5VYpE6pgOh5w@mail.gmail.com>
 <20110810063025.GA31765@opensource.wolfsonmicro.com>
 <CAGsJ_4zmY7gXyD6EDmYgRVAkmOaQVa79LuVSrK287Q=pHF6_FA@mail.gmail.com>
 <20110812035308.GA25184@core.coreip.homeip.net>
 <1313124082.19990.54.camel@finisterre.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:42514 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab1HLF6B (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Aug 2011 01:58:01 -0400
Received: by iye16 with SMTP id 16so890194iye.1
        for <linux-input@vger.kernel.org>; Thu, 11 Aug 2011 22:58:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313124082.19990.54.camel@finisterre.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Barry Song <21cnbao@gmail.com>, Liam Girdwood <lrg@ti.com>, Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, linux-input@vger.kernel.org

On Fri, Aug 12, 2011 at 01:41:22PM +0900, Mark Brown wrote:
> On Thu, 2011-08-11 at 20:53 -0700, Dmitry Torokhov wrote:
> 
> > Maybe should not add DT bindings for devices that can't be adequately
> > expressed via DT properties [yet]? Because I do not see what benefits we
> > get since platform code still needs to provide missing data and now we'd
> > have issue of data not being there when device is registered and driver
> > is being bound to it.
> 
> You tend to find that in a lot of systems only need a subset of the
> platform data - some of it can get pretty esoteric - or perhaps none at
> all so they'll be able to run happily even if not everything can be
> configured via the device tree.

That is why I said "devices that can't be adequately expressed". If we
can have bindings that satisfy majority of users then of course DT
handling code is more than welcome.

-- 
Dmitry
