From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: generic: Wacom mouse is only provided for
 opaque tablets
Date: Mon, 6 Mar 2017 13:22:53 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1703061322030.31814@cbobk.fhfr.pm>
References: <1486509851-2977-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53468 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752808AbdCFMXV (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 6 Mar 2017 07:23:21 -0500
In-Reply-To: <1486509851-2977-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, killertofu@gmail.com, Ping Cheng <pingc@wacom.com>, Ping Cheng <ping.cheng@wacom.com>

On Tue, 7 Feb 2017, Ping Cheng wrote:

> So, don't add mouse and lens cursor tools.
> 
> Signed-off-by: Ping Cheng <ping.cheng@wacom.com>

Could you please make the changelog more specific? It's not clear from it 
what kind of bug this is exactly fixing, and what are the user-visible 
effects of it (namely in relation to it's applicability to 
4.11/stable/etc).

Thanks,

-- 
Jiri Kosina
SUSE Labs

