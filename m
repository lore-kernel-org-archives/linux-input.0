From: Yanmin Zhang <yanmin_zhang@linux.intel.com>
Subject: Re: [PATCH] input: add a input_dev_reset callback
Date: Wed, 29 Jun 2011 15:48:54 +0800
Message-ID: <1309333734.2601.11.camel@ymzhang>
References: <1309325122.2601.3.camel@ymzhang>
	 <20110629070927.GA10299@core.coreip.homeip.net>
Reply-To: yanmin_zhang@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:61182 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751178Ab1F2HtZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jun 2011 03:49:25 -0400
In-Reply-To: <20110629070927.GA10299@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, 2011-06-29 at 00:09 -0700, Dmitry Torokhov wrote:
> Hi Yanmin,
> 
> On Wed, Jun 29, 2011 at 01:25:22PM +0800, Yanmin Zhang wrote:
> > From: Yanmin Zhang <yanmin_zhang@linux.intel.com>
> > Date: Tue, 28 Jun 2011 10:48:03 +0800
> > Subject: [PATCH] input: add a input_dev_reset callback
> > 
> > input_polled_dev starts a worker if it's opened. During
> > suspend-2-ram, kernel need cancel the worker and restart it
> > after resuming.
> 
> I do not believe that there is an issue. Polled device implementation
> uses freezable workqueue to ensure that work is not being executed
> during system sleep transition. The work should restart automatically
> when workqueue it thawed.
Nice! I forgot it. I hit it with kernel 2.6.35 and ported my patch to
the latest kernel.

Thanks,
Yanmin


