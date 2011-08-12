From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Add device tree binding for WM8753
Date: Fri, 12 Aug 2011 13:41:22 +0900
Message-ID: <1313124082.19990.54.camel@finisterre.wolfsonmicro.main>
References: <1312778255-29755-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	 <CAGsJ_4y2tDb3ZBPo8bCtrjFt0OWzR8WeG+kL_RKJPRP7-pZopw@mail.gmail.com>
	 <20110809065100.GB8017@core.coreip.homeip.net>
	 <20110809142851.GA15861@opensource.wolfsonmicro.com>
	 <CAGsJ_4w-YhWQTFovkynKVVr6JkwcHJQn-EmfxUxOSd=C2BwhiA@mail.gmail.com>
	 <20110810045113.GA23625@opensource.wolfsonmicro.com>
	 <CAGsJ_4ykb65aD_a-04NuE-DRoERmB+WKLvaS8+5VYpE6pgOh5w@mail.gmail.com>
	 <20110810063025.GA31765@opensource.wolfsonmicro.com>
	 <CAGsJ_4zmY7gXyD6EDmYgRVAkmOaQVa79LuVSrK287Q=pHF6_FA@mail.gmail.com>
	 <20110812035308.GA25184@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:50144 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750726Ab1HLEld (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Aug 2011 00:41:33 -0400
In-Reply-To: <20110812035308.GA25184@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, Liam Girdwood <lrg@ti.com>, Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, linux-input@vger.kernel.org

On Thu, 2011-08-11 at 20:53 -0700, Dmitry Torokhov wrote:
> On Fri, Aug 12, 2011 at 11:16:49AM +0800, Barry Song wrote:

> > at least wakeup, irq_flags in the structure should be something
> > related with driver implementation not hardware. Suppose all others
> > are hardware properties, it looks terrible to list and get so many
> > properties in dts and drivers.

It doesn't seem like this should be a blocker for moving the things we
can move, the conversion is going to need doing anyway so we may as well
get on with it. We always keep the platform data option around anyway as
not all platforms have converted to the device tree and it means that
systems that don't need to use any of the things that are difficult to
convert are able to convert.

In the case of wakeup there's already an API for controlling things at
runtime (device_may_wakeup() and so on) which the driver should probably
be converted to use, though I've not looked at what the actual platform
data does.

In the case of the IRQ flags we've got a generic problem that needs
solving at the IRQ level - the device is responsible for specifying the
flags but many devices are flexible about how they signal interrupts in
order to improve interoperability with controllers.

> Maybe should not add DT bindings for devices that can't be adequately
> expressed via DT properties [yet]? Because I do not see what benefits we
> get since platform code still needs to provide missing data and now we'd
> have issue of data not being there when device is registered and driver
> is being bound to it.

You tend to find that in a lot of systems only need a subset of the
platform data - some of it can get pretty esoteric - or perhaps none at
all so they'll be able to run happily even if not everything can be
configured via the device tree.

