From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3 2.6.39] Input: wm831x-ts - Fix races with IRQ
 management
Date: Tue, 3 May 2011 08:43:03 -0700
Message-ID: <20110503154303.GA6509@core.coreip.homeip.net>
References: <1303237074-12878-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20110503144618.GD2893@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40387 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918Ab1ECPnL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 May 2011 11:43:11 -0400
Received: by pzk9 with SMTP id 9so83242pzk.19
        for <linux-input@vger.kernel.org>; Tue, 03 May 2011 08:43:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110503144618.GD2893@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com

On Tue, May 03, 2011 at 03:46:18PM +0100, Mark Brown wrote:
> On Tue, Apr 19, 2011 at 07:17:52PM +0100, Mark Brown wrote:
> > If the WM831x pen down and data IRQs run in parallel it is possible for the
> > data and pen down IRQs to deadlock themselves as one is part way through
> > disabling its operation while the other is part way through enabling. Fix
> > this by always disabling the pen down interrupt while data is active and
> > vice versa.  When a changeover is required we disable the IRQ that is to
> > be stopped then schedule work that will enable the new IRQ.
> 
> Any updates on this?

I sent a pull request to Linus last night, hopefully he'll pull.

Thanks.

-- 
Dmitry
