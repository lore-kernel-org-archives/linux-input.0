From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] drivers:input:set driver data to NULL for pcap_keys
Date: Mon, 25 Jul 2011 01:30:49 -0700
Message-ID: <20110725083048.GD22937@core.coreip.homeip.net>
References: <1311176068-9934-1-git-send-email-wanlong.gao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:50728 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145Ab1GYIay (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2011 04:30:54 -0400
Received: by pzk37 with SMTP id 37so8099361pzk.1
        for <linux-input@vger.kernel.org>; Mon, 25 Jul 2011 01:30:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311176068-9934-1-git-send-email-wanlong.gao@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wanlong Gao <wanlong.gao@gmail.com>
Cc: linux-input@vger.kernel.org, Wanlong Gao <gaowanlong@cn.fujitsu.com>

On Wed, Jul 20, 2011 at 11:34:28PM +0800, Wanlong Gao wrote:
> It's better to set the device's driver data to NULL
> when remove it.
> 

I'd rather have platform devices core clean up this pointer, then we
could stop caring about it in all drivers...

Thanks.

-- 
Dmitry
