From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hid: enable hid device to suspend/resume
 asynchronously
Date: Fri, 4 Sep 2015 15:10:29 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1509041509510.30132@pobox.suse.cz>
References: <55D20409.4060801@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37514 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933181AbbIDNKa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 4 Sep 2015 09:10:30 -0400
In-Reply-To: <55D20409.4060801@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Cc: linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, 17 Aug 2015, Fu, Zhonghui wrote:

> Enable hid device to suspend/resume asynchronously. This can improve
> system suspend/resume speed.

How well was this tested?

Power management is notorious for not being really in excellent shape on 
many HID devices.

So I'd like to be careful.

Thanks,

-- 
Jiri Kosina
SUSE Labs

