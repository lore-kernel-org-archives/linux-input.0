From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: move check for same handler in input_pass_event
Date: Fri, 7 Jan 2011 11:29:38 -0800
Message-ID: <20110107192938.GB28875@core.coreip.homeip.net>
References: <1294352688-29564-1-git-send-email-kristen@linux.intel.com>
 <20110107060456.GA29038@core.coreip.homeip.net>
 <20110107102434.7776091d@kcaccard-MOBL3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37730 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376Ab1AGT3p (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Jan 2011 14:29:45 -0500
Received: by ywl5 with SMTP id 5so6871867ywl.19
        for <linux-input@vger.kernel.org>; Fri, 07 Jan 2011 11:29:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110107102434.7776091d@kcaccard-MOBL3>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: linux-input@vger.kernel.org, arjan@linux.intel.com

On Fri, Jan 07, 2011 at 10:24:34AM -0800, Kristen Carlson Accardi wrote:
> On Thu, 6 Jan 2011 22:04:56 -0800
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > On Thu, Jan 06, 2011 at 02:24:48PM -0800, Kristen Carlson Accardi wrote:
> > > If the handler that injected an event is the same,
> > > just skip the filter, but allow the handler->event()
> > > routine to be called.  This allows evdev to be able to
> > > be used to loopback events.
> > 
> > Why is it needed? Could you please give some examples?
> > 
> > Thanks.
> > 
> 
> We have a customer who has a touchscreen device which sends
> a bitmap into a gesture engine, which then interprets that
> result and feeds it back into the kernel through a virtual
> input driver that X is listening to.

That really should be done though uinput.

Thanks.

-- 
Dmitry
