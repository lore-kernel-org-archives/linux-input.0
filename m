From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] soc_button_array: fix the issue that button device can't
 be enumerated since 3.16-rc1
Date: Mon, 22 Sep 2014 10:36:30 -0700
Message-ID: <20140922173630.GA22421@core.coreip.homeip.net>
References: <1404309504.8366.93.camel@rzhang1-toshiba>
 <1404309713.8366.94.camel@rzhang1-toshiba>
 <2556427.cdnVoQoSXY@vostro.rjw.lan>
 <20140709165732.GD10364@core.coreip.homeip.net>
 <1406702719.10148.3.camel@rzhang1-toshiba>
 <1411350272.1280.51.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:57290 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879AbaIVRgg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Sep 2014 13:36:36 -0400
Received: by mail-pd0-f172.google.com with SMTP id y10so4789524pdj.17
        for <linux-input@vger.kernel.org>; Mon, 22 Sep 2014 10:36:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1411350272.1280.51.camel@rzhang1-toshiba>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, yao.jin@intel.com, linux-input <linux-input@vger.kernel.org>

On Mon, Sep 22, 2014 at 09:44:32AM +0800, Zhang Rui wrote:
> Hi, Dmitry,
> 
> On Wed, 2014-07-30 at 14:45 +0800, Zhang Rui wrote:
> > Hi, Dmitry,
> > 
> > On Wed, 2014-07-09 at 09:57 -0700, Dmitry Torokhov wrote:
> > > On Tue, Jul 08, 2014 at 10:50:04PM +0200, Rafael J. Wysocki wrote:
> > > > On Wednesday, July 02, 2014 10:01:53 PM Zhang Rui wrote:
> > > > > From c2ee1886ba230d9d93d2ea2f350b1dc1a2d5ead5 Mon Sep 17 00:00:00 2001
> > > > > From: Jin Yao <yao.jin@linux.intel.com>
> > > > > Date: Thu, 26 Jun 2014 10:26:44 +0800
> > > > > Subject: [PATCH] soc_button_array: fix the issue that button device can't be
> > > > >  enumerated since 3.16-rc1
> > > > 
> > > > Hi Rui,
> > > > 
> > > > For 3.16 I'm afraid we need to add the missing device ID to the PNP list.
> > > > It is too late to do the conversion at this point IMO and we can do it later.
> > > 
> > > But for 3.17 this patch is the right way of doing things, right?
> > 
> > This is the patch we should use for 3.17.
> > Compared with the previous version, I just removed the soc_button_array id
> > from acpi pnp id list, which was added in 3.16-rc5, as an urgent fix.
> > 
> > Please review.
> > 
> Can you please take a look at this patch?

Ah, yes, it looks good. I think it's OK to hold it for 3.18 though,
right?

Thanks.

-- 
Dmitry
