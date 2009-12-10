From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add Driver for Logitech Flight System G940
Date: Thu, 10 Dec 2009 10:12:45 -0800
Message-ID: <20091210181245.GB23717@core.coreip.homeip.net>
References: <fce72f9b0912081439ia797224xf05ed93771b5203d@mail.gmail.com> <alpine.LNX.2.00.0912091416010.3755@pobox.suse.cz> <fce72f9b0912100947q2214c471r71f6cf6e81212cd2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:46847 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761059AbZLJSMr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Dec 2009 13:12:47 -0500
Received: by pwj9 with SMTP id 9so67333pwj.21
        for <linux-input@vger.kernel.org>; Thu, 10 Dec 2009 10:12:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <fce72f9b0912100947q2214c471r71f6cf6e81212cd2@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gary Stein <lordcnidarian@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On Thu, Dec 10, 2009 at 12:47:06PM -0500, Gary Stein wrote:
> Ok, I'll go through the coding issues, that checkpatch.pl was useful,
> I was not positive on all of the coding standards, but with that
> script I can setup my IDE properly to make sure everything works out
> (like c99 comments and 80 char limits)
> 
> The wrapping is whatever gmail wants to do in their web interface.
> 

Yeah, gmail web interface is not suitable for patch exchange. However
you can use conventional mailers (mutt for example) to send patches via
gmail. And they say IMAP works OK with gmail as well. You can also send
patch both inline (for commenting) and as an attachment (for applying)
if you are forced to use web interface.

> I wanted to do FF_CUSTOM (which appears in input.h) and I did try that
> for awhile but in the end ff-memless didn't seem to pass everything
> along even if I set it up in the flags, etc.
> 
> It would be more work, but is there any way to add a different
> FF_CONSTANT through the union process?

The problem with adding a new constant (and FF_CUSTOM really) is that
only _your_ application and device will make use of it.

Have you tried expanding the cosine table in fixp-arith.h to provide
better granularity?

-- 
Dmitry
