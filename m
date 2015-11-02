From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: fix Intuos wireless report id issue
Date: Mon, 2 Nov 2015 17:41:44 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1511021741380.22567@pobox.suse.cz>
References: <1445894952-3495-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47801 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752246AbbKBQlo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Nov 2015 11:41:44 -0500
In-Reply-To: <1445894952-3495-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, dlbrewe@hotmail.com, Ping Cheng <pingc@wacom.com>

On Mon, 26 Oct 2015, Ping Cheng wrote:

> Intuos Pen in wireless mode does not have the same report id (2) as
> when it is in USB mode (17).
> 
> This patch also moves WIRELESS next to REMOTE in type enum so we
> can group devices with similar features easily.
> 
> Reported-by: Dale Brewe <dlbrewe@hotmail.com>
> Tested-by: Dale Brewe <dlbrewe@hotmail.com>
> Signed-off-by: Ping Cheng <pingc@wacom.com>

Applied to hid.git#for-4.4/wacom.

Thanks,

-- 
Jiri Kosina
SUSE Labs

