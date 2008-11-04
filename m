From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: locking in hidraw
Date: Tue, 04 Nov 2008 21:36:29 +0100
Message-ID: <4910B24D.2020700@gmail.com>
References: <200811041534.38166.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:21569 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753615AbYKDUgl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Nov 2008 15:36:41 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1351863nfc.21
        for <linux-input@vger.kernel.org>; Tue, 04 Nov 2008 12:36:27 -0800 (PST)
In-Reply-To: <200811041534.38166.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@jikos.cz>

Ccing jikos.

Oliver Neukum napsal(a):
> Hi,
> 
> in this code:
> 
> 		mutex_lock(&list->read_mutex);
> 
> 		if (list->head == list->tail) {
> 			add_wait_queue(&list->hidraw->wait, &wait);
> 			set_current_state(TASK_INTERRUPTIBLE);
> 
> it would make more sense to lock the mutex interruptable so all
> tasks sleep the same way. Is this intentional?
