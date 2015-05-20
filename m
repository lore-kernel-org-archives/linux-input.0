From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: wacom: fix an Oops caused by
 wacom_wac_finger_count_touches
Date: Wed, 20 May 2015 12:05:41 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1505201205170.8186@pobox.suse.cz>
References: <1432082522-4107-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59985 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753750AbbETKFr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 20 May 2015 06:05:47 -0400
In-Reply-To: <1432082522-4107-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, tasos@tasossah.com, Ping Cheng <pingc@wacom.com>

On Tue, 19 May 2015, Ping Cheng wrote:

> We assumed all touch interfaces report touch data. But, Bamboo
> and Intuos non-touch devices report express keys on touch
> interface. We need to check touch_max before counting touches.
> 
> Reported-by: Tasos Sahanidis <tasos@tasossah.com>
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
> Hi Jiri, this patch is based on for-4.1/wacom. The issue was
> initially introduced in 4.1.

Thanks. This is now applied to for-4.1/upstream-fixes, and this branch 
will be sent to Linus for pulling later today.

-- 
Jiri Kosina
SUSE Labs
