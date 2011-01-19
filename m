From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] Input: ad7979 - Convert SPI to dev_pm_ops
Date: Wed, 19 Jan 2011 18:39:16 +0000
Message-ID: <20110119183916.GB17150@opensource.wolfsonmicro.com>
References: <1295441139-14706-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1295441139-14706-2-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20110119174038.GA29107@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:44172 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750827Ab1ASSjS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Jan 2011 13:39:18 -0500
Content-Disposition: inline
In-Reply-To: <20110119174038.GA29107@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Mike Frysinger <vapier@gentoo.org>, linux-input@vger.kernel.org

On Wed, Jan 19, 2011 at 09:40:38AM -0800, Dmitry Torokhov wrote:

> I was looking at SIMPLE_DEV_PM_OPS definition and it turns into noop if
> CONFIG_PM_SLEEP is not set (for systems with runtime PM only, for
> example). This will lead to "unused function" compiler warnings (and I
> think I have seen such reports for randconfig compiles off linux-next).

> Do you think we coudl augment your patch thusly:

Looks sane to me - do you want me to redo the updates?
