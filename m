From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH] psmouse: run kpsmoused only while needed
Date: Tue, 3 Feb 2009 10:49:43 +0100
Message-ID: <20090203094942.GD23466@nowhere>
References: <496fd1d3.0d135e0a.171b.43ea@mx.google.com> <20090126143210.ce6a4503.akpm@linux-foundation.org> <20090128230837.GA7631@nowhere> <20090202230335.9e31c97f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f29.google.com ([209.85.218.29]:42135 "EHLO
	mail-bw0-f29.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbZBCJtt (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Feb 2009 04:49:49 -0500
Content-Disposition: inline
In-Reply-To: <20090202230335.9e31c97f.akpm@linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: dmitry.torokhov@gmail.com, dtor@mail.ru, linux-kernel@vger.kernel.org, mingo@elte.hu, linux-input@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>

On Mon, Feb 02, 2009 at 11:03:35PM -0800, Andrew Morton wrote:
> On Thu, 29 Jan 2009 00:08:39 +0100 Frederic Weisbecker <fweisbec@gmail.com> wrote:
> 
> > > > @@ -1131,7 +1155,13 @@ static void psmouse_disconnect(struct serio *serio)
> > > >  
> > > >  	/* make sure we don't have a resync in progress */
> > > >  	mutex_unlock(&psmouse_mutex);
> > > > -	flush_workqueue(kpsmoused_wq);
> > > > +
> > > > +	prepare_to_wait(&psmouse->recync_pending_queue, &wait,
> > > > +				TASK_UNINTERRUPTIBLE);
> > > > +	if (atomic_read(&psmouse->nb_recync_pending))
> > > > +		schedule();
> > > > +	finish_wait(&psmouse->recync_pending_queue, &wait);
> > > 
> > > So... we're requiring that nb_recync_pending is zero at this stage?
> > > 
> > > I wonder if the code manages to do that.  A little WARN_ON(), maybe?
> > > 
> > > >  	mutex_lock(&psmouse_mutex);
> > > >  
> > > 
> > 
> > After reading how work the async jobs (kernel/async.c), I think it would be better
> > to actually use it instead of creating a thread through a workqueue and wait for a
> > counter to be zero to be sure all is flushed.
> > 
> > The async functions provide local execution and synchronisation domains through special cookies,
> > which means long tasks of mouse resync will not starve other works.
> > 
> > What do you think about it?
> 
> Yes, it would be better to use the async infrastructure.
> 
> If only to see how the code ends up looking - it _should_ be simpler/cleaner
> than the open-coded implementation.  If it isn't, we should ask the async code
> "why not?".


Right, it would have make it cleaner, by managing itself the thread creation and
synchronize_cookie bits.
I discussed it with Arjan because the main requirement for kpsmoused to use it
was to ensure that async will never run the function in the current context which
is hardirq here. Mouse resyncing is a slow work and it needs to be done in user
context.

If async failed to allocate the given function as a queued node or if we are
overflowing the queue of jobs, async runs the passed function synchronously.

But we need other callsites which would require it before adapting async to manage
that. Only implementing that for kpsmoused would be pointless.

So I recently submitted a v2 (cc'd you) of this patch which addressed your review but I kept
the on-the-fly thread approach.

