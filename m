From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: locking in hidraw
Date: Wed, 12 Nov 2008 15:39:49 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0811121539090.32143@jikos.suse.cz>
References: <200811041534.38166.oliver@neukum.org> <4910B24D.2020700@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:38074 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750962AbYKLOju (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Nov 2008 09:39:50 -0500
In-Reply-To: <4910B24D.2020700@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>, Oliver Neukum <oliver@neukum.org>
Cc: linux-input@vger.kernel.org

On Tue, 4 Nov 2008, Jiri Slaby wrote:

> > in this code:
> > 
> > 		mutex_lock(&list->read_mutex);
> > 
> > 		if (list->head == list->tail) {
> > 			add_wait_queue(&list->hidraw->wait, &wait);
> > 			set_current_state(TASK_INTERRUPTIBLE);
> > 
> > it would make more sense to lock the mutex interruptable so all
> > tasks sleep the same way. Is this intentional?

Well, we have the test for pending signals just below that code, right?

-- 
Jiri Kosina
SUSE Labs
