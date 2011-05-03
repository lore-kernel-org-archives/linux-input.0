From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3 2.6.39] Input: wm831x-ts - Fix races with IRQ
 management
Date: Tue, 3 May 2011 16:44:14 +0100
Message-ID: <20110503154414.GX1762@opensource.wolfsonmicro.com>
References: <1303237074-12878-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20110503144618.GD2893@sirena.org.uk>
 <20110503154303.GA6509@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:42950 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751435Ab1ECPoQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 3 May 2011 11:44:16 -0400
Content-Disposition: inline
In-Reply-To: <20110503154303.GA6509@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com

On Tue, May 03, 2011 at 08:43:03AM -0700, Dmitry Torokhov wrote:
> On Tue, May 03, 2011 at 03:46:18PM +0100, Mark Brown wrote:

> > Any updates on this?

> I sent a pull request to Linus last night, hopefully he'll pull.

Oh, OK - I hadn't noticed that you'd applied the patches at all (they
didn't vanish in my last -next rebase on Thursday and you didn't reply
to my mail) so I thought they'd slipped by when you were reviewing.
