From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch 3/9] input: ads7846.c sparse lock annotation
Date: Wed, 13 May 2009 20:51:45 -0700
Message-ID: <20090514035135.GF12778@dtor-d630.eng.vmware.com>
References: <200905122102.n4CL2L95006887@imap1.linux-foundation.org> <20090514032404.GC12778@dtor-d630.eng.vmware.com> <1242272067.23058.3.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:54606 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbZENDvv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 May 2009 23:51:51 -0400
Received: by rv-out-0506.google.com with SMTP id f6so2640144rvb.5
        for <linux-input@vger.kernel.org>; Wed, 13 May 2009 20:51:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1242272067.23058.3.camel@brick>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: akpm@linux-foundation.org, linux-input@vger.kernel.org

On Wed, May 13, 2009 at 08:34:27PM -0700, Harvey Harrison wrote:
> On Wed, 2009-05-13 at 20:24 -0700, Dmitry Torokhov wrote:
> > On Tue, May 12, 2009 at 01:43:06PM -0700, akpm@linux-foundation.org wrote:
> > > From: Harvey Harrison <harvey.harrison@gmail.com>
> > > 
> > > Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> > > Cc: Dmitry Torokhov <dtor@mail.ru>
> > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > ---
> > >  
> > >  /* Must be called with ts->lock held */
> > >  static void ads7846_disable(struct ads7846 *ts)
> > > +__releases(&ts->lock)
> > > +__acquires(&ts->lock)
> > >  {
> > 
> > I still haven't gotten any explanation why this is needed and also I am
> > still getting sparce warnings with this patch applied. Please drop.
> > 
> 
> Sorry, I didn't realize I had a local patchset doing extra context checking
> of what lock is passed in to spin_lock/unlock...it helps to document when a
> function requires a lock held (see the comment)
> 

I understand the comment ;) The annotation syntax is confusing though...
Maybe if instead of __releases and __acquires it said __needs_lock() and
__leaves_locked() that would make more sense... 

> The culprit in this function:
> 		while (ts->pending) {
> 			spin_unlock_irq(&ts->lock);
> 			msleep(1);
> 			spin_lock_irq(&ts->lock);
> 		}
> 
> Anyways, as current sparse will still warn please drop.
> 
> Harvey
> 

-- 
Dmitry
