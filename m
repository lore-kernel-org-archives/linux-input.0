From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] cy8ctmg110: capacitive touchscreen support
Date: Fri, 9 Jul 2010 17:48:12 +0100
Message-ID: <20100709174812.485caa05@linux.intel.com>
References: <20100709155259.3798.80408.stgit@localhost.localdomain>
	<20100709165951.GB20120@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:45603 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758350Ab0GIRRI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 9 Jul 2010 13:17:08 -0400
In-Reply-To: <20100709165951.GB20120@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

> Hmm, I think device_init_wakeup() call is missing as well. And
> threaded IRQ being chared is somewhat unusual... But it is not
> oneshot so should be OK.

I will double check these. I don't believe the IRQ can ever get shared
but I'd need to double check with the Aava folks.
