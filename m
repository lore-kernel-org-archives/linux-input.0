From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] soc_button_array: fix the issue that button device
 can't be enumerated since 3.16-rc1
Date: Thu, 10 Jul 2014 14:24:02 +0800
Message-ID: <1404973442.28592.7.camel@rzhang1-toshiba>
References: <1404309504.8366.93.camel@rzhang1-toshiba>
	 <1404309713.8366.94.camel@rzhang1-toshiba>
	 <2556427.cdnVoQoSXY@vostro.rjw.lan>
	 <20140709165732.GD10364@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:52690 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbaGJGYH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Jul 2014 02:24:07 -0400
In-Reply-To: <20140709165732.GD10364@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, yao.jin@intel.com, linux-input <linux-input@vger.kernel.org>

On Wed, 2014-07-09 at 09:57 -0700, Dmitry Torokhov wrote:
> On Tue, Jul 08, 2014 at 10:50:04PM +0200, Rafael J. Wysocki wrote:
> > On Wednesday, July 02, 2014 10:01:53 PM Zhang Rui wrote:
> > > From c2ee1886ba230d9d93d2ea2f350b1dc1a2d5ead5 Mon Sep 17 00:00:00 2001
> > > From: Jin Yao <yao.jin@linux.intel.com>
> > > Date: Thu, 26 Jun 2014 10:26:44 +0800
> > > Subject: [PATCH] soc_button_array: fix the issue that button device can't be
> > >  enumerated since 3.16-rc1
> > 
> > Hi Rui,
> > 
> > For 3.16 I'm afraid we need to add the missing device ID to the PNP list.
> > It is too late to do the conversion at this point IMO and we can do it later.
> 
> But for 3.17 this patch is the right way of doing things, right?
> 
yes, but it needs a bit more work to revert the "PNP0C40" id from
drivers/acpi/acpi_pnp.c.
I will send an updated one once the "Adding PNP0C40 id" patch is merged.

thanks,
rui
> Thanks.
> 


