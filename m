From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v4 0/2] HID: HID Sensor: Custom and Generic sensor
 support
Date: Fri, 10 Apr 2015 22:24:15 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1504102223080.26287@pobox.suse.cz>
References: <1428690143-28099-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48662 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753741AbbDJUYR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Apr 2015 16:24:17 -0400
In-Reply-To: <1428690143-28099-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jic23@kernel.org, linux-input@vger.kernel.org

On Fri, 10 Apr 2015, Srinivas Pandruvada wrote:

> v4
> - Fix sysfs_attr_init arguments. Again sorry for the mistake
> - Fix attribute value size for multi byte feature report

I have now applied v4 to for-4.1/sensor-hub. I have retained Jonathan's 
Reviewed-by, given the very limited amount of changes Srinivas did 
compared to v3. Please let me know if you have objections to that.

Thanks,

-- 
Jiri Kosina
SUSE Labs
