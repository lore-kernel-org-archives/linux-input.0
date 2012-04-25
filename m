From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: twl4030 power button: don't lose presses on resume
Date: Tue, 24 Apr 2012 22:09:19 -0700
Message-ID: <20120425050919.GB27843@core.coreip.homeip.net>
References: <20120425122139.512c6890@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f51.google.com ([209.85.210.51]:55451 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630Ab2DYFJY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Apr 2012 01:09:24 -0400
Content-Disposition: inline
In-Reply-To: <20120425122139.512c6890@notabene.brown>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Neil,

On Wed, Apr 25, 2012 at 12:21:39PM +1000, NeilBrown wrote:
> 
> If we press and release the power button before the press interrupt is
> handled - as can happen on resume - we lose the press event so the
> release event is ignored and we don't know what happened to cause the
> wakeup.

What kind of latency do you observe?

> 
> So make sure that each interrupt handled does generate an event.
> Because twl4030 queues interrupt events we will see two interrupts
> for a press-release even if we handle the first one later.  This means
> that such a sequence will be reported as two button presses.  This
> is unfortunate but is better than no button presses.
> Possibly we could set the PENDDIS_MASK to disable queuing of
> interrupts, but that might adversely affect other interrupt sources.
>

It looks like we'd have to modify every driver to ensure consistent
behavior as we do not have any guarantees on how long resume takes.
Maybe this is something that input core needs to implement?

Thanks.


-- 
Dmitry
