From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5] Input: Improve the performance of alps v5-protocol's
 touchpad
Date: Thu, 26 Dec 2013 16:00:12 -0800
Message-ID: <20131227000012.GA8147@core.coreip.homeip.net>
References: <1387876717-3878-1-git-send-email-yunkang.tang@cn.alps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:49349 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940Ab3L0AAP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Dec 2013 19:00:15 -0500
Received: by mail-pb0-f50.google.com with SMTP id rr13so8673022pbb.37
        for <linux-input@vger.kernel.org>; Thu, 26 Dec 2013 16:00:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1387876717-3878-1-git-send-email-yunkang.tang@cn.alps.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yunkang Tang <tommywill2011@gmail.com>
Cc: cernekee@gmail.com, dturvene@dahetral.com, linux-input@vger.kernel.org, ndevos@redhat.com, jclift@redhat.com, yunkang.tang@cn.alps.com

On Tue, Dec 24, 2013 at 05:18:37PM +0800, Yunkang Tang wrote:
> Hi all,
> 
> Here is the 5th patch of supporting ALPS v5 protocol's device.
> 
> Change since v4:
> - Use temporary variables to store the result of fls() and ffs(). (Suggestion by Kevin)
> - Use PSMOUSE_* macro instead of raw hex directly. (Suggestion by Kevin)
> - Change V5 device's mask0 from 0xc8 to 0xd8 to protect the abnormal case. (Discuss with Dmitry)
> 
> Self test with v5 device:
> - Checked on both 32-bit & 64-bit environment.
> - Cursor moves correctly.
> - 1Finger Tap/Drag works well.
> - 2Finger Tap works well.
> - 2Finger Scroll works well.
> - L/R Buttons do function
> 
> Signed-off-by: Yunkang Tang <yunkang.tang@cn.alps.com>

Applied, thank you.

-- 
Dmitry
