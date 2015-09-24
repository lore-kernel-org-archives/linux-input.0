From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: Re: [PATCH] hid: enable hid device to suspend/resume asynchronously
Date: Thu, 24 Sep 2015 14:07:47 +0800
Message-ID: <56039333.8040208@linux.intel.com>
References: <55D20409.4060801@linux.intel.com> <alpine.LNX.2.00.1509041509510.30132@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:29822 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932359AbbIXGIH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Sep 2015 02:08:07 -0400
In-Reply-To: <alpine.LNX.2.00.1509041509510.30132@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



On 2015/9/4 21:10, Jiri Kosina wrote:
> On Mon, 17 Aug 2015, Fu, Zhonghui wrote:
>
>> Enable hid device to suspend/resume asynchronously. This can improve
>> system suspend/resume speed.
> How well was this tested?
>
> Power management is notorious for not being really in excellent shape on 
> many HID devices.
>
> So I'd like to be careful.
I were on leave these days, so sorry for late reply.

This can reduce system suspend/resume time about 20ms, from 1030ms to 1010ms on ASUS T100TA machine. Although the improvement is not very significant, but this can let your parent/child device suspend/resume more asynchronously and take advantage of multicore to improve overall system suspend/resume speed.

I have resent this patch with updated commit message - "[PATCH v2] hid: enable hid device to suspend/resume asynchronously".


Thanks,
Zhonghui

>
> Thanks,
>

