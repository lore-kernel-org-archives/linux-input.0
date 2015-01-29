From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/3] Make sure touch arbitration is applied consistently
 across devices
Date: Thu, 29 Jan 2015 14:06:40 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1501291406210.28996@pobox.suse.cz>
References: <1422466979-17405-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41948 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753309AbbA2NGr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Jan 2015 08:06:47 -0500
In-Reply-To: <1422466979-17405-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Wed, 28 Jan 2015, Ping Cheng wrote:

> stylus_in_proximity is used to make sure no touch event is sent while pen
> is in proximity. touch_down is used to make sure a touch up event is sent
> when pen comes into proximity while touch is down.
> 
> Two touch routines didn't store touch_down. One touch routine forgot to
> check stylus_in_proximity before sending touch events. This patch fixes
> those issues.
> 
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
> v2: added commit comments as reqested by Jiri. No code update.

Thanks. I've applied all 3 patches.

-- 
Jiri Kosina
SUSE Labs
