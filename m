From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: locking in hidraw
Date: Mon, 1 Dec 2008 11:07:13 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0812011106370.21911@jikos.suse.cz>
References: <200811041534.38166.oliver@neukum.org> <4910B24D.2020700@gmail.com> <alpine.LNX.1.10.0811121539090.32143@jikos.suse.cz> <200811121551.07909.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:60308 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750824AbYLAKHO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 1 Dec 2008 05:07:14 -0500
In-Reply-To: <200811121551.07909.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-input@vger.kernel.org

On Wed, 12 Nov 2008, Oliver Neukum wrote:

> > > > in this code:
> > > > 
> > > > 		mutex_lock(&list->read_mutex);
> > > > 
> > > > 		if (list->head == list->tail) {
> > > > 			add_wait_queue(&list->hidraw->wait, &wait);
> > > > 			set_current_state(TASK_INTERRUPTIBLE);
> > > > it would make more sense to lock the mutex interruptable so all
> > > > tasks sleep the same way. Is this intentional?
> > Well, we have the test for pending signals just below that code, right?
> So the tasks blocking on the mutex sleep all the time until another
> task is finished and unlocks the mutex, only to return to user space
> because signals are pending. Therefore why not make the wait on
> the mutex interruptible, so the signals are processed right away?

Yes, it makes sense. Could you please fold this change together with the 
hidraw changes you are going to push with the autosuspend patches?

Thanks,

-- 
Jiri Kosina
