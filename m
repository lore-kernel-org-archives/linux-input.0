From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: hid-debug and CONFIG_DEBUG_FS
Date: Wed, 14 Aug 2013 09:16:00 -0700
Message-ID: <520BAD40.8000909@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1062 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014Ab3HNQIt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Aug 2013 12:08:49 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Hi Jiri,

I am implementing some hid driver which require relatively higher 
throughput. HID debug relies on CONFIG_DEBUG_FS, which is by default 
turned on by many distros. These debugs causes issues with the 
throughput, because each report and event is logged.

What do you think about using something other than CONFIG_DEBUG_FS for 
enabling HID debug (something like CONFIG_HID_DEBUG_FS..)?

Thanks,
Srinivas
