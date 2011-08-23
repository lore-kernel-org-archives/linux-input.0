From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: wacom_w8001 - implement open and close
Date: Tue, 23 Aug 2011 10:48:31 -0700
Message-ID: <20110823174831.GA25681@core.coreip.homeip.net>
References: <1313957747-22796-1-git-send-email-dmitry.torokhov@gmail.com>
 <CAGzDe_bUbbpg5g773zhX__ax65jfVcRYf1afd=GxMS4GS8ge-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61886 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755609Ab1HWRsh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Aug 2011 13:48:37 -0400
Received: by gwaa12 with SMTP id a12so274406gwa.19
        for <linux-input@vger.kernel.org>; Tue, 23 Aug 2011 10:48:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAGzDe_bUbbpg5g773zhX__ax65jfVcRYf1afd=GxMS4GS8ge-w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Jaya Kumar <jayakumar.lkml@gmail.com>

On Tue, Aug 23, 2011 at 12:22:06PM -0500, Chris Bagwell wrote:
> I don't have one of these to test but anyways:
> 
> Acked-by: Chris Bagwell <chris@cnpbagwell.com>

Thanks for looking at this. I don't have the hardware either so it would
be nice if someone who has it tried the patches...

> 
> I've been trying to slowing document the protocols for ISDV4 and USB
> Wacom devices (http://sourceforge.net/apps/mediawiki/linuxwacom/index.php?title=ISDV4_Protocol
> for these ISDV4 ones if your interested).  During this, I was
> comparing this version against the user land version of this driver
> inside xf86-input-wacom.
> 
> xf86-input-wacom was doing a version of this patch so good to see
> here.  The only other difference remaining is it also discards any
> data on the line during startup to flush old data from after initial
> STOP command and so that its sure of command/response sequence.

Hmm, I guess it indeed would be a good idea to reset w8001->idx in
w8001_open() to make sure we do not restart with buffer half-filled with
old data...

Thanks.

-- 
Dmitry
