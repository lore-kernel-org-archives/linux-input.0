From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ads7846: clean up, fix pressure reporting
Date: Sun, 9 Aug 2009 11:51:13 +0100
Message-ID: <20090809105112.GD4773@sirena.org.uk>
References: <20090807180941.GF1728@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:48984 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbZHIKvX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 9 Aug 2009 06:51:23 -0400
Content-Disposition: inline
In-Reply-To: <20090807180941.GF1728@ucw.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: dtor@mail.ru, linux-input@vger.kernel.org, rpurdie@rpsys.net, lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>, Dirk@Opfer-Online.de, arminlitzel@web.de, Cyril Hrubis <metan@ucw.cz>, thommycheck@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, dbaryshkov@gmail.com, omegamoon@gmail.com, eric.miao@marvell.com, utx@penguin.cz

On Fri, Aug 07, 2009 at 08:09:41PM +0200, Pavel Machek wrote:

> +#ifndef VERBOSE
> +#undef dev_dbg
> +#define dev_dbg(...) do {} while(0)
> +#endif

Better to convert the offending dev_dbg()s to dev_vdbg() instead, I'd
have thought.
