From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: bcm5974 - Report button also for zero fingers
Date: Thu, 24 Feb 2011 14:20:59 -0800
Message-ID: <20110224222058.GA2448@core.coreip.homeip.net>
References: <1298576264-1563-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:57174 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756108Ab1BXWVw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Feb 2011 17:21:52 -0500
Content-Disposition: inline
In-Reply-To: <1298576264-1563-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Feb 24, 2011 at 08:37:44PM +0100, Henrik Rydberg wrote:
> With the current code, pressing the integrated button with an
> isolating tool does not result in any button report. Fixed
> with this this patch.
> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
> Hi Dmitry,
> 
> that nobody every complained about this bug is beyond me...

I guess nobody uses styluses to work with the touchpad... I'll apply it
of course, but since I do not recall bug reports I'll hold it till .39 I
think.

Thanks. 

-- 
Dmitry
