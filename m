From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH] HID: usbhid: fix dead lock between open and disconect
Date: Thu, 12 Jan 2012 10:54:50 +0100
Message-ID: <201201121054.50083.oneukum@suse.de>
References: <1326361342-4141-1-git-send-email-tom.leiming@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49768 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933Ab2ALJxA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Jan 2012 04:53:00 -0500
In-Reply-To: <1326361342-4141-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@suse.de>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Ming Lei <ming.lei@canonical.com>

Am Donnerstag, 12. Januar 2012, 10:42:22 schrieb Ming Lei:
> There is no reason to hold hiddev->existancelock before
> calling usb_deregister_dev, so move it out of the lock.
> 
> The patch fixes the lockdep warning below [1].
> 
> [1], lockdep warning

Hi,

you should however hold the lock while you unset hiddev->exist
and you should unset hiddev->exist before you call usb_deregister_dev().
So the diagnosis is very good, but the patch needs a bit elaboration.

	Regards
		Oliver
