From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/3] Cleanup to get rid of a static checker warning
Date: Thu, 2 Apr 2015 14:21:06 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1504021420150.843@pobox.suse.cz>
References: <1426888600-8603-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42328 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750747AbbDBMVJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 2 Apr 2015 08:21:09 -0400
In-Reply-To: <1426888600-8603-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: benjamin.tissoires@gmail.com, linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Fri, 20 Mar 2015, Ping Cheng wrote:

> Patch e2c7d8877e5c leads to the following Smatch complaint:
> 
> drivers/hid/wacom_wac.c:602 wacom_intuos_inout()
>          error: we previously assumed 'wacom->shared' could be null (see line 584)
> 
> The first patch in this series fixes that warning. The next two cleans up the code
> and fixes a logic order.
> 
> The patchset is based on Jiri's for-4.0/upstream-fixes branch.
> 
> Ping Cheng (3):
>   HID: wacom: remove hardcoded WACOM_QUIRK_MULTI_INPUT
>   HID: wacom: use wacom_wac_finger_count_touches to set touch_down
>   HID: wacom: set stylus_in_proximity before checking touch_down

I've had to fix a few conflicts between for-4.1/wacom and 
for-4.1/upstream-fixes to make everything apply. Hopefully everything is 
okay, but please doublecheck.

It's now pushed out to for-4.1/wacom (and merged to for-next).

Thanks,

-- 
Jiri Kosina
SUSE Labs
