From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch 3/9] input: ads7846.c sparse lock annotation
Date: Thu, 14 May 2009 16:45:39 +0200 (CEST)
Message-ID: <alpine.LRH.2.00.0905141643570.10524@twin.jikos.cz>
References: <200905122102.n4CL2L95006887@imap1.linux-foundation.org> <20090514032404.GC12778@dtor-d630.eng.vmware.com> <1242272067.23058.3.camel@brick> <20090514035135.GF12778@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:44494 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751299AbZENOpn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 14 May 2009 10:45:43 -0400
In-Reply-To: <20090514035135.GF12778@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Harvey Harrison <harvey.harrison@gmail.com>, akpm@linux-foundation.org, linux-input@vger.kernel.org

On Wed, 13 May 2009, Dmitry Torokhov wrote:

> > > >  /* Must be called with ts->lock held */
> > > >  static void ads7846_disable(struct ads7846 *ts)
> > > > +__releases(&ts->lock)
> > > > +__acquires(&ts->lock)
> > > >  {
> > > I still haven't gotten any explanation why this is needed and also I am
> > > still getting sparce warnings with this patch applied. Please drop.
> > Sorry, I didn't realize I had a local patchset doing extra context 
> > checking of what lock is passed in to spin_lock/unlock...it helps to 
> > document when a function requires a lock held (see the comment)
> I understand the comment ;) The annotation syntax is confusing though... 
> Maybe if instead of __releases and __acquires it said __needs_lock() and 
> __leaves_locked() that would make more sense...

I fully agree. __acquires() and __releases() is used to annotate a 
completely different thing -- it should be used solely to avoid false 
positives about locking inbalances across functions (i.e. one function 
deliberately not unlocking lock that it has locked), shoudldn't it?

-- 
Jiri Kosina
SUSE Labs

