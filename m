From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: wacom: generic: Wacom mouse is only provided
 for opaque tablets
Date: Tue, 21 Mar 2017 14:48:42 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1703211448310.31814@cbobk.fhfr.pm>
References: <1489536496-29253-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47736 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757852AbdCUPDn (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Mar 2017 11:03:43 -0400
In-Reply-To: <1489536496-29253-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, killertofu@gmail.com, Ping Cheng <pingc@wacom.com>, Ping Cheng <ping.cheng@wacom.com>

On Tue, 14 Mar 2017, Ping Cheng wrote:

> Commit f85c9dc ("Support tool ID and additional tool types") introduced mouse
> and lens cursor tools to generic codepath, which covers both display (direct)
> and opaque tablets (indirect devices). However, mouse and lens cursor tools are
> only provided for opaque tablets. This patch ignores mouse and lens cursor tools
> if the device is a display tablet.
> 
> Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
> Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
> ---
> v2: updated commit comments as requested by Jiri.

Applied to for-4.11/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs

