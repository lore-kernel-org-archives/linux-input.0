From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: hid-sensor-hub: fix sleeping function called from
 invalid context
Date: Tue, 25 Mar 2014 13:11:48 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1403251311380.17500@pobox.suse.cz>
References: <1395703504-3945-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50427 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753563AbaCYMLu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Mar 2014 08:11:50 -0400
In-Reply-To: <1395703504-3945-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-input@vger.kernel.org

On Mon, 24 Mar 2014, Srinivas Pandruvada wrote:

> Fix issue with the sleeping calling hid_hw_request under spinlock.
> When i2c is used as HID transport, this is calling kmalloc, which
> can sleep. So remove call to this function while under spinlock.
>  [ 1067.021961] Call Trace:
>  [ 1067.021970]  [<ffffffff8192f5f2>] dump_stack+0x4d/0x6f
>  [ 1067.021976]  [<ffffffff811109f2>] __might_sleep+0xd2/0xf0
>  [ 1067.021981]  [<ffffffff811ea15b>] __kmalloc+0xeb/0x200
>  [ 1067.021989]  [<ffffffff816e0cb3>] ? hid_alloc_report_buf+0x23/0x30
>  [ 1067.021993]  [<ffffffff816e0cb3>] hid_alloc_report_buf+0x23/0x30
>  [ 1067.021997]  [<ffffffff816f4cb7>] i2c_hid_request+0x57/0x110
>  [ 1067.022006]  [<ffffffffa02bc61c>] sensor_hub_input_attr_get_raw_value+0xbc/0x100 [hid_sensor_hub]

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
