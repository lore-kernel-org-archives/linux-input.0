From: Oliver Neukum <oliver@neukum.org>
Subject: locking in hidraw
Date: Tue, 4 Nov 2008 15:34:37 +0100
Message-ID: <200811041534.38166.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:35690 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbYKDOe0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Nov 2008 09:34:26 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-input@vger.kernel.org

Hi,

in this code:

		mutex_lock(&list->read_mutex);

		if (list->head == list->tail) {
			add_wait_queue(&list->hidraw->wait, &wait);
			set_current_state(TASK_INTERRUPTIBLE);

it would make more sense to lock the mutex interruptable so all
tasks sleep the same way. Is this intentional?

	Regards
		Oliver
