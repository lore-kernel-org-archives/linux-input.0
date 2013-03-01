From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/3] logitech-dj: Successfully detect attached devices
 during probe()
Date: Fri, 1 Mar 2013 14:15:38 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1303011415260.25001@pobox.suse.cz>
References: <alpine.LNX.2.00.1302181405240.17024@pobox.suse.cz> <1361208023-11500-1-git-send-email-andrew-vger@gizmolabs.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33192 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887Ab3CANPj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 1 Mar 2013 08:15:39 -0500
In-Reply-To: <1361208023-11500-1-git-send-email-andrew-vger@gizmolabs.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew de los Reyes <andrew-vger@gizmolabs.org>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew de los Reyes <adlr@chromium.org>

On Mon, 18 Feb 2013, Andrew de los Reyes wrote:

> From: Andrew de los Reyes <adlr@chromium.org>
> 
> This patch series includes the latest version of the patch to separate
> the HID driver lock into two. It also includes the first use of the
> new API provided by that patch: a change to the Logitech Unifying
> Receiver driver to detect attached peripherals during probe(). With
> that in, we can also revert a previous workound, which was originally
> introduced when probe() stopped being able to communicate with the
> device.
> 
> Andrew de los Reyes (3):
>   HID: Separate struct hid_device's driver_lock into two locks.
>   HID: Fix logitech-dj: Allow incoming packets during probe().
>   Revert "HID: Fix logitech-dj: missing Unifying device issue"
> 
>  drivers/hid/hid-core.c        | 24 +++++++++++++++++++---
>  drivers/hid/hid-logitech-dj.c | 48 +++----------------------------------------
>  drivers/hid/hid-logitech-dj.h |  1 -
>  include/linux/hid.h           | 46 ++++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 69 insertions(+), 50 deletions(-)

Now queued in my tree. Thanks,

-- 
Jiri Kosina
SUSE Labs
