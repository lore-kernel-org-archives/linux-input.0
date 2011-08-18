From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH] HID: magicmouse: ignore 'ivalid report id' while switching
 modes
Date: Thu, 18 Aug 2011 09:25:32 -0700
Message-ID: <4E4D3CFC.7000700@canonical.com>
References: <1313611182-19924-1-git-send-email-jaikumarg@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:58757 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755295Ab1HRQZf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Aug 2011 12:25:35 -0400
In-Reply-To: <1313611182-19924-1-git-send-email-jaikumarg@android.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaikumar Ganesh <jaikumarg@android.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On 08/17/2011 12:59 PM, Jaikumar Ganesh wrote:
> From: Jiri Kosina <jkosina@suse.cz>
> 
> 23746a introduced this commit but was reverted in c3a492.
> The trackpad uses report Ids which are not present in the
> report descriptor. These reports ids are not documented
> anywhere. There are devices in the market (Apple magic tracpkad,
> BT version 2.0 is one such device) with the same device id,
> which fail when we use 0xd7 as the report id. So we need the EIO
> change of 23746a as a failsafe to work with these devices.
> 
> Original Author: Jiri Kosina <jkosina@suse.cz>
> 
> Signed-off-by: Jaikumar Ganesh <jaikumarg@android.com>

I worry this may just be papering over a bug elsewhere in the system
again. I'm going to try to git bisect this today.

-- Chase
