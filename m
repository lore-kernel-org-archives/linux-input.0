From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v1] HID: hid-sensor-hub: Fix kernel warning and failure
Date: Mon, 9 Dec 2013 15:46:34 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1312091546230.24835@pobox.suse.cz>
References: <1386290065-31813-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1386290065-31813-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58598 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932593Ab3LIOqi (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 9 Dec 2013 09:46:38 -0500
In-Reply-To: <1386290065-31813-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-input@vger.kernel.org

On Thu, 5 Dec 2013, Srinivas Pandruvada wrote:

> Fix kernel warning and failure to register sensor hub devices with MFD.
> Now many devices has in-built sensor hubs. So by default this HID hub,
> is properly parsed and register individual sensors as platform device
> using MFD framework. But if a second sensor hub is attached via USB,
> which has same sensors, it will result in kernel warning and failure
> to register MFD cell as the platform device sysfs file name will be
> same as created by in-built sensor hubs. This patch sets MFD cell id
> to PLATFORM_DEVID_AUTO. In this way there will never
> be duplicate sysfs file names.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied, thanks Srinivas.

-- 
Jiri Kosina
SUSE Labs
