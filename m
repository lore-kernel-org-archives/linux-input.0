From: Oliver Neukum <oliver@neukum.org>
Subject: Re: locking in hidraw
Date: Mon, 8 Dec 2008 10:08:32 +0100
Message-ID: <200812081008.32663.oliver@neukum.org>
References: <200811041534.38166.oliver@neukum.org> <200811121551.07909.oliver@neukum.org> <alpine.LNX.1.10.0812011106370.21911@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:59405 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727AbYLHJGy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Dec 2008 04:06:54 -0500
In-Reply-To: <alpine.LNX.1.10.0812011106370.21911@jikos.suse.cz>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-input@vger.kernel.org

Am Montag, 1. Dezember 2008 11:07:13 schrieb Jiri Kosina:
> On Wed, 12 Nov 2008, Oliver Neukum wrote:
> 
> > > > > in this code:
> > > > > 
> > > > > 		mutex_lock(&list->read_mutex);
> > > > > 
> > > > > 		if (list->head == list->tail) {
> > > > > 			add_wait_queue(&list->hidraw->wait, &wait);
> > > > > 			set_current_state(TASK_INTERRUPTIBLE);
> > > > > it would make more sense to lock the mutex interruptable so all
> > > > > tasks sleep the same way. Is this intentional?
> > > Well, we have the test for pending signals just below that code, right?
> > So the tasks blocking on the mutex sleep all the time until another
> > task is finished and unlocks the mutex, only to return to user space
> > because signals are pending. Therefore why not make the wait on
> > the mutex interruptible, so the signals are processed right away?
> 
> Yes, it makes sense. Could you please fold this change together with the 
> hidraw changes you are going to push with the autosuspend patches?

On second thought, no, this would not be a good idea. Bug fixes, fixes
for oddities such as this and clear enhancements, like autosuspend, should
be kept apart. I'd rather send separate patches for this, what do you think?

	Regards
		Oliver
