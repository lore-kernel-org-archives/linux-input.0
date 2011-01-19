From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] Input: ad7979 - Convert SPI to dev_pm_ops
Date: Wed, 19 Jan 2011 10:53:54 -0800
Message-ID: <20110119185354.GC29107@core.coreip.homeip.net>
References: <1295441139-14706-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1295441139-14706-2-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20110119174038.GA29107@core.coreip.homeip.net>
 <20110119183916.GB17150@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:52562 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300Ab1ASSyD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Jan 2011 13:54:03 -0500
Received: by qwa26 with SMTP id 26so1156871qwa.19
        for <linux-input@vger.kernel.org>; Wed, 19 Jan 2011 10:54:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110119183916.GB17150@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Mike Frysinger <vapier@gentoo.org>, linux-input@vger.kernel.org

On Wed, Jan 19, 2011 at 06:39:16PM +0000, Mark Brown wrote:
> On Wed, Jan 19, 2011 at 09:40:38AM -0800, Dmitry Torokhov wrote:
> 
> > I was looking at SIMPLE_DEV_PM_OPS definition and it turns into noop if
> > CONFIG_PM_SLEEP is not set (for systems with runtime PM only, for
> > example). This will lead to "unused function" compiler warnings (and I
> > think I have seen such reports for randconfig compiles off linux-next).
> 
> > Do you think we coudl augment your patch thusly:
> 
> Looks sane to me - do you want me to redo the updates?

If it is not too much bother...

-- 
Dmitry
