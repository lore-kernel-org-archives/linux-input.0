From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Input: ad7879 - Convert I2C to dev_pm_ops
Date: Thu, 6 Jan 2011 00:37:12 +0000
Message-ID: <20110106003712.GB12153@opensource.wolfsonmicro.com>
References: <1294254095-25844-1-git-send-email-broonie@opensource.wolfsonmicro.com> <20110105221432.GA6086@core.coreip.homeip.net> <20110105224145.GA5476@opensource.wolfsonmicro.com> <20110106000934.GA6677@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:54763 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754730Ab1AFAhN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 5 Jan 2011 19:37:13 -0500
Content-Disposition: inline
In-Reply-To: <20110106000934.GA6677@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mike Frysinger <vapier@gentoo.org>, Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org

On Wed, Jan 05, 2011 at 04:09:34PM -0800, Dmitry Torokhov wrote:

> I actually do not much liek the "simple" initializator as it usually
> does way more than needed.

It does mean that we're exactly replicating the set of calls that get
done where the legacy methods are used (at least for the simple buses
like I2C) which is pretty important for this sort of mechanical update.
