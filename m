From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH 04/16] HID: wiimote: Add extension support stub
Date: Mon, 14 Nov 2011 08:54:37 +0100
Message-ID: <201111140854.37983.oneukum@suse.de>
References: <1321190839-3517-1-git-send-email-dh.herrmann@googlemail.com> <1321190839-3517-5-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59744 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752269Ab1KNIbV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 03:31:21 -0500
In-Reply-To: <1321190839-3517-5-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz

Am Sonntag, 13. November 2011, 14:27:07 schrieb David Herrmann:
> +/* Deinitializes the extension driver of a wiimote */
> +void wiiext_deinit(struct wiimote_data *wdata)
> +{
> +       struct wiimote_ext *ext = wdata->ext;
> +       unsigned long flags;
> +
> +       if (!ext)
> +               return;
> +
> +       spin_lock_irqsave(&wdata->state.lock, flags);
> +       wdata->ext = NULL;
> +       spin_unlock_irqrestore(&wdata->state.lock, flags);
> +
> +       cancel_work_sync(&ext->worker);
> +       kfree(ext);
> +}


Are you sure you are doing this in the correct order?
You are needlessly leaving a window where wdate->ext is NULL
but the worker may run.

	Regards
		Oliver
