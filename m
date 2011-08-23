From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH V2 0/5] Wiimote fixes for 3.1
Date: Tue, 23 Aug 2011 10:58:11 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1108231058010.13644@pobox.suse.cz>
References: <1313574204-12664-1-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53819 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754923Ab1HWI6N (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Aug 2011 04:58:13 -0400
In-Reply-To: <1313574204-12664-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, oliver@neukum.org, padovan@profusion.mobi

On Wed, 17 Aug 2011, David Herrmann wrote:

> This contains few fixes for the current wiimote driver. Since HID core uses a
> semaphore lock now, we can simplify the wiimote synchronization. This also adds
> open/close callbacks, although bthid doesn't need that, but it makes the code
> more consistent with other drivers.
> As discussed on the mailinglist, this also removes the four LED sysfs attributes
> in favor of four new led_classdev devices. I hope it is ok to remove an API as
> long as 3.1 isn't released, yet.
> The last two patches fix a bug that the driver didn't work when an extension was
> plugged/unplugged. They simply reset the current DRM so the extension port is
> ignored.
> 
> I've kept these fixes for 3.1 small. I will resend the other patches for 3.2
> as RFC soon.

Thanks. I have now queued the patchset.

-- 
Jiri Kosina
SUSE Labs
