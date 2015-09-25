From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hid: enable hid device to suspend/resume
 asynchronously
Date: Fri, 25 Sep 2015 14:05:41 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1509251404130.30132@pobox.suse.cz>
References: <55D20409.4060801@linux.intel.com> <alpine.LNX.2.00.1509041509510.30132@pobox.suse.cz> <56039333.8040208@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57369 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754412AbbIYMFl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Sep 2015 08:05:41 -0400
In-Reply-To: <56039333.8040208@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Cc: linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, 24 Sep 2015, Fu, Zhonghui wrote:

> >> Enable hid device to suspend/resume asynchronously. This can improve
> >> system suspend/resume speed.
> > How well was this tested?
> >
> > Power management is notorious for not being really in excellent shape on 
> > many HID devices.
> >
> > So I'd like to be careful.
> I were on leave these days, so sorry for late reply.
> 
> This can reduce system suspend/resume time about 20ms, from 1030ms to 
> 1010ms on ASUS T100TA machine. Although the improvement is not very 
> significant, but this can let your parent/child device suspend/resume 
> more asynchronously and take advantage of multicore to improve overall 
> system suspend/resume speed.
> 
> I have resent this patch with updated commit message - "[PATCH v2] hid: 
> enable hid device to suspend/resume asynchronously".

Is there any reason why not enable this from userspace via sysfs instead, 
based on whitelist on known-to-be-well-behaved devices, from udev?

I am really careful when it comes to enabling features like this 
(especially given the state of PM support on some low-end devices) 
globally.

Thanks,

-- 
Jiri Kosina
SUSE Labs

