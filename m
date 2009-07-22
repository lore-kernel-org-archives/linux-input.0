From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC/RFT] serio - switch to using dev_pm_ops
Date: Wed, 22 Jul 2009 09:38:33 -0700
Message-ID: <20090722163832.GB2775@dtor-d630.eng.vmware.com>
References: <20090721080612.GC10168@dtor-d630.eng.vmware.com> <9b2b86520907211448t24a091e2i6d8ad89f709f35ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.228]:8765 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512AbZGVQih (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jul 2009 12:38:37 -0400
Content-Disposition: inline
In-Reply-To: <9b2b86520907211448t24a091e2i6d8ad89f709f35ff@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jul 21, 2009 at 10:48:05PM +0100, Alan Jenkins wrote:
> >  drivers/input/serio/serio.c |   30 ++++++++++++++++--------------
> >  1 files changed, 16 insertions(+), 14 deletions(-)
> 
> > -	if (!serio->suspended && state.event == PM_EVENT_SUSPEND)
> > -		serio_cleanup(serio);
> > -
> > -	serio->suspended = state.event == PM_EVENT_SUSPEND ||
> > -			   state.event == PM_EVENT_FREEZE;
> 
> > -	if (serio->suspended) {
> > -		serio->suspended = false;
> > -		serio_queue_event(serio, NULL, SERIO_RECONNECT_PORT);
> > -	}
> 
> It looks like you should be able to remove the suspended field of
> struct serio.  Or is it used somewhere else?
> 

No, it is not needed now, thanks for noticing.

-- 
Dmitry
