From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: wm97xx_read_aux_adc() for battery & pen down?
Date: Sun, 26 Jun 2011 12:00:19 +0100
Message-ID: <20110626110018.GA16568@opensource.wolfsonmicro.com>
References: <20110624130049.GA9374@pengutronix.de>
 <20110624165204.GB30047@opensource.wolfsonmicro.com>
 <20110624165802.GB5042@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:38779 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752789Ab1FZLAW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 26 Jun 2011 07:00:22 -0400
Content-Disposition: inline
In-Reply-To: <20110624165802.GB5042@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-input@vger.kernel.org, dp@opensource.wolfsonmicro.com

On Fri, Jun 24, 2011 at 06:58:02PM +0200, Wolfram Sang wrote:

> Ahem, sorry, I mixed the function names. wm97xx_read_aux_adc() uses the
> poll_sample-pointer which points to wm9712_poll_sample() in my case.
> There I need the above code.

It looks like poll_sample() needs to be passed a flag to disable the pen
down checking.
