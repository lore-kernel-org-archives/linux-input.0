From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: magicmouse: Don't report REL_{X,Y} for Magic
 Trackpad
Date: Thu, 9 Dec 2010 14:41:01 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1012091440410.508@pobox.suse.cz>
References: <1291849685-2623-1-git-send-email-chase.douglas@canonical.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:54015 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750747Ab0LINlD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Dec 2010 08:41:03 -0500
In-Reply-To: <1291849685-2623-1-git-send-email-chase.douglas@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Michael Poole <mdpoole@troilus.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 8 Dec 2010, Chase Douglas wrote:

> With the recent switch to having the hid layer handle standard axis
> initialization, the Magic Trackpad now reports relative axes. This would
> be fine in the normal mode, but the driver puts the device in multitouch
> mode where no relative events are generated. Also, userspace software
> depends on accurate axis information for device type detection. Thus,
> ignoring the relative axes from the Magic Trackpad is best.

Applied, thank you. I take it this should better go into .37 still, right?

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
