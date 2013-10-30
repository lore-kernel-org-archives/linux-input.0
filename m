From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: hid-sensor-hub: fix report size
Date: Wed, 30 Oct 2013 14:27:23 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1310301427120.21144@pobox.suse.cz>
References: <1382807049-28478-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49896 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751971Ab3J3N13 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Oct 2013 09:27:29 -0400
In-Reply-To: <1382807049-28478-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-input@vger.kernel.org

On Sat, 26 Oct 2013, Srinivas Pandruvada wrote:

> Most of the hid sensor field size is reported in report_size field
> in the report descriptor. For rotation fusion sensor the quaternion
> data is 16 byte field, the report size was set to 4 and report
> count field is set to 4. So the total size is 16 bytes. But the current
> driver has a bug and not taking account for report count field. This
> causes user space to see only 4 bytes of data sent via IIO interface. 
> The number of bytes in a field needs to take account of report_count
> field. Need to multiply report_size and report_count to get total
> number of bytes.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thanks, applied.

-- 
Jiri Kosina
SUSE Labs
