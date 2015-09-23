From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/2] HID: wacom: Cleanup unsupported device_type for
 BAMBOO_PT
Date: Wed, 23 Sep 2015 22:56:16 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1509232255570.30132@pobox.suse.cz>
References: <1443027550-7269-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54234 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754582AbbIWU4Q (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Sep 2015 16:56:16 -0400
In-Reply-To: <1443027550-7269-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, aaron.skomra@wacom.com, Ping Cheng <pingc@wacom.com>

On Wed, 23 Sep 2015, Ping Cheng wrote:

> Not all Bamboo support both pen and touch. Make sure we deal with
> pen only and touch only devices properly.
> 
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> Tested-By: Aaron Skomra <aaron.skomra@wacom.com>

Both patches queued in hid.git#for-4.4/wacom.

Thanks,

-- 
Jiri Kosina
SUSE Labs

