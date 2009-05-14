From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [patch 3/9] input: ads7846.c sparse lock annotation
Date: Wed, 13 May 2009 20:34:27 -0700
Message-ID: <1242272067.23058.3.camel@brick>
References: <200905122102.n4CL2L95006887@imap1.linux-foundation.org>
	 <20090514032404.GC12778@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f115.google.com ([209.85.222.115]:45796 "EHLO
	mail-pz0-f115.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628AbZENDea (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 May 2009 23:34:30 -0400
Received: by pzk13 with SMTP id 13so442948pzk.33
        for <linux-input@vger.kernel.org>; Wed, 13 May 2009 20:34:31 -0700 (PDT)
In-Reply-To: <20090514032404.GC12778@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: akpm@linux-foundation.org, linux-input@vger.kernel.org

On Wed, 2009-05-13 at 20:24 -0700, Dmitry Torokhov wrote:
> On Tue, May 12, 2009 at 01:43:06PM -0700, akpm@linux-foundation.org wrote:
> > From: Harvey Harrison <harvey.harrison@gmail.com>
> > 
> > Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> > Cc: Dmitry Torokhov <dtor@mail.ru>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >  
> >  /* Must be called with ts->lock held */
> >  static void ads7846_disable(struct ads7846 *ts)
> > +__releases(&ts->lock)
> > +__acquires(&ts->lock)
> >  {
> 
> I still haven't gotten any explanation why this is needed and also I am
> still getting sparce warnings with this patch applied. Please drop.
> 

Sorry, I didn't realize I had a local patchset doing extra context checking
of what lock is passed in to spin_lock/unlock...it helps to document when a
function requires a lock held (see the comment)

The culprit in this function:
		while (ts->pending) {
			spin_unlock_irq(&ts->lock);
			msleep(1);
			spin_lock_irq(&ts->lock);
		}

Anyways, as current sparse will still warn please drop.

Harvey

