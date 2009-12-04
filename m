From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 9/9] Input: panasonic-laptop - switch to using sparse
	keymap library
Date: Fri, 4 Dec 2009 12:27:19 -0800
Message-ID: <20091204202719.GC25669@core.coreip.homeip.net>
References: <20091204060701.28288.91430.stgit@localhost.localdomain> <20091204061241.28288.73256.stgit@localhost.localdomain> <20091204191415.GI3653@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f188.google.com ([209.85.216.188]:61869 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757306AbZLDU1U (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Dec 2009 15:27:20 -0500
Received: by pxi26 with SMTP id 26so659733pxi.21
        for <linux-input@vger.kernel.org>; Fri, 04 Dec 2009 12:27:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091204191415.GI3653@prithivi.gnumonks.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Harald Welte <laforge@gnumonks.org>
Cc: linux-input@vger.kernel.org

Hi Harald,

On Sat, Dec 05, 2009 at 12:44:15AM +0530, Harald Welte wrote:
> Dear Dmitry.
> 
> Looks fine to me, but I'm currently travelling and don't have any hardware
> where I can test it on.  I will put it on my todo list, but that will likely
> take one week.
> 

That should be fine.

I will be merging the input parts (the library module) in the merge
window but drivers can folow later (in fact, since drivers/platform is
Len's domain he will decide when to push them out once the changes been
reviewed and tested). Ultimately I'd prefer to have these changes appear
in .33 release.

Thanks.

-- 
Dmitry
