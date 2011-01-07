From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH] input: move check for same handler in input_pass_event
Date: Fri, 7 Jan 2011 10:24:34 -0800
Message-ID: <20110107102434.7776091d@kcaccard-MOBL3>
References: <1294352688-29564-1-git-send-email-kristen@linux.intel.com>
	<20110107060456.GA29038@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56305 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754820Ab1AGSXX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 7 Jan 2011 13:23:23 -0500
In-Reply-To: <20110107060456.GA29038@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, arjan@linux.intel.com

On Thu, 6 Jan 2011 22:04:56 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Thu, Jan 06, 2011 at 02:24:48PM -0800, Kristen Carlson Accardi wrote:
> > If the handler that injected an event is the same,
> > just skip the filter, but allow the handler->event()
> > routine to be called.  This allows evdev to be able to
> > be used to loopback events.
> 
> Why is it needed? Could you please give some examples?
> 
> Thanks.
> 

We have a customer who has a touchscreen device which sends
a bitmap into a gesture engine, which then interprets that
result and feeds it back into the kernel through a virtual
input driver that X is listening to.
