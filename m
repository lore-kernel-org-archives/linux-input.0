From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Remove unneeded '\n' from psmouse.proto
	parameter
Date: Thu, 12 Nov 2009 23:31:21 -0800
Message-ID: <20091113073121.GA5429@core.coreip.homeip.net>
References: <s5haayq7usz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:63849 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498AbZKMHbU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Nov 2009 02:31:20 -0500
Received: by pzk1 with SMTP id 1so1120782pzk.33
        for <linux-input@vger.kernel.org>; Thu, 12 Nov 2009 23:31:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <s5haayq7usz.wl%tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-input@vger.kernel.org

On Fri, Nov 13, 2009 at 08:22:52AM +0100, Takashi Iwai wrote:
> The get parameter function should return a string without a life-feed.
> Otherwise you'll see additional empty line in sysfs parameters file.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Applied, thank you Takashi.

-- 
Dmitry
