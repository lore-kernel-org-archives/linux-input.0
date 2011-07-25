From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] drivers:input:set driver data to NULL for pcap_keys
Date: Mon, 25 Jul 2011 19:29:28 +0100
Message-ID: <20110725182928.GB1175@sirena.org.uk>
References: <1311176068-9934-1-git-send-email-wanlong.gao@gmail.com>
 <20110725083048.GD22937@core.coreip.homeip.net>
 <4E2D33E3.9090408@cn.fujitsu.com>
 <20110725152106.GB23356@suse.de>
 <1311608069.3262.8.camel@Allen>
 <20110725181916.GB6876@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:46080 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666Ab1GYS3b (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2011 14:29:31 -0400
Content-Disposition: inline
In-Reply-To: <20110725181916.GB6876@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Wanlong Gao <wanlong.gao@gmail.com>, Greg KH <gregkh@suse.de>, Wanlong Gao <gaowanlong@cn.fujitsu.com>, linux-input@vger.kernel.org

On Mon, Jul 25, 2011 at 11:19:16AM -0700, Dmitry Torokhov wrote:

> Right, like i2c bus we could just have platform core clean up platform
> drvdata pointer after calling ->remove() and also if ->probe() errors
> out.

I2C doesn't do this (at least not any more).

> Then individual drivers do not have to care about cleaning up this
> pointer.

They don't have to worry about it anyway, the only thing that is allowed
to use the pointer is a currently bound driver and it's only allowed to
rely on is that while it's bound it'll get back the same driver_data
that it put in.
