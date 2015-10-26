From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] hid-gfrm: Google Fiber TV Box remote controls
Date: Mon, 26 Oct 2015 01:41:03 -0700
Message-ID: <20151026084103.GC13056@localhost>
References: <1445454286-134412-1-git-send-email-pgynther@google.com>
 <alpine.LNX.2.00.1510221055030.21100@pobox.suse.cz>
 <alpine.LNX.2.00.1510261600220.8998@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36547 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbbJZIlK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Oct 2015 04:41:10 -0400
Received: by pacfv9 with SMTP id fv9so190376547pac.3
        for <linux-input@vger.kernel.org>; Mon, 26 Oct 2015 01:41:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1510261600220.8998@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Petri Gynther <pgynther@google.com>, linux-input@vger.kernel.org

On Mon, Oct 26, 2015 at 04:01:25PM +0900, Jiri Kosina wrote:
> On Thu, 22 Oct 2015, Jiri Kosina wrote:
> 
> > > Add HID driver for Google Fiber TV Box remote controls
> > 
> > I am not particularly happy with drvdata not being actually used "the 
> > usual way", i.e. to store a pointer, but apart from being unusual, I don't 
> > see a real issue with it.
> > 
> > Dmitry, as this depends on a patch queued in your tree, would you be okay 
> > with taking the patch with my signoff?
> 
> I discussed this Dmitry in person on Kernel Summit earlier today, and 
> he'll be taking the driver through his tree.
> 
> For that purpose:
> 	
> 	Signed-off-by: Jiri Kosina <jkosina@suse.cz>

Applied, thank you.

-- 
Dmitry
