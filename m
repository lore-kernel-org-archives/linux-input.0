From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH] HID: magicmouse: ignore 'ivalid report id' while switching
 modes
Date: Thu, 18 Aug 2011 09:48:47 -0700
Message-ID: <4E4D426F.607@canonical.com>
References: <1313611182-19924-1-git-send-email-jaikumarg@android.com> <4E4D3CFC.7000700@canonical.com> <CAA8bQNjQ2s4EY=2r455z-3r7yyV0uwSjhQ6m5g2+TCyMRvu0sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:58220 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277Ab1HRQsv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Aug 2011 12:48:51 -0400
In-Reply-To: <CAA8bQNjQ2s4EY=2r455z-3r7yyV0uwSjhQ6m5g2+TCyMRvu0sQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaikumar Ganesh <jaikumarg@android.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On 08/18/2011 09:36 AM, Jaikumar Ganesh wrote:
> Hi Chase
> 
> On Thu, Aug 18, 2011 at 9:25 AM, Chase Douglas
> <chase.douglas@canonical.com <mailto:chase.douglas@canonical.com>> wrote:
> 
>     On 08/17/2011 12:59 PM, Jaikumar Ganesh wrote:
>     > From: Jiri Kosina <jkosina@suse.cz <mailto:jkosina@suse.cz>>
>     >
>     > 23746a introduced this commit but was reverted in c3a492.
>     > The trackpad uses report Ids which are not present in the
>     > report descriptor. These reports ids are not documented
>     > anywhere. There are devices in the market (Apple magic tracpkad,
>     > BT version 2.0 is one such device) with the same device id,
>     > which fail when we use 0xd7 as the report id. So we need the EIO
>     > change of 23746a as a failsafe to work with these devices.
>     >
>     > Original Author: Jiri Kosina <jkosina@suse.cz
>     <mailto:jkosina@suse.cz>>
>     >
>     > Signed-off-by: Jaikumar Ganesh <jaikumarg@android.com
>     <mailto:jaikumarg@android.com>>
> 
>     I worry this may just be papering over a bug elsewhere in the system
>     again. I'm going to try to git bisect this today.
> 
>  
> The original commit explains in detail why it used to work before, so
> its not a regression in that sense. The commit was present in 2.6.39
> stable tree too but was reverted in 3.0 tree. 

It was reverted because it was papering over a bug in the bluetooth
stack, and when that bug was fixed this commit broke things again.

I've determined that there's a bug between Ubuntu's 3.0-1.2 and 3.0-2.3
kernels. There does not appear to be any Ubuntu specific patches that
went in between those versions that would affect this, but there was a
rebase from upstream 3.0-rc3 to 3.0-rc4. There is likely a bug
introduced sometime in there.

I'll be digging deeper...

-- Chase
