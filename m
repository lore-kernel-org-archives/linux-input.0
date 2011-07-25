From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] drivers:input:set driver data to NULL for pcap_keys
Date: Mon, 25 Jul 2011 11:37:46 -0700
Message-ID: <20110725183746.GD6876@core.coreip.homeip.net>
References: <1311176068-9934-1-git-send-email-wanlong.gao@gmail.com>
 <20110725083048.GD22937@core.coreip.homeip.net>
 <4E2D33E3.9090408@cn.fujitsu.com>
 <20110725152106.GB23356@suse.de>
 <1311608069.3262.8.camel@Allen>
 <20110725181916.GB6876@core.coreip.homeip.net>
 <20110725182928.GB1175@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41287 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563Ab1GYShx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2011 14:37:53 -0400
Received: by ywe9 with SMTP id 9so2419209ywe.19
        for <linux-input@vger.kernel.org>; Mon, 25 Jul 2011 11:37:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110725182928.GB1175@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Wanlong Gao <wanlong.gao@gmail.com>, Greg KH <gregkh@suse.de>, Wanlong Gao <gaowanlong@cn.fujitsu.com>, linux-input@vger.kernel.org

On Mon, Jul 25, 2011 at 07:29:28PM +0100, Mark Brown wrote:
> On Mon, Jul 25, 2011 at 11:19:16AM -0700, Dmitry Torokhov wrote:
> 
> > Right, like i2c bus we could just have platform core clean up platform
> > drvdata pointer after calling ->remove() and also if ->probe() errors
> > out.
> 
> I2C doesn't do this (at least not any more).
> 

Sure does. See drivers/i2c/i2c-core.c::i2c_device_probe() and
i2c_device_remove().

> > Then individual drivers do not have to care about cleaning up this
> > pointer.
> 
> They don't have to worry about it anyway, the only thing that is allowed
> to use the pointer is a currently bound driver and it's only allowed to
> rely on is that while it's bound it'll get back the same driver_data
> that it put in.

Right, except that some people trying to use this pointers to pass
platform data to the driver... Resetting the pointer to NULL on unbind
will hopefully show them their mistake.

-- 
Dmitry
