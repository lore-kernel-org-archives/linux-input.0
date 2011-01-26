From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Fromy: Hong Liu <hong.liu@intel.com>
Date: Wed, 26 Jan 2011 10:01:51 +0000
Message-ID: <20110126100151.6332e8ec@lxorguk.ukuu.org.uk>
References: <20110125143139.10249.33984.stgit@bob.linux.org.uk>
	<20110126050639.GD23085@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52513 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751159Ab1AZKB1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Jan 2011 05:01:27 -0500
In-Reply-To: <20110126050639.GD23085@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

> Hmm, if it is platform driver then you need to also post it to the
> platform driver list/Matthew. If you want it to be an input driver
> please move to drivers/input/misc/.

Will do - wanted to check it was ok on the input side first.

> > +config INTEL_MID_POWER_BUTTON
> > +	tristate "power button driver for Intel MID platforms"
> > +	depends on INTEL_SCU_IPC
> > +	default y
> 
> 'y' is for essential features I believe.

Good point - fixed
> 
> > +	help
> > +	  This driver handles the power button on the Intel MID platforms.
> > +
> > +	  If unsure, say N.
> > +
> 
> To compile this driver as a module...

Thats a form the platform/x86 driver Kconfig never uses - not sure of the
history of that choice


> > +	ret = intel_scu_ipc_ioread8(MSIC_PB_STATUS, &pbstat);
> 
> Is this sleeping?

Yes - hence the threade IRQ. The SCU is basically another device we send
messages to and which sends us replies back.

> Space after comma please.

Fixed

> You are forgetting to free IRQ.

Fixed

Will now send it to mjg

