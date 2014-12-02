From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: wacom - add defines for new Cintiq and DTU outbound
 tracking
Date: Tue, 2 Dec 2014 11:42:42 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1412021142330.2524@pobox.suse.cz>
References: <1417470268-13635-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60386 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752805AbaLBKm1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Dec 2014 05:42:27 -0500
In-Reply-To: <1417470268-13635-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Mon, 1 Dec 2014, Ping Cheng wrote:

> There are screen to tablet offsets for newer Cintiq and DTU models.
> These offsets serve as outbound tracking for those display tablets.
> 
> Use defines instead of hardcoded numbers for the offsets.
> 
> Signed-off-by: Ping Cheng <pingc@wacom.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
