From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: move check for same handler in input_pass_event
Date: Tue, 25 Jan 2011 20:59:05 -0800
Message-ID: <20110126045905.GC23085@core.coreip.homeip.net>
References: <1294352688-29564-1-git-send-email-kristen@linux.intel.com>
 <20110107060456.GA29038@core.coreip.homeip.net>
 <20110107102434.7776091d@kcaccard-MOBL3>
 <20110107192938.GB28875@core.coreip.homeip.net>
 <4D276A51.5030102@linux.intel.com>
 <20110107194313.GC28875@core.coreip.homeip.net>
 <20110120085654.GA19696@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60068 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab1AZE7O (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Jan 2011 23:59:14 -0500
Received: by iyj18 with SMTP id 18so24595iyj.19
        for <linux-input@vger.kernel.org>; Tue, 25 Jan 2011 20:59:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110120085654.GA19696@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Kristen Carlson Accardi <kristen@linux.intel.com>, linux-input@vger.kernel.org, Jason Wessel <jason.wessel@windriver.com>

On Thu, Jan 20, 2011 at 12:56:54AM -0800, Dmitry Torokhov wrote:
> On Fri, Jan 07, 2011 at 11:43:13AM -0800, Dmitry Torokhov wrote:
> > On Fri, Jan 07, 2011 at 11:32:33AM -0800, Arjan van de Ven wrote:
> > > On 1/7/2011 11:29 AM, Dmitry Torokhov wrote:
> > > >On Fri, Jan 07, 2011 at 10:24:34AM -0800, Kristen Carlson Accardi wrote:
> > > >>On Thu, 6 Jan 2011 22:04:56 -0800
> > > >>Dmitry Torokhov<dmitry.torokhov@gmail.com>  wrote:
> > > >>
> > > >>>On Thu, Jan 06, 2011 at 02:24:48PM -0800, Kristen Carlson Accardi wrote:
> > > >>>>If the handler that injected an event is the same,
> > > >>>>just skip the filter, but allow the handler->event()
> > > >>>>routine to be called.  This allows evdev to be able to
> > > >>>>be used to loopback events.
> > > >>>Why is it needed? Could you please give some examples?
> > > >>>
> > > >>>Thanks.
> > > >>>
> > > >>We have a customer who has a touchscreen device which sends
> > > >>a bitmap into a gesture engine, which then interprets that
> > > >>result and feeds it back into the kernel through a virtual
> > > >>input driver that X is listening to.
> > > >That really should be done though uinput.
> > > 
> > > quite possible.
> > > 
> > > but the application already exists, and works just fine in 2.6.35...
> > > causing this to be classified as a kernel ABI regression ;-(
> > > 
> > 
> > Hmm... I'd probably call it "relying on implementation details not
> > spelled out anywhere".
> > 
> > Anyway, let me ponder this one a bit...
> > 
> 
> OK, I think if we apply the patch below and then completely revert
> 5fdbe44d033d059cc56c2803e6b4dbd8cb4e5e39 we'll get the behavior we
> want.
> 
> Jason, could you please try this and see if SysRq still works for you?
>

*ping*

Anyone?

Thanks.

-- 
Dmitry
