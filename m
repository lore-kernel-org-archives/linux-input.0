From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Input: mpu3050: set IRQF_ONESHOT when requesting the
 interrupt
Date: Wed, 9 May 2012 12:48:23 +0100
Message-ID: <20120509124823.026a5536@pyramind.ukuu.org.uk>
References: <1335894406-27428-1-git-send-email-swarren@wwwdotorg.org>
	<20120509052301.GB10514@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:36114 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755794Ab2EILpt (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 May 2012 07:45:49 -0400
In-Reply-To: <20120509052301.GB10514@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thomas Gleixner <tglx@linutronix.de>, linux-input@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, Alan Cox <alan@linux.intel.com>

> BTW, since it appears you have the hardware any chance you could try the
> patch below? I had it in my queue for a while but Alan disappeared and
> I didn't have anyone to test it.

I've not disappeared but I don't have any mpu3050 hardware either at this
point.

Alan
