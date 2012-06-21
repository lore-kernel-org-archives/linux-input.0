From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] input: gpio_keys: added setup call for extending
 functionality of driver
Date: Thu, 21 Jun 2012 11:03:24 +0100
Message-ID: <20120621100324.GB28523@sirena.org.uk>
References: <1340208597-31865-1-git-send-email-shc_work@mail.ru>
 <20120621085045.GD2193@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:48639 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759250Ab2FUKD1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jun 2012 06:03:27 -0400
Content-Disposition: inline
In-Reply-To: <20120621085045.GD2193@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alexander Shiyan <shc_work@mail.ru>, linux-input@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>

On Thu, Jun 21, 2012 at 01:50:45AM -0700, Dmitry Torokhov wrote:

> Also, given the general push towards DT-ased setups platform-supplied
> board setup code might not be the best approach.

This isn't a general thing, it's only for ARM really (plus things like
PowerPC that have already adopted it).  The majority of architectures
have no plans to use DT.
