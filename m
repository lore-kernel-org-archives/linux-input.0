From: Oliver Neukum <oliver@neukum.org>
Subject: Re: locking in hidraw
Date: Wed, 12 Nov 2008 15:51:06 +0100
Message-ID: <200811121551.07909.oliver@neukum.org>
References: <200811041534.38166.oliver@neukum.org> <4910B24D.2020700@gmail.com> <alpine.LNX.1.10.0811121539090.32143@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:60838 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbYKLOuk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Nov 2008 09:50:40 -0500
In-Reply-To: <alpine.LNX.1.10.0811121539090.32143@jikos.suse.cz>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-input@vger.kernel.org

Am Mittwoch, 12. November 2008 15:39:49 schrieb Jiri Kosina:
> On Tue, 4 Nov 2008, Jiri Slaby wrote:
> 
> > > in this code:
> > > 
> > > 		mutex_lock(&list->read_mutex);
> > > 
> > > 		if (list->head == list->tail) {
> > > 			add_wait_queue(&list->hidraw->wait, &wait);
> > > 			set_current_state(TASK_INTERRUPTIBLE);
> > > 
> > > it would make more sense to lock the mutex interruptable so all
> > > tasks sleep the same way. Is this intentional?
> 
> Well, we have the test for pending signals just below that code, right?

So the tasks blocking on the mutex sleep all the time until another
task is finished and unlocks the mutex, only to return to user space
because signals are pending. Therefore why not make the wait on
the mutex interruptible, so the signals are processed right away?

	Regards
		Oliver

