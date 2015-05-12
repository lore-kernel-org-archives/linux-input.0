From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v1] HID: hid-sensor-hub: Fix debug lock warning
Date: Tue, 12 May 2015 14:14:30 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1505121414170.8186@pobox.suse.cz>
References: <1431033994-7836-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1431033994-7836-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37510 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932334AbbELMOd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 May 2015 08:14:33 -0400
In-Reply-To: <1431033994-7836-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-input@vger.kernel.org

On Thu, 7 May 2015, Srinivas Pandruvada wrote:

> When CONFIG_DEBUG_LOCK_ALLOC is defined, mutex magic is compared and
> warned for (l->magic != l), here l is the address of mutex pointer.
> In hid-sensor-hub as part of hsdev creation, a per hsdev mutex is
> initialized during MFD cell creation. This hsdev, which contains, mutex
> is part of platform data for the a cell. But platform_data is copied
> in platform_device_add_data() in platform.c. This copy will copy the
> whole hsdev structure including mutex. But once copied the magic
> will no longer match. So when client driver call
> sensor_hub_input_attr_get_raw_value, this will trigger mutex warning.
> So to avoid this allocate mutex dynamically. This will be same even
> after copy.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied to for-4.1/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs
