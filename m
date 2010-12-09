From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: mt: Identify pointer emulation contact
Date: Thu, 9 Dec 2010 15:49:21 -0800
Message-ID: <20101209234920.GA14810@core.coreip.homeip.net>
References: <1291936745-4973-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:34565 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756238Ab0LIXt2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Dec 2010 18:49:28 -0500
Content-Disposition: inline
In-Reply-To: <1291936745-4973-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Dec 10, 2010 at 12:19:05AM +0100, Henrik Rydberg wrote:
> For MT applications, the tracking id provides a robust way to know
> when a touch is new; essential information to determine when _not_ to
> emit motion events, for instance.  Currently, ST applications do not
> have the equivalent information, but instead rely on global properties
> such as a change in number of fingers. Moreover, some MT applications
> need to know which contact correponds to the pointer. This patch adds
> the ABS_TRACKING_ID axis and emits it in
> input_mt_report_pointer_emulation(), provided the proper absbit is
> setup by the driver.
> 

So how do you propose userspace will use it? Obviously it will not help
old dumb (ST) applications and new smart applications should understand
MT protocol and thus do not need to pay much attention to ST events
anyway. Apparently you have some new dumb userspace in mind here?

Thanks.

-- 
Dmitry
