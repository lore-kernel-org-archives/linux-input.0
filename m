From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Add device tree binding for WM8753
Date: Fri, 12 Aug 2011 15:07:24 +0900
Message-ID: <1313129244.19990.56.camel@finisterre.wolfsonmicro.main>
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
	 <20110812055754.GC25184@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:51455 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751271Ab1HLGHq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Aug 2011 02:07:46 -0400
In-Reply-To: <20110812055754.GC25184@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, Liam Girdwood <lrg@ti.com>, Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, linux-input@vger.kernel.org

On Thu, 2011-08-11 at 22:57 -0700, Dmitry Torokhov wrote:
> On Fri, Aug 12, 2011 at 01:41:22PM +0900, Mark Brown wrote:

> > You tend to find that in a lot of systems only need a subset of the
> > platform data - some of it can get pretty esoteric - or perhaps none at
> > all so they'll be able to run happily even if not everything can be
> > configured via the device tree.

> That is why I said "devices that can't be adequately expressed". If we
> can have bindings that satisfy majority of users then of course DT
> handling code is more than welcome.

You seemed to be suggesting that devices that have platform data that
can't be expressed aren't worth adding DT support to - my point was that
the value is more dependant on the system needs than on the full feature
set that a driver can express.


