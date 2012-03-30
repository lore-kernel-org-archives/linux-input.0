From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC] usbhid: fix error handling of not enough bandwidth
Date: Fri, 30 Mar 2012 15:16:15 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1203301514500.25526@pobox.suse.cz>
References: <201203281316.20038.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60256 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760710Ab2C3NQR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Mar 2012 09:16:17 -0400
In-Reply-To: <201203281316.20038.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Libor Pechacek <lpechacek@suse.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Wed, 28 Mar 2012, Oliver Neukum wrote:

> From 22569602350f8992f2d2b321cf195e633e74574a Mon Sep 17 00:00:00 2001
> From: Oliver Neukum <oliver@neukum.org>
> Date: Wed, 28 Mar 2012 10:37:05 +0200
> Subject: [PATCH] usbhid: fix error handling of not enough bandwidth
> 
> In case IO cannot be started because there is a lack of bandwidth
> on the bus, it makes no sense to reset the device. If IO is requested
> because the device is opened, user space should be notified with
> an error right away. If the lack of bandwidth arises later, for
> example after resume, there's no other choice but to retry in the
> hope that bandwidth will be freed.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.de>
> ---
> 
> Unfortunately only XHCI implements check_bandwidth()
> I've seen this trigger on UHCI due to an error, but still, it can happen.

Ok, makes sense. I have applied it now. 

(not considering it important enough to trigger merge with Linus in 
current merge window though solely for the purpose of this patch though 
-- I have already flushed my merge window queue to Linus).

Thanks,

-- 
Jiri Kosina
SUSE Labs
